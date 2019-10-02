//
//  EmptyTableBackgroundView.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-17.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "EmptyTableBackgroundView.h"

@interface EmptyTableBackgroundView ()

// Properties

@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation EmptyTableBackgroundView

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        [NSBundle.mainBundle loadNibNamed:@"EmptyTableBackgroundView" owner:self options:0];
        [self addSubview:_contentView];
        [_contentView setFrame:self.bounds];
    }
    return self;
}

- (instancetype)initWithMessage:(NSString *)message andDescription:(NSString *)description {
    if ((self = [self init])) {
        _messageLabel.text = message;
        _descriptionLabel.text = description;
    }
    
    return self;
}

@end
