//
//  scoreView.m
//  Caddy
//
//  Created by shawn on 8/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "scoreView.h"


@implementation scoreView

@synthesize currentGame;
@synthesize managedObjectContext;
@synthesize fetchedResultsController;
@synthesize players;

@synthesize scoreTableView;
@synthesize scoreScrollView;

@synthesize scoreCellView;
@synthesize holeLabel;
@synthesize scoreLabel1;
@synthesize scoreLabel2;
@synthesize scoreLabel3;
@synthesize scoreLabel4;
@synthesize scoreButton1;
@synthesize scoreButton2;
@synthesize scoreButton3;
@synthesize scoreButton4;


@synthesize playerLabel1;
@synthesize playerLabel2;
@synthesize playerLabel3;
@synthesize playerLabel4;
@synthesize playerLabels;

@synthesize scoreValueButton1;
@synthesize scoreValueButton2;
@synthesize scoreValueButton3;
@synthesize scoreValueButton4;
@synthesize scoreValueButton5;
@synthesize scoreValueButton6;
@synthesize scoreValueButtonCancel;
@synthesize scoreValuesView;

@synthesize currentHole;
@synthesize currentPlayer;

@synthesize morePlayersToolBar;
@synthesize morePlayersButtonBarItem;
@synthesize prevPlayersButtonBarItem;
@synthesize finishGameButtonBarItem;
@synthesize currentPage;

@synthesize readOnly;


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		currentPage=1;
		readOnly=NO;
		self.players=[[NSMutableArray alloc] initWithCapacity:0];
	}
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self fetchPlayers];
	self.scoreValuesView.hidden=YES;
	if([players count]<4){
		self.morePlayersButtonBarItem.enabled=NO;
	}
	UIBarButtonItem *doneButton;
	if(self.readOnly){
		doneButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector( finishGame ) ];
	}else{
		doneButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector( finishGameAlert ) ];
	}
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	self.navigationItem.rightBarButtonItem=doneButton;
}

-(void)finishGame{
//	mainView *mainVC= [[mainView alloc] init];
//	[self.navigationController pushViewController:mainVC animated:YES];
//	mainVC.managedObjectContext=self.managedObjectContext;
//	[mainVC release];
}

