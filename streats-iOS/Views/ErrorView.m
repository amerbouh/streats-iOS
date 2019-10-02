//
//  ErrorView.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-14.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "ErrorView.h"

@interface ErrorView ()

/** A label that displays a string representing an overview of an error.*/
@property (weak, nonatomic) IBOutlet UIView *contentView;

/** A label that displays a string representing the details of an error. */
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

/** A button that can be clicked to attempt to recover from an error. */
@property (weak, nonatomic) IBOutlet UIButton *tryAgainButton;

/** Handles an event where the try again button is taped. */
- (IBAction)tryAgainButtonTaped:(UIButton *)sender;

@end

@implementation ErrorView

#pragma mark - Methods

- (void)setMessage:(NSString *)message
{
    [self.messageLabel setText:message];
}

- (instancetype)initWithMessage:(NSString *)message
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [NSBundle.mainBundle loadNibNamed:@"ErrorView" owner:self options:0];
        
        [self setMessage:message];
        [self addSubview:self.contentView];
        [self.contentView setFrame:self.bounds];
        [self.tryAgainButton setTitle:NSLocalizedString(@"tryAgain", @"") forState:UIControlStateNormal];
    }
    return self;
}

- (IBAction)tryAgainButtonTaped:(UIButton *)sender
{
    [self.delegate tryAgainButtonTaped:self];
}

@end
