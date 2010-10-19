// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to player.m instead.

#import "_player.h"

@implementation playerID
@end

@implementation _player

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"players" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"players";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"players" inManagedObjectContext:moc_];
}

- (playerID*)objectID {
	return (playerID*)[super objectID];
}




@dynamic name;






@dynamic displayName;








@end
