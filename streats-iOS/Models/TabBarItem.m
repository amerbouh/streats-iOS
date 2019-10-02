//
//  TabBarItem.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-08-12.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "TabBarItem.h"

@implementation TabBarItem

#pragma mark - Initialization

- (instancetype)initWithTitle:(NSString *)title controller:(UIViewController *)viewController
{
    self = [super init];
    if (self) {
        _title = title;
        _viewController = viewController;
    }
    return self;
}

@end
