//
//  HorizontalPageViewControllerManager.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-06-08.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HorizontalPageViewControllerManagerDelegate
- (void)didTransitionToPage:(UIViewController *_Nonnull)pageViewController atIndex:(NSUInteger)index;
@end

@interface HorizontalPageViewControllerManager : NSObject <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

// Properties

@property(strong, nonatomic, nonnull) NSArray<UIViewController *> *pages;
@property(weak, nonatomic, nullable) id <HorizontalPageViewControllerManagerDelegate> delegate;

// Methods

- (instancetype _Nullable)initWithPages:(NSArray<UIViewController *> * _Nonnull)pages managedPageViewController:(UIPageViewController * _Nonnull)managedPageViewController;

@end
