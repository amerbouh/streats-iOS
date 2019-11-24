//
//  VendorsListTableViewController.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-13.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "VendorsListTableViewController.h"
#import "TabViewController.h"
#import "MenuItemsListTableViewController.h"
#import "VendorInformationTableViewController.h"
#import "MenuItemsListTableViewController.h"
#import "EventsListTableViewController.h"
#import "EmptyTableBackgroundView.h"
#import "VendorTableViewCell.h"
#import "Lot.h"
#import "Vendor.h"
#import "ServiceError.h"
#import "VendorsService.h"
#import "ImagesService.h"
#import "TabBarItem.h"

@interface VendorsListTableViewController ()

// Properties

@property(strong, nonatomic, nullable) Lot *lot;
@property(strong, nonatomic, nullable) NSArray<Vendor *> *vendors;

// Methods

- (void)loadVendors;
- (void)showActivityIndicator;
- (void)hideActivityIndicator;
- (void)showEmptyDataSetView;
- (void)showErrorMessage:(NSString*)message;

@end

@implementation VendorsListTableViewController {
    NSString* _dayFilter;
    NSString* _reuseIdentifier;
}

#pragma mark - Initialization

- (instancetype)initWithLot:(Lot *)lot
{
    if ((self = [super init])) {
        _lot = lot;
    }
    
    return self;
}

- (instancetype)initWithFilter:(NSString *)filter
{
    if ((self = [super init])) {
        _dayFilter = filter;
    }
    
    return self;
}

#pragma mark - View's lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    // Initialize the reuse identifier.
    _reuseIdentifier = @"VendorTableViewCell";
    
    // Register cell classes.
    UINib* vendorCellNib = [UINib nibWithNibName:@"VendorTableViewCell" bundle:NULL];
    [self.tableView registerNib:vendorCellNib forCellReuseIdentifier:_reuseIdentifier];
    
    // Do any additional setup after loading the view.
    [self loadVendors];
    [self registerForPreviewingWithDelegate:self sourceView:self.tableView];
}

#pragma mark - Methods

- (void)showActivityIndicator
{
    UIActivityIndicatorView* activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    // Set the activity indicator as the background of the table view and start animating it.
    [activityIndicator startAnimating];
    [self.tableView setBackgroundView:activityIndicator];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)hideActivityIndicator
{
    [self.tableView setBackgroundView:NULL];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
}

- (void)showEmptyDataSetView
{
    EmptyTableBackgroundView *emptyTableBackgroundView = [[EmptyTableBackgroundView alloc] initWithMessage:NSLocalizedString(@"noVendors", NULL) andDescription:NSLocalizedString(@"noVendorsDescription", NULL)];
    
    // Set the empty table background view as the background of the table view.
    [self.tableView setBackgroundView:emptyTableBackgroundView];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)showErrorMessage:(NSString *)message
{
    ErrorView *errorView = [[ErrorView alloc] initWithMessage:message];
    
    // Configure the error view...
    [errorView setDelegate:self];
    [errorView setFrame:self.tableView.bounds];
    
    // Set the error view as the table view's background.
    [self.tableView setBackgroundView:errorView];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)loadVendors
{
    if (self.lot != NULL) {
        self.vendors = self.lot.attendees;
        [self.tableView reloadData];
        
        return;
    }
        
    // Show the activity indicator.
    [self showActivityIndicator];
    
    // Fetch the vendors.
    [[VendorsService new] getVendorsForTime:_dayFilter completionHandler:^(NSArray<Vendor *> * _Nullable vendors, ServiceError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideActivityIndicator];
            
            if (error != NULL) {
                [self showErrorMessage:error.detail];
            } else {
                if (vendors.count > 0) {
                    self.vendors = vendors;
                    [self.tableView reloadData];
                } else {
                    [self showEmptyDataSetView];
                }
            }
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.vendors.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VendorTableViewCell *cell = (VendorTableViewCell *) [tableView dequeueReusableCellWithIdentifier:_reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Vendor* vendor = [self.vendors objectAtIndex:indexPath.row];
    
    [cell setDelegate:self];
    [cell populateWithVendor:vendor];
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Vendor* selectedVendor = [self.vendors objectAtIndex:indexPath.row];
    
    // Get an instance of the necessary view controllers.
    VendorInformationTableViewController *vendorInformationVC = [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"VendorInformationTableViewController"];
    MenuItemsListTableViewController *menuItemsListVC = [[MenuItemsListTableViewController alloc] initWithVendor:selectedVendor];
    EventsListTableViewController *eventsListVC = [[EventsListTableViewController alloc] initWithVendor:selectedVendor];
    
    // Configure the view controllers, if applicable.
    [vendorInformationVC setVendor:selectedVendor];
    
    // Prepare the Vendor Details VC.
    NSArray<TabBarItem *> *items = @[
                                 [[TabBarItem alloc] initWithTitle:NSLocalizedString(@"information", NULL) controller:vendorInformationVC],
                                 [[TabBarItem alloc] initWithTitle:NSLocalizedString(@"menu", NULL) controller:menuItemsListVC],
                                 [[TabBarItem alloc] initWithTitle:NSLocalizedString(@"events", NULL) controller:eventsListVC]
                                 ];
    
    // Get an instance of the Tab View Controller.
    TabViewController *vendorDetailsTabViewController = [[TabViewController alloc] initWithItems:items];
    [vendorDetailsTabViewController.navigationItem setTitle:selectedVendor.name];
    
    // Present the Tab View Controller.
    [self.navigationController pushViewController:vendorDetailsTabViewController animated:YES];
}

#pragma mark - View Controller Previewing Delegate

- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
}

- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    // Get the pressed vendor.
    NSIndexPath *pressedCellIndexPath = [self.tableView indexPathForRowAtPoint:location];
    Vendor *pressedVendor = [self.vendors objectAtIndex:pressedCellIndexPath.row];
    
    // Get an instance of the Menu items table view controller.
    MenuItemsListTableViewController *menuItemsListVC = [[MenuItemsListTableViewController alloc] initWithVendor:pressedVendor];
    
    // Set the source rect.
    previewingContext.sourceRect = [self.tableView cellForRowAtIndexPath:pressedCellIndexPath].frame;
    
    return menuItemsListVC;
}

#pragma mark - Error view delegate

- (void)tryAgainButtonTaped:(ErrorView *)errorView
{
    [self loadVendors];
}

#pragma mark - Vendor table view cell delegate

- (void)didRequestResourceWithURL:(NSURL *)URL from:(VendorTableViewCell *)requestor
{
    [ImagesService downloadImageWithURL:URL completionHandler:^(UIImage * _Nullable downloadedImage, NSError * _Nullable error) {
        if (error == NULL) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [requestor setVendorImage:downloadedImage];
            });
        }
    }];
}

@end
