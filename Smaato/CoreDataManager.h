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

/*!
 * @discussion CodateDataManager single instance
 *
 */

+ (CoreDataManager *)manager;

/*!
 * @discussion Method that stores a Object into the database
 * @param object Object
 * @return return YES if the object is successfuly saved and NO if not.
 *
 */

- (BOOL)saveObject:(Object *)object;

/*!
 * @discussion Method that stores a Object into the database
 * @param object Object
 * @param image A data representation of a image
 * @return return YES if the object is successfuly saved and NO if not.
 *
 */

- (BOOL)saveObject:(Object *)object withImage:(NSData *)image;

/*!
 * @discussion Method that deletes an existing Object from the database
 * @param NSNumber created in this case I expect the created date of the object because is the only unique value I could found.
 * @return return YES if the object is successfuly deleted and NO if not.
 *
 */

- (BOOL)deleteObject:(NSNumber *)created;

/*!
 * @discussion Method that fetchs and specific Object from the data base.
 * @param NSNumber created in this case I expect the created date of the object because is the only unique value I could found.
 * @return return an filled SmaatoContent object if it existis and nil if not.
 *
 */

- (SmaatoContent *)fetchSmaatoObject:(NSNumber *)created;

/*!
 * @discussion Method that fecths all the existing objects in the data base.
 * @return return an array of SmaatoContent objects and a empty
 *
 */

- (NSMutableArray *)fetchObjects;

@end
