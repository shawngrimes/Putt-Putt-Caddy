//
//  CourseDetailsViewController.m
//  Caddy
//
//  Created by shawn on 10/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CourseDetailsViewController.h"


@implementation CourseDetailsViewController
@synthesize locationLabel;
@synthesize courseLabel;
@synthesize playHereButton;
@synthesize leadersTableView;
@synthesize pbResult;
@synthesize selectedCourse;
@synthesize managedObjectContext;
@synthesize courseStatsLabel;

NSMutableArray *tableArray;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		self.title=@"Course Details";
		tableArray=[[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.locationLabel.text=self.pbResult.title;
	self.courseLabel.text=self.selectedCourse.name;
	self.courseStatsLabel.text=[NSString stringWithFormat:@"Par: %i  -  Holes: %i",[self.selectedCourse.par integerValue],[self.selectedCourse.numHoles integerValue]];
	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(IBAction) addPlayers{
	/*
	game *newGame = (game *)[NSEntityDescription insertNewObjectForEntityForName:@"games" inManagedObjectContext:managedObjectContext];
	newGame.courseID=self.selectedCourse;
	newGame.Date=[NSDate date];
	NSError *error;
	if (![self.managedObjectContext save:&error]) NSLog(@"Error: %@", [error localizedDescription]);
	*/
	
	editPlayersView *editPlayersVC = [[editPlayersView alloc] initWithNibName:nil bundle:nil];
	editPlayersVC.managedObjectContext=managedObjectContext;
	editPlayersVC.selectedCourse=self.selectedCourse;
	[self.navigationController pushViewController:editPlayersVC animated:YES];

	
}

#pragma mark tableView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section{
	return [tableArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	NSLog(@"cellForRowAtIndexPath");
	static NSString *cellIdentifier=@"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if(cell==nil){
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier] autorelease];
	}
	
	//golfCourse *course=[self.courseList objectAtIndex:indexPath.row];
	
	//cell.textLabel.text=[[tableArray objectAtIndex:indexPath.row] name];
	cell.textLabel.text=[tableArray objectAtIndex:indexPath.row];		
	
	//cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
	return @"";
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	return @"Leaders";
}

-(void) fetchLeaders{
	if(tableArray!=nil){
		[tableArray release];
	}else{
		tableArray = [[NSMutableArray alloc] initWithCapacity:1];
	}
	
	[tableArray addObject:@"Coming soon..." ];
	NSLog(@"Found %i courses for this location", [tableArray count]);
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
	[locationLabel release];
	[courseLabel release];
	[playHereButton release];
	[leadersTableView release];
	[pbResult release];
	[selectedCourse release];
    [super dealloc];
}


@end
