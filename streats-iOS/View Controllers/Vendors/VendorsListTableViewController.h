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
#import "VendorDetailTableViewController.h"

@interface VendorsListTableViewController : UITableViewController <VendorTableViewCellDelegate, ErrorViewDelegate>

// Methods

- (instancetype _Nullable)initWithFilter:(NSString* _Nonnull)filter;

@end
