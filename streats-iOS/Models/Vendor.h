//
//  Vendor.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-13.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Position;

@interface Vendor : NSObject

// Properties

@property(strong, nonatomic, nonnull) NSNumber *identifier;
@property(strong, nonatomic, nonnull) NSString *name;
@property(strong, nonatomic, nonnull) NSString *cuisineType;
@property(strong, nonatomic, nonnull) NSString *shortDescription;

@property(strong, nonatomic, nullable) NSString *emailAddress;
@property(strong, nonatomic, nullable) NSString *phoneNumber;
@property(strong, nonatomic, nullable) NSString *website;
@property(strong, nonatomic, nullable) NSString *iconDownloadURL;

@property(strong, nonatomic, nullable) NSArray<NSString *> *banners;
@property(strong, nonatomic, nullable) NSArray<NSString *> *paymentMethods;

@property(strong, nonatomic, nullable) NSString *openingHours;
@property(strong, nonatomic, nullable) NSString *openiningDate;

@property(strong, nonatomic, nullable) Position *lastPosition;

/**
* Initializes and returns a Vendor object using the provided parameters.
*
 @param identifier              A string representing the title of the event.
 @param name     A string representing the start date of the event.
 @param cuisineType      A string representing the end date of the event.
 @param shortDescription  A boolean indicating whether or not an event lasts all day.
 @param emailAddress  A boolean indicating whether or not an event lasts all day.
 @param phoneNumber  A boolean indicating whether or not an event lasts all day.
 @param website  A boolean indicating whether or not an event lasts all day.
 @param iconDownloadURLSuffix  A boolean indicating whether or not an event lasts all day.
*/
- (instancetype _Nullable)initWithIdentifier:(NSNumber * _Nonnull)identifier name:(NSString * _Nonnull)name cuisineType:(NSString * _Nonnull)cuisineType shortDescription:(NSString*_Nonnull)shortDescription emailAddress:(NSString * _Nullable)emailAddress phoneNumber:(NSString * _Nullable)phoneNumber website:(NSString * _Nullable)website iconDownloadURLSuffix:(NSString * _Nullable)suffix banners:(NSArray<NSString *> * _Nullable)banners;

/**
* Initializes and returns a Vendor object using the provided dictionary.
*
* @param dictionary A dictionary that represents the data of the event.
*/
- (instancetype _Nullable)initWithDictionary:(NSDictionary<NSString *, id> *_Nonnull)dictionary;

@end
