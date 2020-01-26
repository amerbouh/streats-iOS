//
//  VendorsService.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-13.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "VendorsService.h"
#import "RESTClientController.h"
#import "MTLFoodTrucksClientController.h"

@implementation VendorsService

#pragma mark - Methods

- (void)getVendorsForPeriod:(Period)period completionHandler:(void (^)(NSArray<Vendor*> * _Nullable, ServiceError * _Nullable))completionHandler
{
    [[MTLFoodTrucksClientController new] getVendorsForPeriod:period withCompletionHandler:completionHandler];;
}

+ (void)getDetailsForVendorWithIdentifier:(NSString *)identifier completionHandler:(void (^)(Vendor * _Nullable, ServiceError * _Nullable))completionHandler
{
    [[RESTClientController new] getDetailsForVendorWithIdentifier:identifier completionHandler:completionHandler];
}

+ (void)getMenuItemsForVendorWithIdentifier:(NSString *)identifier completionHandler:(void (^)(NSArray<MenuItem *> * _Nullable, ServiceError * _Nullable))completionHandler
{
    [[RESTClientController new] getMenuItemsForVendorWithIdentifier:@"5d890aae1c9d44000009d987" completionHandler:completionHandler];
}

+ (void)getEventsForVendorWithIdentifier:(NSString *)identifier completionHandler:(void (^)(NSArray<Event *> * _Nullable, ServiceError * _Nullable))completionHandler
{
    [[MTLFoodTrucksClientController new] getEventsForVendorWithIdentifier:identifier completionHandler:completionHandler];
}

@end
