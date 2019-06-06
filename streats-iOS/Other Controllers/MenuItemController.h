//
//  MenuItemController.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-06-04.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Vendor;
@class MenuItem;
@class UIImage;

@interface MenuItemController : NSObject

- (instancetype _Nullable)initWithMenuItem:(MenuItem *_Nonnull)menuItem;

/**
 * @brief Uploads an image of the menu item on Firebase Cloud Storage.
 * @param image The image of the menu item.
 * @param vendorIdentifier The identifer of the vendor whose the menu item belongs to.
 * @param completionHandler The completion handler to call when the upload is complete.
 * 
 */
- (void)uploadItemImage:(UIImage *_Nonnull)image correspondingVendorIdentifier:(NSNumber *_Nonnull)vendorIdentifier completionHandler:(void (^_Nullable)(NSError * _Nullable error))completionHandler;

@end
