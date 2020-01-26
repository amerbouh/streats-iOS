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
#import "ServiceError.h"
#import "VendorsService.h"

@interface VendorInformationTableViewController ()

// Properties

@property (strong, nonatomic, nonnull) Position *lastPosition;

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

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *placeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryNameLabel;

// Methods

- (void)populateViews;
- (void)configureMapView;
- (void)completeVendorData;
- (void)configureTitleLabels;

@end

@implementation VendorInformationTableViewController {
    NSArray<NSString *> *_sectionTitles;
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
    
    // Initialize the section titles array.
    _sectionTitles = [[NSArray alloc] initWithObjects:
                      NSLocalizedString(@"details", NULL),
                      NSLocalizedString(@"latestPosition", NULL), nil];
    
    // Do any additional setup after loading the view.
    [self setLastPosition:self.vendor.lastPosition];
    [self.nameLabel setText:self.vendor.name];
    [self.readMoreButton setHidden:YES];
    [self completeVendorData];
    [self configureMapView];
    [self configureTitleLabels];
}

#pragma mark - Methods

- (void)completeVendorData
{
    [VendorsService getDetailsForVendorWithIdentifier:[self.vendor.identifier stringValue] completionHandler:^(Vendor * _Nullable vendor, ServiceError * _Nullable serviceError) {
        if (serviceError != NULL) {
            NSLog(@"An error occured while trying to complete the vendor's data : %@", serviceError.detail);
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setVendor:vendor];
                [self populateViews];
            });
        }
    }];
}

- (void)configureTitleLabels
{
    [self.readMoreButton setTitle:NSLocalizedString(@"readMore", NULL) forState:UIControlStateNormal];
    [self.cuisineTypeTitleLabel setText:NSLocalizedString(@"cuisineType", NULL)];
    [self.phoneNumberTitleLabel setText:NSLocalizedString(@"phoneNumber", NULL)];
    [self.emailAddressTitleLabel setText:NSLocalizedString(@"emailAddress", NULL)];
    [self.websiteTitleLabel setText:NSLocalizedString(@"website", NULL)];
    [self.usefulInformationTitleLabel setText:NSLocalizedString(@"usefulData", NULL)];
    [self.addressTitleLabel setText:NSLocalizedString(@"address", NULL)];
}

- (void)configureMapView
{
    CLLocationCoordinate2D latestPositionCoordinate = [self.vendor.lastPosition getCoordinate];
    
    // Initialize and configure the point annotation.
    MKPointAnnotation *latestPositionAnnotation = [[MKPointAnnotation alloc] init];
    latestPositionAnnotation.coordinate = latestPositionCoordinate;
    
    // Configure the visible region.
    MKCoordinateRegion visibleRegion = MKCoordinateRegionMakeWithDistance(latestPositionCoordinate, 300, 300);
    
    // Set the center coordinate of the map view and add the annotation indicating the latest position
    // of the currently viewed vendor.
    [self.mapView addAnnotation:latestPositionAnnotation];
    [self.mapView setCenterCoordinate:latestPositionCoordinate];
    [self.mapView setRegion:visibleRegion];
}

- (void)populateViews
{
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
    
    // Set the address.
    [self.lastPosition getAddressWithCompletionHandler:^(CLPlacemark * _Nullable placemark, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (placemark != NULL) {
                [self.placeNameLabel setText:placemark.name];
                [self.cityNameLabel setText:[NSString stringWithFormat:@"%@, %@", placemark.subLocality, placemark.postalCode]];
                [self.countryNameLabel setText:placemark.country];
            }
        });
    }];
}

+ (VendorInformationTableViewController *)instanciateFromStoryboard
{
    return [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"VendorInformationTableViewController"];
}

#pragma mark - Table view delegate

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return NULL;
    }
    
    return _sectionTitles[section - 1];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return NSLocalizedString(@"latestLocationDisclaimer", NULL);
    }
    
    return NULL;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 60)];
    
    // Configure the header view...
    NSString * title = [tableView.dataSource tableView:tableView titleForHeaderInSection:section];
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, headerView.bounds.size.width, headerView.bounds.size.height * 1/2)];
    
    [titleLabel setFont:[UIFont systemFontOfSize:24 weight:UIFontWeightBold]];
    [titleLabel setText:title];
    
    [headerView addSubview:titleLabel];
    
    return headerView;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowVendorDescriptionVCSegue"]) {
        UINavigationController *navigationController = (UINavigationController *) segue.destinationViewController;
        VendorDescriptionViewController *descriptionViewController = (VendorDescriptionViewController *) navigationController.visibleViewController;
        
        // Pass the name and the description of the vendor.
        [descriptionViewController setVendorName:self.vendor.name];
        [descriptionViewController setVendorDescription:self.vendor.shortDescription];
    }
}

@end
