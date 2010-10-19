//
//  PhoneBookResult.h
//  Caddy
//
//  Created by shawn on 10/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface PhoneBookResult : NSObject <MKAnnotation> {
	NSString *title;
	NSURL *url;
	NSString *address;
	NSString *city;
	NSString *state;
	NSString *zipcode;
	CLLocation *location;
	NSString *uniqueID;
	CLLocationCoordinate2D coordinate;
	NSString *phone;
	NSString *userRating;
	
}
@property (nonatomic, retain) 	NSString *phone;
@property (nonatomic, retain) NSString *userRating;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) 	NSURL *url;
@property (nonatomic, retain) 	NSString *address;
@property (nonatomic, retain) 	NSString *city;
@property (nonatomic, retain) 	NSString *state;
@property (nonatomic, retain) 	NSString *zipcode;
@property (nonatomic, retain) 	CLLocation *location;
@property (nonatomic, retain) 	NSString *uniqueID;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

-(id)initWithCoordinate:(CLLocationCoordinate2D) c;
-(void) setCoordinate:(CLLocationCoordinate2D)newCoordinate;


@end
