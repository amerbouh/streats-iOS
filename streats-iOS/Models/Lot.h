//
//  Lot.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-18.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class Vendor;

@interface Lot : NSObject <MKAnnotation>

// Properties

@property(strong, nonatomic, nonnull) NSString *identifier;
@property(strong, nonatomic, nonnull) NSString *name;
@property(strong, nonatomic, nonnull) NSString *address;
@property(strong, nonatomic, nonnull) NSString *emailAddress;
@property(strong, nonatomic, nonnull) NSNumber *latitude;
@property(strong, nonatomic, nonnull) NSNumber *longitude;
@property(strong, nonatomic, nonnull) NSString *bannerDownloadURL;

@property(strong, nonatomic, nullable) NSString *hostTruckName;
@property(strong, nonatomic, nullable) NSArray<Vendor *> *attendees;

// Methods

- (instancetype _Nullable) initWithIdentifier:(NSString * _Nonnull)identifier name:(NSString * _Nonnull)name emailAddress:(NSString * _Nonnull)emailAddress address:(NSString * _Nonnull)address latitude:(NSNumber * _Nonnull)latitude longitude:(NSNumber * _Nonnull)longitude;
- (instancetype _Nullable) initWithDictionary:(NSDictionary<NSString *, id> * _Nonnull)dictionary;

@end
