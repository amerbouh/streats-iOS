//
//  VendorTableViewCell.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-13.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "VendorTableViewCell.h"
#import "Vendor.h"

@interface VendorTableViewCell ()

@property(weak, nonatomic) IBOutlet UILabel *nameLabel;
@property(weak, nonatomic) IBOutlet UILabel *cuisineTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property(weak, nonatomic) IBOutlet UIImageView *logoImageView;

@end

@implementation VendorTableViewCell

#pragma mark - Methods

- (void)prepareForReuse {
    [super prepareForReuse];
    
    // Reset the image view displaying the vendor's logo.
    UIImage* defaultImage = [UIImage imageNamed:@"img_food-truck-placeholder"];
    [self.logoImageView setImage:defaultImage];
}

- (void)setVendorImage:(UIImage *)image {
    [self.logoImageView setImage:image];
}

- (void)populateWithVendor:(Vendor *)vendor {
    [self.nameLabel setText:vendor.name];
    [self.cuisineTypeLabel setText:vendor.cuisineType];
    [self.descriptionLabel setText:vendor.shortDescription];
    
    // Ask the delegate to download the vendor's icon, if applicable.
    if (vendor.iconDownloadURL != NULL) {
        NSURL* resourceURL = [NSURL URLWithString:vendor.iconDownloadURL];
        [self.delegate didRequestResourceWithURL:resourceURL from:self];
    }
}

@end
