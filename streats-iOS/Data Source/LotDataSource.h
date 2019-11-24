//
//  LotDataSource.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-10-12.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LotsDataSourceDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface LotDataSource : NSObject <UITableViewDataSource>

/**
 * Holds a reference to the object that sends touch-related events from the view.
 */
@property (weak, nonatomic, nullable) id <LotsDataSourceDelegate> delegate;

/**
 @brief Retrieves the lots corresponding to the time passed as a constructor parameter.
 */
- (void)loadLots;

@end

NS_ASSUME_NONNULL_END
