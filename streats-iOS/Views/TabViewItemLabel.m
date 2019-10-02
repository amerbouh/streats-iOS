//
//  TabViewItemLabel.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-08-12.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "TabViewItemLabel.h"

@interface TabViewItemLabel ()

/**
 * Configures the appearance of the label used to display the title.
 */
- (void)configureLabelWithTitle:(NSString *)title;

@end

@implementation TabViewItemLabel

#pragma mark - Initialization

- (instancetype)initWithTitle:(NSString *)title
{
    self =  [super init];
    if (self) {
        [self configureLabelWithTitle:title];
    }
    return self;
}

#pragma mark - Methods

- (void)configureLabelWithTitle:(NSString *)title
{
    [self setText:title];
    [self setTextColor:UIColor.whiteColor];
    [self setTextAlignment:NSTextAlignmentCenter];
    [self setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightMedium]];
    [self setUserInteractionEnabled:YES];
}

@end
