//
//  CoreDataManager.m
//  Smaato
//
//  Created by Bruno Rocha on 2/22/16.
//  Copyright © 2016 Bruno. All rights reserved.
//

#import "CoreDataManager.h"
#import <CoreData/CoreData.h>
#import "SmaatoContent.h"

@interface CoreDataManager ()

@property (strong) NSManagedObjectContext *managedObjectContext;
@property (strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation CoreDataManager

+ (CoreDataManager *)manager {
    
    static CoreDataManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
    
}

- (id)init {
    
    if (self = [super init]) {
        
        NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        NSURL *storeUrl = [NSURL fileURLWithPath:[docs stringByAppendingPathComponent: @"Smaato.sqlite"]];
        
        self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[NSManagedObjectModel mergedModelFromBundles:nil]];
        
        [_persistentStoreCoordinator addPersistentStoreWithType: NSSQLiteStoreType configuration:nil URL: storeUrl options: nil error: nil];
        
        self.managedObjectContext = [[NSManagedObjectContext alloc] init];
        
        [self.managedObjectContext setPersistentStoreCoordinator: _persistentStoreCoordinator];
        
        
    }
    
    return self;
}

- (BOOL)saveObject:(Object *)object withImage:(NSData *)image {
    
    SmaatoContent *content = [NSEntityDescription
                              insertNewObjectForEntityForName: @"SmaatoContent"
                              inManagedObjectContext: _managedObjectContext];
    
    content.country = object.user.country;
    content.created = @(object.created);
    content.name = object.user.name;
    content.text = object.data.text;
    content.type = object.type;
    content.url = object.data.url;
    
    if (image)
        content.image = image;
    
    NSError *error;
    if (![_managedObjectContext save: &error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        return NO;
    }
    
    return YES;
}

- (BOOL)saveObject:(Object *)object {
    
    return [self saveObject: object withImage: nil];
}

- (BOOL)deleteObject:(NSNumber *)created {
    
    SmaatoContent *content = [self fetchSmaatoObject:created];
    
    [_managedObjectContext deleteObject: content];
    
    NSError *error;
    if (![_managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        return NO;
    }
    
    return YES;
    
}

- (SmaatoContent *)fetchSmaatoObject:(NSNumber *)created {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName: @"SmaatoContent"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"created = %@", created];
    fetchRequest.predicate = predicate;
    
    NSArray *fetchedObjects = [_managedObjectContext executeFetchRequest: fetchRequest error: nil];
    
    if (fetchedObjects.count)
        return [fetchedObjects firstObject];
    
    return nil;
    
}

- (NSMutableArray *)fetchObjects {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName: @"SmaatoContent"
                                              inManagedObjectContext: _managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSMutableArray *fetchedObjects = [NSMutableArray arrayWithArray: [_managedObjectContext executeFetchRequest: fetchRequest error: nil]];

    return fetchedObjects;
}

@end
