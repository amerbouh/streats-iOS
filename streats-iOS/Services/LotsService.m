//
//  LotsService.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-18.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "LotsService.h"
#import "Lot.h"

@implementation LotsService

+ (void)getLotsForTime:(NSString *)time completionHandler:(void (^)(NSArray<Lot *> * _Nullable, NSError * _Nullable))completionHandler {
    NSString *URLString = [NSString stringWithFormat:@"https://montreal.bestfoodtrucks.com/api/events/events?when=%@&where=68", time];
    NSURL *requestURL = [[NSURL alloc] initWithString:URLString];
    
    // Check if the passed URL is valid.
    if (requestURL == NULL) {
        return;
    }
    
    // Configure the request.
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:requestURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != NULL) {
            completionHandler(NULL, error);
        } else {
            NSError *serializationError;
            NSArray<NSDictionary<NSString *, id> *> *lotsDictionnaries = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            if (serializationError != NULL) {
                completionHandler(NULL, serializationError);
            } else {
                // Initalize the lots dictionary holding the retrevied lots.
                NSMutableArray<Lot *> *lots = [[NSMutableArray alloc] init];
                
                for (NSDictionary<NSString *, id> *lotDictionary in lotsDictionnaries) {
                    Lot *lot = [[Lot alloc] initWithDictionary:lotDictionary];
                    [lots addObject:lot];
                }
                
                // Call the compmletion handler and pass the given lots.
                completionHandler(lots, NULL);
            }
        }
    }];
    
    // Send the request.
    [task resume];
}

@end
