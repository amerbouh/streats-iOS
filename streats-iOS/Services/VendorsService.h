//
//  VendorsService.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-13.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Event;
@class Vendor;
@class MenuItem;
@class ServiceError;

@interface VendorsService : NSObject

/**
 * @brief Retrieves all the vendors for the given time.
 * @param time The time range from which the vendors will be fetched.
 * @param completionHandler The completion handler to call when the load request is complete.
 */
- (void)getVendorsForTime:(NSString*_Nonnull)time completionHandler:(void (^_Nullable)(NSArray<Vendor*> * _Nullable vendors, ServiceError * _Nullable error))completionHandler;

/**
 * @brief Retrieves the details of the vendor with the given identifier.
 * @param identifier The identifier of the vendor.
 * @param completionHandler The completion handler to call when the load request is complete.
 */
+ (void)getDetailsForVendorWithIdentifier:(NSString*_Nonnull)identifier completionHandler:(void (^_Nullable)(Vendor * _Nullable vendor, NSError * _Nullable error))completionHandler;

/**
 * @brief Retrieves the menu of the vendor with the given identifier.
 * @param identifier The identifier of the vendor.
 * @param completionHandler The completion handler to call when the load request is complete.
 */
+ (void)getMenuItemsForVendorWithIdentifier:(NSString *_Nonnull)identifier completionHandler:(void (^_Nullable)(NSArray<MenuItem *> * _Nullable menuItems, NSError * _Nullable error))completionHandler;

/**
 * @brief Retrieves all the events organized by the vendor with the given identifier.
 * @param identifier The identifier of the vendor.
 * @param completionHandler The completion handler to call when the load request is complete.
 */
+ (void)getEventsForVendorWithIdentifier:(NSString*_Nonnull)identifier completionHandler:(void (^_Nullable)(NSArray<Event *> * _Nullable events, NSError * _Nullable error))completionHandler;

@end
