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

#pragma mark - Methods

- (void)populateCellWithMenuItem:(MenuItem *)menuItem {
    [self.nameLabel setText:menuItem.name];
    [self.priceLabel setText:menuItem.priceString];
}

@end
