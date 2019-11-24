//
//  LotsService.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-18.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Lot;
@class ServiceError;

@interface LotsService : NSObject

/**
 * @brief Retrieves all the lots for the given time.
 * @param time The time range from which the lots will be fetched.
 * @param completionHandler The completion handler to call when the load request is complete.
*/
- (void)getLotsForTime:(NSString * _Nonnull)time completionHandler:(void (^_Nullable)(NSArray<Lot*> * _Nullable lots, ServiceError * _Nullable error))completionHandler;

@end
