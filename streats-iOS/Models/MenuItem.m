//
//  MenuItem.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-16.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "MenuItem.h"

@interface MenuItem ()

+ (NSString *)formatCurrencyFromPrice:(NSNumber *)price;

@end

@implementation MenuItem

- (instancetype)initWithName:(NSString *)name price:(NSNumber *)price ingredients:(NSString *)ingredients {
    if ((self = [super init])) {
        _name = name;
        _price = price;
        _ingredients = ingredients;
        _priceString = [MenuItem formatCurrencyFromPrice:price];
    }
    
    return self;
}

- (instancetype)initWithJSON:(NSDictionary<NSString *,id> *)JSON {
    NSString *name = [JSON objectForKey:@"name"];
    NSNumber *price = [JSON objectForKey:@"price"];
    NSString *ingredients = [JSON objectForKey:@"ingredients"];
    
    return [self initWithName:name price:price  ingredients:ingredients];
}

+ (NSString *)formatCurrencyFromPrice:(NSNumber *)price {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    
    return [numberFormatter stringFromNumber:price];
}


@end
