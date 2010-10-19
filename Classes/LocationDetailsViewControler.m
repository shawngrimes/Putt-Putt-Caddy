//
//  LocationDetailsViewControler.m
//  Caddy
//
//  Created by shawn on 10/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LocationDetailsViewControler.h"


@implementation LocationDetailsViewControler

@synthesize locationNameLabel;
@synthesize locationAddressLabel;
@synthesize tableView;
@synthesize pbResult;
@synthesize managedObjectContext;
@synthesize tableArray;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.title=@"Select Course";
    }

    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.locationNameLabel.text=pbResult.title;
	self.locationAddressLabel.text=pbResult.address;
	[self fetchCourses];
	[self.tableView reloadData];
	[self.navigationController setNavigationBarHidden:NO animated:YES];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark tableView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
	if(indexPath.section==0){
		//Show Map
		LocationMapViewController *locationMapVC=[[LocationMapViewController alloc] init];
		locationMapVC.pbResult=self.pbResult;
		[self.navigationController pushViewController:locationMapVC animated:YES];
		[locationMapVC release];
		
	}else if(indexPath.section==1){
		if(indexPath.row>=[self.tableArray count]){
			//Add new course
			AddNewCourseViewController *addNewCourseVC=[[AddNewCourseViewController alloc] init];
			addNewCourseVC.managedObjectContext=self.managedObjectContext;
			addNewCourseVC.pbResult=self.pbResult;
			
			[self.navigationController pushViewController:addNewCourseVC animated:YES];
			[addNewCourseVC release];
		}else{
			CourseDetailsViewController *courseDetsVC=[[CourseDetailsViewController alloc] init];
			courseDetsVC.managedObjectContext=self.managedObjectContext;
			courseDetsVC.pbResult=self.pbResult;
			courseDetsVC.selectedCourse=[self.tableArray objectAtIndex:indexPath.row];
			[self.navigationController pushViewController:courseDetsVC animated:YES];
			[courseDetsVC release];
		}
	}
	
	
	
	/*
	if(indexPath.row<[self.tableArray count]){
		if([[self.tableArray objectAtIndex:indexPath.row] isKindOfClass:[PhoneBookResult class]]){
			LocationDetailsViewControler *locDetailsVC=[[LocationDetailsViewControler alloc] init];
			locDetailsVC.managedObjectContext=self.managedObjectContext;
			locDetailsVC.pbResult=[self.tableArray objectAtIndex:indexPath.row];
			
			//UINavigationController *navController=[[UINavigationController alloc] init];
			//self.navigationController;
			[self.navigationController pushViewController:locDetailsVC animated:YES];
			[locDetailsVC release];
			NSLog(@"Showing location");
		}else if([[self.tableArray objectAtIndex:indexPath.row] isKindOfClass:[game class]] ){
			NSLog(@"Showing historical game");
		}
	}else{
		NSLog(@"Adding course...");
	}
	
	*/	
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section{
	if(section==0){
		return 1;
	}else if(section==1){
		return ([self.tableArray count]+1);
	}else{
		return 0;
	}

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

	
	
	NSLog(@"cellForRowAtIndexPath");
	static NSString *cellIdentifier=@"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if(cell==nil){
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier] autorelease];
	}
	
	//golfCourse *course=[self.courseList objectAtIndex:indexPath.row];
	
	if(indexPath.section==0){
		cell.textLabel.text=@"Details & Map";
	}else{
		if(indexPath.row>=[self.tableArray count]){
			cell.textLabel.text=@"Add Course...";
		}else{
			cell.textLabel.text=[[self.tableArray objectAtIndex:indexPath.row] name];
			cell.detailTextLabel.text=[NSString stringWithFormat:@"Holes: %i  -  Par: %i",[[[self.tableArray objectAtIndex:indexPath.row] numHoles] integerValue],[[[self.tableArray objectAtIndex:indexPath.row] par] integerValue]];

		}
	}
		cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
	return @"";
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	if(section==1){
		return @"Courses";
	}else{
		return @"";
	}
}

-(void) fetchCourses{
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"courses" inManagedObjectContext:managedObjectContext];
	[request setEntity:entity];
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];
	[sortDescriptor release];
	[sortDescriptors release];
	
	NSPredicate *predicate=[NSPredicate predicateWithFormat:@"uniqueID=%@", pbResult.uniqueID];
	[request setPredicate:predicate];
	
	NSError *error;
	NSArray *fetchedObjects=[[[NSArray alloc] init] autorelease];
	fetchedObjects=[managedObjectContext executeFetchRequest:request error:&error];
	
	if(self.tableArray!=nil){
		[self.tableArray release];
	}else{
		self.tableArray = [[NSMutableArray alloc] initWithCapacity:1];
	}
	
	[self.tableArray setArray:fetchedObjects ];
	NSLog(@"Unique ID: %@", pbResult.uniqueID);
	NSLog(@"Found %i courses for this location", [self.tableArray count]);
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
    [super dealloc];
}


@end
