//
//  AddNewCourseViewController.m
//  Caddy
//
//  Created by shawn on 10/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AddNewCourseViewController.h"


@implementation AddNewCourseViewController

@synthesize managedObjectContext;
@synthesize pbResult;
@synthesize courseDetailsPicker;
@synthesize courseName;
@synthesize addPlayersButton;
@synthesize locationName;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		self.title=@"New Course Details";
			self.addPlayersButton.enabled=NO;
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.locationName.text=self.pbResult.title;
	[courseDetailsPicker selectRow:17 inComponent:0 animated:YES];
	[courseDetailsPicker selectRow:35 inComponent:1 animated:YES];
	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(IBAction) addPlayers{
	//Create course
	if(![self.courseName.text isEqualToString:@""]){
			NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"courses" inManagedObjectContext:managedObjectContext];
			NSFetchRequest *request = [[NSFetchRequest alloc] init];
			[request setEntity:entityDesc];
			
			golfCourse *newCourse = (golfCourse *)[NSEntityDescription insertNewObjectForEntityForName:@"courses" inManagedObjectContext:managedObjectContext];
			newCourse.name=self.courseName.text;
			[newCourse setValue:[NSNumber numberWithInt:[courseDetailsPicker selectedRowInComponent:0]+1] forKey:@"numHoles"];
			[newCourse setValue:[NSNumber numberWithInt:[courseDetailsPicker selectedRowInComponent:1]+1] forKey:@"par"];
		[newCourse setLatitude:[NSNumber numberWithDouble:pbResult.location.coordinate.latitude]];
		[newCourse setLongitude:[NSNumber numberWithDouble:pbResult.location.coordinate.longitude]];
		[newCourse setUniqueID:pbResult.uniqueID];
		[newCourse setCreationDate:[NSDate date]];
		NSError *error;
			if (![self.managedObjectContext save:&error]) NSLog(@"Error Saving New Course: %@", [error localizedDescription]);
			game *newGame = (game *)[NSEntityDescription insertNewObjectForEntityForName:@"games" inManagedObjectContext:managedObjectContext];
			newGame.courseID=newCourse;
			
			newGame.Date=[NSDate date];
			if (![self.managedObjectContext save:&error]) NSLog(@"Error: %@", [error localizedDescription]);
			
			[request release];
		
		editPlayersView *editPlayersVC = [[editPlayersView alloc] initWithNibName:nil bundle:nil];
		editPlayersVC.managedObjectContext=managedObjectContext;
		editPlayersVC.currentGame=newGame;
		[self.navigationController pushViewController:editPlayersVC animated:YES];
			
			
	}
	
}

#pragma mark UITextField
-(IBAction) doneButtonOnKeyboardPressed:(id)sender{
}

-(IBAction) editCourseName{
	self.addPlayersButton.enabled=YES;
}



#pragma mark UIPickerView
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 2;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	if(component==0){
		return [NSString stringWithFormat:@"%d", row+1];
	}else if(component==1){
		return [NSString stringWithFormat:@"%d", row+1];
	}
	return nil;
}


-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	NSLog(@"Component: %i", component);
	if(component==0){
		return 36;
	}else if(component==1){
		return 200;
	}
	return 0;
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
