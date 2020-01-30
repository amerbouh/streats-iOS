//
//  EventListViewController.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-20.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "EventListViewController.h"
#import "Vendor.h"
#import "ErrorView.h"
#import "EventsDataSource.h"
#import "EmptyTableBackgroundView.h"

@interface EventListViewController ()

@property (strong, nonatomic, nonnull) Vendor * vendor;
@property (strong, nonatomic, nonnull) UITableView * tableView;
@property (strong, nonatomic, nonnull) EventsDataSource * eventsDataSource;

/** Configures the view's hierarchy to accomodate an activity indicator and displays it. */
- (void)showActivityIndicator;

/** Configure the view's hierarchy to accomodate the regular UI and hides the activity indicator. */
- (void)hideActivityIndicator;

/** Displays an a view describing the provided error message. */
- (void)showErrorViewWithMessage:(NSString *)message;

/** Displays a view indicating that there is no event to displayed. */
- (void)showEmptyTableBackgroundView;

@end

@implementation EventListViewController

static NSString * reuseIdentifier = @"EventTableViewCell";

#pragma mark - Initialization

- (instancetype)initWithVendor:(Vendor *)vendor
{
    self = [super init];
    if (self) {
        _vendor = vendor;
        _tableView = [UITableView new];
        _eventsDataSource = [[EventsDataSource alloc] initWithVendorIdentifier:[vendor.identifier stringValue]];
        
        // Add the table view as a subview.
        [self.view addSubview:_tableView];
        
        // Set the Events Data Source's delegate.
        _eventsDataSource.delegate = self;
    }
    return self;
}

#pragma mark - View's lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Register cell classes.
    [self.tableView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:NULL]
                    forCellReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    [self showActivityIndicator];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self.eventsDataSource];
}

#pragma mark - Methods

- (void)viewWillLayoutSubviews
{
    self.tableView.frame = self.view.bounds;
}

- (void)showActivityIndicator
{
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    [activityIndicator startAnimating];
    [activityIndicator setColor:UIColor.grayColor];
    
    // Set the activity indicator as the table view's background.
    [self.tableView setBackgroundView:activityIndicator];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)hideActivityIndicator
{
    [self.tableView setBackgroundView:NULL];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
}

- (void)showErrorViewWithMessage:(NSString *)message
{
    ErrorView *errorView = [[ErrorView alloc] initWithMessage:message];
    [errorView setDelegate:self];
    
    // Set the error view as the background of the table view.
    [self.tableView setBackgroundView:errorView];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)showEmptyTableBackgroundView
{
    EmptyTableBackgroundView *backgroundView = [[EmptyTableBackgroundView alloc] initWithMessage:NSLocalizedString(@"noEvents", NULL) andDescription:NSLocalizedString(@"noEventsDescription", NULL)];
    
    // Set the background as the table view's background.
    [self.tableView setBackgroundView:backgroundView];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

#pragma mark - Error view delegate

- (void)tryAgainButtonTaped:(ErrorView * _Nonnull)errorView
{
    [self showActivityIndicator];
    [self.eventsDataSource loadVendorEvents];
}

#pragma mark - Events data source delegate

- (void)eventsDataSource:(EventsDataSource *)eventsDataSource onFetchFailedWithErrorMessage:(NSString *)message
{
    [self hideActivityIndicator];
    [self showErrorViewWithMessage:message];
}

- (void)eventsDataSource:(EventsDataSource *)eventsDataSource onEventsFetched:(NSArray<Event *> *)fetchedEvents
{
    [self hideActivityIndicator];
    
    // Execute the appropriate block of code according to the fetched amount
    // of events.
    if (fetchedEvents.count > 0)
    {
        [self.tableView reloadData];
    } /* if more than 0 events were returned by the fetch operation. */
    else {
        [self showEmptyTableBackgroundView];
    } /* if 0 events were returned by the fetch operation. */
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

@end
