//
//  UIImageView+URLImage.h
//  Smaato
//
//  Created by Bruno Rocha on 2/22/16.
//  Copyright © 2016 Bruno. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (URLImage)

- (void)loadFromURL: (NSURL*) url response:(void (^)(UIImage *image))response;
    
@end
