#import <Foundation/Foundation.h>
#import <Foundation/NSXMLElement.h>
#import "ArchiveHelper.h"

void usage(const char* cmd)
{
	NSLog(@"invalid command line in %s", cmd);
}


void HandleXMLDocError(NSError* err)
{
	if (!err) return;
}

NSXMLDocument *createXMLDocumentFromFile(NSString* file, NSError** pErr)
{
    NSXMLDocument *xmlDoc;
    NSURL *furl = [NSURL fileURLWithPath:file];
    if (!furl)
	{
        NSLog(@"Can't create an URL from file %@.", file);
        return nil;
    }
	
    xmlDoc = [[NSXMLDocument alloc] initWithContentsOfURL:furl
												  options:(NSXMLNodePreserveWhitespace|NSXMLNodePreserveCDATA)
													error:pErr];
    if (xmlDoc == nil)
	{
        xmlDoc = [[NSXMLDocument alloc] initWithContentsOfURL:furl
													  options:NSXMLDocumentTidyXML
														error:pErr];
    }
	
    if (*pErr)
	{
		HandleXMLDocError(*pErr);
    }
	
	return xmlDoc;
}



int main (int argc, const char * argv[])
{
	int rv = 0;
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

	objc_startCollectorThread();
	
	NSError *err=nil;

	if (argc < 2)
	{
		usage(argv[0]);
		[pool drain];
		return 1;
	}

		//ArchiveHelper* archiveHelper = [[ArchiveHelper alloc] init];
	
	NSString* fileName = [[NSString alloc] initWithCString:argv[1]
												  encoding:NSMacOSRomanStringEncoding];
	NSXMLDocument* doc = createXMLDocumentFromFile(fileName, &err);
	if (!doc)
	{
		[pool drain];
		return 2;
	}
	
	NSArray *placemarks = [doc nodesForXPath:@".//Placemark" error:&err];
	if (err != nil)
	{
		HandleXMLDocError(err);
		[pool drain];
		return 3;
	}
	
	for (NSXMLElement* aPlacemark in placemarks)
	{		
		NSError* nameError = nil;
		NSError* coordsError = nil;
		NSError* descrsError = nil;
		
		NSArray *names = [aPlacemark nodesForXPath:@"./name" error:&nameError];
		NSArray *coords = [aPlacemark nodesForXPath:@"./Point/coordinates" error:&coordsError];
		NSArray *descrs = [aPlacemark nodesForXPath:@"./description" error:&descrsError];
		
		if (!nameError && [names count] > 0 && !coordsError && [coords count] > 0 && !descrsError && [descrs count] > 0)
		{			
			NSArray* tuple = [[[coords objectAtIndex:0] stringValue] componentsSeparatedByString:@","];
			
			NSScanner* descrsScanner = [NSScanner scannerWithString:[[descrs objectAtIndex:0] stringValue]];
			NSString* pointID = nil;
			[descrsScanner scanUpToString:@"/avl.jsp?id=" intoString:NULL];
			[descrsScanner scanString:@"/avl.jsp?id=" intoString:NULL];
			[descrsScanner scanUpToString:@"\"" intoString:&pointID];
			
			NSString* name = [[[names objectAtIndex:0] stringValue] capitalizedString];
			
			printf("%s|%lf|%lf|%s\n", [pointID cStringUsingEncoding:NSUTF8StringEncoding],
				   [[tuple objectAtIndex:1] doubleValue],
				   [[tuple objectAtIndex:0] doubleValue],
				   [name cStringUsingEncoding:NSUTF8StringEncoding]);
				//[archiveHelper AddTimepointWithName:[[names objectAtIndex:0] stringValue] Location:NSMakePoint([[tuple objectAtIndex:0] floatValue],[[tuple objectAtIndex:1] floatValue]) PointID:pointID];
		}
	}
			
		//[archiveHelper save];
	
    [pool drain];
    return rv;
}
