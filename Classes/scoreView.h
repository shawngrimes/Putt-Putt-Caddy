//
//  scoreView.h
//  Caddy
//
//  Created by shawn on 8/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "golfCourse.h"
#import "game.h"
#import "scores.h"
#import "scoreValueSelectorModalView.h"
#import "SHK.h"
//#import "mainView.h"
#import "player.h"

@interface scoreView : UIViewController <scoreValueSelectorDelegate,UITableViewDelegate, UITextFieldDelegate, NSFetchedResultsControllerDelegate, UIAlertViewDelegate> {
	NSManagedObjectContext *managedObjectContext;
	NSFetchedResultsController *fetchedResultsController;
	game *currentGame;
	
	NSMutableArray *players;
	
	
	IBOutlet UITableView *scoreTableView;
	
	IBOutlet UITableViewCell *scoreCellView;
	IBOutlet UILabel *holeLabel;
	IBOutlet UILabel *scoreLabel1;
	IBOutlet UILabel *scoreLabel2;
	IBOutlet UILabel *scoreLabel3;
	IBOutlet UILabel *scoreLabel4;
	IBOutlet UIButton *scoreButton1;
	IBOutlet UIButton *scoreButton2;
	IBOutlet UIButton *scoreButton3;
	IBOutlet UIButton *scoreButton4;
	
	IBOutlet UIView *scoreValuesView;
	IBOutlet UIButton *scoreValueButton1;
	IBOutlet UIButton *scoreValueButton2;
	IBOutlet UIButton *scoreValueButton3;
	IBOutlet UIButton *scoreValueButton4;
	IBOutlet UIButton *scoreValueButton5;
	IBOutlet UIButton *scoreValueButton6;
	IBOutlet UIButton *scoreValueButtonCancel;
	
	
	IBOutlet UILabel *playerLabel1;
	IBOutlet UILabel *playerLabel2;
	IBOutlet UILabel *playerLabel3;
	IBOutlet UILabel *playerLabel4;
	NSArray *playerLabels;
	
	NSInteger currentHole;
	NSInteger currentPlayer;
	
	
	IBOutlet UIToolbar *morePlayersToolBar;
	IBOutlet UIBarButtonItem *morePlayersButtonBarItem;
	IBOutlet UIBarButtonItem *prevPlayersButtonBarItem;
	IBOutlet UIBarButtonItem *finishGameButtonBarItem;
	
	NSInteger currentPage;
	
	BOOL readOnly;
	
}

@property (nonatomic) 	BOOL readOnly;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) game *currentGame;
@property (nonatomic, retain) NSMutableArray *players;

@property (nonatomic, retain) 	IBOutlet UITableView *scoreTableView;
@property (nonatomic, retain) 	IBOutlet UIScrollView *scoreScrollView;

@property (nonatomic, retain) IBOutlet UITableViewCell *scoreCellView;
@property (nonatomic, retain) 	IBOutlet UILabel *holeLabel;
@property (nonatomic, retain) 	IBOutlet UILabel *scoreLabel1;
@property (nonatomic, retain) 	IBOutlet UILabel *scoreLabel2;
@property (nonatomic, retain) 	IBOutlet UILabel *scoreLabel3;
@property (nonatomic, retain) 	IBOutlet UILabel *scoreLabel4;
@property (nonatomic, retain) 	IBOutlet UIButton *scoreButton1;
@property (nonatomic, retain) 	IBOutlet UIButton *scoreButton2;
@property (nonatomic, retain) 	IBOutlet UIButton *scoreButton3;
@property (nonatomic, retain) 	IBOutlet UIButton *scoreButton4;

@property (nonatomic, retain) IBOutlet UILabel *playerLabel1;
@property (nonatomic, retain) 	IBOutlet UILabel *playerLabel2;
@property (nonatomic, retain) 	IBOutlet UILabel *playerLabel3;
@property (nonatomic, retain) 	IBOutlet UILabel *playerLabel4;
@property (nonatomic, retain) NSArray *playerLabels;

@property (nonatomic, retain) 	IBOutlet UIView *scoreValuesView;
@property (nonatomic, retain) IBOutlet UIButton *scoreValueButton1;
@property (nonatomic, retain) 	IBOutlet UIButton *scoreValueButton2;
@property (nonatomic, retain) 	IBOutlet UIButton *scoreValueButton3;
@property (nonatomic, retain) 	IBOutlet UIButton *scoreValueButton4;
@property (nonatomic, retain) 	IBOutlet UIButton *scoreValueButton5;
@property (nonatomic, retain) 	IBOutlet UIButton *scoreValueButton6;
@property (nonatomic, retain) 	IBOutlet UIButton *scoreValueButtonCancel;

@property (nonatomic) NSInteger currentHole;
@property (nonatomic) NSInteger currentPlayer;

@property (nonatomic, retain) IBOutlet UIToolbar *morePlayersToolBar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *morePlayersButtonBarItem;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *prevPlayersButtonBarItem;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *finishGameButtonBarItem;

@property (nonatomic) 	NSInteger currentPage;


-(IBAction)changeScorePlayer1:(id) sender;
-(IBAction)changeScorePlayer2:(id) sender;
-(IBAction)changeScorePlayer3:(id) sender;
-(IBAction)changeScorePlayer4:(id) sender;

-(IBAction)setStroke1:(id) sender;
-(IBAction)setStroke2:(id) sender;
-(IBAction)setStroke3:(id) sender;
-(IBAction)setStroke4:(id) sender;
-(IBAction)setStroke5:(id) sender;
-(IBAction)setStroke6:(id) sender;
-(IBAction)setStrokeCancel:(id) sender;

-(IBAction)nextPlayersPage:(id) sender;
-(IBAction)prevPlayersPage:(id) sender;
-(IBAction)shareResults:(id) sender;

-(void)fetchPlayers;
-(void)finishGame;
-(void)finishGameAlert;

@end
