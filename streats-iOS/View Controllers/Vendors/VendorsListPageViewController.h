//
//  VendorsListPageViewController.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-13.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VendorsListPageViewController;
@protocol VendorsListPageViewControllerDelegate
- (void)didTransitionToPage:(VendorsListPageViewController *_Nonnull)vendorsListPageViewController atIndex:(NSUInteger)index;
@end

@interface VendorsListPageViewController : UIPageViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property(nonatomic, weak, nullable) id <VendorsListPageViewControllerDelegate> transitionDelegate;

@end
