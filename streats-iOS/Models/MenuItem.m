//
//  MenuItem.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-16.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "MenuItem.h"


@implementation MenuItem

#pragma mark - Initialization

- (instancetype)initWithIdentifier:(NSString *)identifier name:(NSString *)name price:(NSNumber *)price ingredients:(NSArray<NSString *> *)ingredients {
    self = [super init];
    if (self) {
        _identifier = identifier;
        _name = name;
        _price = price;
        _ingredients = ingredients;
    }
    return self;
}

- (instancetype)initWithJSON:(NSDictionary<NSString *,id> *)JSON
{
    NSString *identifier = [JSON objectForKey:@"id"];
    NSString *name = [JSON objectForKey:@"name"];
    NSNumber *price = [JSON objectForKey:@"price"];
    NSArray<NSString *> *ingredients = [JSON objectForKey:@"ingredients"];
    
    return [self initWithIdentifier:identifier name:name price:price  ingredients:ingredients];
}

#pragma mark - Methods

- (NSString *)priceString
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setCurrencyCode:@"CAD"];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    return [formatter stringFromNumber:self.price];
}

@end
