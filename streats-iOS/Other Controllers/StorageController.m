
//
//  StorageController.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-06-03.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "StorageController.h"
#import <FirebaseStorage/FirebaseStorage.h>

@interface StorageController ()

@property(strong, nonatomic, nonnull) FIRStorage *storage;

@end

@implementation StorageController

#pragma mark - Methods

- (instancetype)init
{
    self = [super init];
    if (self) {
        _storage = [FIRStorage storage];
    }
    return self;
}

- (void)uploadImage:(UIImage *)image atLocation:(FIRStorageReference *)location completionHandler:(void (^)(NSURL * _Nullable, NSError * _Nullable))completionHandler {
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    
    // Create and send the upload task.
    [location putData:imageData metadata:NULL completion:^(FIRStorageMetadata * _Nullable metadata, NSError * _Nullable error) {
        if (error != NULL) {
            completionHandler(NULL, error);
        } else {
            [location downloadURLWithCompletion:completionHandler];
        }
    }];
}

@end
