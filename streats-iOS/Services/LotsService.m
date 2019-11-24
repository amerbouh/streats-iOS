//
//  LotsService.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-18.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "LotsService.h"
#import "ServiceError.h"
#import "WebClientController.h"
#import "Lot.h"

@interface LotsService ()

/** The Web Controller object instance used to perform requests to any given Web Service. */
@property (strong, nonatomic, nonnull) WebClientController *webClientController;

@end

@implementation LotsService

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        _webClientController = [[WebClientController alloc] initWithBaseURL:@"https://montreal.bestfoodtrucks.com/api"];
    }
    return self;
}

#pragma mark - Methods

- (void)getLotsForTime:(NSString *)time completionHandler:(void (^)(NSArray<Lot *> * _Nullable, ServiceError * _Nullable))completionHandler
{
    NSDictionary<NSString *, id> *requestParams = @{
        @"when": time,
        @"where": @"68"
    };
    
    // Send a request to Montreal's web service to return all the lots attending to an event for the given time.
    [self.webClientController loadResourceForPath:@"events/events" withParams:requestParams completionHandler:^(id  _Nullable result, ServiceError * _Nullable serviceError) {
        if (serviceError != NULL) {
            completionHandler(NULL, serviceError);
        } else {
            NSMutableArray<Lot *> *lots = [[NSMutableArray alloc] init];
            NSArray<NSDictionary<NSString *, id> *> *lotsDictionnaries = (NSArray<NSDictionary<NSString *, id> *> *) result;
            
            // Loop through each Lot dictionary and add it to the lots array.
            for (NSDictionary<NSString *, id> *lotDictionary in lotsDictionnaries) {
                Lot *lot = [[Lot alloc] initWithDictionary:lotDictionary];
                [lots addObject:lot];
            }
            
            // Call the compmletion handler and pass the given lots.
            completionHandler(lots, NULL);
        }
    }];
}

@end
