//
//  SMTNetwork.h
//  Smaato
//
//  Created by Bruno Rocha on 2/17/16.
//  Copyright © 2016 Bruno. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const GET = @"GET";
static NSString *const POST = @"POST";

/*!
 * @brief Block that handles success
 */
typedef void (^SMTSuccess)(NSArray *data, NSURLResponse *response);

/*!
 * @brief Block that handles success
 */
typedef void (^SMTFailure)(NSError *error);

@interface SMTNetwork : NSObject

+ (id)instance;

- (id)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration;

- (void)requestWithURL:(NSString *)url
                method:(NSString *)method
            parameters:(NSDictionary *)parameters
               success:(SMTSuccess)success
               failure:(SMTFailure)failure;


@end
