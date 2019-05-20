//
//  LotInformationTableViewController.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-19.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Lot;

@interface LotInformationTableViewController : UITableViewController

@property(strong, nonatomic, nonnull) Lot *lot;

@end
