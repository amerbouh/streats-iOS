//
//  MenuItemsListTableViewController.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-16.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Vendor;

@interface MenuItemsListTableViewController : UITableViewController

- (instancetype)initWithVendor:(Vendor *)vendor;

@end
