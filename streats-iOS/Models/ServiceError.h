//
//  ServiceError.h
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-10-12.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONObjectPayload.h"

NS_ASSUME_NONNULL_BEGIN

@interface ServiceError : NSObject <JSONObjectPayload>

/** A string describing a short, human-readable summary of the problem. */
@property (strong, nonatomic, nonnull) NSString *title;

/** A string representing the HTTP status code applicable to this problem. */
@property (strong, nonatomic, nonnull) NSString *status;

/** A string representing a human-readable explanation specific to this occurrence of the problem. */
@property (strong, nonatomic, nonnull) NSString *detail;

/**
 Initializes and returns a Service Error object using the provided parameters.
 
 @param title A string describing a short, human-readable summary of the problem.
 @param status A string representing the HTTP status code applicable to this problem.
 @param detail A string representing a human-readable explanation specific to this occurrence of the problem.
 */
- (instancetype)initWithTitle:(NSString *)title status:(NSString *)status detail:(NSString *)detail;

/**
 Initializes and returns a Service Error object using the provided NSError object.

 @param error An NSError object instance describing an error condition.
*/
- (instancetype)initWithError:(NSError *)error;

/**
 Initializes and returns a Service Error object using the provided message.

 @param message A string describing an error.
*/
- (instancetype)initClientErrorWithMessage:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
