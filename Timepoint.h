//
//  Timepoint.h
//  MakeTimepointsDatabaseFromXML
//
//  Created by Michael Rockhold on 5/30/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Timepoint : NSObject<NSCoding>
{
	@private
	NSString*	name;
	NSPoint		location;
	NSString*	pointID;
}

@property (nonatomic, retain) NSString* name;
@property (nonatomic)		  NSPoint	location;
@property (nonatomic, retain) NSString* pointID;

- (id)initFromName:(NSString*)name PointID:(NSString*)pointID Location:(NSPoint)location;

- (NSNumber*)distanceTo:(NSPoint)otherLocation;

- (id)initWithCoder:(NSCoder*)decoder;
- (void)encodeWithCoder:(NSCoder*)coder;

@end
