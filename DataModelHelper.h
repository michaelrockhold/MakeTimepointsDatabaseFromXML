//
//  DummyCoreDataApplication_AppDelegate.h
//  DummyCoreDataApplication
//
//  Created by Michael Rockhold on 5/30/09.
//  Copyright __MyCompanyName__ 2009 . All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DataModelHelper : NSObject 
{
    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
- (NSManagedObjectModel *)managedObjectModel;
- (NSManagedObjectContext *)managedObjectContext;

- (void)AddTimepointWithName:(NSString*)name Longitude:(double)longitude Latitude:(double)latitude PointID:(int)pointID;


@end
