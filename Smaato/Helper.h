//
//  Helper.h
//  Smaato
//
//  Created by Bruno Rocha on 2/22/16.
//  Copyright © 2016 Bruno. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helper : NSObject

+ (NSString *)timeFromSeconds:(NSTimeInterval)seconds
                   withFormat:(NSString *)format;

@end
