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

@property (weak, nonatomic) IBOutlet UILabel *attendeesCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation LotTableViewCell

#pragma mark - View's lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}

#pragma mark - Methods

- (void)populateWithLot:(Lot *)lot {
    [self.nameLabel setText:lot.name];
    [self.addressLabel setText:lot.address];
}

@end
