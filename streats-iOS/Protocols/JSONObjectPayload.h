//
//  JSONObjectPayload.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-08-15.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#ifndef JSONObjectPayload_h
#define JSONObjectPayload_h

typedef NSDictionary<NSString *, id> JSON;

@protocol JSONObjectPayload <NSObject>

- (instancetype)initWithJSON:(JSON *)json;

@end

#endif /* JSONObjectPayload_h */
