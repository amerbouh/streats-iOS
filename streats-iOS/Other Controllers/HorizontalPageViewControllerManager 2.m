//
//  HorizontalPageViewControllerManager.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-06-08.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "HorizontalPageViewControllerManager.h"

@interface HorizontalPageViewControllerManager ()

@property(strong, nonatomic, nonnull) UIPageViewController *managedPageViewController;

@end

@implementation HorizontalPageViewControllerManager

- (instancetype)initWithPages:(NSArray<UIViewController *> *)pages managedPageViewController:(UIPageViewController *)managedPageViewController {
    if ((self = [super init])) {
        _pages = pages;
        [managedPageViewController setDelegate:self];
        [managedPageViewController setViewControllers:[NSArray arrayWithObjects:_pages.firstObject, nil] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
    }
    
    return self;
}

#pragma mark - Page view controller data source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger currentIndex = [self.pages indexOfObject: viewController];
    NSInteger nextIndex = currentIndex + 1;
    
    // If the next index is greater than the pages count, it means that there is no
    // view controller after the current one.
    if (nextIndex > self.pages.count - 1) {
        return NULL;
    }
        
    return [self.pages objectAtIndex:nextIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger currentIndex = [self.pages indexOfObject: viewController];
    
    // If the next index is greater than the pages count, it means that there is no
    // view controller after the current one.
    if ((currentIndex == 0) || (currentIndex == NSNotFound)) {
        return NULL;
    }
    
    return [self.pages objectAtIndex:currentIndex - 1];
}

#pragma mark - Page view controller delegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    // Only notify the delegate if the used completed the page-turn
    // gesture.
    if (completed) {
        UIViewController *visibleViewController = pageViewController.viewControllers.firstObject;
        NSUInteger visibleViewControllerIndex = [self.pages indexOfObject:visibleViewController];
        
        // Figure out the index of the page the used navigated to based
        // on the previous pages count.
        if (!visibleViewControllerIndex) {
            [self.delegate didTransitionToPage:self.managedPageViewController atIndex:0];
        } else {
            [self.delegate didTransitionToPage:self.managedPageViewController atIndex:visibleViewControllerIndex];
        }
    }
}

@end
