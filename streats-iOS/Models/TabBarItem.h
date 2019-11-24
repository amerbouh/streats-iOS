//
//  TabBarItem.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-08-12.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarItem : NSObject

// Properties

@property (strong, nonatomic, nonnull) NSString *title;
@property (strong, nonatomic, nonnull) UIViewController *viewController;

/**
Initializes and returns a Tab Bar Item object using the provided parameters.

@param title A string describing the title of the Tab Bar Item.
@param viewController A View Controller object representing the View Controller instance the Tab Bar Item controls.
*/
- (instancetype _Nullable)initWithTitle:(NSString * _Nonnull)title controller:(UIViewController * _Nonnull)viewController;

@end
