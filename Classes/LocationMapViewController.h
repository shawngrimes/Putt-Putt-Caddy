//
//  LocationMapViewController.h
//  Caddy
//
//  Created by shawn on 10/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "PhoneBookResult.h"

@interface LocationMapViewController : UIViewController {
	PhoneBookResult *pbResult;
	
	IBOutlet UITextView *locationTextView;
	IBOutlet MKMapView *locationMapView;
	
}

@property (nonatomic, retain) 	PhoneBookResult *pbResult;
@property (nonatomic, retain) 	IBOutlet UITextView *locationTextView;
@property (nonatomic, retain) IBOutlet MKMapView *locationMapView;


@end
