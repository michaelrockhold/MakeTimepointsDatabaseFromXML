//
//  ArchiveHelper.h
//  DummyCoreDataApplication
//
//  Created by Michael Rockhold on 5/30/09.
//  Copyright __MyCompanyName__ 2009 . All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ArchiveHelper : NSObject 
{
	NSMutableArray* m_timepoints;    
}

- (void)AddTimepointWithName:(NSString*)name Location:(NSPoint)locaton PointID:(NSString*)pointID;
- (void)save;

@end
