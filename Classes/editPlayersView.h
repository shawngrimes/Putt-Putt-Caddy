//
//  addPlayersView.h
//  Caddy
//
//  Created by shawn on 8/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import "game.h"
#import "scores.h"
#import "player.h"
#import "golfCourse.h"
#import "scoreView.h"

@interface editPlayersView : UIViewController <UITableViewDelegate, UITextFieldDelegate, NSFetchedResultsControllerDelegate> {
	NSManagedObjectContext *managedObjectContext;
	NSFetchedResultsController *fetchedResultsController;
	game *currentGame;
	golfCourse *selectedCourse;
	
	IBOutlet UITableView *playerList;
	IBOutlet UITableView *playerAutoComplete;
	IBOutlet UIScrollView *AutoCompleteScrollView;
	IBOutlet UITextField *playerName;
	IBOutlet UIBarButtonItem *startGame;
	IBOutlet UIBarButtonItem *editPlayerList;
	
	NSMutableArray *players;
	
	
}

@property (nonatomic, retain) 	golfCourse *selectedCourse;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) 	game *currentGame;

@property (nonatomic, retain) 	IBOutlet UITableView *playerAutoComplete;
@property (nonatomic, retain) IBOutlet UIScrollView *AutoCompleteScrollView;


@property (nonatomic, retain) 	IBOutlet UITableView *playerList;
@property (nonatomic, retain) IBOutlet UITextField *playerName;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *startGame;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *editPlayerList;

@property (nonatomic, retain) NSMutableArray *players;


-(IBAction) nextButtonOnKeyboardPressed:(id)sender;
-(IBAction) startGameButtonPressed:(id)sender;
-(IBAction) editPlayerName;
-(void) fetchPlayers;
-(void) searchForPlayerName;


@end
