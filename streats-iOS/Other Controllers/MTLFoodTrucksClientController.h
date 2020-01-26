//
//  MTLFoodTrucksClientController.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-12-14.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Period.h"

NS_ASSUME_NONNULL_BEGIN

@class Event;
@class Vendor;
@class ServiceError;

@interface MTLFoodTrucksClientController : NSObject

/**
* @brief Retrieves all the vendors for the given period.
* @param period The time range from which the vendors will be fetched.
* @param completionHandler The completion handler to call when the load request is complete.
*/
- (void)getVendorsForPeriod:(Period)period withCompletionHandler:(void (^_Nullable)(NSArray<Vendor*> * _Nullable vendors, ServiceError * _Nullable error))completionHandler;

/**
 * @brief Retrieves all the events the vendor with the given identifier is attending to.
 * @param identifier The identifier of the vendor.
 * @param completionHandler The completion handler to call when the load request is complete.
 */
- (void)getEventsForVendorWithIdentifier:(NSString * _Nonnull)identifier completionHandler:(void (^_Nullable)(NSArray<Event *> * _Nullable events, ServiceError * _Nullable serviceError))completionHandler;

@end

NS_ASSUME_NONNULL_END
