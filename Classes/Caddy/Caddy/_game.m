// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to game.m instead.

#import "_game.h"

@implementation gameID
@end

@implementation _game

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"games" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"games";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"games" inManagedObjectContext:moc_];
}

- (gameID*)objectID {
	return (gameID*)[super objectID];
}




@dynamic Date;






@dynamic courseID;

	

@dynamic players;

	
- (NSMutableSet*)playersSet {
	[self willAccessValueForKey:@"players"];
	NSMutableSet *result = [self mutableSetValueForKey:@"players"];
	[self didAccessValueForKey:@"players"];
	return result;
}
	

@dynamic scores;

	
- (NSMutableSet*)scoresSet {
	[self willAccessValueForKey:@"scores"];
	NSMutableSet *result = [self mutableSetValueForKey:@"scores"];
	[self didAccessValueForKey:@"scores"];
	return result;
}
	



@end
