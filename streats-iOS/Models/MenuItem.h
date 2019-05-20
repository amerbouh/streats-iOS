//
//  MenuItem.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-16.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuItem : NSObject

// Properties

@property(strong, nonatomic, nonnull) NSString *name;
@property(strong, nonatomic, nonnull) NSNumber *price;
@property(strong, nonatomic, nullable) NSString *ingredients;
@property(strong, nonatomic, nonnull, readonly) NSString *priceString;

// Methods

- (instancetype _Nullable)initWithName:(NSString *_Nonnull)name price:(NSNumber *_Nonnull)price ingredients:(NSString *_Nullable)ingredients;
- (instancetype _Nullable)initWithJSON:(NSDictionary<NSString *, id> *_Nonnull)JSON;

@end
