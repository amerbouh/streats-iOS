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

@property(strong, nonatomic, nonnull) NSString *identifier;
@property(strong, nonatomic, nonnull) NSString *name;
@property(strong, nonatomic, nonnull) NSNumber *price;
@property(strong, nonatomic, nullable) NSArray<NSString *> *ingredients;

// Methods

- (instancetype _Nullable)initWithIdentifier:(NSString *_Nonnull)identifier name:(NSString *_Nonnull)name price:(NSNumber *_Nonnull)price ingredients:(NSArray<NSString *> *_Nullable)ingredients;
- (instancetype _Nullable)initWithJSON:(NSDictionary<NSString *, id> *_Nonnull)JSON;
-(NSString * _Nonnull)priceString;

@end
