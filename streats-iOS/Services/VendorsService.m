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
#import <FirebaseFirestore/FirebaseFirestore.h>

/** @brief The base URL of the API used the retrieve the vendor's schedule. */
static const NSString *BASE_URL = @"https://montreal.bestfoodtrucks.com/api";

@implementation VendorsService

+ (void)getVendorsForTime:(NSString *)time completionHandler:(void (^)(NSArray<Vendor*> * _Nullable, NSError * _Nullable))completionHandler {
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
                        Vendor* vendor = [[Vendor alloc] initWithJSON:attendee];
    
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

+ (void)getDetailsForVendorWithIdentifier:(NSString *)identifier completionHandler:(void (^)(Vendor * _Nullable, NSError * _Nullable))completionHandler {
    FIRCollectionReference *vendorsRef = [[FIRFirestore firestore] collectionWithPath:@"vendors"];
    FIRDocumentReference *vendorDoc = [vendorsRef documentWithPath:identifier];
    
    // Get the content of the vendor's document.
    [vendorDoc getDocumentWithCompletion:^(FIRDocumentSnapshot * _Nullable snapshot, NSError * _Nullable error) {
        if (error != NULL) {
            completionHandler(NULL, error);
        } else {
            if (snapshot.exists) {
                Vendor *vendor = [[Vendor alloc] initWithJSON:snapshot.data];
                
                // Cast the banners download URLs.
                NSArray<NSString *> *banners = [snapshot.data objectForKey:@"banners"];
                [vendor setBanners:banners];
                
                completionHandler(vendor, NULL);
            } else {
                NSError *error = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:404 userInfo:NULL];
                completionHandler(NULL, error);
            }
        }
    }];
}

+ (void)getMenuItemsForVendorWithIdentifier:(NSString *)identifier completionHandler:(void (^)(NSArray<MenuItem *> * _Nullable, NSError * _Nullable))completionHandler {
    FIRDocumentReference *vendorDoc = [[[FIRFirestore firestore] collectionWithPath:@"vendors"] documentWithPath:identifier];
    FIRQuery *menuItemsRef = [[vendorDoc collectionWithPath:@"menu_items"] queryOrderedByField:@"price"];
    
    // Get the content of the menu items document.
    [menuItemsRef getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        if (error != NULL) {
            completionHandler(NULL, error);
        } else {
            NSMutableArray<MenuItem *> *menuItems = [[NSMutableArray alloc] init];
            NSArray<FIRQueryDocumentSnapshot *> *documents = snapshot.documents;
            
            // Loop through each document, initialize a Menu Item object from
            // the document's data and add it to the menu items array.
            for (FIRDocumentSnapshot *document in documents) {
                MenuItem *menuItem = [[MenuItem alloc] initWithJSON:document.data];
                
                // Set the menu item identifier manually.
                menuItem.identifier = document.documentID;
                
                [menuItems addObject:menuItem];
            }
            
            // Call the compmletion handler and pass the given menu items.
            completionHandler(menuItems, NULL);
        }
    }];
}

+ (void)getEventsForVendorWithIdentifier:(NSString *)identifier completionHandler:(void (^)(NSArray<Event *> * _Nullable, NSError * _Nullable))completionHandler {
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
