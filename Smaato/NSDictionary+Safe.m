//
//  NSDictionary+Safe.m
//  Smaato
//
//  Created by Bruno Rocha on 2/18/16.
//  Copyright © 2016 Bruno. All rights reserved.
//

#import "NSDictionary+Safe.h"

@implementation NSDictionary (Safe)

- (id)objectForKeyNotNull:(id)key {
    
    id object = [self objectForKey:key];
    if (object == [NSNull null])
        return nil;
    
    return object;
}


@end
