//
//  Event.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-14.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

/** A boolean indicating whether or not an event lasts all day. */
@property(assign) BOOL lastsAllDay;

/** A string representing the title of the event. */
@property(strong, nonatomic, nonnull) NSString *title;

/** A string representing the start date of the event. */
@property(strong, nonatomic, nonnull) NSString *startDate;

/** A string representing the end date of the event. */
@property(strong, nonatomic, nonnull) NSString *endDate;

/**
* Initializes and returns an Event object using the provided parameters.
*
* @param title              A string representing the title of the event.
* @param startDate     A string representing the start date of the event.
* @param endDate      A string representing the end date of the event.
* @param lastsAllDay  A boolean indicating whether or not an event lasts all day.
*/
- (instancetype _Nullable)initWithTitle:(NSString *_Nonnull)title startDate:(NSString *_Nonnull)startDate endDate:(NSString *_Nonnull)endDate lastsAllDay:(BOOL)lastsAllDay;

/**
* Initializes and returns an Event object using the provided dictionary.
*
* @param dictionary A dictionary that represents the data of the event.
*/
- (instancetype _Nullable)initWithDictionary:(NSDictionary<NSString *, id> *_Nonnull)dictionary;

@end
