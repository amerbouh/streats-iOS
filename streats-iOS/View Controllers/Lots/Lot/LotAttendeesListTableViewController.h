//
//  LotAttendeesListTableViewController.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-18.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Vendor;

@interface LotAttendeesListTableViewController : UITableViewController

// Properties

@property(strong, nonatomic, nonnull) NSArray<Vendor *> *attendees;

// Methods

- (instancetype _Nullable)initWithAttendees:(NSArray<Vendor *> * _Nonnull)attendees;

@end
