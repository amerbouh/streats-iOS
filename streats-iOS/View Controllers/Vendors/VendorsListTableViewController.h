//
//  VendorsListTableViewController.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-13.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Period.h"
#import "ErrorViewDelegate.h"
#import "VendorTableViewCellDelegate.h"

@class Lot;

@interface VendorsListTableViewController : UITableViewController <UIViewControllerPreviewingDelegate, VendorTableViewCellDelegate, ErrorViewDelegate>

- (instancetype _Nullable)initWithLot:(Lot *_Nonnull)lot;
- (instancetype _Nullable)initWithPeriodFilter:(Period)filter;

@end
