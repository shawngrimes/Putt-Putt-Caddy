#import <MapKit/MapKit.h>
#import "_golfCourse.h"

@interface golfCourse : _golfCourse {}
// Custom logic goes here.

-(double) getDistanceFromLocation:(CLLocation *)currentLocation;
-(NSComparisonResult) compareDistinaceToCurrentLocation:(golfCourse *) sortCourse1;

@end
