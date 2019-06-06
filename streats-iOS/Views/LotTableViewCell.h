//
//  LotTableViewCell.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-06-01.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Lot;

@interface LotTableViewCell : UITableViewCell

- (void)populateWithLot:(Lot *)lot;

@end
