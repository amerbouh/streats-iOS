//
//  VendorsListTableViewController.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-13.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ErrorView.h"
#import "VendorTableViewCell.h"

@class Lot;

@interface VendorsListTableViewController : UITableViewController <UIViewControllerPreviewingDelegate, VendorTableViewCellDelegate, ErrorViewDelegate>

// Methods

- (instancetype _Nullable)initWithLot:(Lot *_Nonnull)lot;
- (instancetype _Nullable)initWithFilter:(NSString *_Nonnull)filter;

@end
