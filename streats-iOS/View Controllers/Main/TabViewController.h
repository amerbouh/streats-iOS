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

- (instancetype)initWithItems:(NSArray<TabBarItem *> *)items;

@end
