//
//  TabView.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-08-12.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * A subclass of UIView used to display a horizontal list of titles
 * the user can interact with.
 */
@interface TabView : UIView

/** The color applied to the titles displayed by the view. */
@property (strong, nonatomic, nonnull) UIColor *textColor;

/** The background color of the view displayed underneath the currenlty selected title. */
@property (strong, nonatomic, nonnull) UIColor *selectedTabIndicatorViewBackgroundColor;

/**
 * Initializes and returns a Tab View object using the provided title instances.
 *
 * @param titles A array of strings that represent the titles displayed by the view.
 */
- (instancetype _Nullable)initWithTitles:(NSArray<NSString *> * _Nonnull)titles;

/**
* Initializes and returns a Tab View object using the provided title instances and background color.
*
* @param titles An array of strings that represents the titles displayed by the view.
* @param backgroundColor The background color the apply to the Tab View object.
*/
- (instancetype _Nullable)initWithTitles:(NSArray<NSString *> * _Nonnull)titles backgroundColor:(UIColor * _Nonnull)backgroundColor;

/**
 *
 * Moves the selected tab indicator view underneath the title positionned at the
 * given index.
 *
 * @param index An unsigned integer thet represents the position of the title to select.
 */
- (void)selectTabAtIndex:(NSUInteger)index;

@end
