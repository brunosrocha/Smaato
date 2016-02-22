//
//  SmaatoContent.h
//  Smaato
//
//  Created by Bruno Rocha on 2/22/16.
//  Copyright © 2016 Bruno. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface SmaatoContent : NSManagedObject

@property (nonatomic, retain) NSString *country;
@property (nonatomic, retain) NSNumber *created;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *url;

@end
