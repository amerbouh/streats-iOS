//
//  VendorInformationTableViewController.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-14.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Vendor;

@interface VendorInformationTableViewController : UITableViewController

@property(strong, nonatomic, nonnull) Vendor* vendor;

@end
