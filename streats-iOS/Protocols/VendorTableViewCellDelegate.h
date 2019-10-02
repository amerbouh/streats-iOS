//
//  VendorTableViewCellDelegate.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-08-13.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#ifndef VendorTableViewCellDelegate_h
#define VendorTableViewCellDelegate_h

@class VendorTableViewCell;

/**
 * The protocol used to interact with the Vendor Table View Cell.
 */
@protocol VendorTableViewCellDelegate <NSObject>

- (void)didRequestResourceWithURL:(NSURL * _Nonnull)URL from:(VendorTableViewCell*_Nonnull)requestor;

@end

#endif /* VendorTableViewCellDelegate_h */
