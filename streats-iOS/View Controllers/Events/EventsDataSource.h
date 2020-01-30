//
//  EventsDataSource.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2020-01-29.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventsDataSourceDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface EventsDataSource : NSObject <UITableViewDataSource>

@property (weak, nonatomic, nullable) id <EventsDataSourceDelegate> delegate;

/** @brief Fetches all the events a given vendor attends to. */
- (void)loadVendorEvents;

/**
 * @brief Initializes and returns a Events Data Source object using the provided parameters..
 *
 * @param identifier An NSString representing the identifier of the vendor used to fetch events.
 */
- (instancetype)initWithVendorIdentifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
