//
//  WebClientController.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-10-12.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "WebClientController.h"
#import "ServiceError.h"

@implementation WebClientController

#pragma mark - Initialization

- (instancetype)initWithBaseURL:(NSString *)baseURL
{
    self = [super init];
    if (self) {
        _baseURL = baseURL;
    }
    return self;
}

#pragma mark - Methods

- (void)loadResourceForPath:(NSString *)path withParams:(NSDictionary<NSString *, id> *)params completionHandler:(void (^)(id _Nullable, ServiceError * _Nullable))completionHandler
{
    NSString * requestUrlString = [NSString stringWithFormat:@"%@/%@", self.baseURL, path];
    NSURL * requestURL = [NSURL URLWithString:requestUrlString];
    
    // Make sure that the URL of the request is valid.
    if (requestURL == NULL) {
        return;
    }

    // Create the NSMutableArray used to store NSURLQueryItem instances.
    NSMutableArray<NSURLQueryItem *> * queryItems = [NSMutableArray new];
    
    // Loop through each parameter in the parameters dictionnary and add
    // it to the NSURLQueryItem array.
    for (NSString * key in params.allKeys) {
        NSString * value = params[key];
        NSURLQueryItem * queryItem = [[NSURLQueryItem alloc] initWithName:key value:value];
        
        // Add the NSURLQueryItem object to the NSURLQueryItem array.
        [queryItems addObject:queryItem];
    }
    
    // Add the NSURLQueryItem to the NSURLComponents objects.
    NSURLComponents * components = [NSURLComponents componentsWithURL:requestURL resolvingAgainstBaseURL:NO];
    components.queryItems = [queryItems copy];
    
    // Create the request.
    NSURLSessionDataTask * task = [NSURLSession.sharedSession dataTaskWithURL:components.URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != NULL) {
            ServiceError *serviceError = [[ServiceError alloc] initWithError:error];
            completionHandler(NULL, serviceError);
        } else {
            NSError * serializationError;
            NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *) response;
            
            // Parse the response's data.
            id receivedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&serializationError];
            
            // Verify the parsing was successful.
            if (serializationError != NULL ) {
                ServiceError * serviceError = [[ServiceError alloc] initWithError:serializationError];
                
                // Call the completion handler and pass the Service Error instance.
                completionHandler(NULL, serviceError);
                
                return;
            }
            
            // Verify if the server could successfully process the request.
            if (httpResponse.statusCode >= 200 && httpResponse.statusCode < 300) {
                completionHandler(receivedObject, NULL);
            } else {
                NSDictionary<NSString *, NSString *> *errorDict = (NSDictionary<NSString *, NSString *> *) receivedObject;
                
                // Get an instance of the Service Error object.
                ServiceError *serviceError = [[ServiceError alloc] initWithJSON:errorDict];
                
                // Call the completion hanlder and pass the Service Error instance.
                completionHandler(NULL, serviceError);
            }
        }
    }];
    
    // Send the request.
    [task resume];
}

@end
