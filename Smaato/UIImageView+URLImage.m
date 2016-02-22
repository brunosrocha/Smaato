//
//  UIImageView+URLImage.m
//  Smaato
//
//  Created by Bruno Rocha on 2/22/16.
//  Copyright © 2016 Bruno. All rights reserved.
//

#import "UIImageView+URLImage.h"

@implementation UIImageView (URLImage)


- (void)loadFromURL: (NSURL*) url response:(void (^)(UIImage *image))response {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    
    dispatch_async(queue, ^{
        NSData * imageData = [NSData dataWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:imageData];
            response(image);
        });
    });
}


@end
