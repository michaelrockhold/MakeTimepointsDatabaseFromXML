//
//  DataModelHelper.m
//
//  Created by Michael Rockhold on 5/30/09.
//  Copyright __MyCompanyName__ 2009 . All rights reserved.
//

#import "DataModelHelper.h"
#import "Timepoint.h"
#import <Foundation/Foundation.h>

@implementation DataModelHelper

/**
    Returns the support folder for the application, used to store the Core Data
    store file.  This code uses a folder named "MakeTimepointsDatabaseFromXML" for
    the content, either in the NSApplicationSupportDirectory location or (if the
    former cannot be found), the system's temporary directory.
 */

- (NSString *)applicationSupportFolder
{
#if 0
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : NSTemporaryDirectory();
    return [basePath stringByAppendingPathComponent:@"MakeTimepointsDatabaseFromXML"];
#else
	return @".";
#endif
}


/**
    Creates, retains, and returns the managed object model for the application 
    by merging all of the models found in the application bundle.
 */
 
- (NSManagedObjectModel *)managedObjectModel
{
    if (managedObjectModel != nil)
	{
        return managedObjectModel;
    }
	
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    return managedObjectModel;
}


/**
    Returns the persistent store coordinator for the application.  This 
    implementation will create and return a coordinator, having added the 
    store for the application to it.  (The folder for the store is created, 
    if necessary.)
 */

- (NSPersistentStoreCoordinator *) persistentStoreCoordinator
{
    if (persistentStoreCoordinator != nil)
	{
        return persistentStoreCoordinator;
    }

    NSFileManager *fileManager;
    NSString *applicationSupportFolder = nil;
    NSURL *url;
    NSError *error;
    
    fileManager = [NSFileManager defaultManager];
    applicationSupportFolder = [self applicationSupportFolder];
    if ( ![fileManager fileExistsAtPath:applicationSupportFolder isDirectory:NULL] )
	{
        [fileManager createDirectoryAtPath:applicationSupportFolder attributes:nil];
    }
    
    url = [NSURL fileURLWithPath: [applicationSupportFolder stringByAppendingPathComponent: @"KCMetroTimepoints.xml"]];
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSXMLStoreType configuration:nil URL:url options:nil error:&error])
	{
		NSLog(@"Error creating persistent store coordinator %@", [error description]);
    }    

    return persistentStoreCoordinator;
}


/**
    Returns the managed object context for the application (which is already
    bound to the persistent store coordinator for the application.) 
 */
 
- (NSManagedObjectContext *) managedObjectContext
{
    if (managedObjectContext != nil)
	{
        return managedObjectContext;
    }

    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) 
	{
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    
    return managedObjectContext;
}


- (void)AddTimepointWithName:(NSString*)name Longitude:(double)longitude Latitude:(double)latitude PointID:(int)pointID
{
	NSLog(@"     name       : %@", name);
	NSLog(@"     coords     : %f, %f", longitude, latitude);
	NSLog(@"     ID         : %d", pointID);
	
	NSEntityDescription *tpEntity = [[[self managedObjectModel] entitiesByName] objectForKey:@"Timepoint"];
    Timepoint *tp = [[Timepoint alloc] initWithEntity:tpEntity insertIntoManagedObjectContext:[self managedObjectContext]];
	
    tp.name = name;
	tp.pointID = [NSNumber numberWithInt:pointID];
	tp.longitude = [NSNumber numberWithDouble:longitude];
	tp.latitude = [NSNumber numberWithDouble:latitude];	
}



/**
    Implementation of dealloc, to release the retained variables.
 */
 
- (void) dealloc
{
    [managedObjectContext release], managedObjectContext = nil;
    [persistentStoreCoordinator release], persistentStoreCoordinator = nil;
    [managedObjectModel release], managedObjectModel = nil;
    [super dealloc];
}


@end
