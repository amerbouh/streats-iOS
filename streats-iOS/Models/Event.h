//
//  Event.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-14.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

// Properties

@property(assign) BOOL lastsAllDay;
@property(strong, nonatomic, nonnull) NSString* title;
@property(strong, nonatomic, nonnull) NSString* startDate;
@property(strong, nonatomic, nonnull) NSString* endDate;

// Methods

- (instancetype _Nullable)initWithTitle:(NSString *_Nonnull)title startDate:(NSString *_Nonnull)startDate endDate:(NSString *_Nonnull)endDate lastsAllDay:(BOOL)lastsAllDay;
- (instancetype _Nullable)initWithDictionary:(NSDictionary<NSString *, id> *_Nonnull)dictionary;

@end
