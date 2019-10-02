//
//  LotTableViewCell.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-06-01.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Lot;

/**
 * A subclass of UITableViewCell used to display the details of a Lot instance.
 */
@interface LotTableViewCell : UITableViewCell

/**
 * Populates the views of the cell with the details of the provided Lot instance. 
 *
 * @param lot A Lot instance.
 */
- (void)populateWithLot:(Lot *)lot;

@end
