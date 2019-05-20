//
//  ImagesService.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-14.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagesService : NSObject

/**
 * @brief Downloads an image with the given URL over the network.
 * @param URL The download URL of the image.
 * @param completionHandler The completion handler to call when the load request is complete.
 */
+ (void)downloadImageWithURL:(NSURL*_Nonnull)URL completionHandler:(void (^_Nullable)(UIImage * _Nullable downloadedImage, NSError * _Nullable error))completionHandler;

@end
