//
//  VendorDetailContainerViewController.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-20.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VendorDetailPageViewController.h"

@class Vendor;

@interface VendorDetailContainerViewController : UIViewController <VendorDetailPageViewControllerDelegate>

@property(strong, nonatomic, nonnull) Vendor *vendor;

@end
