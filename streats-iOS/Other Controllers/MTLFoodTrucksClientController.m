//
//  MTLFoodTrucksClientController.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-12-14.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "MTLFoodTrucksClientController.h"
#import "WebClientController.h"
#import "Lot.h"
#import "Event.h"
#import "Vendor.h"

@interface MTLFoodTrucksClientController ()

/** A WebClientController instance used to perform network requests. */
@property (strong, nonatomic, nonnull) WebClientController * webClientController;

/**
* @brief Retrieves all the lots for the given period.
* @param period The time range from which the lots will be fetched.
* @param completionHandler The completion handler to call when the load request is complete.
*/
- (void)getLotsForPeriod:(Period)period withCompletionHandler:(void (^_Nullable)(NSArray<Lot *> * _Nullable lots, ServiceError * _Nullable serviceError))completionHandler;

@end

NSString * const REGION_CODE_MONTREAL = @"68";
NSString * const FOOD_TRUCK_EVENTS_API_BASE_URL = @"https://montreal.bestfoodtrucks.com/api";

@implementation MTLFoodTrucksClientController

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        _webClientController = [[WebClientController alloc] initWithBaseURL:FOOD_TRUCK_EVENTS_API_BASE_URL];
    }
    return self;
}

#pragma mark - Methods

- (void)getVendorsForPeriod:(Period)period withCompletionHandler:(void (^)(NSArray<Vendor *> * _Nullable, ServiceError * _Nullable))completionHandler
{
    [self getLotsForPeriod:period withCompletionHandler:^(NSArray<Lot *> * _Nullable lots, ServiceError * _Nullable serviceError) {
        if (serviceError) {
            completionHandler(NULL, serviceError);
            return;
        }
        
        // Initialize the array of Vendor objects.
        NSMutableArray<Vendor *> * vendors = [NSMutableArray new];
        
        // Loop through each Lot and extract the array of vendors attending to the event
        // associated with it.
        for (Lot * lot in lots) {
            for (Vendor * vendor in lot.attendees) {
                if (![vendors containsObject:vendor]) { [vendors addObject:vendor]; }
            }
        }
        
        // Call the completion handler.
        completionHandler(vendors, NULL);
    }];
}

- (void)getEventsForVendorWithIdentifier:(NSString *)identifier completionHandler:(void (^)(NSArray<Event *> * _Nullable, ServiceError * _Nullable))completionHandler
{
    NSString * path = [NSString stringWithFormat:@"trucks/truck_events/%@", identifier];
    
    // Load the resource with the given path.
    [self.webClientController loadResourceForPath:path withParams:0 completionHandler:^(id  _Nullable result, ServiceError * _Nullable serviceError) {
        if (serviceError) {
            completionHandler(NULL, serviceError);
            return;
        }
        
        // Cast the result to an array of dictionnaries representing an Event.
        NSMutableArray<Event *> * events = [NSMutableArray new];
        NSArray<NSDictionary<NSString *, id> *> * eventsDict = (NSArray<NSDictionary<NSString *, id> *> *) result;
        
        // Loop through each dictionnary and initialize an Event object from it. Add the initialized Event
        // object to the events array.
        for (NSDictionary<NSString *, id> * eventDict in eventsDict) {
            Event * event = [[Event alloc] initWithDictionary:eventDict];
            [events addObject:event];
        }
        
        // Call the completion handler.
        completionHandler(events, NULL);
    }];
}

- (void)getLotsForPeriod:(Period)period withCompletionHandler:(void (^)(NSArray<Lot *> * _Nullable, ServiceError * _Nullable))completionHandler
{
    NSString * periodString;
    
    // Initialize the period string variable.
    if (period == PeriodToday) periodString = @"today";
    else if (period == PeriodTomorrow) periodString = @"tomorrow";
    else if (period == PeriodCurrentWeek) periodString = @"This Week";
    
    // Initialize the request's parameters.
    NSDictionary<NSString *, id> * requestParams = @{
        @"when": periodString,
        @"where": REGION_CODE_MONTREAL
    };
    
    // Load the resource at the given path.
    [self.webClientController loadResourceForPath:@"events/events" withParams:requestParams completionHandler:^(id  _Nullable result, ServiceError * _Nullable serviceError) {
        if (serviceError) {
            completionHandler(NULL, serviceError);
            return;
        }
        
        // Cast the result to an array of dictionnaries representing a Lot.
        NSMutableArray<Lot *> * lots = [NSMutableArray new];
        NSArray<NSDictionary<NSString *, id> *> * lotsDict = (NSArray<NSDictionary<NSString *, id> *> *) result;
        
        // Loop through each dictionnary and initialize a Lot object from it. Add the initialized Lot
        // object to the lots array.
        for (NSDictionary<NSString *, id> * lotDict in lotsDict) {
            Lot * lot = [[Lot alloc] initWithDictionary:lotDict];
            [lots addObject:lot];
        }
        
        // Call the completion handler.
        completionHandler(lots, NULL);
    }];
}

@end
