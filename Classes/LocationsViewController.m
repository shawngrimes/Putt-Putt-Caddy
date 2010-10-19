//
//  LocationsViewController.m
//  Putt Putt Caddy
//
//  Created by shawn on 10/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LocationsViewController.h"


@implementation LocationsViewController

@synthesize locationsTableVC;
@synthesize managedObjectContext;
@synthesize tableArray;

@synthesize locationSearchBar;
@synthesize locationsTableView;

@synthesize locationManager;
@synthesize currentLocation;
@synthesize locationString;

@synthesize navController;

BOOL hasLocation=NO;

#define SEGBingAPIKey		@"FB57CEB0888FD778DCC6A1DDCC22CE79F3458454"



 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		self.title=@"Locations";
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[[self locationManager] startUpdatingLocation]; 
	self.title=@"Locations";

}

-(void)viewDidAppear:(BOOL)animated{
	[self.navigationController setNavigationBarHidden:YES animated:YES];	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark CoreData
/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext {
    
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
    
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    //managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
	NSString *path = [[NSBundle mainBundle] pathForResource:@"Caddy" ofType:@"momd"];
    NSURL *momURL = [NSURL fileURLWithPath:path];
    managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:momURL];
	
    return managedObjectModel;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
    
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"Caddy.sqlite"]];
    
    NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
	
	
	NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error]) {
        NSLog(@"Unable to create persistent Store Coordinator: %@", [error localizedDescription]);
		// Handle the error.
    }    
	
    
    return persistentStoreCoordinator;
}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark UISearchBar
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
	[searchBar resignFirstResponder];
	[self reloadTableViewDataSource];
	
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
	[searchBar resignFirstResponder];
	searchBar.text=@"";
	[self reloadTableViewDataSource];
	
	
}

#pragma mark Table view data source

- (void) reloadTableViewDataSource{
	NSLog(@"Running fetchCourses");
	[self fetchCourses];
	NSLog(@"Reloading data with array count: %i", [self.tableArray count]);
	//self.locationsTableView.delegate=self;
	[self.locationsTableVC.tableView reloadData];
	[self.locationsTableVC dataSourceDidFinishLoadingNewData];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
	if(indexPath.row<[self.tableArray count]){
		LocationDetailsViewControler *locDetailsVC=[[LocationDetailsViewControler alloc] init];
		NSLog(@"Self MOC: %@", self.managedObjectContext);
		locDetailsVC.managedObjectContext=self.managedObjectContext;
		locDetailsVC.pbResult=[self.tableArray objectAtIndex:indexPath.row];
		
		//UINavigationController *navController=[[UINavigationController alloc] init];
		//self.navigationController;
		NSLog(@"Nav : %@", [self navigationController]);
//		[self presentModalViewController:locDetailsVC animated:YES];
		locDetailsVC.hidesBottomBarWhenPushed=YES;
		[[self navigationController] pushViewController:locDetailsVC animated:YES];

//		self.tabBarController.tabbar.hidden=YES;
		[locDetailsVC release];
		NSLog(@"Showing location");
	}else{
		NSLog(@"Adding course...");
	}
	
	
	
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section{
	NSLog(@"Found %i rows in Section", [self.tableArray count]);
	return ([self.tableArray count]+1);
	//return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	NSLog(@"cellForRowAtIndexPath");
	static NSString *cellIdentifier=@"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if(cell==nil){
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier] autorelease];
	}
	
	//golfCourse *course=[self.courseList objectAtIndex:indexPath.row];
	if(indexPath.row<[self.tableArray count]){
		PhoneBookResult *pbResult=[self.tableArray objectAtIndex:indexPath.row];
		
		NSLog(@"Index: %i Name: %@", indexPath.row, pbResult.title);
		cell.textLabel.text=pbResult.title;
		cell.detailTextLabel.text=[NSString stringWithFormat:@"%i meters away",(int)[pbResult.location distanceFromLocation:self.currentLocation]];
	}else{
		cell.textLabel.text=@"Add new course...";
	}
	cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
	if(self.locationString){
		return [NSString stringWithFormat:@"Looking for courses near: %@",self.locationString];
	}else {
		return [NSString stringWithFormat:@"Looking for location..."];
	}
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	return @"Nearby Courses";
}

