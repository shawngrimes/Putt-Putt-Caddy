#import "player.h"

@implementation player

// Custom logic goes here.
- (NSComparisonResult)comparePlayer:(player *)p{
	return [self.name compare:p.name];	
}

@end
