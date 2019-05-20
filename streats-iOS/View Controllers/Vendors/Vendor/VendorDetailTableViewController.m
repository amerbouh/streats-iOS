//
//  VendorDetailTableViewController.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-14.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "VendorDetailTableViewController.h"
#import "CarouselCollectionViewController.h"
#import "MenuItemsListTableViewController.h"
#import "MenuItemDetailTableViewController.h"
#import "Vendor.h"
#import "VendorsService.h"

@interface VendorDetailTableViewController ()

// Properties

@property (weak, nonatomic) IBOutlet UIView *carouselContainerView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet UILabel *directionsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *cuisineTypeTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailAddressTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *websiteTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *usefulInformationTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *showMoreTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *cuisineTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailAddresslabel;
@property (weak, nonatomic) IBOutlet UILabel *websiteLabel;
@property (weak, nonatomic) IBOutlet UILabel *usefulDataLabel;

// Methods
- (void)populateViews;
- (void)completeVendorData;
- (void)configureTitleLabels;

@end

@implementation VendorDetailTableViewController {
    NSArray<NSString *> *_sectionTitles;
}

#pragma mark - View's lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize the section titles array.
    _sectionTitles = [[NSArray alloc] initWithObjects:
                      NSLocalizedString(@"details", NULL),
                      NSLocalizedString(@"menu", NULL),
                      NSLocalizedString(@"events", NULL),
                      NSLocalizedString(@"location", NULL), nil];
    
    // Do any additional setup after loading the view.
    if (self.vendor == NULL) {
        [NSException raise:@"null pointer" format:@"You must initialize the Vendor object in order to use the Vendor Detail View Controller."];
    } else {
        [self completeVendorData];
        [self configureTitleLabels];
    }
}

#pragma mark - Methods

- (void)completeVendorData {
    [VendorsService getDetailsForVendorWithIdentifier:[self.vendor.identifier stringValue] completionHandler:^(Vendor * _Nullable vendor, NSError * _Nullable error) {
        if (error != NULL) {
            NSLog(@"An error occured while trying to complete the vendor's data : %@", error.localizedDescription);
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setVendor:vendor];
                
                // Reload the carousel's images.
                CarouselCollectionViewController *carouselViewController = (CarouselCollectionViewController *) self.childViewControllers.firstObject;
                [carouselViewController reloadPictures:vendor.banners];
                
                // Populate the views with the completed vendor's data.
                [self populateViews];
            });
        }
    }];
}

- (void)configureTitleLabels {
    [self.cuisineTypeTitleLabel setText:NSLocalizedString(@"cuisineType", NULL)];
    [self.phoneNumberTitleLabel setText:NSLocalizedString(@"phoneNumber", NULL)];
    [self.emailAddressTitleLabel setText:NSLocalizedString(@"emailAddress", NULL)];
    [self.websiteTitleLabel setText:NSLocalizedString(@"website", NULL)];
    [self.usefulInformationTitleLabel setText:NSLocalizedString(@"usefulData", NULL)];
    [self.directionsTitleLabel setText:NSLocalizedString(@"directions", NULL)];
    [self.showMoreTitleLabel setText:NSLocalizedString(@"showMore", NULL)];
}

- (void)populateViews {
    [self.navigationItem setTitle:self.vendor.name];
    
    [self.nameLabel setText:self.vendor.name];
    [self.cuisineTypeLabel setText:self.vendor.cuisineType];
    
    // Set the description.
    if (self.vendor.shortDescription != NULL) {
        [self.descriptionLabel setText:self.vendor.shortDescription];
    } else {
        [self.descriptionLabel setText:NSLocalizedString(@"noDescription", NULL)];
    }
    
    // Set the phone number.
    if (self.vendor.phoneNumber != NULL) {
        [self.phoneNumberLabel setText:self.vendor.phoneNumber];
    } else {
        [self.phoneNumberLabel setText:NSLocalizedString(@"noPhoneNumber", NULL)];
    }
    
    // Set the email address.
    if (self.vendor.emailAddress != NULL) {
        [self.emailAddresslabel setText:self.vendor.emailAddress];
    } else {
        [self.emailAddresslabel setText:NSLocalizedString(@"noEmailAddress", NULL)];
    }

    // Set the website.
    if (self.vendor.website != NULL) {
        [self.websiteLabel setText:self.vendor.website];
    } else {
        [self.websiteLabel setText:NSLocalizedString(@"noWebsite", NULL)];
    }
    
    // Set the payment methods.
    if (self.vendor.paymentMethods == NULL) {
        [self.usefulDataLabel setText:NSLocalizedString(@"mayAcceptCashOnly", NULL)];
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    MenuItemDetailTableViewController *menuItemDetailVC = (MenuItemDetailTableViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"MenuItemDetailTableViewController"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:menuItemDetailVC];
    
    // Configure the Menu Item Detail View Controller.
    [menuItemDetailVC setShouldShowBarButtonItems:YES];
    
    // Configure the navigation controller.
    [navigationController.navigationBar setTranslucent:NO];
    [navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [navigationController.navigationBar setTintColor:UIColor.whiteColor];
    [navigationController.navigationBar setBarTintColor:[UIColor colorNamed:@"Primary"]];
    
    // Present the navigation controller modally.
    [self presentViewController:navigationController animated:YES completion:NULL];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return NULL;
    }
    
    return _sectionTitles[section - 1];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 60)];
    
    // Configure the header view...
    NSString *title = _sectionTitles[section - 1];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, headerView.bounds.size.width, headerView.bounds.size.height * 1/2)];
    
    [titleLabel setFont:[UIFont systemFontOfSize:24 weight:UIFontWeightBold]];
    [titleLabel setText:title];
    
    [headerView addSubview:titleLabel];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return UITableViewAutomaticDimension;
            
        case 1:
            return 60;
            
        case 2:
            return 50;
            
        case 3:
            return 60;
            
        case 4:
            if (indexPath.row == 0) {
                return 180;
            }
            
            return 52;
            
        default:
            return 42;
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (([segue.identifier isEqualToString:@"ShowMenuItemsListVCSegue"])) {
        MenuItemsListTableViewController *menuItemsListVC = (MenuItemsListTableViewController *) segue.destinationViewController;
        menuItemsListVC.vendorIdentifier = self.vendor.identifier;
    } else if ([segue.identifier isEqualToString:@"CarouselCollectionViewEmbedSsgue"]) {
        CarouselCollectionViewController *menuItemsListVC = (CarouselCollectionViewController *) segue.destinationViewController;
        menuItemsListVC.picturesDownloadURLs = self.vendor.banners;
    }
}

@end
