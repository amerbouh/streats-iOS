//
//  VendorTableViewCell.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-13.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Vendor;
@class VendorTableViewCell;

/**
 * @brief The protocol used to interact with the Vendor Table View Cell.
 */
@protocol VendorTableViewCellDelegate <NSObject>

- (void)didRequestResourceWithURL:(NSURL*_Nonnull)URL from:(VendorTableViewCell*_Nonnull)requestor;

@end

@interface VendorTableViewCell : UITableViewCell

// Properties

@property(weak, nonatomic, nullable) id <VendorTableViewCellDelegate> delegate;

// Methods

- (void)setVendorImage:(UIImage*_Nullable)image;
- (void)populateWithVendor:(Vendor*_Nonnull)vendor;

@end
