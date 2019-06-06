//
//  VendorInformationTableViewController.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-14.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "VendorInformationTableViewController.h"
#import "MenuItemsListTableViewController.h"
#import "MenuItemDetailTableViewController.h"
#import "VendorDescriptionViewController.h"
#import "Vendor.h"
#import "Position.h"
#import "VendorsService.h"
#import <MapKit/MapKit.h>

@interface VendorInformationTableViewController ()

// Properties

@property(assign) BOOL descriptionRowExpanded;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *readMoreButton;

@property (weak, nonatomic) IBOutlet UILabel *cuisineTypeTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailAddressTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *websiteTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *usefulInformationTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *cuisineTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailAddresslabel;
@property (weak, nonatomic) IBOutlet UILabel *websiteLabel;
@property (weak, nonatomic) IBOutlet UILabel *usefulDataLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

// Methods
- (void)populateViews;
- (void)configureMapView;
- (void)completeVendorData;
- (void)configureTitleLabels;

@end

@implementation VendorInformationTableViewController {
    NSArray<NSString *> *_sectionTitles;
}

#pragma mark - View's lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize the section titles array.
    _sectionTitles = [[NSArray alloc] initWithObjects:
                      NSLocalizedString(@"details", NULL),
                      NSLocalizedString(@"latestPosition", NULL), nil];
    
    // Do any additional setup after loading the view.
    if (self.vendor == NULL) {
        [NSException raise:@"null pointer" format:@"You must initialize the Vendor object in order to use the Vendor Detail View Controller."];
    } else {
        [self.nameLabel setText:self.vendor.name];
        [self.readMoreButton setHidden:YES];
        [self completeVendorData];
        [self configureMapView];
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
                [self populateViews];
            });
        }
    }];
}

- (void)configureTitleLabels {
    [self.readMoreButton setTitle:NSLocalizedString(@"readMore", NULL) forState:UIControlStateNormal];
    [self.cuisineTypeTitleLabel setText:NSLocalizedString(@"cuisineType", NULL)];
    [self.phoneNumberTitleLabel setText:NSLocalizedString(@"phoneNumber", NULL)];
    [self.emailAddressTitleLabel setText:NSLocalizedString(@"emailAddress", NULL)];
    [self.websiteTitleLabel setText:NSLocalizedString(@"website", NULL)];
    [self.usefulInformationTitleLabel setText:NSLocalizedString(@"usefulData", NULL)];
    [self.addressTitleLabel setText:NSLocalizedString(@"address", NULL)];
}

- (void)configureMapView {
    CLLocationCoordinate2D latestPositionCoordinate = [self.vendor.lastPosition getCoordinate];
    
    // Initialize the point annotation.
    MKPointAnnotation *latestPositionAnnotation;
    
    // Create an annotation view.
    if (@available(iOS 13.0, *)) {
        latestPositionAnnotation = [[MKPointAnnotation alloc] initWithCoordinate:latestPositionCoordinate];
    } else {
        latestPositionAnnotation = [[MKPointAnnotation alloc] init];
        latestPositionAnnotation.coordinate = latestPositionCoordinate;
    }
    
    // Set the center coordinate of the map view and add the annotation indicating the latest position
    // of the currently viewed vendor.
    [self.mapView addAnnotation:latestPositionAnnotation];
    [self.mapView setCenterCoordinate:latestPositionCoordinate];
}

- (void)populateViews {
    [self.cuisineTypeLabel setText:self.vendor.cuisineType];
    
    // Set the description.
    if (self.vendor.shortDescription != NULL) {
        [self.descriptionLabel setText:self.vendor.shortDescription];
        [self.readMoreButton setHidden:NO];
    } else {
        [self.descriptionLabel setText:NSLocalizedString(@"noDescription", NULL)];
        [self.readMoreButton setHidden:YES];
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

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowVendorDescriptionVCSegue"]) {
        UINavigationController *navigationController = (UINavigationController *) segue.destinationViewController;
        VendorDescriptionViewController *descriptionViewController = (VendorDescriptionViewController *) navigationController.visibleViewController;
        
        // Pass the name and the description of the vendor.
        [descriptionViewController setVendorName:self.vendor.name];
        [descriptionViewController setVendorDescription:self.vendor.shortDescription];
    }
}

@end
