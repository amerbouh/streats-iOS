//
//  MenuItem.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-16.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuItem : NSObject

/** A string representing the name of the menu item. */
@property (strong, nonatomic, nonnull) NSString * name;

/** A string representing the price of the menu item. */
@property (strong, nonatomic, nonnull) NSNumber * price;

/** A string representing the unique identifier of the menu item. */
@property (strong, nonatomic, nonnull) NSString * identifier;

/** A array of strings representing the ingredients present in the menu item. */
@property (strong, nonatomic, nullable) NSArray<NSString *> * ingredients;

/**
 Initializes and returns a MenuItem object using the provided parameters.
 
 @param name A string that represents the name of the menu item.
 @param price A string that represents the price of the menu item.
 @param identifier A string that represents the unique identifier of the menu item.
 @param ingredients An array of strings that represents the ingredients present in the menu item.
*/
- (instancetype _Nullable)initWithIdentifier:(NSString * _Nonnull)identifier name:(NSString *_Nonnull)name price:(NSNumber * _Nonnull)price ingredients:(NSArray<NSString *> * _Nullable)ingredients;

/**
 Initializes and returns a Vendor object using the provided dictionary.
 
 @param JSON A dictionary that represents the data of the event.
*/
- (instancetype _Nullable)initWithJSON:(NSDictionary<NSString *, id> * _Nonnull)JSON;

/** Returns the price of the menu item in the canadian's currency format.  */
- (NSString * _Nonnull)priceString;


@end
