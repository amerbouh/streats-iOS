//
//  WebClientController.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-10-12.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ServiceError;

@interface WebClientController : NSObject

/** The base used to perform requests to the Web Client. */
@property (strong, nonatomic, nonnull) NSString * baseURL;

/**
 * @brief Loads the content of the given path.
 * @param path The path of the resource to load.
 * @param params The params to use when requesting the resource.
 * @param completionHandler The block which is invoked when the request finishes.
 */
- (void)loadResourceForPath:(NSString * _Nonnull)path withParams:(NSDictionary<NSString *, id> * _Nullable)params completionHandler:(void (^_Nullable)(id _Nullable result, ServiceError * _Nullable serviceError))completionHandler;

/**
* Initializes and returns a Web Controller object using the provided parameters..
*
* @param baseURL A string that represents the host to which the requests will be sent.
*/
- (instancetype)initWithBaseURL:(NSString *)baseURL;

@end

NS_ASSUME_NONNULL_END
