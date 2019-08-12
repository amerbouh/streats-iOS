//
//  TabViewController.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-06-07.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "TabViewController.h"
#import "HorizontalPageViewControllerManager.h"
#import "TabView.h"
#import "TabBarItem.h"

@interface TabViewController ()

// Properties

@property(strong, nonatomic, nonnull) TabView *tabView;
@property(strong, nonatomic, nonnull) UIPageViewController *pageViewController;
@property(strong, nonatomic, nonnull) HorizontalPageViewControllerManager *pageViewControllerManager;

// Methods

- (void)layoutTabView;
- (void)layoutPageViewController;

@end

@implementation TabViewController

#pragma mark - Initialization

- (instancetype)initWithItems:(NSArray<TabBarItem *> *)items {
    if ((self = [super init])) {
        NSMutableArray<NSString *> *titles = [[NSMutableArray alloc] init];
        NSMutableArray<UIViewController *> *pages = [[NSMutableArray alloc] init];
        
        // Loop through each tab item and add its title to the titles
        // array.
        for (TabBarItem *item in items) {
            [titles addObject:item.title];
            [pages addObject:item.viewController];
        }
        
        _tabView = [[TabView alloc] initWithTitles:titles];
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:NULL];
        _pageViewControllerManager = [[HorizontalPageViewControllerManager alloc] initWithPages:pages managedPageViewController:_pageViewController];
    }
    
    return self;
}


#pragma mark - View's lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self.pageViewController setDataSource:self.pageViewControllerManager];
    [self.pageViewControllerManager setDelegate:self];
}

#pragma mark - Methods

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    // Configure the views' hierarchy
    [self.view addSubview:self.tabView];
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    
    // Notify the page view controller that it was added as a child view controller.
    [self.pageViewController didMoveToParentViewController:self];
    
    // Layout the subviews
    [self layoutTabView];
    [self layoutPageViewController];
}

- (void)layoutTabView {
    [self.tabView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // Set the tab view's constraints.
    [[self.tabView.heightAnchor constraintEqualToConstant:55] setActive:YES];
    [[self.tabView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor] setActive:YES];
    [[self.tabView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor] setActive:YES];
    [[self.tabView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor] setActive:YES];
}

- (void)layoutPageViewController {
    [self.pageViewController.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // Get the page view controller's view.
    UIView *pageViewControllerView = self.pageViewController.view;
    
    // Set the page view controller's constraints.
    [[pageViewControllerView.topAnchor constraintEqualToAnchor:self.tabView.bottomAnchor] setActive:YES];
    [[pageViewControllerView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor] setActive:YES];
    [[pageViewControllerView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor] setActive:YES];
    [[pageViewControllerView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor] setActive:YES];
}

#pragma mark - Horizontal page view controller manager delegate

- (void)didTransitionToPage:(UIViewController *)pageViewController atIndex:(NSUInteger)index {
    [self.tabView selectTabAtIndex:index];
}

@end
