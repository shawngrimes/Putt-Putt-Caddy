//
//  LocationMapViewController.m
//  Caddy
//
//  Created by shawn on 10/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LocationMapViewController.h"


@implementation LocationMapViewController
@synthesize pbResult;
@synthesize locationTextView;
@synthesize locationMapView;



 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		self.title=@"Location Details";
		self.locationTextView.editable=NO;
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	MKCoordinateSpan span;
	span.latitudeDelta=.01;
	span.longitudeDelta=.01;
	
	MKCoordinateRegion region;
	region.span=span;
	region.center=self.pbResult.coordinate;
	
	[self.locationMapView setRegion:region animated:YES];
	[self.locationMapView regionThatFits:region];
	
	[self.locationMapView addAnnotation:self.pbResult];
	
	self.locationTextView.text=[NSString stringWithFormat:@"%@\nUser Rating:%@\nPhone: %@\nAddress: %@\n%@, %@ %@",self.pbResult.title,self.pbResult.userRating,self.pbResult.phone,self.pbResult.address,self.pbResult.city,self.pbResult.state,self.pbResult.zipcode];
	
	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark dealloc
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
