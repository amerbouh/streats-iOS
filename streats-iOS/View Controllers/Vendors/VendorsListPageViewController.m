//
//  VendorsListPageViewController.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-13.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "VendorsListPageViewController.h"
#import "VendorsListTableViewController.h"

@interface VendorsListPageViewController ()

// Properties

@property (strong, nonatomic) NSArray<VendorsListTableViewController *>* pages;

// Methods

- (void)initializePages;

@end

@implementation VendorsListPageViewController

#pragma mark - View's lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self initializePages];
    [self setDelegate:self];
    [self setDataSource:self];

    NSArray<UIViewController *>* startViewControllers = [[NSArray alloc] initWithObjects:self.pages.firstObject, nil];
    [self setViewControllers:startViewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
}

#pragma mark - Methods

- (void)initializePages {
    VendorsListTableViewController* todayVendorsListVC = [[VendorsListTableViewController alloc] initWithFilter:@"today"];
    VendorsListTableViewController* tomorrowVendorsListVC = [[VendorsListTableViewController alloc] initWithFilter:@"tomorrow"];
    VendorsListTableViewController* weekVendorsListVC = [[VendorsListTableViewController alloc] initWithFilter:@"anytime"];
    
    // Initialize the arrays of pages.
    self.pages = [[NSArray alloc] initWithObjects:todayVendorsListVC, tomorrowVendorsListVC, weekVendorsListVC, nil];
}

#pragma mark - Page view controller data source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger currentIndex = [self.pages indexOfObject:(VendorsListTableViewController*) viewController];
    NSInteger nextIndex = currentIndex + 1;
    
    // If the next index is greater than the pages count, it means that there is no
    // view controller after the current one.
    if (nextIndex == self.pages.count) {
        return NULL;
    }
    
    return [self.pages objectAtIndex:nextIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger currentIndex = [self.pages indexOfObject:(VendorsListTableViewController*) viewController];
    NSInteger previousIndex = currentIndex - 1;
    
    // If the next index is greater than the pages count, it means that there is no
    // view controller after the current one.
    if (previousIndex < 0) {
        return NULL;
    }
    
    return [self.pages objectAtIndex:previousIndex];
}

#pragma mark - Page view controller delegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    // Only notify the delegate if the used completed the page-turn
    // gesture.
    if (completed) {
        VendorsListTableViewController* visibleViewController = pageViewController.viewControllers.firstObject;
        NSUInteger visibleViewControllerIndex = [self.pages indexOfObject:visibleViewController];
        
        // Figure out the index of the page the used navigated to based
        // on the previous pages count.
        if (!visibleViewControllerIndex) {
            [self.transitionDelegate didTransitionToPage:self atIndex:0];
        } else {
            [self.transitionDelegate didTransitionToPage:self atIndex:visibleViewControllerIndex];
        }
    }
}

@end
