//
//  LocationsViewController.h
//  Putt Putt Caddy
//
//  Created by shawn on 10/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationTableViewController.h"

@interface LocationsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, MKReverseGeocoderDelegate, UISearchBarDelegate> {

	IBOutlet LocationTableViewController *locationsTableVC;
	
	
	NSManagedObjectContext *managedObjectContext;
	NSManagedObjectModel *managedObjectModel;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
	
	NSMutableArray *tableArray;
	
	IBOutlet UISearchBar *locationSearchBar;
	IBOutlet UITableView *locationsTableView;
	
	CLLocationManager *locationManager;
	CLLocation *currentLocation;
	NSString *locationString;
	
	
	EGORefreshTableHeaderView *refreshHeaderView;
	
	BOOL checkForRefresh;
	BOOL reloading;
	
	SoundEffect *psst1Sound;
	SoundEffect *psst2Sound;
	SoundEffect *popSound;
	
	
	
}

@property (nonatomic, retain) 	IBOutlet LocationTableViewController *locationsTableVC;

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

- (void)dataSourceDidFinishLoadingNewData;
- (void) showReloadAnimationAnimated:(BOOL)animated;

- (NSString *)applicationDocumentsDirectory;
-(void) fetchCourses;
- (void) reloadTableViewDataSource;

@end
