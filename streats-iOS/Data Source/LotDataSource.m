//
//  LotDataSource.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-10-12.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "LotDataSource.h"
#import "Lot.h"
#import "LotsService.h"
#import "LotTableViewCell.h"

@interface LotDataSource ()

@property (strong, nonatomic, nonnull) NSArray<Lot *> * lots;
@property (strong, nonatomic, nonnull) LotsService * lotsService;

@end

@implementation LotDataSource

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        _lots = [NSArray new];
        _lotsService = [LotsService new];
    }
    return self;
}

#pragma mark - Methods

- (void)loadLots
{
}

#pragma mark - Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lots.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LotTableViewCell *cell = (LotTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"LotTableViewCell"];
    
    // Configure the cell...
    Lot *lot = [self.lots objectAtIndex:indexPath.row];
    [cell populateWithLot:lot];
    
    return cell;
}

@end
