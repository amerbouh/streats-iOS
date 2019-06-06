
//
//  MenuItemController.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-06-04.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "MenuItemController.h"
#import "MenuItemsService.h"
#import "Vendor.h"
#import "MenuItem.h"

@interface MenuItemController ()

@property(strong, nonatomic, nonnull) MenuItem *menuItem;

@end

@implementation MenuItemController

- (instancetype)initWithMenuItem:(MenuItem *)menuItem {
    if ((self = [super init])) {
        _menuItem = menuItem;
    }
    
    return self;
}

- (void)uploadItemImage:(UIImage *)image correspondingVendorIdentifier:(NSNumber *)vendorIdentifier completionHandler:(void (^)(NSError * _Nullable))completionHandler {
    [MenuItemsService uploadMenuItemImage:image forMenuItemWithIdentifier:self.menuItem.identifier andVendorWithIdentifier:vendorIdentifier completionHandler:completionHandler];
}

@end
