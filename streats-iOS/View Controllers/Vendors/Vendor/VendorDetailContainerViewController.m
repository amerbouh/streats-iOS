//
//  VendorDetailContainerViewController.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-20.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "VendorDetailContainerViewController.h"
#import "Vendor.h"

@interface VendorDetailContainerViewController ()

// Properties

@property (weak, nonatomic) IBOutlet UILabel *informationTabLabel;
@property (weak, nonatomic) IBOutlet UILabel *menuTabLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventsTabLabel;

@property(weak, nonatomic) IBOutlet UIView *pageIndicatorView;
@property(weak, nonatomic) IBOutlet NSLayoutConstraint *pageIndicatorViewLeadingAnchor;

// Methods

- (void)configureTabsLabels;
- (void)activateTabAtIndex:(NSUInteger)index;

@end

@implementation VendorDetailContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self configureTabsLabels];
    [self.navigationItem setTitle:self.vendor.name];
}

#pragma mark - Methods

- (void)configureTabsLabels {
    [self.informationTabLabel setText:[NSLocalizedString(@"information", NULL) localizedUppercaseString]];
    [self.menuTabLabel setText:[NSLocalizedString(@"menu", NULL) localizedUppercaseString]];
    [self.eventsTabLabel setText:[NSLocalizedString(@"events", NULL) localizedUppercaseString]];
}

- (void)activateTabAtIndex:(NSUInteger)index {
    switch (index) {
        case 0:
            [self.informationTabLabel setTextColor:UIColor.whiteColor];
            [self.menuTabLabel setTextColor:UIColor.lightTextColor];
            [self.eventsTabLabel setTextColor:UIColor.lightTextColor];
            
            [self.pageIndicatorViewLeadingAnchor setConstant:0];
            break;
            
        case 1:
            [self.informationTabLabel setTextColor:UIColor.lightTextColor];
            [self.menuTabLabel setTextColor:UIColor.whiteColor];
            [self.eventsTabLabel setTextColor:UIColor.lightTextColor];
            
            [self.pageIndicatorViewLeadingAnchor setConstant:self.pageIndicatorView.frame.size.width];
            break;
            
        case 2:
            [self.informationTabLabel setTextColor:UIColor.lightTextColor];
            [self.menuTabLabel setTextColor:UIColor.lightTextColor];
            [self.eventsTabLabel setTextColor:UIColor.whiteColor];
            
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

#pragma mark - Vendor detail page view controller delegate

- (void)didTransitionToPage:(VendorDetailPageViewController *)vendorDetailPageViewController atIndex:(NSUInteger)index {
    [self activateTabAtIndex:index];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"VendorDetailPageVCEmbedSegue"]) {
        VendorDetailPageViewController *vendorDetailPageViewController = (VendorDetailPageViewController *) segue.destinationViewController;
        [vendorDetailPageViewController setVendor:self.vendor];
        [vendorDetailPageViewController setTransitionDelegate:self];
    }
}


@end
