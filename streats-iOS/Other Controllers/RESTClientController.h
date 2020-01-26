//
//  RESTClientController.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-12-15.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Vendor;
@class MenuItem;
@class ServiceError;

@interface RESTClientController : NSObject

/**
 * @brief Retrieves the details of the vendor with the given identifier.
 * @param identifier The identifier of the vendor.
 * @param completionHandler The completion handler to call when the load request is complete.
 */
- (void)getDetailsForVendorWithIdentifier:(NSString * _Nonnull)identifier completionHandler:(void (^_Nullable)(Vendor * _Nullable vendor, ServiceError * _Nullable error))completionHandler;

/**
 * @brief Retrieves the menu of the vendor with the given identifier.
 * @param identifier The identifier of the vendor.
 * @param completionHandler The completion handler to call when the load request is complete.
 */
- (void)getMenuItemsForVendorWithIdentifier:(NSString * _Nonnull)identifier completionHandler:(void (^_Nullable)(NSArray<MenuItem *> * _Nullable menuItems, ServiceError * _Nullable serviceError))completionHandler;

@end

NS_ASSUME_NONNULL_END
