// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to player.h instead.

#import <CoreData/CoreData.h>






@interface playerID : NSManagedObjectID {}
@end

@interface _player : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (playerID*)objectID;



@property (nonatomic, retain) NSString *name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *displayName;

//- (BOOL)validateDisplayName:(id*)value_ error:(NSError**)error_;




@end

@interface _player (CoreDataGeneratedAccessors)

@end

@interface _player (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;


- (NSString*)primitiveDisplayName;
- (void)setPrimitiveDisplayName:(NSString*)value;



@end
