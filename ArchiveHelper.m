//
//  ArchiveHelper.m
//
//  Created by Michael Rockhold on 5/30/09.
//  Copyright __MyCompanyName__ 2009 . All rights reserved.
//

#import "ArchiveHelper.h"
#import "Timepoint.h"
#import <Foundation/Foundation.h>

@implementation ArchiveHelper

- (id)init
{
	id this = [super init];
	if ( this != nil )
	{
		m_timepoints = [[NSMutableArray array] retain];
	}
	return this;
}

- (void)dealloc
{
	[m_timepoints release];
	[super dealloc];
}

- (void)AddTimepointWithName:(NSString*)name Location:(NSPoint)location PointID:(NSString*)pointID
{
	NSLog(@"     name       : %@", name);
	NSLog(@"     coords     : %f, %f", location.x, location.y);
	NSLog(@"     ID         : %d", pointID);
	
	[m_timepoints addObject:[[Timepoint alloc] initFromName:name PointID:pointID Location:location]];
	
}

- (void)save
{
	if ( NO == [NSKeyedArchiver archiveRootObject:m_timepoints toFile:@"timepoints.dat"] )
	{
		NSLog(@"Unable to save timepoints.dat");
	}
}

@end
