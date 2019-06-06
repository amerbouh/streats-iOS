//
//  LotsListTableViewController.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-06-01.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "LotsListTableViewController.h"
#import "LotTableViewCell.h"
#import "ErrorView.h"
#import "Lot.h"
#import "LotsService.h"

@interface LotsListTableViewController ()

// Methods

@property(strong, nonatomic, nonnull) NSMutableArray<Lot *> *lots;

// Methods

- (void)loadLots;
- (void)showActivityIndicator;
- (void)hideActivityIndicator;
- (void)showErrorViewWithMessage:(NSString*)message;

@end

@implementation LotsListTableViewController {
    NSString *_reuseIdentifier;
}

#pragma mark - View's lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize the reuse identifier.
    _reuseIdentifier = @"LotTableViewCell";
    
    // Register cell classes...
    UINib *lotCellNib = [UINib nibWithNibName:_reuseIdentifier bundle:NULL];
    [self.tableView registerNib:lotCellNib forCellReuseIdentifier:_reuseIdentifier];
    
    // Do any additional setup after loading the view.
    [self loadLots];
}

#pragma mark - Methods

- (void)loadLots {
    [self showActivityIndicator];
    
    // Fetch the lots.
    [LotsService getLotsForTime:@"today" completionHandler:^(NSArray<Lot *> * _Nullable lots, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideActivityIndicator];
            
            if (error != NULL) {
                [self showErrorViewWithMessage:error.localizedDescription];
            } else {
                
            }
        });
    }];
}

- (void)showActivityIndicator {
    UIActivityIndicatorView* activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    // Set the activity indicator as the background of the table view and start animating it.
    [activityIndicator startAnimating];
    [self.tableView setBackgroundView:activityIndicator];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)hideActivityIndicator {
    [self.tableView setBackgroundView:NULL];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
}

- (void)showErrorViewWithMessage:(NSString *)message {
    ErrorView *errorView = [[ErrorView alloc] init];
    
    // Configure the error view...
    [errorView setDelegate:self];
    [errorView setFrame:self.tableView.bounds];

    // Set the error view as the table view's background.
    [self.tableView setBackgroundView:errorView];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lots.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LotTableViewCell *cell = (LotTableViewCell *) [tableView dequeueReusableCellWithIdentifier:_reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Lot *lot = [self.lots objectAtIndex:indexPath.row];
    [cell populateWithLot:lot];
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

#pragma mark - Error view delegate

- (void)tryAgainButtonTaped:(ErrorView * _Nonnull)errorView {
    [self loadLots];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
