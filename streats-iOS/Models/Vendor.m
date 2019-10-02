//
//  Vendor.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-13.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "Vendor.h"

@implementation Vendor

#pragma mark - Initialization

- (instancetype)initWithIdentifier:(NSNumber *)identifier name:(NSString *)name cuisineType:(NSString *)cuisineType shortDescription:(NSString *)shortDescription emailAddress:(NSString *)emailAddress phoneNumber:(NSString *)phoneNumber website:(NSString *)website iconDownloadURLSuffix:(NSString *)suffix banners:(NSArray<NSString *> *)banners
{
    self = [super init];
    if (self) {
        _name = [[name lowercaseString] capitalizedString];
        _identifier = identifier;
        _cuisineType = cuisineType;
        _shortDescription = shortDescription;
        _emailAddress = emailAddress;
        _phoneNumber = phoneNumber;
        _website = website;
        _iconDownloadURL = [NSString stringWithFormat:@"https://lotmom.imgix.net/%@", suffix];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)JSON
{
    NSString *name = [JSON objectForKey:@"name"];
    NSNumber *identifier = [JSON objectForKey:@"id"];
    NSString *cuisineType = [JSON objectForKey:@"cuisine_type"];
    NSString *shortDescription = [JSON objectForKey:@"description"];
    NSString *emailAddress = [JSON objectForKey:@"email_address"];
    NSString *phoneNumber = [JSON objectForKey:@"phone_number"];
    NSString *website = [JSON objectForKey:@"website_url"];
    NSString *iconDownloadURLSuffix = [JSON objectForKey:@"full"];
    NSArray<NSString *> *banners = [JSON objectForKey:@"banners"];
    
    return [self initWithIdentifier:identifier name:name cuisineType:cuisineType shortDescription:shortDescription emailAddress:emailAddress phoneNumber:phoneNumber website:website iconDownloadURLSuffix:iconDownloadURLSuffix banners:banners];
}

#pragma mark - Methods

- (BOOL)isEqual:(id)object
{
    if ([object class] == [Vendor class]) {
        Vendor* comparedVendor = (Vendor*) object;
        
        // Check if the vendors have the same identifier.
        return [comparedVendor.identifier isEqualToNumber:self.identifier];
    }
    
    return false;
}

@end