-(void) fetchCourses{
	//	[self.activityIndicator startAnimating];
	if(self.tableArray!=nil){
		[self.tableArray removeAllObjects];
	}
	
	//if(self.currentLocation.horizontalAccuracy
	int searchRadius=10;
	NSString *searchString=[NSString stringWithFormat:@"putt%%20putt"];
	NSLog(@"SearchBar: %@", self.locationSearchBar.text);
	if(self.locationSearchBar.text.length>0){
		searchRadius=200;
		searchString=self.locationSearchBar.text;
	}
	//http://api.search.live.net/xml.aspx?Appid=FB57CEB0888FD778DCC6A1DDCC22CE79F3458454&query=putt%20putt&sources=phonebook&SearchRequest.Latitude=+39.427021&SearchRequest.Longitude=-76.811700
	NSString *webRequest=[NSString stringWithFormat:@"http://api.search.live.net/xml.aspx?Appid=%@&query=%@&sources=phonebook&Latitude=%f&Longitude=%f&LatitudeSpecified=true&longitudespecified=true&radius=%i",SEGBingAPIKey,searchString,self.currentLocation.coordinate.latitude,self.currentLocation.coordinate.longitude,searchRadius];
	NSLog(@"webRequest: %@", webRequest);
	NSURL *bingURL=[NSURL URLWithString:webRequest];
	NSData *urlData = [NSData dataWithContentsOfURL:bingURL];
	//NSLog(@"URL DATA: %@", urlData);
	TBXML *xmlData=[[TBXML alloc] initWithXMLData:urlData];
	NSLog(@"URL DATA: %@", xmlData);
	if (xmlData.rootXMLElement){
		NSLog(@"Found root element: %@", [TBXML textForElement:xmlData.rootXMLElement]);
		TBXMLElement *xmlPBRElement=[TBXML childElementNamed:@"pho:Phonebook" parentElement:xmlData.rootXMLElement];
		//int xmlPBResultCount=[[TBXML textForElement:[TBXML childElementNamed:@"pho:Total" parentElement:xmlPBRElement]] integerValue];
		if(xmlPBRElement){
			TBXMLElement *xmlPBRResultsElement=[TBXML childElementNamed:@"pho:Results" parentElement:xmlPBRElement];
			if(xmlPBRResultsElement){
				TBXMLElement *xmlPBResultElement=[TBXML childElementNamed:@"pho:PhonebookResult" parentElement:xmlPBRResultsElement];
				while(xmlPBResultElement){
					CLLocationCoordinate2D location;
					location.latitude = [[TBXML textForElement:[TBXML childElementNamed:@"pho:Latitude" parentElement:xmlPBResultElement]] doubleValue];
					location.longitude = [[TBXML textForElement:[TBXML childElementNamed:@"pho:Longitude" parentElement:xmlPBResultElement]] doubleValue];
					
					PhoneBookResult *pbResult=[[PhoneBookResult alloc] initWithCoordinate:location];
					pbResult.title=[[TBXML textForElement:[TBXML childElementNamed:@"pho:Title" parentElement:xmlPBResultElement]] stringByDecodingHTMLEntities];
					pbResult.url=[NSURL URLWithString:[TBXML textForElement:[TBXML childElementNamed:@"pho:Url" parentElement:xmlPBResultElement]]];
					pbResult.address=[TBXML textForElement:[TBXML childElementNamed:@"pho:Address" parentElement:xmlPBResultElement]];
					pbResult.city=[TBXML textForElement:[TBXML childElementNamed:@"pho:City" parentElement:xmlPBResultElement]];
					pbResult.state=[TBXML textForElement:[TBXML childElementNamed:@"pho:StateOrProvince" parentElement:xmlPBResultElement]];
					pbResult.zipcode=[TBXML textForElement:[TBXML childElementNamed:@"pho:PostalCode" parentElement:xmlPBResultElement]];
					if([TBXML childElementNamed:@"pho:PhoneNumber" parentElement:xmlPBResultElement]){
						pbResult.phone=[TBXML textForElement:[TBXML childElementNamed:@"pho:PhoneNumber" parentElement:xmlPBResultElement]];
					}
					if([TBXML childElementNamed:@"pho:UserRating" parentElement:xmlPBResultElement]){
						pbResult.userRating=[TBXML textForElement:[TBXML childElementNamed:@"pho:UserRating" parentElement:xmlPBResultElement]];
					}
					pbResult.location=[[CLLocation alloc] initWithLatitude:[[TBXML textForElement:[TBXML childElementNamed:@"pho:Latitude" parentElement:xmlPBResultElement]] doubleValue] longitude:[[TBXML textForElement:[TBXML childElementNamed:@"pho:Longitude" parentElement:xmlPBResultElement]] doubleValue]];
					pbResult.uniqueID=[TBXML textForElement:[TBXML childElementNamed:@"pho:UniqueId" parentElement:xmlPBResultElement]];
					
					// 				pbResult.coordinate=pbResult.location.coordinate;
					//pbResult.mSubTitle=pbResult.address;
					
					
					
					if(self.tableArray==nil){
						self.tableArray = [[NSMutableArray alloc] initWithCapacity:1];
						[self.tableArray addObject:pbResult];
						
					}else{
						[self.tableArray addObject:pbResult];
					}
					
					[pbResult release];
					
					xmlPBResultElement=xmlPBResultElement->nextSibling;
				}
			}
		}
	}
	[xmlData release];
	
	NSLog(@"Added %i courses to courseList", [self.tableArray count]);
	
	//
	
	//	[self.activityIndicator stopAnimating];
	
	
}

