//
//  CarouselCollectionViewCell.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-17.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "CarouselCollectionViewCell.h"

@interface CarouselCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation CarouselCollectionViewCell

#pragma mark - Methods

- (void)setImage:(UIImage *)image {
    [self.imageView setImage:image];
}

@end
