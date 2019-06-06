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

// Methods

- (instancetype _Nullable)initWithLatitude:(NSNumber *_Nonnull)latitude longitude:(NSNumber *_Nonnull)longitude;
- (CLLocationCoordinate2D)getCoordinate;
- (void)getAddressWithCompletionHandler:(void (^_Nullable)(CLPlacemark * _Nullable placemark, NSError * _Nullable error))completionHandler;

@end
