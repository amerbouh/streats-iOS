//
//  EventsListTableViewController.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-20.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ErrorView.h"

@interface EventsListTableViewController : UITableViewController <ErrorViewDelegate>

@property(strong, nonatomic, nonnull) NSNumber *vendorIdentifier;

@end
