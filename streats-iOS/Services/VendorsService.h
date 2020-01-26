//
//  VendorsService.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-13.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Period.h"

@class Event;
@class Vendor;
@class MenuItem;
@class ServiceError;

@interface VendorsService : NSObject

/**
 * @brief Retrieves all the vendors for the given period.
 * @param period The time range from which the vendors will be fetched.
 * @param completionHandler The completion handler to call when the load request is complete.
 */
- (void)getVendorsForPeriod:(Period)period completionHandler:(void (^_Nullable)(NSArray<Vendor *> * _Nullable vendors, ServiceError * _Nullable error))completionHandler;

/**
 * @brief Retrieves the details of the vendor with the given identifier.
 * @param identifier The identifier of the vendor.
 * @param completionHandler The completion handler to call when the load request is complete.
 */
+ (void)getDetailsForVendorWithIdentifier:(NSString * _Nonnull)identifier completionHandler:(void (^_Nullable)(Vendor * _Nullable vendor, ServiceError * _Nullable serviceError))completionHandler;

/**
 * @brief Retrieves the menu of the vendor with the given identifier.
 * @param identifier The identifier of the vendor.
 * @param completionHandler The completion handler to call when the load request is complete.
 */
+ (void)getMenuItemsForVendorWithIdentifier:(NSString * _Nonnull)identifier completionHandler:(void (^_Nullable)(NSArray<MenuItem *> * _Nullable menuItems, ServiceError * _Nullable serviceError))completionHandler;

/**
 * @brief Retrieves all the events organized by the vendor with the given identifier.
 * @param identifier The identifier of the vendor.
 * @param completionHandler The completion handler to call when the load request is complete.
 */
+ (void)getEventsForVendorWithIdentifier:(NSString * _Nonnull)identifier completionHandler:(void (^_Nullable)(NSArray<Event *> * _Nullable events, ServiceError * _Nullable serviceError))completionHandler;

@end
