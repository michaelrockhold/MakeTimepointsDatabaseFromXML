//
//  Timepoint.m
//  MakeTimepointsDatabaseFromXML
//
//  Created by Michael Rockhold on 5/30/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Timepoint.h"


@implementation Timepoint

@synthesize name;
@synthesize pointID;
@synthesize location;


- (id)initFromName:(NSString*)_name PointID:(NSString*)_pointID Location:(NSPoint)_location
{
	id this = [super init];
	if (this != nil)
	{
		self.name = _name;
		self.pointID = _pointID;
		self.location = _location;
	}
	return this;
}


- (id)initWithCoder:(NSCoder*)coder
{
	self.name = [coder decodeObjectForKey:@"name"];
	self.pointID = [coder decodeObjectForKey:@"pointID"];
	self.location = NSMakePoint([coder decodeFloatForKey:@"longitude"], [coder decodeFloatForKey:@"latitude"]);
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:name forKey:@"name"];
    [coder encodeObject:pointID forKey:@"pointID"];
    [coder encodeFloat:location.x forKey:@"longitude"];
    [coder encodeFloat:location.y forKey:@"latitude"];
}

- (NSNumber*)distanceTo:(NSPoint)otherLocation
{
	return [NSNumber numberWithFloat:255.0];
}

@end

