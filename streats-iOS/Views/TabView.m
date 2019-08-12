//
//  TabView.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-08-12.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "TabView.h"
#import "TabViewItemLabel.h"

@interface TabView ()

// Properties

@property (strong, nonatomic, nonnull) NSArray<NSString *> *titles;
@property (strong, nonatomic, nonnull) NSNumber *selectedTabIndex;

@property (strong, nonatomic, nonnull) UIView *selectedTabIndicatorView;
@property (strong, nonatomic, nonnull) UIStackView *titleLabelsContainerStackView;

// Methopds

- (void)configureTitleLabels;
- (void)configureSelectedTabIndicatorView;

@end

@implementation TabView

#pragma mark - Initialization

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles {
    if ((self = [super initWithFrame:CGRectZero])) {
        _titles = titles;
        _selectedTabIndex = 0;
        _selectedTabIndicatorView = [[UIView alloc] init];
        _titleLabelsContainerStackView = [[UIStackView alloc] init];
        _selectedTabIndicatorViewBackgroundColor = UIColor.whiteColor;
        
        // Set the tab background color.
        UIColor *backgroundColor = [UIColor colorNamed:@"Primary"];
        [self setBackgroundColor:backgroundColor];
    }
    
    return self;
}

#pragma mark - Methods

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // Configure the title labels and the tab indicator view.
    [self configureTitleLabels];
    [self configureSelectedTabIndicatorView];
    
    // Add the tab indicator view to the view's hierarchy.
    [self addSubview:self.selectedTabIndicatorView];
    [self addSubview:self.titleLabelsContainerStackView];
}

- (void)configureTitleLabels {
    [self.titleLabelsContainerStackView setFrame:self.bounds];
    [self.titleLabelsContainerStackView setAxis:UILayoutConstraintAxisHorizontal];
    [self.titleLabelsContainerStackView setDistribution:UIStackViewDistributionFillEqually];
    
    // Create a label for each title and add it to the title labels
    // stack view.
    for (NSString *title in self.titles) {
        TabViewItemLabel *titleLabel = [[TabViewItemLabel alloc] initWithTitle:title];
        
        // Add the title label to the labels container stack view if it was successfully
        // instanciated.
        if (titleLabel != nil) {
            [self.titleLabelsContainerStackView addArrangedSubview:(UIView *) titleLabel];
        }
    }
}

- (void)configureSelectedTabIndicatorView {
    int tabIndicatorViewHeight = 3;
    CGRect tabIndicatorViewFrame = CGRectMake(0, (self.bounds.size.height - tabIndicatorViewHeight), (self.bounds.size.width / self.titles.count), tabIndicatorViewHeight);
    
    // Configure the tab indicator view's background color and frame.
    [self.selectedTabIndicatorView setBackgroundColor:self.selectedTabIndicatorViewBackgroundColor];
    [self.selectedTabIndicatorView setFrame:tabIndicatorViewFrame];
}

- (void)selectTabAtIndex:(NSUInteger)index {
    TabViewItemLabel *selectedTabTitleLabel = (TabViewItemLabel *) [self.titleLabelsContainerStackView.arrangedSubviews objectAtIndex:index];
    
    // Re-position the selected tab indicator below the selected tab and
    // animate the changes.
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint tabIndicatorViewCenter = CGPointMake(selectedTabTitleLabel.center.x, self.bounds.size.height);
        [self.selectedTabIndicatorView setCenter:tabIndicatorViewCenter];
    }];
}

@end
