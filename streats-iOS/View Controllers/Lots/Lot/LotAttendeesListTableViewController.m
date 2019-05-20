//
//  LotAttendeesListTableViewController.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-18.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "LotAttendeesListTableViewController.h"
#import "VendorTableViewCell.h"
#import "EmptyTableBackgroundView.h"
#import "Vendor.h"

@interface LotAttendeesListTableViewController ()

@end

@implementation LotAttendeesListTableViewController

#pragma mark - View's lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes.
    UINib* vendorCellNib = [UINib nibWithNibName:@"VendorTableViewCell" bundle:NULL];
    [self.tableView registerNib:vendorCellNib forCellReuseIdentifier:@"VendorTableViewCell"];
    
    // Do any additional setup after loading the view.
    if (self.attendees.count < 1) {
        EmptyTableBackgroundView *backgroundView = [[EmptyTableBackgroundView alloc] initWithMessage:NSLocalizedString(@"noAttendee", NULL) andDescription:NSLocalizedString(@"noAttendeeDescription", NULL)];
        
        [self.tableView setBackgroundView:backgroundView];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
}

#pragma mark - Methods

- (instancetype)initWithAttendees:(NSArray<Vendor *> *)attendees {
    if ((self = [super init])) {
        _attendees = attendees;
    }
    
    return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.attendees.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VendorTableViewCell *cell = (VendorTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"VendorTableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    Vendor *vendor = [self.attendees objectAtIndex:indexPath.row];
    [cell populateWithVendor:vendor];
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

@end
