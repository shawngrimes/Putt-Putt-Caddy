// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to golfCourse.m instead.

#import "_golfCourse.h"

@implementation golfCourseID
@end

@implementation _golfCourse

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"courses" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"courses";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"courses" inManagedObjectContext:moc_];
}

- (golfCourseID*)objectID {
	return (golfCourseID*)[super objectID];
}




@dynamic uniqueID;






@dynamic par;



- (short)parValue {
	NSNumber *result = [self par];
	return [result shortValue];
}

- (void)setParValue:(short)value_ {
	[self setPar:[NSNumber numberWithShort:value_]];
}

- (short)primitiveParValue {
	NSNumber *result = [self primitivePar];
	return [result shortValue];
}

- (void)setPrimitiveParValue:(short)value_ {
	[self setPrimitivePar:[NSNumber numberWithShort:value_]];
}





@dynamic name;






@dynamic numHoles;



- (short)numHolesValue {
	NSNumber *result = [self numHoles];
	return [result shortValue];
}

- (void)setNumHolesValue:(short)value_ {
	[self setNumHoles:[NSNumber numberWithShort:value_]];
}

- (short)primitiveNumHolesValue {
	NSNumber *result = [self primitiveNumHoles];
	return [result shortValue];
}

- (void)setPrimitiveNumHolesValue:(short)value_ {
	[self setPrimitiveNumHoles:[NSNumber numberWithShort:value_]];
}





@dynamic longitude;



- (double)longitudeValue {
	NSNumber *result = [self longitude];
	return [result doubleValue];
}

- (void)setLongitudeValue:(double)value_ {
	[self setLongitude:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveLongitudeValue {
	NSNumber *result = [self primitiveLongitude];
	return [result doubleValue];
}

- (void)setPrimitiveLongitudeValue:(double)value_ {
	[self setPrimitiveLongitude:[NSNumber numberWithDouble:value_]];
}





@dynamic location;






@dynamic creationDate;






@dynamic latitude;



- (double)latitudeValue {
	NSNumber *result = [self latitude];
	return [result doubleValue];
}

- (void)setLatitudeValue:(double)value_ {
	[self setLatitude:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveLatitudeValue {
	NSNumber *result = [self primitiveLatitude];
	return [result doubleValue];
}

- (void)setPrimitiveLatitudeValue:(double)value_ {
	[self setPrimitiveLatitude:[NSNumber numberWithDouble:value_]];
}







@end
