#import "golfCourse.h"

@implementation golfCourse

// Custom logic goes here.
-(double) getDistanceFromLocation:(CLLocation *)currentLocation{
	CLLocation *courseLocation=[[CLLocation alloc] initWithLatitude:self.latitudeValue longitude:self.longitudeValue];
	double locationDistance=[courseLocation distanceFromLocation:currentLocation];
	NSLog(@"Location Distance: %d", locationDistance);
	
	return locationDistance;
}

static int compareDistinaceToCurrentLocation(golfCourse *sortCourse1, golfCourse *sortCourse2, CLLocation *currentLocation){
	NSComparisonResult retVal=NSOrderedSame;
	double distance1=[sortCourse1 getDistanceFromLocation:currentLocation];
	double distance2=[sortCourse2 getDistanceFromLocation:currentLocation];
	
	
	if(distance1>distance2){
		retVal=NSOrderedDescending;
	}else if(distance2>distance1){
		retVal=NSOrderedAscending;
	}
	
	return retVal;
	
	
}

@end
