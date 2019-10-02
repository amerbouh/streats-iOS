//
//  AppDelegate.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-13.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "AppDelegate.h"
#import <FirebaseCore/FirebaseCore.h>

typedef NS_ENUM(NSUInteger, ShortcutItemTitle) {
    kTodayVendors
};

@interface AppDelegate ()

/**
 * Performs an action based the provided shortcut item instance.
 *
 * @param application Your singleton app object.
 * @param item The shortcut item instance handled by the function.
 */
- (void)application:(UIApplication *)application handleShortcutItem:(UIApplicationShortcutItem *)item;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [FIRApp configure];
    return YES;
}
  
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    [self application:application handleShortcutItem:shortcutItem];
}

- (void)application:(UIApplication *)application handleShortcutItem:(UIApplicationShortcutItem *)item
{
    NSString *bundleIdentifier = NSBundle.mainBundle.bundleIdentifier;
    NSString *shortcutType = [NSString stringWithFormat:@"%@.%@", bundleIdentifier, item.type];
    
    if ([shortcutType containsString:@"see_today_vendors"]) {
        UITabBarController *tabBarController = (UITabBarController *) application.keyWindow.rootViewController;
        [tabBarController setSelectedIndex:1];
    }
}

@end
