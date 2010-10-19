// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to scores.h instead.

#import <CoreData/CoreData.h>


@class game;
@class player;





@interface scoresID : NSManagedObjectID {}
@end

@interface _scores : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (scoresID*)objectID;



@property (nonatomic, retain) NSNumber *score;

@property short scoreValue;
- (short)scoreValue;
- (void)setScoreValue:(short)value_;

//- (BOOL)validateScore:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *displayName;

//- (BOOL)validateDisplayName:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *hole;

@property short holeValue;
- (short)holeValue;
- (void)setHoleValue:(short)value_;

//- (BOOL)validateHole:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) game* game;
//- (BOOL)validateGame:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) player* player;
//- (BOOL)validatePlayer:(id*)value_ error:(NSError**)error_;



@end

@interface _scores (CoreDataGeneratedAccessors)

@end

@interface _scores (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveScore;
- (void)setPrimitiveScore:(NSNumber*)value;

- (short)primitiveScoreValue;
- (void)setPrimitiveScoreValue:(short)value_;


- (NSString*)primitiveDisplayName;
- (void)setPrimitiveDisplayName:(NSString*)value;


- (NSNumber*)primitiveHole;
- (void)setPrimitiveHole:(NSNumber*)value;

- (short)primitiveHoleValue;
- (void)setPrimitiveHoleValue:(short)value_;




- (game*)primitiveGame;
- (void)setPrimitiveGame:(game*)value;



- (player*)primitivePlayer;
- (void)setPrimitivePlayer:(player*)value;


@end
