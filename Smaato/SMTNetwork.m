
//
//  SMTNetwork.m
//  Smaato
//
//  Created by Bruno Rocha on 2/17/16.
//  Copyright © 2016 Bruno. All rights reserved.
//

#import "SMTNetwork.h"
#import <Foundation/Foundation.h>

@interface SMTNetwork ()

@property (strong) NSURLSession *session;

@end

@implementation SMTNetwork

+ (id)instance {
    
    static SMTNetwork *sharedMyManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] initWithSessionConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    return sharedMyManager;
}

- (id)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration {
    
    if (self = [super init]) {
        
        self.session = [NSURLSession sessionWithConfiguration: configuration];
    }
    
    return self;
}

- (void)requestWithURL:(NSString *)url
                method:(NSString *)method
            parameters:(NSDictionary *)parameters
               success:(SMTSuccess)success
               failure:(SMTFailure)failure {
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString: url]];
    [request setHTTPMethod: method];
    
    if ([method isEqualToString: GET]) {
 
        NSURLSessionDataTask *mTask = [self.session dataTaskWithRequest: request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            [self validateResponse: data response: response error: error success: success failure: failure];
        }];
        
        [mTask resume];


    } else {
        
        NSData *data = [NSJSONSerialization dataWithJSONObject: parameters
                                                       options: kNilOptions error: nil];
        
        [self.session uploadTaskWithRequest: request fromData: data completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            [self validateResponse: data response: response error: error success: success failure: failure];

        }];
    }
}

- (void)validateResponse:(NSData *)data response:(NSURLResponse *)response error:(NSError *)error success:(SMTSuccess)success failure:(SMTFailure)failure {
    
    if (error)
        failure(error);
    else {
        NSError *parseError;

        
        NSArray* json = [NSJSONSerialization
                              JSONObjectWithData:data
                              options:NSJSONReadingMutableContainers
                              error: &parseError];
        
        parseError ? failure(parseError) : success(json, response);
    }
}


@end