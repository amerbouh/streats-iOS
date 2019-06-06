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

@implementation MenuItemsService

+ (void)uploadMenuItemImage:(UIImage *)image forMenuItemWithIdentifier:(NSString *)menuItemIdentifier andVendorWithIdentifier:(NSNumber *)vendorIdentifier completionHandler:(void (^)(NSError * _Nullable))completionHandler {
    StorageController *storageController  = [[StorageController alloc] init];
    
    // Create the reference to the image location.
    FIRStorage *storage = [FIRStorage storage];
    FIRStorageReference *imageLocation = [[storage reference] child:[NSString stringWithFormat:@"assets/%@/menu_items/%@/menuItem.png", vendorIdentifier, menuItemIdentifier]];
    
    // Upload the menu item' image.
    [storageController uploadImage:image atLocation:imageLocation completionHandler:^(NSURL * _Nullable uploadedImageUrl, NSError * _Nullable error) {
        if (error != NULL) {
            completionHandler(error);
        } else {
            [MenuItemsService uploadImageDownloadURLForMenuItemWithIdentifier:menuItemIdentifier correspondingVendorIdentifier:vendorIdentifier downloadUrl:uploadedImageUrl completionHandler:completionHandler];
        }
    }];
}

+ (void)uploadImageDownloadURLForMenuItemWithIdentifier:(NSString *)menuItemIdentifier correspondingVendorIdentifier:(NSNumber *)vendorIdentifier downloadUrl:(NSURL *)downloadUrl completionHandler:(void (^)(NSError * _Nullable))completionHandler {
    FIRDocumentReference *vendorDocumentRef = [[[FIRFirestore firestore] collectionWithPath:@"vendors"] documentWithPath:[vendorIdentifier stringValue]];
    FIRDocumentReference *menuItemRef = [[vendorDocumentRef collectionWithPath:@"menu_items"] documentWithPath:menuItemIdentifier];
    
    // Set the download URL of the menu item's image on its document.
    [menuItemRef updateData:@{ @"image_download_url": downloadUrl.absoluteString } completion:completionHandler];
}

@end