#pragma mark CLLocation
- (CLLocationManager *)locationManager {
	
    if (locationManager != nil) {
        return locationManager;
    }
	
    locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.delegate = self;
	
    return locationManager;
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    hasLocation = YES;
	NSDate* eventDate = newLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0)
    {
        NSLog(@"latitude %+.6f, longitude %+.6f\n",
			  newLocation.coordinate.latitude,
			  newLocation.coordinate.longitude);
    }
	
	if (self.currentLocation!=nil) {
		[self.currentLocation release];
	}
	self.currentLocation = [[CLLocation alloc] initWithCoordinate:newLocation.coordinate altitude:newLocation.altitude horizontalAccuracy:newLocation.horizontalAccuracy verticalAccuracy:newLocation.verticalAccuracy timestamp:newLocation.timestamp];
	
	MKReverseGeocoder *theGeocoder=[[MKReverseGeocoder alloc] initWithCoordinate:newLocation.coordinate];
	theGeocoder.delegate=self;
	[theGeocoder start];
	
	NSLog(@"Coordinates: %fx%f",newLocation.coordinate.latitude, newLocation.coordinate.longitude);
	NSLog(@"Accuracy: %f", newLocation.horizontalAccuracy);
	
	
	[self.locationManager stopUpdatingLocation];
	//if(newLocation.horizontalAccuracy<200){
	[self reloadTableViewDataSource];
	//}
	
}

- (void)locationManager:(CLLocationManager *)manager
	   didFailWithError:(NSError *)error {
    hasLocation = NO;
}



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
	[managedObjectContext release];
	[tableArray release];
	
	[locationSearchBar release];
	[locationsTableView release];
	
	[locationManager release];
	[currentLocation release];
	[locationString release];
    [super dealloc];
}


@end
