//
//  MapViewController.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-18.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "MapViewController.h"
#import "LotDetailContainerViewController.h"
#import "Lot.h"
#import "LotsService.h"
#import "ServiceError.h"
#import "BaseNavigationController.h"

@interface MapViewController ()

// Properties

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;

// Methods

- (void)loadLots;
- (void)configureMapView;
- (void)zoomMapOnMontreal;
- (void)showErrorMessage:(NSString *)message;
- (void)zoomMapOnCoordinate:(CLLocationCoordinate2D)coordinate withDistance:(CLLocationDistance)distance;

@end

@implementation MapViewController

#pragma mark - View's lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    [self configureMapView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Do any additional setup before the view appears.
    [self loadLots];
}

#pragma mark - Methods

- (void)loadLots
{
    [[LotsService new] getLotsForTime:@"today" completionHandler:^(NSArray<Lot *> * _Nullable lots, ServiceError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error != NULL) {
                [self showErrorMessage:error.title];
            } else {
                // Add each lot as an annotation on the map.
                for (Lot *lot in lots) {
                    [self.mapView addAnnotation:lot];
                }
            }
        });
    }];
}

- (void)configureMapView
{
    self.locationManager = [[CLLocationManager alloc] init];
    
    // Configure the location manager.
    [self.locationManager setDelegate:self];
    
    // Request the user's authorization to access his location, if applicable.
    if (CLLocationManager.authorizationStatus == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestWhenInUseAuthorization];
    }
}

- (void)zoomMapOnMontreal
{
    CLLocationCoordinate2D montrealCenterCoordinate = CLLocationCoordinate2DMake(45.5017, -73.5673);
    [self zoomMapOnCoordinate:montrealCenterCoordinate withDistance:19000];
}

- (void)showErrorMessage:(NSString *)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"oops", NULL) message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // Configure the alert controller...
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:NULL];
    UIAlertAction *tryAgainAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"tryAgain", NULL) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self loadLots];
    }];
    
    [alertController addAction:tryAgainAction];
    [alertController addAction:dismissAction];
    
    // Present the alert controller.
    [self presentViewController:alertController animated:YES completion:NULL];
}

- (void)zoomMapOnCoordinate:(CLLocationCoordinate2D)coordinate withDistance:(CLLocationDistance)distance {
    MKCoordinateRegion viewRegion= MKCoordinateRegionMakeWithDistance(coordinate, distance, distance);
    [self.mapView setRegion:viewRegion animated:YES];
}

#pragma mark - Map view delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if (![annotation isKindOfClass:[Lot class]]) {
        return NULL;
    }
    
    // Allocate a MKMarkerAnnotationView instance.
    NSString *reuseIdentifier = @"LotMarker";
    MKMarkerAnnotationView *annotationView;
    
    // Check if there is an available annotation to reuse.
    MKAnnotationView *dequeuedView = [mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
    
    if (dequeuedView != NULL && [dequeuedView isKindOfClass:[MKMarkerAnnotationView class]]) {
        dequeuedView.annotation = annotation;
        annotationView = (MKMarkerAnnotationView *) dequeuedView;
    } else {
        annotationView = [[MKMarkerAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
        [annotationView setCanShowCallout:YES];
        [annotationView setRightCalloutAccessoryView:[UIButton buttonWithType:UIButtonTypeDetailDisclosure]];
    }
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    Lot *lot = (Lot *) view.annotation;
    
    // Get an instance of the Lot Detail Container View Controller.
    LotDetailContainerViewController *lotDetailContainerVC = [[LotDetailContainerViewController alloc] initWithLot:lot];
    
    // Get an instance of the Base Navigation Controller.
    BaseNavigationController *navigationController = [[BaseNavigationController alloc] initWithRootViewController:lotDetailContainerVC];
    
    [self.navigationController presentViewController:navigationController animated:YES completion:NULL];
}

#pragma mark - Core location delegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    [self.mapView setShowsUserLocation:status == kCLAuthorizationStatusAuthorizedWhenInUse];
    
    // If the user has not allowed us to access his location, zoom on Montreal.
    if (status != kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self zoomMapOnMontreal];
    } else {
        [manager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    [manager stopUpdatingLocation];
    
    // Make sure the array of locations contains 1 or more locations.
    if (locations.count < 1) {
        return;
    }
    
    // Retrieve the first element of the array and zoom on the user location.
    CLLocation *currentUserLocation = locations.firstObject;
    [self zoomMapOnCoordinate:currentUserLocation.coordinate withDistance:500];
}

@end
