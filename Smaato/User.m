//
//  User.m
//  Smaato
//
//  Created by Bruno Rocha on 2/18/16.
//  Copyright © 2016 Bruno. All rights reserved.
//

#import "User.h"
#import "NSDictionary+Safe.h"

@implementation User

- (id)initWithDictionary:(NSDictionary *)dictionary {
    
    if (self = [super init]) {
        
        self.name = [dictionary objectForKeyNotNull: @"name"];
        self.country = [dictionary objectForKeyNotNull: @"country"];

    }
    
    return self;
    
}

@end
