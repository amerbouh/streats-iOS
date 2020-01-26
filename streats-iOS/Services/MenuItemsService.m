//
//  MenuItemsService.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-06-04.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "MenuItemsService.h"
#import "StorageController.h"
#import <FirebaseStorage/FirebaseStorage.h>
#import <FirebaseFirestore/FirebaseFirestore.h>

@interface MenuItemsService ()

+ (void)uploadImageDownloadURLForMenuItemWithIdentifier:(NSString *)menuItemIdentifier correspondingVendorIdentifier:(NSNumber *)vendorIdentifier downloadUrl:(NSURL *)downloadUrl completionHandler:(void (^_Nullable)(NSError * _Nullable error))completionHandler;

@end

#define CURRENT_DATETIME_TIMESTAMP [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000]

struct entite {
    float x, y;
};

@implementation MenuItemsService

#pragma mark - Methods

+ (void)uploadMenuItemImage:(UIImage *)image forMenuItemWithIdentifier:(NSString *)menuItemIdentifier andVendorWithIdentifier:(NSNumber *)vendorIdentifier completionHandler:(void (^)(NSError * _Nullable))completionHandler
{
    StorageController * storageController  = [StorageController new];
        
    // Generate the image's name.
    NSString * imageName = [NSString stringWithFormat:@"menuItem_%@_%@", menuItemIdentifier, CURRENT_DATETIME_TIMESTAMP];
    
    // Create the reference to the image location.
    FIRStorage * storage = [FIRStorage storage];
    FIRStorageReference * imageLocation = [[storage reference] child:[NSString stringWithFormat:@"assets/%@/menu_items/%@/%@.png", vendorIdentifier, menuItemIdentifier, imageName]];
    
    // Upload the menu item' image.
    [storageController uploadImage:image atLocation:imageLocation completionHandler:^(NSURL * _Nullable uploadedImageUrl, NSError * _Nullable error) {
        if (error != NULL) {
            completionHandler(error);
        } else {
            [MenuItemsService uploadImageDownloadURLForMenuItemWithIdentifier:menuItemIdentifier correspondingVendorIdentifier:vendorIdentifier downloadUrl:uploadedImageUrl completionHandler:completionHandler];
        }
    }];
}

+ (void)uploadImageDownloadURLForMenuItemWithIdentifier:(NSString *)menuItemIdentifier correspondingVendorIdentifier:(NSNumber *)vendorIdentifier downloadUrl:(NSURL *)downloadUrl completionHandler:(void (^)(NSError * _Nullable))completionHandler
{
    NSLog(@"The image's download URL is %@", downloadUrl.absoluteString);
    completionHandler(NULL);
}

@end
