//
//  EventTableViewCell.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-20.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Event;

/**
 * A subclass of UITableViewCell used to display the details of an Event instance.
 */
@interface EventTableViewCell : UITableViewCell

/**
 * Populates the views of the cell with the details of the provided Event instance. 
 *
 * @param event An Event instance.
 */
- (void)populateWithEvent:(Event *)event;

@end
