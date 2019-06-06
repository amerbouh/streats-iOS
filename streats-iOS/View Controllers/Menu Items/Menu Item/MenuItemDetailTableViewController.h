//
//  MenuItemDetailTableViewController.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-16.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuItem;

@interface MenuItemDetailTableViewController : UITableViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(strong, nonatomic, nonnull) MenuItem *menuItem;
@property(strong, nonatomic, nonnull) NSNumber *vendorIdentifier;

@end
