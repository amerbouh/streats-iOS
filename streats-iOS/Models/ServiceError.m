//
//  ServiceError.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-10-12.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "ServiceError.h"

@implementation ServiceError

#pragma mark - Initialization

- (instancetype)initWithTitle:(NSString *)title status:(NSString *)status detail:(NSString *)detail
{
    self = [super init];
    if (self) {
        _title = title;
        _status = status;
        _detail = detail;
    }
    return self;
}

- (instancetype)initWithError:(NSError *)error
{
    self = [super init];
    if (self) {
        _title = error.localizedDescription;
        _status = [NSString stringWithFormat: @"%ld", (long)error.code];
        _detail = error.localizedFailureReason;
    }
    return self;
}

- (instancetype)initClientErrorWithMessage:(NSString *)message
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithJSON:(JSON *)json
{
    NSString *title = json[@"title"];
    NSString *status = json[@"status"];
    NSString *detail = json[@"detail"];
    
    return [self initWithTitle:title status:status detail:detail];
}

@end
