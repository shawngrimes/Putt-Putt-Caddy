//
//  CourseDetailsViewController.h
//  Caddy
//
//  Created by shawn on 10/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "editPlayersView.h"
#import "PhoneBookResult.h"
#import "golfCourse.h"
#import "game.h"

@interface CourseDetailsViewController : UIViewController <UITableViewDelegate> {

	NSManagedObjectContext *managedObjectContext;
	
	IBOutlet UILabel *locationLabel;
	IBOutlet UILabel *courseLabel;
	IBOutlet UILabel *courseStatsLabel;
	IBOutlet UIButton *playHereButton;
	IBOutlet UITableView *leadersTableView;
	
	
	PhoneBookResult *pbResult;
	golfCourse *selectedCourse;
	
	
}

@property (nonatomic, retain) 	IBOutlet UILabel *courseStatsLabel;
@property (nonatomic, retain) 	NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) 	IBOutlet UILabel *locationLabel;
@property (nonatomic, retain) 	IBOutlet UILabel *courseLabel;
@property (nonatomic, retain) 	IBOutlet UIButton *playHereButton;
@property (nonatomic, retain) 	IBOutlet UITableView *leadersTableView;
@property (nonatomic, retain) 	PhoneBookResult *pbResult;
@property (nonatomic, retain) 	golfCourse *selectedCourse;

-(IBAction) addPlayers;

@end
