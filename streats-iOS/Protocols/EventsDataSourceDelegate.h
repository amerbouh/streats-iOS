//
//  EventsDataSourceDelegate.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2020-01-29.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Event;
@class EventsDataSource;

@protocol EventsDataSourceDelegate <NSObject>

- (void)eventsDataSource:(EventsDataSource * _Nonnull)eventsDataSource onFetchFailedWithErrorMessage:(NSString *)message;
- (void)eventsDataSource:(EventsDataSource * _Nonnull)eventsDataSource onEventsFetched:(NSArray<Event *> * _Nonnull)fetchedEvents;

@end

NS_ASSUME_NONNULL_END
