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

/**
* Initializes and returns a Lot Detail Container View Controller object using the provided lot instances.
*
* @param lot A lot object used by the View Controller to display relevant data to the user.
*/
- (instancetype)initWithLot:(Lot *)lot;

@end
