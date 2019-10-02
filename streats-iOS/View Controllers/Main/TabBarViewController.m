//
//  TabBarViewController.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-17.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "TabBarViewController.h"
#import "TabViewController.h"
#import "MapViewController.h"
#import "BaseNavigationController.h"
#import "VendorsListTableViewController.h"
#import "TabBarItem.h"

@interface TabBarViewController ()

/* The View Controller object used to display the position of the lots. */
@property (strong, nonatomic, nonnull) MapViewController *mapViewController;

/* The View Controller object used to present a list of vendors. */
@property (strong, nonatomic, nonnull) TabViewController *vendorsListViewController;

/* Configures the appearance of the Tab Bar View Controller. */
- (void)configureAppearance;

@end

@implementation TabBarViewController

#pragma mark - Initialization

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _mapViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"MapViewController"];
        _vendorsListViewController = [[TabViewController alloc] initWithItems:@[
            [[TabBarItem alloc] initWithTitle:NSLocalizedString(@"today", NULL) controller:[[VendorsListTableViewController alloc] initWithFilter:@"today"]],
            [[TabBarItem alloc] initWithTitle:NSLocalizedString(@"tomorrow", NULL) controller:[[VendorsListTableViewController alloc] initWithFilter:@"tomorrow"]],
            [[TabBarItem alloc] initWithTitle:NSLocalizedString(@"thisWeek", NULL) controller:[[VendorsListTableViewController alloc] initWithFilter:@"This%20Week"]],
        ]];
    }
    return self;
}

#pragma mark - View's lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    BaseNavigationController *mapNavigationController = [[BaseNavigationController alloc] initWithRootViewController:self.mapViewController];
    BaseNavigationController *vendorsListNavigationController = [[BaseNavigationController alloc] initWithRootViewController:self.vendorsListViewController];
    
    [self.vendorsListViewController.navigationItem setTitle:NSLocalizedString(@"vendors", NULL)];
    [vendorsListNavigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    // Configure the contained view controllers.
    [mapNavigationController setViewControllers:[NSArray arrayWithObjects:self.mapViewController, nil]];
    [mapNavigationController.tabBarItem setTitle:NSLocalizedString(@"map", NULL)];
    [mapNavigationController.tabBarItem setImage:[UIImage imageNamed:@"Tab bar icons/ic_map"]];
    
    [vendorsListNavigationController setViewControllers:[NSArray arrayWithObjects:self.vendorsListViewController, nil]];
    [vendorsListNavigationController.tabBarItem setTitle:NSLocalizedString(@"list", NULL)];
    [vendorsListNavigationController.tabBarItem setImage:[UIImage imageNamed:@"Tab bar icons/ic_list"]];
    
    // Add the contained view controllers.
    [self setViewControllers:@[
        mapNavigationController,
        vendorsListNavigationController
    ]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Do any additional setup before the view appears.
    [self configureAppearance];
}

#pragma mark - Methods

- (void)configureAppearance
{
    [self.tabBar setTintColor:[UIColor colorNamed:@"Red"]];
}

@end
