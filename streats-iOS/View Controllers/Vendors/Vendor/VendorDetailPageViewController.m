//
//  VendorDetailPageViewController.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-20.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "VendorDetailPageViewController.h"
#import "VendorInformationTableViewController.h"
#import "MenuItemsListTableViewController.h"
#import "EventsListTableViewController.h"
#import "Vendor.h"

@interface VendorDetailPageViewController ()

// Properties

@property (strong, nonatomic) NSArray<UITableViewController *> *pages;

// Methods

- (void)initializePages;


@end

@implementation VendorDetailPageViewController

#pragma mark - View's lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self initializePages];
    [self setDelegate:self];
    [self setDataSource:self];
    
    NSArray<UIViewController *> *startViewControllers = [[NSArray alloc] initWithObjects:self.pages.firstObject, nil];
    [self setViewControllers:startViewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
}

#pragma mark - Methods

- (void)initializePages {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:NULL];
    
    VendorInformationTableViewController *informationTableViewController = (VendorInformationTableViewController *) [storyboard instantiateViewControllerWithIdentifier:@"VendorInformationTableViewController"];
    MenuItemsListTableViewController *menuItemsTableViewController = (MenuItemsListTableViewController *) [storyboard instantiateViewControllerWithIdentifier:@"MenuItemsListTableViewController"];
    EventsListTableViewController *eventsTableViewController = (EventsListTableViewController *) [storyboard instantiateViewControllerWithIdentifier:@"EventsListTableViewController"];
    
    // Pass the vendor object to the view controllers.
    [informationTableViewController setVendor:self.vendor];
    [menuItemsTableViewController setVendorIdentifier:self.vendor.identifier];
    [eventsTableViewController setVendorIdentifier:self.vendor.identifier];
    
    // Initialize the arrays of pages.
    self.pages = [[NSArray alloc] initWithObjects:informationTableViewController, menuItemsTableViewController, eventsTableViewController, nil];
}

#pragma mark - Page view controller data source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger currentIndex = [self.pages indexOfObject:(UITableViewController *) viewController];
    NSInteger nextIndex = currentIndex + 1;
    
    // If the next index is greater than the pages count, it means that there is no
    // view controller after the current one.
    if (nextIndex == self.pages.count) {
        return NULL;
    }
    
    return [self.pages objectAtIndex:nextIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger currentIndex = [self.pages indexOfObject:(UITableViewController *) viewController];
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
        UITableViewController *visibleViewController = pageViewController.viewControllers.firstObject;
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
