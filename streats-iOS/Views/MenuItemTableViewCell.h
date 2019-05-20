//
//  MenuItemTableViewCell.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-16.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuItem;

@interface MenuItemTableViewCell : UITableViewCell

- (void)populateCellWithMenuItem:(MenuItem *)menuItem;

@end
