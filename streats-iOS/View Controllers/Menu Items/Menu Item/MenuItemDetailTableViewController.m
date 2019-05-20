//
//  MenuItemDetailTableViewController.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-16.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "MenuItemDetailTableViewController.h"
#import "MenuItem.h"

@interface MenuItemDetailTableViewController ()

// Properties

@property (weak, nonatomic) IBOutlet UILabel *nameTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ingredientsTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

// Methods

- (void)populateViews;
- (void)configureTitleLabels;

@end

@implementation MenuItemDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self populateViews];
    [self configureTitleLabels];
    [self.navigationItem setTitle:self.menuItem.name];
    
    // Check whether or not we should display the bar button items.
    if (self.shouldShowBarButtonItems) {
        UIBarButtonItem *doneBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(handleDoneBarButtonItemTaped:)];
        [self.navigationItem setRightBarButtonItem:doneBarButtonItem];
    }
}

#pragma mark - Methods

- (void)populateViews {
    [self.nameLabel setText:self.menuItem.name];
    [self.priceLabel setText:self.menuItem.priceString];
}

- (void)configureTitleLabels {
    [self.nameTitleLabel setText:NSLocalizedString(@"name", NULL)];
    [self.priceTitleLabel setText:NSLocalizedString(@"price", NULL)];
    [self.ingredientsTitleLabel setText:NSLocalizedString(@"ingredients", NULL)];
}

- (void)handleDoneBarButtonItemTaped:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
