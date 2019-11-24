//
//  MenuItemsService.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-06-04.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;
@class MenuItem;

@interface MenuItemsService : NSObject

/**
 * @brief Uploads the given image for the menu item with the given identifier.
 * @param image The image of the menu item.
 * @param menuItemIdentifier The identifier of the menu item corresponding to the image.
 * @param vendorIdentifier The vendor identifier of the vendor.
 * @param completionHandler The completion handler to call when the upload is complete.
 */
+ (void)uploadMenuItemImage:(UIImage *_Nonnull)image forMenuItemWithIdentifier:(NSString *_Nonnull)menuItemIdentifier andVendorWithIdentifier:(NSNumber *_Nonnull)vendorIdentifier completionHandler:(void (^_Nullable)(NSError * _Nullable error))completionHandler;

@end
