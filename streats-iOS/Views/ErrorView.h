//
//  ErrorView.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-14.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ErrorView;

/**
 * @brief The protocol used to receive touch-related events from the Error View.
 */
@protocol ErrorViewDelegate <NSObject>

- (void)tryAgainButtonTaped:(ErrorView*_Nonnull)errorView;

@end

@interface ErrorView : UIView

/**
 * @brief Holds a reference to the object that touch-related events from the view.
 */
@property(weak, nonatomic, nullable) id <ErrorViewDelegate> delegate;

/**
 * @brief Sets the error message displayed by the view to the user.
 */
- (void)setMessage:(NSString*_Nonnull)message;

/**
 * @brief Creates an new instance of the Error View with the given message.
 * @param message The error message to display to the user.
 */
- (instancetype _Nullable)initWithMessage:(NSString*_Nonnull)message;

@end
