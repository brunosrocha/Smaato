//
//  SMTNetwork.h
//  Smaato
//
//  Created by Bruno Rocha on 2/17/16.
//  Copyright © 2016 Bruno. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 * @brief Network methods that are required by the back-end
 */

static NSString *const GET = @"GET";
static NSString *const POST = @"POST";

/*!
 * @brief Custom block that handles the request Response. It returns an Array of objects and the request response.
 */
typedef void (^SMTSuccess)(NSArray *data, NSURLResponse *response);

/*!
 * @brief Custom block that handles a failure in the request.
 */
typedef void (^SMTFailure)(NSError *error);

@interface SMTNetwork : NSObject

/*!
 * @discussion SMTNetwork single instance
 *
 */

+ (id)instance;

/*!
 * @brief Custom initializer in case the users needs a different session configuration
 */

- (id)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration;

/*!
 * @discussion Method that makes an HTTP Request/
 * @param url a URL as string.
 * @param method The HTTP Method e.g (POST, GET)
 * @param parameters an NSDictionary with parameters if there is one.
 * @param success The SMTSuccess block.
 * @param failure THE SMTFailure block;
 * @code [[SMTNetwork instance] requestWithURL: url method: GET parameters: nil success:^(NSArray *data, NSURLResponse *response) { ....}
 *
 *
 */

- (void)requestWithURL:(NSString *)url
                method:(NSString *)method
            parameters:(NSDictionary *)parameters
               success:(SMTSuccess)success
               failure:(SMTFailure)failure;


@end
