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

- (instancetype)initWithAddress:(NSString *)address latitude:(NSNumber *)latitude longitude:(NSNumber *)longitude {
    if ((self = [super init])) {
        _address = address;
        _latitude = latitude;
        _longitude = longitude;
    }
    
    return self;
}

- (CLLocationCoordinate2D)getCoordinate {
    return CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
}

@end
