//
//  Position.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-06-05.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "Position.h"
#import <CoreLocation/CoreLocation.h>

@interface Position ()

@property(strong, nonatomic, nonnull) NSNumber *latitude;
@property(strong, nonatomic, nonnull) NSNumber *longitude;

@end

@implementation Position

#pragma mark - Initialization

- (instancetype)initWithLatitude:(NSNumber *)latitude longitude:(NSNumber *)longitude
{
    self = [super init];
    if (self) {
        _latitude = latitude;
        _longitude = longitude;
    }
    return self;
}

#pragma mark - Methods

- (CLLocationCoordinate2D)getCoordinate
{
    return CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
}

- (void)getAddressWithCompletionHandler:(void (^)(CLPlacemark * _Nullable, NSError * _Nullable))completionHandler
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:[self.latitude doubleValue] longitude:[self.longitude doubleValue]];
    
    // Get the address from the position's coordinate
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error != NULL) {
            completionHandler(NULL, error);
        } else {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            completionHandler(placemark, NULL);
        }
    }];
}

@end
