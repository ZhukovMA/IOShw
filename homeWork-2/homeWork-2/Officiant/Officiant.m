
#import "Officiant.h"



@implementation Officiant

- (instancetype)init
{
    self = [super init];
    return self;
}

- (void)start {
    [self.delegate goToTheKichen];
    [self.delegate orderFood];
    [self.delegate sayStartCooking];
    [self.delegate bringFoodToTheTable];
    NSLog(@"%@, cook", [self.delegate thank]);
}

@end
