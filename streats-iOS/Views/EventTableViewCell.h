//
//  EventTableViewCell.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-20.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Event;

@interface EventTableViewCell : UITableViewCell

- (void)populateWithEvent:(Event *)event;

@end
