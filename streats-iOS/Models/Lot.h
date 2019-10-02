//
//  Lot.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-18.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "JSONObjectPayload.h"

@class Vendor;

@interface Lot : NSObject <MKAnnotation>

/** An integer representing the unique identifier of the lot. */
@property(strong, nonatomic, nonnull) NSString *identifier;

/** A string representing the name of the lot. */
@property(strong, nonatomic, nonnull) NSString *name;

/**
 * A string representing the address of the place where
 * the lot is currenlty located.
 */
@property(strong, nonatomic, nonnull) NSString *address;

/** A string representing the email address of the lot's owner. */
@property(strong, nonatomic, nonnull) NSString *emailAddress;

/**
 * A number representing the latitude of the place where
 * the lot is currenlty located.
 */
@property(strong, nonatomic, nonnull) NSNumber *latitude;

/**
 * A number representing the longitude of the place where
 * the lot is currenlty located.
 */
@property(strong, nonatomic, nonnull) NSNumber *longitude;

/** A string representing the downlnoad URL of the lot's banner. */
@property(strong, nonatomic, nonnull) NSString *bannerDownloadURL;

/** A string representing the name of truck hosting the lot. */
@property(strong, nonatomic, nullable) NSString *hostTruckName;

/** An array representing the vendors attending to the lot. */
@property(strong, nonatomic, nullable) NSArray<Vendor *> *attendees;

/**
* Initializes and returns a Lot object using the provided parameters.
*
* @param identifier          A string that represents the identifier of the lot.
* @param name               A string that represents the name of the lot.
* @param emailAddress  A string that represents the email address of the lot.
* @param address           A string that represents the address of the lot.
* @param latitude            A number that represents the latitude of the current location of the lot.
* @param longitude         A number that represents the longitude of the current location of the lot.
*/
- (instancetype _Nullable) initWithIdentifier:(NSString * _Nonnull)identifier name:(NSString * _Nonnull)name emailAddress:(NSString * _Nonnull)emailAddress address:(NSString * _Nonnull)address latitude:(NSNumber * _Nonnull)latitude longitude:(NSNumber * _Nonnull)longitude;

/**
* Initializes and returns a Lot object using the provided dictionary.
*
* @param dictionary A dictionary that represents the data of the lot.
*/
- (instancetype _Nullable) initWithDictionary:(NSDictionary<NSString *, id> * _Nonnull)dictionary;

@end
