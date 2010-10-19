// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to scores.m instead.

#import "_scores.h"

@implementation scoresID
@end

@implementation _scores

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"scores" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"scores";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"scores" inManagedObjectContext:moc_];
}

- (scoresID*)objectID {
	return (scoresID*)[super objectID];
}




@dynamic score;



- (short)scoreValue {
	NSNumber *result = [self score];
	return [result shortValue];
}

- (void)setScoreValue:(short)value_ {
	[self setScore:[NSNumber numberWithShort:value_]];
}

- (short)primitiveScoreValue {
	NSNumber *result = [self primitiveScore];
	return [result shortValue];
}

- (void)setPrimitiveScoreValue:(short)value_ {
	[self setPrimitiveScore:[NSNumber numberWithShort:value_]];
}





@dynamic displayName;






@dynamic hole;



- (short)holeValue {
	NSNumber *result = [self hole];
	return [result shortValue];
}

- (void)setHoleValue:(short)value_ {
	[self setHole:[NSNumber numberWithShort:value_]];
}

- (short)primitiveHoleValue {
	NSNumber *result = [self primitiveHole];
	return [result shortValue];
}

- (void)setPrimitiveHoleValue:(short)value_ {
	[self setPrimitiveHole:[NSNumber numberWithShort:value_]];
}





@dynamic game;

	

@dynamic player;

	



@end
