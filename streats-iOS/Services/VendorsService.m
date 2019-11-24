//
//  VendorsService.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-13.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "VendorsService.h"
#import "Lot.h"
#import "Event.h"
#import "Vendor.h"
#import "MenuItem.h"
#import "Position.h"
#import "ServiceError.h"
#import "WebClientController.h"

@interface VendorsService ()

/**
 * The Web Client Controller instance used to perform network requests.
 */
@property (strong, nonatomic, nonnull) WebClientController * webClientController;

@end

/** @brief The base URL of the API used the retrieve the vendor's schedule. */
static const NSString * BASE_URL = @"https://montreal.bestfoodtrucks.com/api";

/** @brief The base URL of the Server.  */
static const NSString * BASE_SERVER_URL = @"https://streats-app-api.herokuapp.com/v1";

@implementation VendorsService

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        _webClientController = [WebClientController new];
    }
    return self;
}

#pragma mark - Methods

- (void)getVendorsForTime:(NSString *)time completionHandler:(void (^)(NSArray<Vendor*> * _Nullable, ServiceError * _Nullable))completionHandler
{
    NSString * requestURL = [NSString stringWithFormat:@"%@/events/events", BASE_URL];
    NSDictionary<NSString *, id> * requestParams = @{
        @"when": time,
        @"where": @"68"
    };
        
    // Load the resource for the given path.
    [self.webClientController loadResourceForPath:requestURL withParams:requestParams completionHandler:^(id  _Nullable result, ServiceError * _Nullable serviceError) {
        if (serviceError ) {
            completionHandler(NULL, serviceError);
            return;
        }
        
        // Handle the response.
        NSLog(@"%@", result);
    }];
}

+ (void)getDetailsForVendorWithIdentifier:(NSString *)identifier completionHandler:(void (^)(Vendor * _Nullable, NSError * _Nullable))completionHandler
{
    NSURL *requestURL = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@/vendors/vendor?id=%@", BASE_SERVER_URL, identifier]];
    
    // Make sure that the request URL is not NULL.
    if (requestURL == NULL) {
        return;
    }
    
    // Create the request.
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:requestURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != NULL) {
            completionHandler(NULL, error);
        } else {
            NSError* serializationError = NULL;
            NSDictionary<NSString *, id> *vendorDetailDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            // Make sure that the data could be serialized to JSON.
            if (serializationError != NULL) {
                completionHandler(NULL, serializationError);
            } else {
                Vendor *vendor = [[Vendor alloc] initWithDictionary:vendorDetailDict];
                completionHandler(vendor, NULL);
            }
        }
    }];
    
    // Send the request.
    [task resume];
}

+ (void)getMenuItemsForVendorWithIdentifier:(NSString *)identifier completionHandler:(void (^)(NSArray<MenuItem *> * _Nullable, NSError * _Nullable))completionHandler
{
    NSURL *requestURL = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@/menu?id=%@", BASE_SERVER_URL, identifier]];
    
    // Make sure that the request URL is not NULL.
    if (requestURL == NULL) {
        return;
    }
    
    // Create the requet.
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:requestURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != NULL) {
            completionHandler(NULL, error);
        } else {
            NSError* serializationError = NULL;
            NSArray<NSDictionary<NSString *, id> *> *vendorMenuDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            // Make sure that the data could be serialized to JSON.
            if (serializationError != NULL) {
                completionHandler(NULL, serializationError);
            } else {
                NSMutableArray<MenuItem *> *vendorMenu = [[NSMutableArray alloc] init];
                
                // Loop through each menu item and add each one to the vendor's menu.
                for (int i = 0; i < vendorMenuDict.count; i++) {
                    NSDictionary<NSString *, id> *menuItemDict = [vendorMenuDict objectAtIndex:i];
                    MenuItem *menuItem = [[MenuItem alloc] initWithJSON:menuItemDict];
                    
                    // Add the menu item to the array.
                    [vendorMenu addObject:menuItem];
                }
                
                // Call the completion handler and pass the vendor's menu.
                completionHandler(vendorMenu, NULL);
            }
        }
    }];
    
    // Send the request.
    [task resume];
}

+ (void)getEventsForVendorWithIdentifier:(NSString *)identifier completionHandler:(void (^)(NSArray<Event *> * _Nullable, NSError * _Nullable))completionHandler
{
    NSString* URLString = [NSString stringWithFormat:@"%@/trucks/truck_events/%@", BASE_URL, identifier];
    NSURL* requestURL = [[NSURL alloc] initWithString:URLString];
    
    // Configure the request.
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:requestURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != NULL) {
            completionHandler(NULL, error);
        } else {
            NSError* serializationError = NULL;
            NSArray<NSDictionary<NSString *, id> *> *eventsDictionnaries = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            // Check if there was a serialization error.
            if (serializationError != NULL) {
                completionHandler(NULL, serializationError);
            } else {
                // Initalize the events dictionary holding the retrevied events.
                NSMutableArray<Event *> *events = [[NSMutableArray alloc] init];
                
                for (NSDictionary<NSString *, id> *eventDictionary in eventsDictionnaries) {
                    Event *event = [[Event alloc] initWithDictionary:eventDictionary];
                    [events addObject:event];
                }
                
                // Call the compmletion handler and pass the given events.
                completionHandler(events, NULL);
            }
        }
    }];
    
    // Send the request.
    [task resume];
}

@end
