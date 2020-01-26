//
//  MenuItemsListTableViewController.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-16.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "MenuItemsListTableViewController.h"
#import "MenuItemDetailTableViewController.h"
#import "EmptyTableBackgroundView.h"
#import "MenuItemTableViewCell.h"
#import "ErrorView.h"
#import "Vendor.h"
#import "MenuItem.h"
#import "ServiceError.h"
#import "VendorsService.h"

@interface MenuItemsListTableViewController ()

// Properties

@property (strong, nonatomic, nonnull) Vendor *vendor;
@property (strong, nonatomic, nullable) NSArray<MenuItem *> *menuItems;

// Methods

- (void)loadMenuItems;
- (void)showActivityIndicator;
- (void)hideActivityIndicator;
- (void)showEmptyTableBackgroundView;
- (void)showErrorViewWithErrorMessage:(NSString * _Nonnull)errorMessage;

@end

@implementation MenuItemsListTableViewController
{
    NSString * _reuseIdentifier;
}

#pragma mark - Initialization

- (instancetype)initWithVendor:(Vendor *)vendor
{
    self = [super init];
    if (self) {
        _vendor = vendor;
    }
    return self;
}

#pragma mark - View's lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize the reuse identifier.
    _reuseIdentifier = @"MenuItemTableViewCell";
    
    // Register cell classes.
    UINib *cellsNib = [UINib nibWithNibName:@"MenuItemTableViewCell" bundle:NULL];
    [self.tableView registerNib:cellsNib forCellReuseIdentifier:_reuseIdentifier];
    
    // Do any additional setup after loading the view.
    [self loadMenuItems];
    [self.navigationItem setTitle:NSLocalizedString(@"menu", @"")];
}

#pragma mark - Methods

- (void)loadMenuItems
{
    [self showActivityIndicator];
    
    // Fetch the vendor's menu items.
    [VendorsService getMenuItemsForVendorWithIdentifier:[self.vendor.identifier stringValue] completionHandler:^(NSArray<MenuItem *> * _Nullable menuItems, ServiceError * _Nullable serviceError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideActivityIndicator];
           
            if (serviceError != NULL) {
                [self showErrorViewWithErrorMessage:serviceError.detail];
            } else {
                if (menuItems.count < 1) {
                    [self showEmptyTableBackgroundView];
                } else {
                    self.menuItems = menuItems;
                    [self.tableView reloadData];
                }
            }
        });
    }];
}

- (void)showEmptyTableBackgroundView
{
    EmptyTableBackgroundView *backgroundView = [[EmptyTableBackgroundView alloc] initWithMessage:NSLocalizedString(@"noMenuItems", NULL) andDescription:NSLocalizedString(@"noMenuItemsDescription", NULL)];
    
    // Set the background as the table view's background.
    [self.tableView setBackgroundView:backgroundView];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)showErrorViewWithErrorMessage:(NSString *)errorMessage
{
    ErrorView *errorView = [[ErrorView alloc] initWithMessage:errorMessage];
    
    // Set the error view as the table view's background.
    [self.tableView setBackgroundView:errorView];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
}

- (void)showActivityIndicator
{
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    [activityIndicator startAnimating];
    [activityIndicator setColor:UIColor.grayColor];
    
    // Set the activity indicator as the table view's background.
    [self.tableView setBackgroundView:activityIndicator];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)hideActivityIndicator
{
    [self.tableView setBackgroundView:NULL];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuItemTableViewCell *cell = (MenuItemTableViewCell *) [tableView dequeueReusableCellWithIdentifier:_reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    MenuItem *menuItem = [self.menuItems objectAtIndex:indexPath.row];
    [cell populateCellWithMenuItem:menuItem];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    UINavigationController * menuItemDetailVCNavigationController = (UINavigationController *) [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"MenuItemDetailVCNavigationController"];
    
    // Get an instance of the MenuItemDetailTableViewController.
    MenuItemDetailTableViewController * menuItemDetailTableViewController = (MenuItemDetailTableViewController *) [menuItemDetailVCNavigationController visibleViewController];
    
    // Initialize the MenuItemDetailTableViewController instance variables.
    menuItemDetailTableViewController.menuItem = [self.menuItems objectAtIndex:indexPath.row];
    menuItemDetailTableViewController.vendorIdentifier = self.vendor.identifier;
    
    // Present the details of the selected menu item.
    [self presentViewController:menuItemDetailVCNavigationController animated:YES completion:NULL];
}

@end
