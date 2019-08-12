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

// Properties

@property(strong, nonatomic, nonnull) Vendor* vendor;

// Methods

- (instancetype _Nullable)initWithVendor:(Vendor * _Nonnull)vendor;

@end
