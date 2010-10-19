//
//  PhoneBookResult.m
//  Caddy
//
//  Created by shawn on 10/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PhoneBookResult.h"


@implementation PhoneBookResult

@synthesize title;
@synthesize url;
@synthesize address;
@synthesize city;
@synthesize state;
@synthesize zipcode;
@synthesize location;
@synthesize uniqueID;
@synthesize coordinate;
@synthesize phone;
@synthesize userRating;

-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
	coordinate=c;
	NSLog(@"%f,%f",c.latitude,c.longitude);
	return self;
}

-(void) setCoordinate:(CLLocationCoordinate2D)newCoordinate{
	self.coordinate=newCoordinate;
}

- (NSString *)subtitle{
	return address;
}

- (NSString *)title{
	return title;
}

@end
