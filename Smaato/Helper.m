//
//  Helper.m
//  Smaato
//
//  Created by Bruno Rocha on 2/22/16.
//  Copyright © 2016 Bruno. All rights reserved.
//

#import "Helper.h"

@implementation Helper

+ (NSString *)timeFromSeconds:(NSTimeInterval)seconds withFormat:(NSString *)format {
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate: seconds];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat: format];
    
    return [formatter stringFromDate:date];
    
}

@end
