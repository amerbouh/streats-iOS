//
//  LotDetailContainerViewController.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-18.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "LotDetailContainerViewController.h"
#import "LotDetailPageViewController.h"
#import "Lot.h"

@interface LotDetailContainerViewController ()

// Properties

@property (weak, nonatomic) IBOutlet UILabel *attendeesTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *informationTitleLabel;

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *pageIndicatorView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pageIndicatorViewLeadingAnchor;

@property (strong, nonatomic) NSArray<UITableViewController *> *pages;

// Methods

- (void)configureTabsLabels;
- (void)activateTabAtIndex:(NSUInteger)index;

@end

@implementation LotDetailContainerViewController

#pragma mark - View's lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self configureTabsLabels];
    [self.navigationItem setTitle:self.lot.name];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

#pragma mark - Methods

- (void)configureTabsLabels {
    [self.attendeesTitleLabel setText:[NSLocalizedString(@"attendees", NULL) localizedUppercaseString]];
    [self.informationTitleLabel setText:[NSLocalizedString(@"information", NULL) localizedUppercaseString]];
}

- (void)activateTabAtIndex:(NSUInteger)index {
    switch (index) {
        case 0:
            [self.attendeesTitleLabel setTextColor:UIColor.whiteColor];
            [self.informationTitleLabel setTextColor:UIColor.lightTextColor];
            
            [self.pageIndicatorViewLeadingAnchor setConstant:0];
            break;
            
        case 1:
            [self.attendeesTitleLabel setTextColor:UIColor.lightTextColor];
            [self.informationTitleLabel setTextColor:UIColor.whiteColor];
            
            [self.pageIndicatorViewLeadingAnchor setConstant:self.pageIndicatorView.frame.size.width];
            break;
            
        default:
            break;
    }
    
    // Animate the changes.
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)doneBarButtonItem:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Vendors list page view controller delegate

- (void)didTransitionToPage:(LotDetailPageViewController *)lotDetailPageViewController atIndex:(NSUInteger)index {
    [self activateTabAtIndex:index];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"LotDetailPageVCEmbedSegue"]) {
        LotDetailPageViewController* lotDetailPageVC = segue.destinationViewController;
        [lotDetailPageVC setLot:self.lot];
        [lotDetailPageVC setTransitionDelegate:self];
    }
}
@end
