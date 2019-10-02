//
//  TabViewItemLabel.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-08-12.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * A subclass of UIView used to display a title in a Tab View.
 */
@interface TabViewItemLabel : UILabel

/**
 * Initializes and returns a Tab View Item Label object using the provided
 * title instance.
 */
- (instancetype _Nullable)initWithTitle:(NSString * _Nonnull)title;

@end
