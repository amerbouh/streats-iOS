//
//  EventsDataSource.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2020-01-29.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import "EventsDataSource.h"
#import "Event.h"
#import "ServiceError.h"
#import "VendorsService.h"
#import "EventTableViewCell.h"

@interface EventsDataSource ()

/** An NSArray representing the list of events the vendor is attending to. */
@property (strong, nonatomic, nonnull) NSArray<Event *> * events;

/** An NSString representing the identifier of the vendor used to fetch events. */
@property (strong, nonatomic, nonnull) NSString * vendorIdentifier;

@end

@implementation EventsDataSource

#pragma mark - Initialization

- (instancetype)initWithVendorIdentifier:(NSString *)identifier
{
    self = [super init];
    if (self) {
        _events = [NSArray new];
        _vendorIdentifier = identifier;
        
        // Fetch the events the vendor with the given identifier attends to.
        [self loadVendorEvents];
    }
    return self;
}

#pragma mark - Methods

- (void)loadVendorEvents
{
    __weak EventsDataSource * weakSelf = self;
    
    // Fetches the events the vendor with the given identifier attends to.
    [VendorsService getEventsForVendorWithIdentifier:self.vendorIdentifier completionHandler:^(NSArray<Event *> * _Nullable events, ServiceError * _Nullable serviceError) {
        if (serviceError != NULL)
        {
            // Go back on the main thread and inform the delegate that an error occurred.
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.delegate eventsDataSource:weakSelf onFetchFailedWithErrorMessage:serviceError.detail];
            });
        } /* if an error occurs while trying to fetch the events. */
        else
        {
            weakSelf.events = events;
            
            // Go back on the main thread and inform the delegate that the events were successfully loaded.
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.delegate eventsDataSource:weakSelf onEventsFetched:events];
            });
        } /* if no error occurs while trying to fetch the events. */
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.events.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    EventTableViewCell *cell = (EventTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"EventTableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    Event * event = [self.events objectAtIndex:indexPath.row];
    
    [cell populateWithEvent:event];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

@end
