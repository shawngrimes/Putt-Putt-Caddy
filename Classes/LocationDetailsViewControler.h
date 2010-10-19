//
//  LocationDetailsViewControler.h
//  Caddy
//
//  Created by shawn on 10/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "PhoneBookResult.h"
#import "AddNewCourseViewController.h"
#import "CourseDetailsViewController.h"
#import "LocationMapViewController.h"

@interface LocationDetailsViewControler : UIViewController <UITableViewDelegate> {

	IBOutlet UILabel *locationNameLabel;
	IBOutlet UILabel *locationAddressLabel;
	IBOutlet UITableView *tableView;
	PhoneBookResult *pbResult;
	NSManagedObjectContext *managedObjectContext;
	
	NSMutableArray *tableArray;
	
}

@property (nonatomic, retain) 	NSMutableArray *tableArray;
@property (nonatomic, retain) 	IBOutlet UILabel *locationNameLabel;
@property (nonatomic, retain) 	IBOutlet UILabel *locationAddressLabel;
@property (nonatomic, retain) 	IBOutlet UITableView *tableView;
@property (nonatomic, retain) 	PhoneBookResult *pbResult;
@property (nonatomic, retain) 	NSManagedObjectContext *managedObjectContext;

-(void) fetchCourses;

@end
