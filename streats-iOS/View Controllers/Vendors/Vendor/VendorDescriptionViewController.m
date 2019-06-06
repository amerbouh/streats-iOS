//
//  VendorDescriptionViewController.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-20.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "VendorDescriptionViewController.h"

@interface VendorDescriptionViewController ()

@property(weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation VendorDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:self.vendorName];
    [self.descriptionLabel setText:self.vendorDescription];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

#pragma mark - Methods

- (IBAction)doneBarButtonItemTaped:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
