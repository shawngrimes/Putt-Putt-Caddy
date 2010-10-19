//
//  AddNewCourseViewController.h
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

@interface AddNewCourseViewController : UIViewController <UIPickerViewDataSource, UITextFieldDelegate> {

	NSManagedObjectContext *managedObjectContext;
	PhoneBookResult *pbResult;
	
	IBOutlet UIPickerView *courseDetailsPicker;
	IBOutlet UILabel *locationName;
	IBOutlet UITextField *courseName;
	IBOutlet UIButton *addPlayersButton;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) 	PhoneBookResult *pbResult;
@property (nonatomic, retain) 	IBOutlet UILabel *locationName;
@property (nonatomic, retain) 	IBOutlet UIPickerView *courseDetailsPicker;
@property (nonatomic, retain) 	IBOutlet UITextField *courseName;
@property (nonatomic, retain) 	IBOutlet UIButton *addPlayersButton;

-(IBAction) editCourseName;
-(IBAction) doneButtonOnKeyboardPressed:(id)sender;
-(IBAction) addPlayers;

@end
