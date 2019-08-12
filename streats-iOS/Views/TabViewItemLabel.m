//
//  TabViewItemLabel.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-08-12.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "TabViewItemLabel.h"

@interface TabViewItemLabel ()

- (void)configureLabelWithTitle:(NSString *)title;

@end

@implementation TabViewItemLabel

#pragma mark - Initialization

- (instancetype)initWithTitle:(NSString *)title {
    if ((self = [super init])) {
        [self configureLabelWithTitle:title];
    }
    
    return self;
}

#pragma mark - Methods

- (void)configureLabelWithTitle:(NSString *)title {
    [self setText:title];
    [self setTextColor:UIColor.whiteColor];
    [self setTextAlignment:NSTextAlignmentCenter];
    [self setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightMedium]];
    [self setUserInteractionEnabled:YES];
}

@end
