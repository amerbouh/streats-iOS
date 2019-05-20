//
//  MenuItemTableViewCell.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-16.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "MenuItemTableViewCell.h"
#import "MenuItem.h"

@interface MenuItemTableViewCell ()

@property(weak, nonatomic) IBOutlet UILabel *nameLabel;
@property(weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation MenuItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Methods

- (void)populateCellWithMenuItem:(MenuItem *)menuItem {
    [self.nameLabel setText:menuItem.name];
    [self.priceLabel setText:menuItem.priceString];
}
 
@end
