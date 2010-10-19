//
//  reviewPastGames.h
//  Caddy
//
//  Created by shawn on 9/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "game.h"
#import "player.h"
#import "golfCourse.h"

#import "scoreView.h"

@interface reviewPastGames : UITableViewController {
	NSManagedObjectContext *managedObjectContext;
	NSManagedObjectModel *managedObjectModel;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
	
	IBOutlet UITableView *pastGamesTableView;
	
	NSMutableArray *tableData;

}

@property (nonatomic, retain) IBOutlet UITableView *pastGamesTableView;

@property (nonatomic, retain) 	NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) NSMutableArray *tableData;


-(void)fetchGames;
- (NSString *)applicationDocumentsDirectory;

@end
