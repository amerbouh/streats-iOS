//
//  VendorDetailViewController.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-08-12.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "VendorDetailViewController.h"
#import "EventListViewController.h"
#import "MenuItemsListTableViewController.h"
#import "VendorInformationTableViewController.h"
#import "Vendor.h"

@interface VendorDetailViewController ()

@property (strong, nonatomic, nonnull) Vendor *vendor;
@property (strong, nonatomic, nonnull) EventListViewController *eventsListViewController;
@property (strong, nonatomic, nonnull) MenuItemsListTableViewController *menuItemsListViewController;
@property (strong, nonatomic, nonnull) VendorInformationTableViewController *vendorInformationViewController;

@end

@implementation VendorDetailViewController

#pragma mark - Initialization

- (instancetype)initWithVendor:(Vendor *)vendor {
    if ((self = [super init])) {
        _vendor = vendor;
        _eventsListViewController = [[EventListViewController alloc] initWithVendor:vendor];
        _menuItemsListViewController = [[MenuItemsListTableViewController alloc] initWithVendor:vendor];
        _vendorInformationViewController = [VendorInformationTableViewController instanciateFromStoryboard];
    }
    
    return self;
}

#pragma mark - View's lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:self.vendor.name];
}

@end
