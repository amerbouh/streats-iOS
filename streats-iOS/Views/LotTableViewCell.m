//
//  LotTableViewCell.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-06-01.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "LotTableViewCell.h"
#import "Lot.h"

@interface LotTableViewCell ()

/**
 * A label that displays a string representing the amount of attendees at
 * the given lot.
 */
@property (weak, nonatomic) IBOutlet UILabel *attendeesCountLabel;

/** A label that displays a string representing the name of the lot. */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

/** A label that displays a string representing the address of the lot. */
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation LotTableViewCell

#pragma mark - Methods

- (void)populateWithLot:(Lot *)lot
{
    [self.nameLabel setText:lot.name];
    [self.addressLabel setText:lot.address];
}

@end
