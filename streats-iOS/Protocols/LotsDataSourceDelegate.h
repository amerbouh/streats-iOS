//
//  LotsDataSourceDelegate.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-10-12.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#ifndef LotsDataSourceDelegate_h
#define LotsDataSourceDelegate_h

@class ServiceError;

@protocol LotsDataSourceDelegate <NSObject>

- (void)onFetchFailedWithServiceError:(ServiceError *)serviceError;
- (void)onFetchCompleted;

@end

#endif /* LotsDataSourceDelegate_h */
