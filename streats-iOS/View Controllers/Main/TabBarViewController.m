//
//  TabBarViewController.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-17.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self.viewControllers[0] setTitle:NSLocalizedString(@"map", NULL)];
    [self.viewControllers[1] setTitle:NSLocalizedString(@"list", NULL)];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
