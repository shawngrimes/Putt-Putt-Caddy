//
//  LocationTableViewController.h
//  Putt Putt Caddy
//
//  Created by shawn on 10/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

#import "PullToRefreshTableViewController.h"
#import "LocationDetailsViewControler.h"

#import "PhoneBookResult.h"
#import "TBXML.h"
#import "NSString+HTML.h"

@interface LocationTableViewController : PullToRefreshTableViewController <UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, MKReverseGeocoderDelegate, UISearchBarDelegate> {

	/*
	NSManagedObjectContext *managedObjectContext;
	NSManagedObjectModel *managedObjectModel;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
	
	NSMutableArray *tableArray;
	
	IBOutlet UISearchBar *locationSearchBar;
	IBOutlet UITableView *locationsTableView;
	
	CLLocationManager *locationManager;
	CLLocation *currentLocation;
	NSString *locationString;

	IBOutlet UINavigationController *navController;
	*/
}

/*

@property (nonatomic, retain) 	IBOutlet UINavigationController *navController;

@property (nonatomic, retain) 	NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) NSMutableArray *tableArray;

@property (nonatomic, retain) 	IBOutlet UISearchBar *locationSearchBar;
@property (nonatomic, retain) 	IBOutlet UITableView *locationsTableView;

@property (nonatomic, retain) 	CLLocationManager *locationManager;
@property (nonatomic, retain) 	CLLocation *currentLocation;
@property (nonatomic, retain) 	NSString *locationString;

- (NSString *)applicationDocumentsDirectory;
-(void) fetchCourses;
- (void) reloadTableViewDataSource;
*/
@end
