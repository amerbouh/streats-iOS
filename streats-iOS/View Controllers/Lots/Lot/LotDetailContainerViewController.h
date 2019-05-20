//
//  LotDetailContainerViewController.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-18.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LotDetailPageViewController.h"

@class Lot;

@interface LotDetailContainerViewController : UIViewController <LotDetailPageViewControllerDelegate>

@property(strong, nonatomic, nonnull) Lot *lot;

@end
