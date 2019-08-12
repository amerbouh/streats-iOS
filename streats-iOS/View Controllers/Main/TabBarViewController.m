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

+ (UIViewController *)createTabBarItemWithTitle:(NSString *)title image:(UIImage *)image controller:(UIViewController *)controller;
+ (UIViewController *)createTabBarItemWithLocalizedTitle:(NSString *)title image:(UIImage *)image controller:(UIViewController *)controller;


@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    MapViewController *mapViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"MapViewController"];
    TabViewController *vendorsListViewController = [[TabViewController alloc] initWithItems:@[
                                                                                     [[TabBarItem alloc] initWithTitle:NSLocalizedString(@"today", NULL) controller:[[VendorsListTableViewController alloc] initWithFilter:@"today"]],
                                                                                     [[TabBarItem alloc] initWithTitle:NSLocalizedString(@"tomorrow", NULL) controller:[[VendorsListTableViewController alloc] initWithFilter:@"tomorrow"]],
                                                                                     [[TabBarItem alloc] initWithTitle:NSLocalizedString(@"thisWeek", NULL) controller:[[VendorsListTableViewController alloc] initWithFilter:@"This%20Week"]],
                                                                                     ]];
    
    // Create the contained view controllers.
    BaseNavigationController *mapNavigationController = (BaseNavigationController *) [TabBarViewController createTabBarItemWithLocalizedTitle:@"map" image:[UIImage imageNamed:@"Tab bar icons/ic_map"] controller:[[BaseNavigationController alloc] init]];
    BaseNavigationController *vendorsListNavigationController = (BaseNavigationController *) [TabBarViewController createTabBarItemWithLocalizedTitle:@"list" image:[UIImage imageNamed:@"Tab bar icons/ic_list"] controller:[[BaseNavigationController alloc] init]];
    
    [vendorsListViewController.navigationItem setTitle:NSLocalizedString(@"vendors", NULL)];
    [vendorsListNavigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    // Configure the contained view controllers.
    [mapNavigationController setViewControllers:[NSArray arrayWithObjects:mapViewController, nil]];
    [vendorsListNavigationController setViewControllers:[NSArray arrayWithObjects:vendorsListViewController, nil]];
    
    // Add the contained view controllers.
    [self setViewControllers:[NSArray arrayWithObjects:mapNavigationController, vendorsListNavigationController, nil]];
}

#pragma mark - Methods

+ (UIViewController *)createTabBarItemWithTitle:(NSString *)title image:(UIImage *)image controller:(UIViewController *)controller {
    [controller setTitle:title];
    
    // Configure the controller's tab bar item.
    [controller.tabBarItem setTitle:title];
    [controller.tabBarItem setImage:image];
    
    return controller;
}

+ (UIViewController *)createTabBarItemWithLocalizedTitle:(NSString *)title image:(UIImage *)image controller:(UIViewController *)controller {
    [controller setTitle:title];
    
    // Configure the controller's tab bar item.
    [controller.tabBarItem setTitle:NSLocalizedString(title, NULL)];
    [controller.tabBarItem setImage:image];
    
    return controller;
}

@end
