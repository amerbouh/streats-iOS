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

@property(strong, nonatomic, nonnull) Lot *lot;
@property (strong, nonatomic) NSArray<UITableViewController *> *pages;

// Methods

- (void)doneBarButtonItemTaped;
- (void)configureNavigationItem;
- (void)activateTabAtIndex:(NSUInteger)index;

@end

@implementation LotDetailContainerViewController

#pragma mark - Initialization

- (instancetype)initWithLot:(Lot *)lot
{
    if ((self = [super init])) {
        _lot = lot;
    }
    return self;
}

#pragma mark - View's lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self configureNavigationItem];
    [self.view setBackgroundColor:UIColor.whiteColor];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

#pragma mark - Methods

- (void)doneBarButtonItemTaped
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)configureNavigationItem
{
    [self.navigationItem setTitle:self.lot.name];
    [self.navigationItem setRightBarButtonItem:[
        [UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneBarButtonItemTaped)]
    ];
}

- (void)activateTabAtIndex:(NSUInteger)index
{
    
}

#pragma mark - Vendors list page view controller delegate

- (void)didTransitionToPage:(LotDetailPageViewController *)lotDetailPageViewController atIndex:(NSUInteger)index
{
    [self activateTabAtIndex:index];
}

@end
