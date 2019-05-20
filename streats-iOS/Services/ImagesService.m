//
//  ImagesServices.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-14.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "ImagesService.h"

@implementation ImagesService

#pragma mark - Methods

+ (void)downloadImageWithURL:(NSURL *)URL completionHandler:(void (^)(UIImage * _Nullable, NSError * _Nullable))completionHandler {
    NSURLSessionDataTask* task = [NSURLSession.sharedSession dataTaskWithURL:URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != NULL) {
            completionHandler(NULL, error);
        } else {
            UIImage* downloadedImage = [UIImage imageWithData:data];
            
            // Make sure that an image could be created with the data received
            // from the server.
            if (downloadedImage != NULL) {
                completionHandler(downloadedImage, NULL);
            } else {
                NSError* invalidResponseContent = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:415 userInfo:NULL];
                completionHandler(NULL, invalidResponseContent);
            }
        }
    }];
    
    // Send the request.
    [task resume];
}

@end
