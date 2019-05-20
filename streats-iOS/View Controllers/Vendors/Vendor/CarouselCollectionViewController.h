//
//  CarouselCollectionViewController.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-16.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarouselCollectionViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

// Properties

@property(strong, nonatomic, nonnull) NSArray<NSString *> *picturesDownloadURLs;

// Methods

- (void)reloadPictures:(NSArray<NSString *> * _Nonnull)newPictures;

@end
