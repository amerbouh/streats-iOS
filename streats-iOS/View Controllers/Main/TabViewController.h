//
//  TabViewController.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-06-07.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HorizontalPageViewControllerManager.h"

@class TabBarItem;

@interface TabViewController : UIViewController <HorizontalPageViewControllerManagerDelegate>

/**
* Initializes and returns a Tab View View Controller object using the provided items instances.
*
* @param items An array of Tab Bar Item objects used by the View Controller to display views..
*/
- (instancetype _Nonnull)initWithItems:(NSArray<TabBarItem *> * _Nonnull)items;

@end
