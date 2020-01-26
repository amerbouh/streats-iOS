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

/** An array of string representing the titles displayed by the view. */
@property (strong, nonatomic, nonnull) NSArray<NSString *> *titles;

/** A view displayed underneath the currenlty selected title. */
@property (strong, nonatomic, nonnull) UIView *selectedTabIndicatorView;

/** A horizontal stack view containing all the titles displayed by the view. */
@property (strong, nonatomic, nonnull) UIStackView *titleLabelsContainerStackView;

/**
 * Creates a label for each title displayed by the view and adds it to the
 * views hierarchy.
 */
- (void)configureTitleLabels;

@end

@implementation TabView

#pragma mark - Initialization

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles
{
    if ((self = [super initWithFrame:CGRectZero])) {
        _titles = titles;
        _selectedTabIndicatorView = [[UIView alloc] init];
        _titleLabelsContainerStackView = [[UIStackView alloc] init];
        _selectedTabIndicatorViewBackgroundColor = UIColor.whiteColor;
        
        // Add the subviews.
        [self addSubview:self.selectedTabIndicatorView];
        [self addSubview:self.titleLabelsContainerStackView];
        
        // Configure the title labels.
        [self configureTitleLabels];
        
        // Configure the selected tab indicator view.
        [self configureSelectedTabIndicatorView];
    }
    
    return self;
}

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles backgroundColor:(UIColor *)backgroundColor
{
    if ((self = [super initWithFrame:CGRectZero])) {
        _titles = titles;
        _selectedTabIndicatorView = [[UIView alloc] init];
        _titleLabelsContainerStackView = [[UIStackView alloc] init];
        _selectedTabIndicatorViewBackgroundColor = UIColor.whiteColor;
        
        // Configure the background color.
        [self setBackgroundColor:backgroundColor];
        
        // Add the subviews.
        [self addSubview:self.selectedTabIndicatorView];
        [self addSubview:self.titleLabelsContainerStackView];
        
        // Configure the title labels.
        [self configureTitleLabels];
        
        // Configure the selected tab indicator view.
        [self configureSelectedTabIndicatorView];
    }
    
    return self;
}

#pragma mark - Methods

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Configure the title labels container stack view frame.
    [self.titleLabelsContainerStackView setFrame:self.bounds];
    
    // Configure the tab indicator view's frame.
    [self configureSelectedTabIndicatorView];
}

- (void)configureTitleLabels
{
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
            
            // Get the index of the inserted label.
            NSUInteger labelIndex = [self.titleLabelsContainerStackView.arrangedSubviews indexOfObject:titleLabel];
            
            // Get the label's text.
            NSString * labelText = [self.titles objectAtIndex:labelIndex];
            
            // Set the label's text.
            [titleLabel setText:labelText];
        }
    }
}

- (void)configureSelectedTabIndicatorView
{
    CGFloat selectedTabIndicatorViewWidth = self.frame.size.width / self.titles.count;
    CGFloat selectedTabIndicatorViewHeight = 3;
    CGRect selectedTabIndicatorViewFrame = CGRectMake(0, (self.frame.size.height - selectedTabIndicatorViewHeight), selectedTabIndicatorViewWidth, selectedTabIndicatorViewHeight);
    
    // Configure the tab indicator view's frame and background color.
    [self.selectedTabIndicatorView setFrame:selectedTabIndicatorViewFrame];
    [self.selectedTabIndicatorView setBackgroundColor:self.selectedTabIndicatorViewBackgroundColor];
   
}

- (void)selectTabAtIndex:(NSUInteger)index
{
    TabViewItemLabel *selectedTabTitleLabel = (TabViewItemLabel *) [self.titleLabelsContainerStackView.arrangedSubviews objectAtIndex:index];
    
    // Re-position the selected tab indicator below the selected tab and
    // animate the changes.
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint tabIndicatorViewCenter = CGPointMake(selectedTabTitleLabel.center.x, self.selectedTabIndicatorView.center.y);
        [self.selectedTabIndicatorView setCenter:tabIndicatorViewCenter];
    }];
}

@end
