//
//  EventsListTableViewController.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-20.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ErrorViewDelegate.h"
#import "EventsDataSourceDelegate.h"

@class Vendor;

@interface EventsListTableViewController : UIViewController <UITableViewDelegate, ErrorViewDelegate, EventsDataSourceDelegate>

- (instancetype)initWithVendor:(Vendor *)vendor;

@end
