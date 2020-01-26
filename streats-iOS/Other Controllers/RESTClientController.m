//
//  RESTClientController.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-12-15.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "RESTClientController.h"
#import "WebClientController.h"
#import "Vendor.h"
#import "MenuItem.h"

@interface RESTClientController ()

@property (strong, nonatomic, nonnull) WebClientController * webClientController;

@end

@implementation RESTClientController

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        _webClientController = [[WebClientController alloc] initWithBaseURL:@"https://streats-app-api.herokuapp.com/v1"];
    }
    return self;
}

#pragma mark - Methods

- (void)getDetailsForVendorWithIdentifier:(NSString *)identifier completionHandler:(void (^)(Vendor * _Nullable, ServiceError * _Nullable))completionHandler
{
    NSString * path = @"vendors/vendor";
    NSDictionary<NSString *, id> * params = @{
        @"id": identifier
    };
    
    // Load the resource at the given path.
    [self.webClientController loadResourceForPath:path withParams:params completionHandler:^(id  _Nullable result, ServiceError * _Nullable serviceError) {
        if (serviceError) {
            completionHandler(NULL, serviceError);
            return;
        }
        
        // Cast the result to a dictionnary representing a Vendor.
        NSDictionary<NSString *, id> * responseDict = (NSDictionary<NSString *, id> *) result;
        NSDictionary<NSString *, id> * vendorDetailDict = (NSDictionary<NSString *, id> *) [responseDict objectForKey:@"data"];
        Vendor * vendor = [[Vendor alloc] initWithDictionary:vendorDetailDict];
        
        // Call the completion handler.
        completionHandler(vendor, NULL);
    }];
}

- (void)getMenuItemsForVendorWithIdentifier:(NSString *)identifier completionHandler:(void (^)(NSArray<MenuItem *> * _Nullable, ServiceError * _Nullable))completionHandler
{
    NSString * path = @"vendors/menu";
    NSDictionary<NSString *, id> * params = @{
        @"id": identifier
    };
    
    // Load the resource at the given path.
    [self.webClientController loadResourceForPath:path withParams:params completionHandler:^(id  _Nullable result, ServiceError * _Nullable serviceError) {
        if (serviceError) {
            completionHandler(NULL, serviceError);
            return;
        }
        
        // Cast the result to an array of dictionnaries representing a Menu Item.
        NSMutableArray<MenuItem *> * menuItems = [NSMutableArray new];
        NSDictionary<NSString *, id> * responseDict = (NSDictionary<NSString *, id> *) result;
        NSArray<NSDictionary<NSString *, id> *> * menuItemsDict = (NSArray<NSDictionary<NSString *, id> *> *) [responseDict objectForKey:@"data"];
        
        // Loop through each dictionnary and initialize a Menu Item object from it. Add the initialized Menu Item
        // object to the menu items array.
        for (NSDictionary<NSString *, id> * menuItemDict in menuItemsDict) {
            MenuItem * menuItem = [[MenuItem alloc] initWithJSON:menuItemDict];
            [menuItems addObject:menuItem];
        }
        
        // Call the completion handler.
        completionHandler(menuItems, NULL);
    }];
}

@end
