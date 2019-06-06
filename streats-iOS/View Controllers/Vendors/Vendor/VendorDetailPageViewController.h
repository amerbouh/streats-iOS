//
//  VendorDetailPageViewController.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-20.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Vendor;
@class VendorDetailPageViewController;

@protocol VendorDetailPageViewControllerDelegate
- (void)didTransitionToPage:(VendorDetailPageViewController *_Nonnull)vendorDetailPageViewController atIndex:(NSUInteger)index;
@end

@interface VendorDetailPageViewController : UIPageViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property(nonatomic, strong, nonnull) Vendor *vendor;
@property(nonatomic, weak, nullable) id <VendorDetailPageViewControllerDelegate> transitionDelegate;

@end
