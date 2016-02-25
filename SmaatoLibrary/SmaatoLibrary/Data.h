//
//  Data.h
//  Smaato
//
//  Created by Bruno Rocha on 2/22/16.
//  Copyright © 2016 Bruno. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Data : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *url;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
