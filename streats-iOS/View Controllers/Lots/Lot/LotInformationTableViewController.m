//
//  LotInformationTableViewController.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-19.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "LotInformationTableViewController.h"
#import "Lot.h"

@interface LotInformationTableViewController ()

// Properties

@property (weak, nonatomic) IBOutlet UILabel *emailTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *hostTruckNameTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *hostTruckNameLabel;

// Methods

- (void)populateViews;
- (void)configureTitleLabels;

@end

@implementation LotInformationTableViewController

#pragma mark - View's lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self populateViews];
    [self configureTitleLabels];
    
    NSLog(@"The lot's name is %@", self.lot.name);
}

#pragma mark - Methods

- (void)configureTitleLabels {
    [self.emailTitleLabel setText:NSLocalizedString(@"eventManagerEmailAddress", NULL)];
    [self.addressTitleLabel setText:NSLocalizedString(@"eventLocationAddress", NULL)];
    [self.phoneNumberTitleLabel setText:NSLocalizedString(@"eventManagerPhoneNumber", NULL)];
    [self.hostTruckNameTitleLabel setText:NSLocalizedString(@"hostTruckName", NULL)];
}

- (void)populateViews {
    [self.emailLabel setText:self.lot.emailAddress];
    [self.addressLabel setText:self.lot.address];
    
    // Populate the phone number label with alternative text, if applicable.
    [self.phoneNumberLabel setText:NSLocalizedString(@"noPhoneNumber", NULL)];
    
    // Populate the host name label with alternative text, if applicable.
    if (self.lot.hostTruckName != NULL) {
        [self.hostTruckNameLabel setText:self.lot.hostTruckName];
    } else {
        [self.hostTruckNameLabel setText:NSLocalizedString(@"unavailableData", NULL)];
    }
    
}

@end
