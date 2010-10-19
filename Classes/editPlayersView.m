//
//  addPlayersView.m
//  Caddy
//
//  Created by shawn on 8/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "editPlayersView.h"


@implementation editPlayersView

@synthesize playerList;
@synthesize playerName;
@synthesize startGame;
@synthesize editPlayerList;
@synthesize currentGame;
@synthesize managedObjectContext;
@synthesize fetchedResultsController;
@synthesize playerAutoComplete, AutoCompleteScrollView;
@synthesize players;
@synthesize selectedCourse;


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		self.title=@"Add Players";
		self.players=[[[NSMutableArray alloc] initWithCapacity:0] autorelease];
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
		self.AutoCompleteScrollView.hidden=YES;
	[self fetchPlayers];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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

-(IBAction) nextButtonOnKeyboardPressed:(id)sender{
	if(![self.playerName.text isEqualToString:@""]){
			NSError *error;
		if(self.currentGame==nil){
			
			self.currentGame = (game *)[NSEntityDescription insertNewObjectForEntityForName:@"games" inManagedObjectContext:managedObjectContext];
			self.currentGame.courseID=self.selectedCourse;
			self.currentGame.Date=[NSDate date];

			if (![self.managedObjectContext save:&error]) NSLog(@"Error: %@", [error localizedDescription]);
		}
		
		
		
		//Check for existing player
		NSFetchRequest *request = [[NSFetchRequest alloc] init];
		NSEntityDescription *entity = [NSEntityDescription entityForName:@"players" inManagedObjectContext:managedObjectContext];
		[request setEntity:entity];
		
		NSPredicate *predicate=[NSPredicate predicateWithFormat:@"name = %@", self.playerName.text];
		[request setPredicate:predicate];
		
		
		NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
		NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
		[request setSortDescriptors:sortDescriptors];
		[sortDescriptor release];
		[sortDescriptors release];
		
		NSFetchedResultsController *playerSearchResultsController=[[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
		
		playerSearchResultsController.delegate = self;
		
		//NSError *error;
		if (![playerSearchResultsController performFetch:&error]) NSLog(@"Error Fetching: %@", [error localizedDescription]);	
		NSLog(@"fetchPlayers:(fetchResults)Found %i players that matched %@", [[playerSearchResultsController fetchedObjects] count], self.playerName.text);	
		[request release];
		
		player *typedPlayer;
		if([[playerSearchResultsController fetchedObjects] count]>0){
			typedPlayer=(player *)[[playerSearchResultsController fetchedObjects] objectAtIndex:0];
		}else{
			typedPlayer = (player *)[NSEntityDescription insertNewObjectForEntityForName:@"players" inManagedObjectContext:managedObjectContext];
			typedPlayer.name=self.playerName.text;
		}
		if (![self.managedObjectContext save:&error]) NSLog(@"Error: %@", [error localizedDescription]);
		
		//Add them to game
		[currentGame addPlayersObject:typedPlayer];
		
				
		if (![self.managedObjectContext save:&error]) NSLog(@"Error: %@", [error localizedDescription]);
		
		[request release];
		
		//Refresh table view
		[self.players sortUsingSelector:@selector(compare:)];
		[self fetchPlayers];
		[self.playerList reloadData];
		self.playerName.text=@"";
		self.AutoCompleteScrollView.hidden=YES;
	}
}
-(IBAction) startGameButtonPressed:(id)sender{
	scoreView *scoreVC = [[scoreView alloc] initWithNibName:nil bundle:nil];
	scoreVC.managedObjectContext=managedObjectContext;
	scoreVC.currentGame=self.currentGame;
	[self.players sortUsingSelector:@selector(compare:)];
	scoreVC.players=self.players;
	[self.navigationController pushViewController:scoreVC animated:YES];
}

-(IBAction) editPlayerName{
	self.AutoCompleteScrollView.hidden=NO;
	[self.playerAutoComplete reloadData];
}

-(void) fetchPlayers{
	/*
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"games" inManagedObjectContext:managedObjectContext];
	[request setEntity:entity];
	
	NSPredicate *predicate=[NSPredicate predicateWithFormat:@"game=%@", self.currentGame];
	[request setPredicate:predicate];

	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"displayName" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];
	[sortDescriptor release];
	[sortDescriptors release];
	
	if(self.fetchedResultsController == NULL){
		self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
	}else{
		[self.fetchedResultsController initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
	}
    self.fetchedResultsController.delegate = self;
	
	NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) NSLog(@"Error Fetching: %@", [error localizedDescription]);	
	NSLog(@"fetchPlayers:(fetchResults)Found %i players in game", [[fetchedResultsController fetchedObjects] count]);	
	[request release];
	 */
	
	self.players=[[[NSMutableArray alloc] initWithCapacity:0] autorelease];
	for (player *tempPlayer in currentGame.playersSet){
		NSLog(@"Adding Player: %@", tempPlayer.name);
		[self.players addObject:tempPlayer.name];
		NSLog(@"Added Player: %@", [self.players objectAtIndex:[players count]-1]);

	}
	[self.players sortUsingSelector:@selector(compare:)];
				
}

-(void) searchForPlayerName{
	ABAddressBookRef addressBook;
	CFErrorRef error = NULL;
	
	addressBook = ABAddressBookCreate();
	
	CFArrayRef people = ABAddressBookCopyArrayOfAllPeople(addressBook);
	CFMutableArrayRef peopleMutable = CFArrayCreateMutableCopy(
															   kCFAllocatorDefault,
															   CFArrayGetCount(people),
															   people
															   );
	
	CFArraySortValues(
					  peopleMutable,
					  CFRangeMake(0, CFArrayGetCount(peopleMutable)),
					  (CFComparatorFunction) ABPersonComparePeopleByName,
					  (void*) ABPersonGetSortOrdering()
					  );
	
	
}

#pragma mark tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	if(tableView.tag==2){
		ABAddressBookRef addressBook;
		CFErrorRef error = NULL;
		
		addressBook = ABAddressBookCreate();
		
		CFArrayRef people = ABAddressBookCopyPeopleWithName(addressBook, (CFStringRef) self.playerName.text);
		CFMutableArrayRef peopleMutable = CFArrayCreateMutableCopy(
																   kCFAllocatorDefault,
																   CFArrayGetCount(people),
																   people
																   );
		
		CFArraySortValues(
						  peopleMutable,
						  CFRangeMake(0, CFArrayGetCount(peopleMutable)),
						  (CFComparatorFunction) ABPersonComparePeopleByName,
						  (void*) ABPersonGetSortOrdering()
						  );
		NSMutableArray *addresses=(NSMutableArray *) peopleMutable;
		ABRecordRef aRecord=[addresses objectAtIndex:indexPath.row];
		
		CFStringRef firstName, lastName;
		firstName = ABRecordCopyValue(aRecord, kABPersonFirstNameProperty);
		lastName  = ABRecordCopyValue(aRecord, kABPersonLastNameProperty);
		self.playerName.text=[NSString stringWithFormat:@"%@ %@", firstName, lastName];
		[self nextButtonOnKeyboardPressed:self];
	}
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section{
	
	if(tableView.tag==1){
		return [players count];
		NSLog(@"Number of rows: %d", [players count]);
	}else if(tableView.tag==2){
		ABAddressBookRef addressBook;
		CFErrorRef error = NULL;
		
		addressBook = ABAddressBookCreate();
		if(![self.playerName.text isEqualToString:@""]){
			CFArrayRef people = ABAddressBookCopyPeopleWithName(addressBook, (CFStringRef) self.playerName.text);
			return  CFArrayGetCount(people);
		}else{
			return 0;
		}
	}else{
		return 0;
	}
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
		
	NSLog(@"Table Tag: %d", tableView.tag);
	
		static NSString *cellIdentifier=@"Cell";
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
		if(cell==nil){
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier] autorelease];
		}
		if(tableView.tag==1){
			NSLog(@"Index Path: %d", indexPath.row);
			NSLog(@"Cell Label: %@", [self.players objectAtIndex:indexPath.row]);
			cell.textLabel.text=[self.players objectAtIndex:indexPath.row];
			
		}else if(tableView.tag==2){
			
			if(![self.playerName.text isEqualToString:@""]){
			ABAddressBookRef addressBook;
			CFErrorRef error = NULL;
			
			addressBook = ABAddressBookCreate();
			
			CFArrayRef people = ABAddressBookCopyPeopleWithName(addressBook, (CFStringRef) self.playerName.text);
			CFMutableArrayRef peopleMutable = CFArrayCreateMutableCopy(
																	   kCFAllocatorDefault,
																	   CFArrayGetCount(people),
																	   people
																	   );
			
			CFArraySortValues(
							  peopleMutable,
							  CFRangeMake(0, CFArrayGetCount(peopleMutable)),
							  (CFComparatorFunction) ABPersonComparePeopleByName,
							  (void*) ABPersonGetSortOrdering()
							  );
			NSMutableArray *addresses=(NSMutableArray *) peopleMutable;
			ABRecordRef aRecord=[addresses objectAtIndex:indexPath.row];
		
			CFStringRef firstName, lastName;
			firstName = ABRecordCopyValue(aRecord, kABPersonFirstNameProperty);
			lastName  = ABRecordCopyValue(aRecord, kABPersonLastNameProperty);
			cell.textLabel.text=[NSString stringWithFormat:@"%@ %@", firstName, lastName];
			}
		}
		return cell;
}


@end
