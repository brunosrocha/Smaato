//
//  Object.m
//  Smaato
//
//  Created by Bruno Rocha on 2/18/16.
//  Copyright © 2016 Bruno. All rights reserved.
//

#import "Object.h"
#import "NSDictionary+Safe.h"

@implementation Object


- (id)initWithDictionary:(NSDictionary *)dictionary {
    
    if (self = [super init]) {
        
        self.created = [[dictionary objectForKeyNotNull: @"created"] intValue];
        self.type = [dictionary objectForKeyNotNull: @"type"];
        self.data = [[Data alloc] initWithDictionary: [dictionary objectForKeyNotNull: @"data"]];
        self.user = [[User alloc] initWithDictionary: [dictionary objectForKeyNotNull: @"user"]];

    }
    
    return self;
    
}

- (NSString *)type {
    if (_type != nil)
        return [_type lowercaseString];
    
    return _type;
}

- (BOOL)isContentValid {
    
    return (self.created != 0 &&
            self.type != nil &&
            self.data != nil &&
            self.user != nil);
}

@end
