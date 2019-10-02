//
//  BaseNavigationController.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-06-08.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

// Methods

- (void)configureAppearance;

@end

@implementation BaseNavigationController

#pragma mark - View's lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self configureAppearance];
}

#pragma mark - Methods

- (void)prepareForInterfaceBuilder
{
    [super prepareForInterfaceBuilder];
    
    // Configure the navigation bar's appearance.
    [self configureAppearance];
}

- (void)configureAppearance
{
    [self.navigationBar setTranslucent:NO];
    [self.navigationBar setTintColor:[UIColor colorNamed:@"Navigation Bar Tint Color"]];
    [self.navigationBar setBarTintColor:[UIColor colorNamed:@"Primary"]];
    
    // Set the title's text attributes.
    NSDictionary<NSAttributedStringKey, id> *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorNamed:@"Secondary"], NSForegroundColorAttributeName, nil];
    [self.navigationBar setTitleTextAttributes:attributes];
}

@end
