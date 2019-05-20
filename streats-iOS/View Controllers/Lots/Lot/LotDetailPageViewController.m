//
//  LotDetailPageViewController.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-18.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "LotDetailPageViewController.h"
#import "LotAttendeesListTableViewController.h"
#import "LotInformationTableViewController.h"
#import "Lot.h"

@interface LotDetailPageViewController ()

// Properties

@property(strong, nonatomic, nonnull) NSArray<UITableViewController *> *pages;

// Methods

- (void)initializePages;

@end

@implementation LotDetailPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self initializePages];
    [self setDelegate:self];
    [self setDataSource:self];
   
    NSArray<UIViewController *>* startViewControllers = [[NSArray alloc] initWithObjects:self.pages.firstObject, nil];
    [self setViewControllers:startViewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
}

#pragma mark - Methods

- (void)initializePages {
    LotAttendeesListTableViewController* attendesListVC = [[LotAttendeesListTableViewController alloc] initWithAttendees:self.lot.attendees];
    LotInformationTableViewController* informationVC = (LotInformationTableViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"LotInformationTableViewController"];
    
    // Pass the Lot object.
    [informationVC setLot:self.lot];
    
    // Initialize the arrays of pages.
    self.pages = [[NSArray alloc] initWithObjects:attendesListVC, informationVC, nil];
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
        UITableViewController* visibleViewController = pageViewController.viewControllers.firstObject;
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
