//
//  Object.h
//  Smaato
//
//  Created by Bruno Rocha on 2/18/16.
//  Copyright © 2016 Bruno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Data.h"
#import "User.h"

@interface Object : NSObject

@property (nonatomic) NSTimeInterval created;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) Data *data;
@property (nonatomic, strong) User *user;

@end
