//
//  TabBarItem.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-08-12.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "TabBarItem.h"

@implementation TabBarItem

- (instancetype)initWithTitle:(NSString *)title controller:(UIViewController *)viewController {
    if ((self = [super init])) {
        _title = title;
        _viewController = viewController;
    }
    
    return self;
}

@end
