//
//  NSDictionary+Safe.h
//  Smaato
//
//  Created by Bruno Rocha on 2/18/16.
//  Copyright © 2016 Bruno. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Safe)

- (id)objectForKeyNotNull:(id)key;


@end
