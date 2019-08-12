//
//  TabView.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-08-12.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabView : UIView

// Properties

@property (strong, nonatomic, nonnull) UIColor *textColor;
@property (strong, nonatomic, nonnull) UIColor *selectedTabIndicatorViewBackgroundColor;

// Initialization

- (instancetype _Nullable)initWithTitles:(NSArray<NSString *> * _Nonnull)titles;

// Methods

- (void)selectTabAtIndex:(NSUInteger)index;

@end
