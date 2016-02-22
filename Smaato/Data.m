//
//  Data.m
//  Smaato
//
//  Created by Bruno Rocha on 2/22/16.
//  Copyright © 2016 Bruno. All rights reserved.
//

#import "Data.h"
#import "NSDictionary+Safe.h"

@implementation Data

- (id)initWithDictionary:(NSDictionary *)dictionary {
    
    if (self = [super init]) {
        
        self.url = [dictionary objectForKeyNotNull: @"url"];
        self.text = [dictionary objectForKeyNotNull: @"text"];
        
    }
    
    return self;
    
}

@end
