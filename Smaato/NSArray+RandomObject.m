//
//  NSArray+RandomObject.m
//  Smaato
//
//  Created by Bruno Rocha on 2/18/16.
//  Copyright © 2016 Bruno. All rights reserved.
//

#import "NSArray+RandomObject.h"

@implementation NSArray (RandomObject)

- (id)randomObject {
    
    NSUInteger count = self.count;
    
    if (count > 0)
        return [self objectAtIndex: arc4random_uniform((int)count)];
    else
        return nil;
}

@end
