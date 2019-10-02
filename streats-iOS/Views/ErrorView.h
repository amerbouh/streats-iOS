//
//  ErrorView.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-14.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ErrorViewDelegate.h"

@class ErrorView;

/**
 * A subclass of UIView used to display an error.
 */
@interface ErrorView : UIView

/**
 * Holds a reference to the object that sends touch-related events from the view.
 */
@property(weak, nonatomic, nullable) id <ErrorViewDelegate> delegate;

/**
 * Sets the error message displayed by the view to the user.
 *
 * @param message A string that represents the message to display.
 */
- (void)setMessage:(NSString*_Nonnull)message;

/**
 * Initializes and returns an Error View object using the provided message.
 *
 * @param message The error message to display to the user.
 */
- (instancetype _Nullable)initWithMessage:(NSString*_Nonnull)message;

@end
