//
//  BaseNavigationController.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-06-08.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

- (void)configureAppearance;

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self configureAppearance];
}

#pragma mark - Methods

- (void)configureAppearance {
    [self.navigationBar setTranslucent:NO];
    [self.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationBar setBarTintColor:[UIColor colorNamed:@"Primary"]];
}

@end
