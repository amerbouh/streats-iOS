//
//  LotDetailPageViewController.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-18.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Lot;
@class LotDetailPageViewController;

@protocol LotDetailPageViewControllerDelegate
- (void)didTransitionToPage:(LotDetailPageViewController *_Nonnull)lotDetailPageViewController atIndex:(NSUInteger)index;
@end

@interface LotDetailPageViewController : UIPageViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property(nonatomic, strong, nonnull) Lot *lot;
@property(nonatomic, weak, nullable) id <LotDetailPageViewControllerDelegate> transitionDelegate;

@end
