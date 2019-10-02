//
//  VendorDetailViewController.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-08-12.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "TabViewController.h"

@class Vendor;

@interface VendorDetailViewController : TabViewController

// Initialization

- (instancetype _Nullable)initWithVendor:(Vendor * _Nonnull)vendor;

@end
