//
//  Lot.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-18.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "Lot.h"
#import "Vendor.h"

@implementation Lot

@synthesize title;
@synthesize subtitle;
@synthesize coordinate;

#pragma mark - Methods

- (instancetype)initWithIdentifier:(NSString *)identifier name:(NSString *)name emailAddress:(NSString *)emailAddress address:(NSString *)address latitude:(NSNumber *)latitude longitude:(NSNumber *)longitude {
    if ((self = [super init])) {
        _identifier = identifier;
        _name = name;
        _address = address;
        _emailAddress = emailAddress;
        _latitude = latitude;
        _longitude = longitude;
        
        // MKAnnotation Protocol properties.
        title = name;
        subtitle = address;
        coordinate = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary {
    NSString *identifier = [dictionary objectForKey:@"id"];
    NSString *name = [dictionary objectForKey:@"name"];
    NSString *address = [dictionary objectForKey:@"address"];
    NSString *emailAddress = [dictionary objectForKey:@"email"];
    NSNumber *latitude = [dictionary objectForKey:@"lat"];
    NSNumber *longitude = [dictionary objectForKey:@"lng"];
    NSString *hostTruckName = [dictionary objectForKey:@"truck_name"];
    NSArray<NSDictionary<NSString *, id> *> *attendeesDictionaries = [dictionary objectForKey:@"attending"];
    
    // Initalize the banner download URL.
    NSString *bannerDownloadURLSuffix = [dictionary objectForKey:@"img"];
    
    if (![bannerDownloadURLSuffix isKindOfClass:[NSNull class]]) {
        _bannerDownloadURL = [NSString stringWithFormat:@"https://lotmom.imgix.net/%@", bannerDownloadURLSuffix];
    }

    // Initalize the vendors array.
    NSMutableArray<Vendor *> *vendors = [[NSMutableArray alloc] init];
    
    // Loop through each attendee dictionary and create a Vendor from it.
    for (NSDictionary<NSString *, id> *attendeeDictionary in attendeesDictionaries) {
        Vendor *vendor = [[Vendor alloc] initWithJSON:attendeeDictionary];
        [vendors addObject:vendor];
    }
    
    // Initialize the attendees array and add the vendors to it.
    _attendees = [[NSArray alloc] initWithArray:vendors];
    _hostTruckName = hostTruckName;
    
    return [self initWithIdentifier:identifier name:name emailAddress:emailAddress address:address latitude:latitude longitude:longitude];
}

@end
