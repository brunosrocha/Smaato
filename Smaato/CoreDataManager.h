//
//  CoreDataManager.h
//  Smaato
//
//  Created by Bruno Rocha on 2/22/16.
//  Copyright © 2016 Bruno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Object.h"
#import "SmaatoContent.h"

@interface CoreDataManager : NSObject

+ (CoreDataManager *)manager;

- (BOOL)saveObject:(Object *)object;
- (BOOL)saveObject:(Object *)object withImage:(NSData *)image;
- (BOOL)deleteObject:(NSNumber *)created;
- (SmaatoContent *)fetchSmaatoContent:(NSNumber *)created;
- (NSMutableArray *)fetchObjects;

@end
