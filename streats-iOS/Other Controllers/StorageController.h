//
//  StorageController.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-06-03.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FIRStorageReference;

@interface StorageController : NSObject

- (void)uploadImage:(UIImage * _Nonnull)image atLocation:(FIRStorageReference * _Nonnull)location completionHandler:(void (^_Nullable)(NSURL * _Nullable uploadedImageUrl, NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
