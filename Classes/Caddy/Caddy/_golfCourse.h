// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to golfCourse.h instead.

#import <CoreData/CoreData.h>












@interface golfCourseID : NSManagedObjectID {}
@end

@interface _golfCourse : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (golfCourseID*)objectID;



@property (nonatomic, retain) NSString *uniqueID;

//- (BOOL)validateUniqueID:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *par;

@property short parValue;
- (short)parValue;
- (void)setParValue:(short)value_;

//- (BOOL)validatePar:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *numHoles;

@property short numHolesValue;
- (short)numHolesValue;
- (void)setNumHolesValue:(short)value_;

//- (BOOL)validateNumHoles:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *longitude;

@property double longitudeValue;
- (double)longitudeValue;
- (void)setLongitudeValue:(double)value_;

//- (BOOL)validateLongitude:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSData *location;

//- (BOOL)validateLocation:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *creationDate;

//- (BOOL)validateCreationDate:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *latitude;

@property double latitudeValue;
- (double)latitudeValue;
- (void)setLatitudeValue:(double)value_;

//- (BOOL)validateLatitude:(id*)value_ error:(NSError**)error_;




@end

@interface _golfCourse (CoreDataGeneratedAccessors)

@end

@interface _golfCourse (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveUniqueID;
- (void)setPrimitiveUniqueID:(NSString*)value;


- (NSNumber*)primitivePar;
- (void)setPrimitivePar:(NSNumber*)value;

- (short)primitiveParValue;
- (void)setPrimitiveParValue:(short)value_;


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;


- (NSNumber*)primitiveNumHoles;
- (void)setPrimitiveNumHoles:(NSNumber*)value;

- (short)primitiveNumHolesValue;
- (void)setPrimitiveNumHolesValue:(short)value_;


- (NSNumber*)primitiveLongitude;
- (void)setPrimitiveLongitude:(NSNumber*)value;

- (double)primitiveLongitudeValue;
- (void)setPrimitiveLongitudeValue:(double)value_;


- (NSData*)primitiveLocation;
- (void)setPrimitiveLocation:(NSData*)value;


- (NSDate*)primitiveCreationDate;
- (void)setPrimitiveCreationDate:(NSDate*)value;


- (NSNumber*)primitiveLatitude;
- (void)setPrimitiveLatitude:(NSNumber*)value;

- (double)primitiveLatitudeValue;
- (void)setPrimitiveLatitudeValue:(double)value_;



@end
