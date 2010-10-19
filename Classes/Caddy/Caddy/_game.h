// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to game.h instead.

#import <CoreData/CoreData.h>


@class golfCourse;
@class player;
@class scores;



@interface gameID : NSManagedObjectID {}
@end

@interface _game : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (gameID*)objectID;



@property (nonatomic, retain) NSDate *Date;

//- (BOOL)validateDate:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) golfCourse* courseID;
//- (BOOL)validateCourseID:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSSet* players;
- (NSMutableSet*)playersSet;



@property (nonatomic, retain) NSSet* scores;
- (NSMutableSet*)scoresSet;



@end

@interface _game (CoreDataGeneratedAccessors)

- (void)addPlayers:(NSSet*)value_;
- (void)removePlayers:(NSSet*)value_;
- (void)addPlayersObject:(player*)value_;
- (void)removePlayersObject:(player*)value_;

- (void)addScores:(NSSet*)value_;
- (void)removeScores:(NSSet*)value_;
- (void)addScoresObject:(scores*)value_;
- (void)removeScoresObject:(scores*)value_;

@end

@interface _game (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveDate;
- (void)setPrimitiveDate:(NSDate*)value;




- (golfCourse*)primitiveCourseID;
- (void)setPrimitiveCourseID:(golfCourse*)value;



- (NSMutableSet*)primitivePlayers;
- (void)setPrimitivePlayers:(NSMutableSet*)value;



- (NSMutableSet*)primitiveScores;
- (void)setPrimitiveScores:(NSMutableSet*)value;


@end
