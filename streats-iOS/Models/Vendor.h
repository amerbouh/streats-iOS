//
//  Vendor.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-13.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

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

// Methods

- (instancetype _Nullable)initWithIdentifier:(NSNumber * _Nonnull)identifier name:(NSString * _Nonnull)name cuisineType:(NSString * _Nonnull)cuisineType shortDescription:(NSString*_Nonnull)shortDescription emailAddress:(NSString * _Nullable)emailAddress phoneNumber:(NSString * _Nullable)phoneNumber website:(NSString * _Nullable)website iconDownloadURLSuffix:(NSString * _Nullable)suffix banners:(NSArray<NSString *> * _Nullable)banners;
- (instancetype _Nullable)initWithJSON:(NSDictionary<NSString *, id> *_Nonnull)JSON;

@end
