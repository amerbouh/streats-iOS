//
//  Position.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-06-05.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Position : NSObject

// Properties

@property(strong, nonatomic, nonnull) NSString *address;

// Methods

- (instancetype _Nullable)initWithAddress:(NSString *_Nonnull)address latitude:(NSNumber *_Nonnull)latitude longitude:(NSNumber *_Nonnull)longitude;
- (CLLocationCoordinate2D)getCoordinate;

@end