-(void)finishGameAlert{
	UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Are you sure?" message:@"Are you sure you are done playing and want to finish this game?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes, I'm done",nil];
	[alertView show];
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

#pragma mark CoreDataSearches
-(void) fetchPlayers{
	
}



#pragma mark tableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger) section{
	
	static NSString *cellIdentifier=@"scoreFooterCell";
	static NSString *CellNib=@"scoreCellHeader";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if(cell==nil){
		NSArray *nib=[[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
		//		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier] autorelease];
		cell=(UITableViewCell *) [nib objectAtIndex:0];
	}
	
	self.playerLabels=[[NSArray alloc] initWithObjects:playerLabel1,playerLabel2,playerLabel3,playerLabel4,nil];
	NSLog(@"PlayerLabels Count: %d", [self.playerLabels count]);
	
	if([players count]<4){
		for (int i=0; i<[players count]; i++) {
			NSMutableString *displayName=[[[NSMutableString alloc] initWithCapacity:[[self.players objectAtIndex:i] length]] autorelease];
			[displayName setString:[self.players objectAtIndex:i]];
			[displayName replaceOccurrencesOfString:@" " withString:[NSString stringWithFormat:@"\n"]
											options:0
											  range:NSMakeRange(0, [displayName length])
			 ];
			UILabel * tempLabel=[self.playerLabels objectAtIndex:i];
			tempLabel.textColor=[UIColor whiteColor];
			tempLabel.text=displayName;
		}
	}else{
		switch (currentPage) {
			case 1:
				for (int i=0; i<4; i++) {
					NSMutableString *displayName=[[[NSMutableString alloc] initWithCapacity:[[self.players objectAtIndex:i] length]] autorelease];
					[displayName setString:[self.players objectAtIndex:i]];
					[displayName replaceOccurrencesOfString:@" " withString:[NSString stringWithFormat:@"\n"]
													options:0
													  range:NSMakeRange(0, [displayName length])
					 ];
					UILabel * tempLabel=[self.playerLabels objectAtIndex:i];
					tempLabel.textColor=[UIColor whiteColor];
					tempLabel.text=displayName;
				}	
				break;
			case 2:
				for (int i=4; i<[players count]; i++) {
					NSMutableString *displayName=[[[NSMutableString alloc] initWithCapacity:[[self.players objectAtIndex:i] length]] autorelease];
					[displayName setString:[self.players objectAtIndex:i]];
					[displayName replaceOccurrencesOfString:@" " withString:[NSString stringWithFormat:@"\n"]
													options:0
													  range:NSMakeRange(0, [displayName length])
					 ];
					UILabel * tempLabel=[self.playerLabels objectAtIndex:(i-4)];
					tempLabel.textColor=[UIColor whiteColor];
					tempLabel.text=displayName;
				}	
				break;
			default:
				break;
		}
	}
	
	
	cell.backgroundColor=[UIColor darkGrayColor];
	
	return cell ;
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	return 48;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
	return 70;	
}



-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger) section{
	static NSString *cellIdentifier=@"scoreFooterCell";
	static NSString *CellNib=@"scoreCellFooter";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if(cell==nil){
		NSArray *nib=[[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
		//		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier] autorelease];
		cell=(UITableViewCell *) [nib objectAtIndex:0];
	}
	golfCourse *currentCourse=currentGame.courseID;
	
	NSArray *scoreLabels=[[NSArray alloc] initWithObjects:scoreLabel1,scoreLabel2,scoreLabel3,scoreLabel4,nil];
	NSMutableArray *playersArray=[[NSMutableArray alloc] initWithArray:[[self.currentGame playersSet] allObjects]];
	[playersArray sortUsingSelector:@selector(comparePlayer:)];
	
	
	for (int x=0; x<[players count]; x++) {
		NSFetchRequest *request = [[NSFetchRequest alloc] init];
		NSEntityDescription *entity = [NSEntityDescription entityForName:@"scores" inManagedObjectContext:managedObjectContext];
		[request setEntity:entity];
		
		
		NSPredicate *predicate=[NSPredicate predicateWithFormat:@"game=%@ AND player=%@", self.currentGame, [playersArray objectAtIndex:x]];
		[request setPredicate:predicate];
				
		NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"hole" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
		NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
		[request setSortDescriptors:sortDescriptors];
		[sortDescriptor release];
		[sortDescriptors release];
		
		NSFetchedResultsController *scoreSearch=[[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
		scoreSearch.delegate=self;
		NSError *error;
		if (![scoreSearch performFetch:&error]) NSLog(@"Error Fetching: %@", [error localizedDescription]);	
		NSLog(@"viewForFooter:(fetchResults)Found %i scores in game for %@", [[scoreSearch fetchedObjects] count], [playersArray objectAtIndex:x]);	
		
		int totalScoreForPlayer=0;
		if ([[scoreSearch fetchedObjects] count]>0){
			for (scores *selectedScore in [scoreSearch fetchedObjects]){
				totalScoreForPlayer+=[selectedScore.score integerValue];
			}
		}
		
		if([players count]<4){
			UILabel *tempLabel=[scoreLabels objectAtIndex:x];
			tempLabel.text=[NSString stringWithFormat:@"%d", totalScoreForPlayer];
		}else{
			switch (self.currentPage) {
				case 1:
					if(x<4){
						NSLog(@"Footer Page 1");
						UILabel *tempLabel=[scoreLabels objectAtIndex:x];
						tempLabel.text=[NSString stringWithFormat:@"%d", totalScoreForPlayer];
					}
					break;
				case 2:
					if(x>3){
						NSLog(@"Footer Page 2");
						UILabel *temp2Label=[scoreLabels objectAtIndex:x-4];
						temp2Label.text=[NSString stringWithFormat:@"%d", totalScoreForPlayer];
					}
					break;
				default:
					break;
			}
		}
	}
	
	
		
	holeLabel.font = [UIFont systemFontOfSize:10];
	holeLabel.text=[NSString stringWithFormat:@"Par:\n%d",[currentCourse.par integerValue]]; 

	
	
	cell.backgroundColor=[UIColor darkGrayColor];

	return cell ;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section{
	golfCourse *currentCourse=currentGame.courseID;
	
	return [currentCourse.numHoles integerValue];
	
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	static NSString *cellIdentifier=@"scoreTableCell";
	static NSString *CellNib=@"scoreCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if(cell==nil){
		NSArray *nib=[[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
//		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier] autorelease];
		cell=(UITableViewCell *) [nib objectAtIndex:0];
		UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 46.0f)];
		cell.backgroundView=backgroundView;
		
		/*
		UILabel *player1Score=[[[UILabel alloc] initWithFrame:CGRectMake(52,0,72,46)] autorelease];
		UILabel *player2Score=[[[UILabel alloc] initWithFrame:CGRectMake(124,0,72,46)] autorelease];
		UILabel *player3Score=[[[UILabel alloc] initWithFrame:CGRectMake(196,0,72,46)] autorelease];
		UILabel *player4Score=[[[UILabel alloc] initWithFrame:CGRectMake(268,0,72,46)] autorelease];
		[cell addSubview:player1Score];
		[cell addSubview:player2Score];
		[cell addSubview:player3Score];
		[cell addSubview:player4Score];
		*/
		
		if(!self.readOnly){
		
			UIButton *player1ScoreChangeButton=[UIButton buttonWithType:UIButtonTypeCustom];
			[player1ScoreChangeButton setFrame:CGRectMake(32,0,72,46)];
			[player1ScoreChangeButton addTarget:self action:@selector(changeScorePlayer1:) forControlEvents:UIControlEventTouchUpInside];
			
			UIButton *player2ScoreChangeButton=[UIButton buttonWithType:UIButtonTypeCustom];
			[player2ScoreChangeButton setFrame:CGRectMake(104,0,72,46)];
			[player2ScoreChangeButton addTarget:self action:@selector(changeScorePlayer2:) forControlEvents:UIControlEventTouchUpInside];
			
			UIButton *player3ScoreChangeButton=[UIButton buttonWithType:UIButtonTypeCustom];
			[player3ScoreChangeButton setFrame:CGRectMake(176,0,72,46)];
			[player3ScoreChangeButton addTarget:self action:@selector(changeScorePlayer3:) forControlEvents:UIControlEventTouchUpInside];
			
			UIButton *player4ScoreChangeButton=[UIButton buttonWithType:UIButtonTypeCustom];
			[player4ScoreChangeButton setFrame:CGRectMake(248,0,72,46)];
			[player4ScoreChangeButton addTarget:self action:@selector(changeScorePlayer4:) forControlEvents:UIControlEventTouchUpInside];
			
			
			
			[cell addSubview:player1ScoreChangeButton];
			if([players count]<4){
				if([players count]>1) [cell addSubview:player2ScoreChangeButton];
				if([players count]>2) [cell addSubview:player3ScoreChangeButton];
				if([players count]>3) [cell addSubview:player4ScoreChangeButton];
			}else{
				switch (currentPage) {
					case 1:
						if([players count]>1) [cell addSubview:player2ScoreChangeButton];
						if([players count]>2) [cell addSubview:player3ScoreChangeButton];
						if([players count]>3) [cell addSubview:player4ScoreChangeButton];
						break;
					case 2:
						if([players count]>4) [cell addSubview:player2ScoreChangeButton];
						if([players count]>5) [cell addSubview:player3ScoreChangeButton];
						if([players count]>6) [cell addSubview:player4ScoreChangeButton];
						break;
					default:
						break;
				}
			}
		}
		
		
		cell.tag=indexPath.row;
		
		[backgroundView release];
		 
	}
	
	//golfCourse *currentCourse=currentGame.course;
	
	holeLabel.text=[NSString stringWithFormat:@"%d", indexPath.row+1];
	
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"scores" inManagedObjectContext:managedObjectContext];
	[request setEntity:entity];
	
	NSPredicate *predicate=[NSPredicate predicateWithFormat:@"game=%@ AND hole=%d", self.currentGame, indexPath.row+1];
	[request setPredicate:predicate];
	
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"hole" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];
	[sortDescriptor release];
	[sortDescriptors release];
	
	NSFetchedResultsController *scoreSearch=[[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
	scoreSearch.delegate=self;
	NSError *error;
	if (![scoreSearch performFetch:&error]) NSLog(@"Error Fetching: %@", [error localizedDescription]);	
	NSLog(@"fetchPlayers:(fetchResults)Found %i scores in game", [[scoreSearch fetchedObjects] count]);	
	
	if ([[scoreSearch fetchedObjects] count]>0){
		for (scores *selectedScore in [scoreSearch fetchedObjects]) {
			if([players count]<4){
				if([[selectedScore.player name] isEqualToString:[players objectAtIndex:0]]){
					scoreLabel1.text=[NSString stringWithFormat:@"%d", [selectedScore.score integerValue]];
				}else if([[selectedScore.player name] isEqualToString:[players objectAtIndex:1]]){
					scoreLabel2.text=[NSString stringWithFormat:@"%d", [selectedScore.score integerValue]];
				}else if([[selectedScore.player name] isEqualToString:[players objectAtIndex:2]]){
					scoreLabel3.text=[NSString stringWithFormat:@"%d", [selectedScore.score integerValue]];
				}else if([[selectedScore.player name] isEqualToString:[players objectAtIndex:3]]){
					scoreLabel4.text=[NSString stringWithFormat:@"%d", [selectedScore.score integerValue]];
				}
			}else{
				switch (currentPage) {
					case 1:
						
						if([[selectedScore.player name] isEqualToString:[players objectAtIndex:0]]){
							scoreLabel1.text=[NSString stringWithFormat:@"%d", [selectedScore.score integerValue]];
						}else if([[selectedScore.player name] isEqualToString:[players objectAtIndex:1]]){
							scoreLabel2.text=[NSString stringWithFormat:@"%d", [selectedScore.score integerValue]];
						}else if([[selectedScore.player name] isEqualToString:[players objectAtIndex:2]]){
							scoreLabel3.text=[NSString stringWithFormat:@"%d", [selectedScore.score integerValue]];
						}else if([[selectedScore.player name] isEqualToString:[players objectAtIndex:3]]){
							scoreLabel4.text=[NSString stringWithFormat:@"%d", [selectedScore.score integerValue]];
						}
						break;
					case 2:
						switch ([players count]){
							case 5:
								if([[selectedScore.player name] isEqualToString:[players objectAtIndex:4]]){
									scoreLabel1.text=[NSString stringWithFormat:@"%d", [selectedScore.score integerValue]];
								}
								break;
							case 6:
								if([[selectedScore.player name] isEqualToString:[players objectAtIndex:4]]){
									scoreLabel1.text=[NSString stringWithFormat:@"%d", [selectedScore.score integerValue]];
								}else if([[selectedScore.player name] isEqualToString:[players objectAtIndex:5]]){
									scoreLabel2.text=[NSString stringWithFormat:@"%d", [selectedScore.score integerValue]];
								}
								break;
							case 7:
								if([[selectedScore.player name] isEqualToString:[players objectAtIndex:4]]){
									scoreLabel1.text=[NSString stringWithFormat:@"%d", [selectedScore.score integerValue]];
								}else if([[selectedScore.player name] isEqualToString:[players objectAtIndex:5]]){
									scoreLabel2.text=[NSString stringWithFormat:@"%d", [selectedScore.score integerValue]];
								}else if([[selectedScore.player name] isEqualToString:[players objectAtIndex:6]]){
									scoreLabel3.text=[NSString stringWithFormat:@"%d", [selectedScore.score integerValue]];
								}
								break;
							case 8:
								if([[selectedScore.player name] isEqualToString:[players objectAtIndex:4]]){
									scoreLabel1.text=[NSString stringWithFormat:@"%d", [selectedScore.score integerValue]];
								}else if([[selectedScore.player name] isEqualToString:[players objectAtIndex:5]]){
									scoreLabel2.text=[NSString stringWithFormat:@"%d", [selectedScore.score integerValue]];
								}else if([[selectedScore.player name] isEqualToString:[players objectAtIndex:6]]){
									scoreLabel3.text=[NSString stringWithFormat:@"%d", [selectedScore.score integerValue]];
								}else if([[selectedScore.player name] isEqualToString:[players objectAtIndex:7]]){
									scoreLabel4.text=[NSString stringWithFormat:@"%d", [selectedScore.score integerValue]];
								}
								break;
							default:
								break;
						}
						break;
					default:
						break;
				}
			}
				
		}
	}
	[scoreSearch release];
	[request release];
		
	
	
	
	return cell;
}



#pragma mark Bar Button Actions
-(IBAction)nextPlayersPage:(id) sender{
	self.prevPlayersButtonBarItem.enabled=YES;
	self.morePlayersButtonBarItem.enabled=NO;
	self.currentPage=2;
	[self.scoreTableView reloadData];
	
}

-(IBAction)prevPlayersPage:(id) sender{
	self.prevPlayersButtonBarItem.enabled=NO;
	self.morePlayersButtonBarItem.enabled=YES;
	self.currentPage=1;
		[self.scoreTableView reloadData];
}

-(IBAction)shareResults:(id) sender{
	int winningScore=500;
	player *winningPlayer=[[player alloc] retain];
	
	NSMutableArray *playersArray=[[NSMutableArray alloc] initWithArray:[[self.currentGame playersSet] allObjects]];
	[playersArray sortUsingSelector:@selector(comparePlayer:)];
	
	for (int x=0; x<[players count]; x++) {
		NSFetchRequest *request = [[NSFetchRequest alloc] init];
		NSEntityDescription *entity = [NSEntityDescription entityForName:@"scores" inManagedObjectContext:managedObjectContext];
		[request setEntity:entity];
		
		
		NSPredicate *predicate=[NSPredicate predicateWithFormat:@"game=%@ AND player=%@", self.currentGame, [playersArray objectAtIndex:x]];
		[request setPredicate:predicate];
		
		NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"hole" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
		NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
		[request setSortDescriptors:sortDescriptors];
		[sortDescriptor release];
		[sortDescriptors release];
		
		NSFetchedResultsController *scoreSearch=[[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
		scoreSearch.delegate=self;
		NSError *error;
		if (![scoreSearch performFetch:&error]) NSLog(@"Error Fetching: %@", [error localizedDescription]);	
		NSLog(@"fetchPlayers:(fetchResults)Found %i scores in game for player", [[scoreSearch fetchedObjects] count]);	
		
		int totalScoreForPlayer=0;
		if ([[scoreSearch fetchedObjects] count]>0){
			for (scores *selectedScore in [scoreSearch fetchedObjects]){
				totalScoreForPlayer+=[selectedScore.score integerValue];
			}
		}
		
		NSLog(@"total Score: %i", totalScoreForPlayer);
		
		if(winningScore>totalScoreForPlayer){
			winningPlayer=[playersArray objectAtIndex:x];
			winningScore=totalScoreForPlayer;
		}
		
	}
	NSString *winnerString=[NSString stringWithFormat:@"Just played putt putt at %@ and %@ won with a score of %i (par was %i)",self.currentGame.courseID.name, winningPlayer.name, winningScore, [self.currentGame.courseID.par integerValue]];
	
	SHKItem *item = [SHKItem text:winnerString];
	
	// Get the ShareKit action sheet
	SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
	
	// Display the action sheet
	[actionSheet showFromToolbar:self.navigationController.toolbar];
	
	
}

#pragma mark Alert View Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if(buttonIndex==0){
		NSLog(@"Cancelled alert: Not finished playing");
	}else{
//		mainView *mainVC= [[mainView alloc] init];
//		[self.navigationController pushViewController:mainVC animated:YES];
//		mainVC.managedObjectContext=self.managedObjectContext;
//		[mainVC release];
		
	}
}


#pragma mark setScores
-(IBAction)setStroke1:(id) sender{
	NSLog(@"Setting score for player: %d to 1 for hole: %d", self.currentPlayer, self.currentHole);
	if((self.currentHole>0) && (self.currentPlayer>0)){
		
		//Check for existing score, else add new one
		NSFetchRequest *request = [[NSFetchRequest alloc] init];
		NSEntityDescription *entity = [NSEntityDescription entityForName:@"scores" inManagedObjectContext:managedObjectContext];
		[request setEntity:entity];
		
		NSPredicate *predicate=[NSPredicate predicateWithFormat:@"game=%@ AND player.name=%@ AND hole=%d", self.currentGame, [self.players objectAtIndex:self.currentPlayer-1], self.currentHole];
		[request setPredicate:predicate];
		
		
		NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"displayName" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
		NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
		[request setSortDescriptors:sortDescriptors];
		[sortDescriptor release];
		[sortDescriptors release];
		
		NSFetchedResultsController *scoreSearch=[[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
		scoreSearch.delegate=self;
		NSError *error;
		if (![scoreSearch performFetch:&error]) NSLog(@"Error Fetching: %@", [error localizedDescription]);	
		NSLog(@"fetchPlayers:(fetchResults)Found %i scores in game", [[scoreSearch fetchedObjects] count]);	
		
		if ([[scoreSearch fetchedObjects] count]>0){
			scores *updateScore=[[scoreSearch fetchedObjects] objectAtIndex:0];
			updateScore.score=[NSNumber numberWithInt:1];
			if (![self.managedObjectContext save:&error]) NSLog(@"Error: %@", [error localizedDescription]);
			[scoreSearch release];
			[request release];
		}else{
			player *selectedPlayer;
			for (player *existingPlayer in [self.currentGame playersSet]){
				NSLog(@"Player Name: %@", existingPlayer.name);
				if([existingPlayer.name isEqualToString:[self.players objectAtIndex:self.currentPlayer-1]]){
					NSLog(@"****Selected player Name: %@", existingPlayer.name);
					selectedPlayer=existingPlayer;
					break;
				}
				
			}
			scores *newScore = (scores *)[NSEntityDescription insertNewObjectForEntityForName:@"scores" inManagedObjectContext:managedObjectContext];
			newScore.game=currentGame;
			newScore.hole=[NSNumber numberWithInt:currentHole];
			newScore.score=[NSNumber numberWithInt:1];
			newScore.player=selectedPlayer;
			if (![self.managedObjectContext save:&error]) NSLog(@"Error: %@", [error localizedDescription]);
			[scoreSearch release];
			[request release];
		}
		
		
	}
		self.currentHole=0;
		self.currentPlayer=0;
		self.scoreValuesView.hidden=YES;
	[self.scoreTableView reloadData];
	
}

-(IBAction)setStroke2:(id) sender{
	NSLog(@"Setting score for player: %d to 2 for hole: %d", self.currentPlayer, self.currentHole);
	if((self.currentHole>0) && (self.currentPlayer>0)){
		
		//Check for existing score, else add new one
		NSFetchRequest *request = [[NSFetchRequest alloc] init];
		NSEntityDescription *entity = [NSEntityDescription entityForName:@"scores" inManagedObjectContext:managedObjectContext];
		[request setEntity:entity];
		
		NSPredicate *predicate=[NSPredicate predicateWithFormat:@"game=%@ AND player.name=%@ AND hole=%d", self.currentGame, [self.players objectAtIndex:self.currentPlayer-1], self.currentHole];
		[request setPredicate:predicate];
		
		
		NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"displayName" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
		NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
		[request setSortDescriptors:sortDescriptors];
		[sortDescriptor release];
		[sortDescriptors release];
		
		NSFetchedResultsController *scoreSearch=[[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
		scoreSearch.delegate=self;
		NSError *error;
		if (![scoreSearch performFetch:&error]) NSLog(@"Error Fetching: %@", [error localizedDescription]);	
		NSLog(@"fetchPlayers:(fetchResults)Found %i scores in game", [[scoreSearch fetchedObjects] count]);	
		
		if ([[scoreSearch fetchedObjects] count]>0){
			scores *updateScore=[[scoreSearch fetchedObjects] objectAtIndex:0];
			updateScore.score=[NSNumber numberWithInt:2];
			if (![self.managedObjectContext save:&error]) NSLog(@"Error: %@", [error localizedDescription]);
			[scoreSearch release];
			[request release];
		}else{
			player *selectedPlayer;
			for (player *existingPlayer in [self.currentGame playersSet]){
				NSLog(@"Player Name: %@", existingPlayer.name);
				if([existingPlayer.name isEqualToString:[self.players objectAtIndex:self.currentPlayer-1]]){
					NSLog(@"****Selected player Name: %@", existingPlayer.name);
					selectedPlayer=existingPlayer;
					break;
				}
				
			}
			scores *newScore = (scores *)[NSEntityDescription insertNewObjectForEntityForName:@"scores" inManagedObjectContext:managedObjectContext];
			newScore.game=currentGame;
			newScore.hole=[NSNumber numberWithInt:currentHole];
			newScore.score=[NSNumber numberWithInt:2];
			newScore.player=selectedPlayer;
			if (![self.managedObjectContext save:&error]) NSLog(@"Error: %@", [error localizedDescription]);
			[scoreSearch release];
			[request release];
		}
	}
	self.currentHole=0;
	self.currentPlayer=0;
	self.scoreValuesView.hidden=YES;
	[self.scoreTableView reloadData];	
}

-(IBAction)setStroke3:(id) sender{
	NSLog(@"Setting score for player: %d to 3 for hole: %d", self.currentPlayer, self.currentHole);
	if((self.currentHole>0) && (self.currentPlayer>0)){
		
		//Check for existing score, else add new one
		NSFetchRequest *request = [[NSFetchRequest alloc] init];
		NSEntityDescription *entity = [NSEntityDescription entityForName:@"scores" inManagedObjectContext:managedObjectContext];
		[request setEntity:entity];
		
		NSPredicate *predicate=[NSPredicate predicateWithFormat:@"game=%@ AND player.name=%@ AND hole=%d", self.currentGame, [self.players objectAtIndex:self.currentPlayer-1], self.currentHole];
		[request setPredicate:predicate];
		
		
		NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"displayName" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
		NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
		[request setSortDescriptors:sortDescriptors];
		[sortDescriptor release];
		[sortDescriptors release];
		
		NSFetchedResultsController *scoreSearch=[[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
		scoreSearch.delegate=self;
		NSError *error;
		if (![scoreSearch performFetch:&error]) NSLog(@"Error Fetching: %@", [error localizedDescription]);	
		NSLog(@"fetchPlayers:(fetchResults)Found %i scores in game", [[scoreSearch fetchedObjects] count]);	
		
		if ([[scoreSearch fetchedObjects] count]>0){
			scores *updateScore=[[scoreSearch fetchedObjects] objectAtIndex:0];
			updateScore.score=[NSNumber numberWithInt:3];
			if (![self.managedObjectContext save:&error]) NSLog(@"Error: %@", [error localizedDescription]);
			[scoreSearch release];
			[request release];
		}else{
			player *selectedPlayer;
			for (player *existingPlayer in [self.currentGame playersSet]){
				NSLog(@"Player Name: %@", existingPlayer.name);
				if([existingPlayer.name isEqualToString:[self.players objectAtIndex:self.currentPlayer-1]]){
					NSLog(@"****Selected player Name: %@", existingPlayer.name);
					selectedPlayer=existingPlayer;
					break;
				}
				
			}
			scores *newScore = (scores *)[NSEntityDescription insertNewObjectForEntityForName:@"scores" inManagedObjectContext:managedObjectContext];
			newScore.game=currentGame;
			newScore.hole=[NSNumber numberWithInt:currentHole];
			newScore.score=[NSNumber numberWithInt:3];
			newScore.player=selectedPlayer;
			if (![self.managedObjectContext save:&error]) NSLog(@"Error: %@", [error localizedDescription]);
			[scoreSearch release];
			[request release];
		}
	}
	self.currentHole=0;
	self.currentPlayer=0;
	self.scoreValuesView.hidden=YES;
	[self.scoreTableView reloadData];	
}

-(IBAction)setStroke4:(id) sender{
	NSLog(@"Setting score for player: %d to 4 for hole: %d", self.currentPlayer, self.currentHole);
	if((self.currentHole>0) && (self.currentPlayer>0)){
		
		//Check for existing score, else add new one
		NSFetchRequest *request = [[NSFetchRequest alloc] init];
		NSEntityDescription *entity = [NSEntityDescription entityForName:@"scores" inManagedObjectContext:managedObjectContext];
		[request setEntity:entity];
		
		NSPredicate *predicate=[NSPredicate predicateWithFormat:@"game=%@ AND player.name=%@ AND hole=%d", self.currentGame, [self.players objectAtIndex:self.currentPlayer-1], self.currentHole];
		[request setPredicate:predicate];
		
		
		NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"displayName" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
		NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
		[request setSortDescriptors:sortDescriptors];
		[sortDescriptor release];
		[sortDescriptors release];
		
		NSFetchedResultsController *scoreSearch=[[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
		scoreSearch.delegate=self;
		NSError *error;
		if (![scoreSearch performFetch:&error]) NSLog(@"Error Fetching: %@", [error localizedDescription]);	
		NSLog(@"fetchPlayers:(fetchResults)Found %i scores in game", [[scoreSearch fetchedObjects] count]);	
		
		if ([[scoreSearch fetchedObjects] count]>0){
			scores *updateScore=[[scoreSearch fetchedObjects] objectAtIndex:0];
			updateScore.score=[NSNumber numberWithInt:4];
			if (![self.managedObjectContext save:&error]) NSLog(@"Error: %@", [error localizedDescription]);
			[scoreSearch release];
			[request release];
		}else{
			player *selectedPlayer;
			for (player *existingPlayer in [self.currentGame playersSet]){
				NSLog(@"Player Name: %@", existingPlayer.name);
				if([existingPlayer.name isEqualToString:[self.players objectAtIndex:self.currentPlayer-1]]){
					NSLog(@"****Selected player Name: %@", existingPlayer.name);
					selectedPlayer=existingPlayer;
					break;
				}
				
			}
			scores *newScore = (scores *)[NSEntityDescription insertNewObjectForEntityForName:@"scores" inManagedObjectContext:managedObjectContext];
			newScore.game=currentGame;
			newScore.hole=[NSNumber numberWithInt:currentHole];
			newScore.score=[NSNumber numberWithInt:4];
			newScore.player=selectedPlayer;
			if (![self.managedObjectContext save:&error]) NSLog(@"Error: %@", [error localizedDescription]);
			[scoreSearch release];
			[request release];
		}
	}
	self.currentHole=0;
	self.currentPlayer=0;
	self.scoreValuesView.hidden=YES;
	[self.scoreTableView reloadData];	
}

-(IBAction)setStroke5:(id) sender{
	NSLog(@"Setting score for player: %d to 5 for hole: %d", self.currentPlayer, self.currentHole);
	if((self.currentHole>0) && (self.currentPlayer>0)){
		
		//Check for existing score, else add new one
		NSFetchRequest *request = [[NSFetchRequest alloc] init];
		NSEntityDescription *entity = [NSEntityDescription entityForName:@"scores" inManagedObjectContext:managedObjectContext];
		[request setEntity:entity];
		
		NSPredicate *predicate=[NSPredicate predicateWithFormat:@"game=%@ AND player.name=%@ AND hole=%d", self.currentGame, [self.players objectAtIndex:self.currentPlayer-1], self.currentHole];
		[request setPredicate:predicate];
		
		
		NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"displayName" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
		NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
		[request setSortDescriptors:sortDescriptors];
		[sortDescriptor release];
		[sortDescriptors release];
		
		NSFetchedResultsController *scoreSearch=[[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
		scoreSearch.delegate=self;
		NSError *error;
		if (![scoreSearch performFetch:&error]) NSLog(@"Error Fetching: %@", [error localizedDescription]);	
		NSLog(@"fetchPlayers:(fetchResults)Found %i scores in game", [[scoreSearch fetchedObjects] count]);	
		
		if ([[scoreSearch fetchedObjects] count]>0){
			scores *updateScore=[[scoreSearch fetchedObjects] objectAtIndex:0];
			updateScore.score=[NSNumber numberWithInt:5];
			if (![self.managedObjectContext save:&error]) NSLog(@"Error: %@", [error localizedDescription]);
			[scoreSearch release];
			[request release];
		}else{
			player *selectedPlayer;
			for (player *existingPlayer in [self.currentGame playersSet]){
				NSLog(@"Player Name: %@", existingPlayer.name);
				if([existingPlayer.name isEqualToString:[self.players objectAtIndex:self.currentPlayer-1]]){
					NSLog(@"****Selected player Name: %@", existingPlayer.name);
					selectedPlayer=existingPlayer;
					break;
				}
				
			}
			scores *newScore = (scores *)[NSEntityDescription insertNewObjectForEntityForName:@"scores" inManagedObjectContext:managedObjectContext];
			newScore.game=currentGame;
			newScore.hole=[NSNumber numberWithInt:currentHole];
			newScore.score=[NSNumber numberWithInt:5];
			newScore.player=selectedPlayer;
			if (![self.managedObjectContext save:&error]) NSLog(@"Error: %@", [error localizedDescription]);
			[scoreSearch release];
			[request release];
		}
	}
	self.currentHole=0;
	self.currentPlayer=0;
	self.scoreValuesView.hidden=YES;
	[self.scoreTableView reloadData];	
}

-(IBAction)setStroke6:(id) sender{
	NSLog(@"Setting score for player: %d to 6 for hole: %d", self.currentPlayer, self.currentHole);
	if((self.currentHole>0) && (self.currentPlayer>0)){
		
		//Check for existing score, else add new one
		NSFetchRequest *request = [[NSFetchRequest alloc] init];
		NSEntityDescription *entity = [NSEntityDescription entityForName:@"scores" inManagedObjectContext:managedObjectContext];
		[request setEntity:entity];
		
		NSPredicate *predicate=[NSPredicate predicateWithFormat:@"game=%@ AND player.name=%@ AND hole=%d", self.currentGame, [self.players objectAtIndex:self.currentPlayer-1], self.currentHole];
		[request setPredicate:predicate];
		
		
		NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"displayName" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
		NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
		[request setSortDescriptors:sortDescriptors];
		[sortDescriptor release];
		[sortDescriptors release];
		
		NSFetchedResultsController *scoreSearch=[[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
		scoreSearch.delegate=self;
		NSError *error;
		if (![scoreSearch performFetch:&error]) NSLog(@"Error Fetching: %@", [error localizedDescription]);	
		NSLog(@"fetchPlayers:(fetchResults)Found %i scores in game", [[scoreSearch fetchedObjects] count]);	
		
		if ([[scoreSearch fetchedObjects] count]>0){
			scores *updateScore=[[scoreSearch fetchedObjects] objectAtIndex:0];
			updateScore.score=[NSNumber numberWithInt:6];
			if (![self.managedObjectContext save:&error]) NSLog(@"Error: %@", [error localizedDescription]);
			[scoreSearch release];
			[request release];
		}else{
			player *selectedPlayer;
			for (player *existingPlayer in [self.currentGame playersSet]){
				NSLog(@"Player Name: %@", existingPlayer.name);
				if([existingPlayer.name isEqualToString:[self.players objectAtIndex:self.currentPlayer-1]]){
					NSLog(@"****Selected player Name: %@", existingPlayer.name);
					selectedPlayer=existingPlayer;
					break;
				}
				
			}
			scores *newScore = (scores *)[NSEntityDescription insertNewObjectForEntityForName:@"scores" inManagedObjectContext:managedObjectContext];
			newScore.game=currentGame;
			newScore.hole=[NSNumber numberWithInt:currentHole];
			newScore.score=[NSNumber numberWithInt:6];
			newScore.player=selectedPlayer;
			if (![self.managedObjectContext save:&error]) NSLog(@"Error: %@", [error localizedDescription]);
			[scoreSearch release];
			[request release];
		}
	}
	self.currentHole=0;
	self.currentPlayer=0;
	self.scoreValuesView.hidden=YES;
	[self.scoreTableView reloadData];	
}

-(IBAction)setStrokeCancel:(id) sender{
	self.currentHole=0;
	self.currentPlayer=0;
	self.scoreValuesView.hidden=YES;
	[self.scoreTableView reloadData];	
	
}

#pragma mark scores
-(IBAction)changeScorePlayer1:(id) sender{
	UIView *callingRow=(UIView *) [sender superview];
	NSLog(@"Calling Row: %d", callingRow.tag);
	self.currentHole=callingRow.tag+1;
	switch (currentPage) {
		case 1:
			self.currentPlayer=1;
			break;
		case 2:
			self.currentPlayer=5;
			break;
		default:
			break;
	}
	

	self.scoreValuesView.hidden=NO;
}
	
-(IBAction)changeScorePlayer2:(id) sender{
	UIView *callingRow=(UIView *) [sender superview];
	NSLog(@"Calling Row: %d", callingRow.tag);
	self.currentHole=callingRow.tag+1;
	switch (currentPage) {
		case 1:
			self.currentPlayer=2;
			break;
		case 2:
			self.currentPlayer=6;
			break;
		default:
			break;
	}
	self.scoreValuesView.hidden=NO;
}

-(IBAction)changeScorePlayer3:(id) sender{
	UIView *callingRow=(UIView *) [sender superview];
	NSLog(@"Calling Row: %d", callingRow.tag);
	self.currentHole=callingRow.tag+1;
	switch (currentPage) {
		case 1:
			self.currentPlayer=3;
			break;
		case 2:
			self.currentPlayer=7;
			break;
		default:
			break;
	}
	self.scoreValuesView.hidden=NO;
}
-(IBAction)changeScorePlayer4:(id) sender{
	UIView *callingRow=(UIView *) [sender superview];
	NSLog(@"Calling Row: %d", callingRow.tag);
	self.currentHole=callingRow.tag+1;
	switch (currentPage) {
		case 1:
			self.currentPlayer=4;
			break;
		case 2:
			self.currentPlayer=8;
			break;
		default:
			break;
	}
	self.scoreValuesView.hidden=NO;
}

/*
-(void)setScoreForPlayer:(NSInteger)player forHole:(NSInteger)hole setScore:(NSInteger)score{
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"scores" inManagedObjectContext:managedObjectContext];
	[request setEntity:entity];
	
	NSPredicate *predicate=[NSPredicate predicateWithFormat:@"game=%@ AND player=%@ AND hole=%d", self.currentGame, player, hole];
	[request setPredicate:predicate];
	
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"displayName" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];
	[sortDescriptor release];
	[sortDescriptors release];
	
	NSFetchedResultsController *fetchedScoresController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
	
	NSError *error;
	if (![ fetchedScoresController performFetch:&error]) NSLog(@"Error Fetching: %@", [error localizedDescription]);	
	NSLog(@"fetchPlayers:(fetchResults)Found %i players in game", [[fetchedResultsController fetchedObjects] count]);	
	[request release];
	
}
*/

@end
