//
//  VendorTableViewCell.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-13.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VendorTableViewCellDelegate.h"

@class Vendor;
@class VendorTableViewCell;

/**
 * A subclass of UITableViewCell used to display the details of a Vendor instance.
 */
@interface VendorTableViewCell : UITableViewCell

/***/
@property(weak, nonatomic, nullable) id <VendorTableViewCellDelegate> delegate;

// Methods

- (void)setVendorImage:(UIImage*_Nullable)image;
- (void)populateWithVendor:(Vendor*_Nonnull)vendor;

@end
