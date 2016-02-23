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

/*!
 * @brief attribute which hold the seconds since the object has been created
 */

@property (nonatomic) NSTimeInterval created;

/*!
 * @brief attribute which hold the type of the content e.g("img", "url")
 */

@property (nonatomic, strong) NSString *type;

/*!
 * @brief Custom Data Object which holds the url and image attributes
 */

@property (nonatomic, strong) Data *data;

/*!
 * @brief Custom User Object which holds the name and url attributes
 */

@property (nonatomic, strong) User *user;

/*!
 * @brief Custom initializer. Expects a JSON dictionary as a parameter
 */

- (id)initWithDictionary:(NSDictionary *)dictionary;

/*!
 * @brief in order to display a valid content to the user we need to check if we have all the necessary information. if this method returns NO it means we have some invalid or missing data
 */

- (BOOL)isContentValid;

@end
