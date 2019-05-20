//
//  VendorsListContainerViewController.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-13.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "VendorsListContainerViewController.h"
#import "VendorsListPageViewController.h"

@interface VendorsListContainerViewController ()

// Properties

@property(weak, nonatomic) IBOutlet UILabel *todayTabLabel;
@property(weak, nonatomic) IBOutlet UILabel *tomorrowTabLabel;
@property(weak, nonatomic) IBOutlet UILabel *weekTabLabel;

@property(weak, nonatomic) IBOutlet UIView *pageIndicatorView;
@property(weak, nonatomic) IBOutlet NSLayoutConstraint *pageIndicatorViewLeadingAnchor;

// Methods

- (void)configureTabsLabels;
- (void)activateTabAtIndex:(NSUInteger)index;

@end

@implementation VendorsListContainerViewController

#pragma mark - Properties

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - View's lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    UIImage* shadowImage = [[UIImage alloc] init];
    
    [self configureTabsLabels];
    [self.navigationItem setTitle:NSLocalizedString(@"vendors", NULL)];
    [self.navigationController.navigationBar setShadowImage:shadowImage];
}

#pragma mark - Methods

- (void)configureTabsLabels {
    [self.todayTabLabel setText:[NSLocalizedString(@"today", NULL) localizedUppercaseString]];
    [self.tomorrowTabLabel setText:[NSLocalizedString(@"tomorrow", NULL) localizedUppercaseString]];
    [self.weekTabLabel setText:[NSLocalizedString(@"thisWeek", NULL) localizedUppercaseString]];
}

- (void)activateTabAtIndex:(NSUInteger)index {
    switch (index) {
        case 0:
            [self.todayTabLabel setTextColor:UIColor.whiteColor];
            [self.tomorrowTabLabel setTextColor:UIColor.lightTextColor];
            [self.weekTabLabel setTextColor:UIColor.lightTextColor];
            
            [self.pageIndicatorViewLeadingAnchor setConstant:0];
            break;
            
        case 1:
            [self.todayTabLabel setTextColor:UIColor.lightTextColor];
            [self.tomorrowTabLabel setTextColor:UIColor.whiteColor];
            [self.weekTabLabel setTextColor:UIColor.lightTextColor];
            
            [self.pageIndicatorViewLeadingAnchor setConstant:self.pageIndicatorView.frame.size.width];
            break;
            
        case 2:
            [self.todayTabLabel setTextColor:UIColor.lightTextColor];
            [self.tomorrowTabLabel setTextColor:UIColor.lightTextColor];
            [self.weekTabLabel setTextColor:UIColor.whiteColor];
            
            [self.pageIndicatorViewLeadingAnchor setConstant:self.pageIndicatorView.frame.size.width * 2];
            break;
            
        default:
            break;
    }
    
    // Animate the changes.
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - Vendors list page view controller delegate

- (void)didTransitionToPage:(VendorsListPageViewController *)vendorsListPageViewController atIndex:(NSUInteger)index {
    [self activateTabAtIndex:index];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"VendorsListPageVCEmbedSegue"]) {
        VendorsListPageViewController* vendorsListPageViewController = segue.destinationViewController;
        [vendorsListPageViewController setTransitionDelegate:self];
    }
}

@end
