//
//  EventsListTableViewController.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-20.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "EventsListTableViewController.h"
#import "EmptyTableBackgroundView.h"
#import "EventTableViewCell.h"
#import "ErrorView.h"
#import "Event.h"
#import "Vendor.h"
#import "ServiceError.h"
#import "VendorsService.h"

@interface EventsListTableViewController ()

// Properties

@property(strong, nonatomic, nonnull) Vendor * vendor;
@property(strong, nonatomic, nullable) NSArray<Event *> * events;

/** Loads the events displayed by the table view. */
- (void)loadEvents;

/** Configures the view's hierarchy to accomodate an activity indicator and displays it. */
- (void)showActivityIndicator;

/** Configure the view's hierarchy to accomodate the regular UI and hides the activity indicator. */
- (void)hideActivityIndicator;

/** Displays an a view describing the provided error message. */
- (void)showErrorViewWithMessage:(NSString *)message;

/** Displays a view indicating that there is no event to displayed. */
- (void)showEmptyTableBackgroundView;

@end

@implementation EventsListTableViewController

static const NSString *reuseIdentifier = @"EventTableViewCell";

#pragma mark - Initialization

- (instancetype)initWithVendor:(Vendor *)vendor {
    self = [super init];
    if (self) {
        _vendor = vendor;
    }
    return self;
}

#pragma mark - View's lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes.
    UINib *eventCellNib = [UINib nibWithNibName:@"EventTableViewCell" bundle:NULL];
    [self.tableView registerNib:eventCellNib forCellReuseIdentifier:@"EventTableViewCell"];
    
    // Do any additional setup before the view appears.
    [self loadEvents];
}

#pragma mark - Methods

- (void)loadEvents {
    [self showActivityIndicator];
    
    // Fetch the vendor's events.
    [VendorsService getEventsForVendorWithIdentifier:[self.vendor.identifier stringValue] completionHandler:^(NSArray<Event *> * _Nullable events, ServiceError * _Nullable serviceError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Hide the activity indicator.
            [self hideActivityIndicator];
            
            if (serviceError != NULL) {
                [self showErrorViewWithMessage:serviceError.detail];
            } else {
                if (events.count > 0) {
                    [self setEvents:events];
                    [self.tableView reloadData];
                } else {
                    [self showEmptyTableBackgroundView];
                }
            }
        });
    }];
}

- (void)showActivityIndicator {
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    [activityIndicator startAnimating];
    [activityIndicator setColor:UIColor.grayColor];
    
    // Set the activity indicator as the table view's background.
    [self.tableView setBackgroundView:activityIndicator];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)hideActivityIndicator {
    [self.tableView setBackgroundView:NULL];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
}

- (void)showErrorViewWithMessage:(NSString *)message {
    ErrorView *errorView = [[ErrorView alloc] initWithMessage:message];
    [errorView setDelegate:self];
    
    // Set the error view as the background of the table view.
    [self.tableView setBackgroundView:errorView];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)showEmptyTableBackgroundView {
    EmptyTableBackgroundView *backgroundView = [[EmptyTableBackgroundView alloc] initWithMessage:NSLocalizedString(@"noEvents", NULL) andDescription:NSLocalizedString(@"noEventsDescription", NULL)];
    
    // Set the background as the table view's background.
    [self.tableView setBackgroundView:backgroundView];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

#pragma mark - Error view delegate

- (void)tryAgainButtonTaped:(ErrorView * _Nonnull)errorView {
    [self loadEvents];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.events.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EventTableViewCell *cell = (EventTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"EventTableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    Event *event = [self.events objectAtIndex:indexPath.row];
    
    [cell populateWithEvent:event];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

@end
