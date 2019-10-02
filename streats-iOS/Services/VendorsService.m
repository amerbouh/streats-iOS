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

/** @brief The base URL of the API used the retrieve the vendor's schedule. */
static const NSString *BASE_URL = @"https://montreal.bestfoodtrucks.com/api";

/** @brief The base URL of the Server.  */
static const NSString *BASE_SERVER_URL = @"https://streats-app-api.herokuapp.com/v1";

@implementation VendorsService

+ (void)getVendorsForTime:(NSString *)time completionHandler:(void (^)(NSArray<Vendor*> * _Nullable, NSError * _Nullable))completionHandler
{
    NSString *URLString = [NSString stringWithFormat:@"%@/events/events?when=%@&where=68", BASE_URL, time];
    NSURL *requestURL = [[NSURL alloc] initWithString:URLString];
        
    // Check if the passed URL is valid.
    if (requestURL == NULL) {
        return;
    }
    
    // Configure the request.
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:requestURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != NULL) {
            completionHandler(NULL, error);
        } else {
            NSError* serializationError = NULL;
            NSArray<NSDictionary<NSString *, id> *> *lots = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            // Make sure that the data could be serialized to JSON.
            if (serializationError != NULL) {
                completionHandler(NULL, serializationError);
            } else {
                NSMutableArray<Vendor *> *vendors = [[NSMutableArray alloc] init];
                
                // Loop through each lot and add each one of its attendees to the vendors array.
                for (int index = 0; index < lots.count; index++) {
                    NSDictionary<NSString *, id> *lotDictionnary = [lots objectAtIndex:index];
                    NSArray<NSDictionary<NSString *, id> *> *attendees = [lotDictionnary objectForKey:@"attending"];
                    
                    for (int index = 0; index < attendees.count; index++) {
                        NSDictionary<NSString *, id> *attendee = [attendees objectAtIndex:index];
                        Vendor* vendor = [[Vendor alloc] initWithDictionary:attendee];
    
                        // Initialize the Lot object.
                        Lot *lot = [[Lot alloc] initWithDictionary:lotDictionnary];
                        
                        // Initialize other properties.
                        vendor.openingHours = [lotDictionnary objectForKey:@"formatted_date"];
                        vendor.openiningDate = [lotDictionnary objectForKey:@"date"];
                        vendor.lastPosition = [[Position alloc] initWithLatitude:lot.latitude longitude:lot.longitude];
                        
                        // Add the vendor to the vendors array, if applicable.
                        if (![vendors containsObject:vendor]) {
                            [vendors addObject:vendor];
                        }
                    }
                }
                
                // Call the completion handler and pass the given vendors.
                completionHandler(vendors, NULL);
            }
        }
    }];

    // Send the request.
    [task resume];
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
    NSURL *requestURL = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@/vendors/menu?id=%@", BASE_SERVER_URL, identifier]];
    
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
