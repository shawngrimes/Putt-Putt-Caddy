//
//  scoreValueSelectorModalView.h
//  Caddy
//
//  Created by shawn on 8/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol scoreValueSelectorDelegate <NSObject>
-(void)setScoreForPlayer:(NSInteger)player forHole:(NSInteger)hole setScore:(NSInteger)score;
@end

@interface scoreValueSelectorModalView : UIViewController {
	id<scoreValueSelectorDelegate> delegate;
	
	IBOutlet UIButton *scoreValueButton1;
	IBOutlet UIButton *scoreValueButton2;
	IBOutlet UIButton *scoreValueButton3;
	IBOutlet UIButton *scoreValueButton4;
	IBOutlet UIButton *scoreValueButton5;
	IBOutlet UIButton *scoreValueButton6;
	
	NSInteger player;
	NSInteger hole;
	
}
@property (assign) id<scoreValueSelectorDelegate> delegate;

@property (nonatomic, retain) IBOutlet UIButton *scoreValueButton1;
@property (nonatomic, retain) 	IBOutlet UIButton *scoreValueButton2;
@property (nonatomic, retain) 	IBOutlet UIButton *scoreValueButton3;
@property (nonatomic, retain) 	IBOutlet UIButton *scoreValueButton4;
@property (nonatomic, retain) 	IBOutlet UIButton *scoreValueButton5;
@property (nonatomic, retain) 	IBOutlet UIButton *scoreValueButton6;

@property (nonatomic) 	NSInteger player;
@property (nonatomic) NSInteger hole;

@end
