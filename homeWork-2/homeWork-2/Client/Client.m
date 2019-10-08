
#import "Client.h"

@interface Client() <ClientProtocol>
@property(nonatomic, strong)Officiant *officiant;
@end

//В данной задаче у клиента есть методы: заказать еду, идти на кухню(самому), говорить повару - готовь, говорить спасибо и нести еду обратно за стол. Официант может делать тоже самое, поэтому клиент дилегирует ему свои полномочия. Но, в свою очередь, официант и клиент не умеют готовить, поэтому повар не может быть их дилегатом.

@implementation Client

- (instancetype)init{
    self = [super init];
    if (self) {
        self.officiant = [[Officiant alloc] init];
        self.cook = [[Cook alloc]  init];
        self.officiant.delegate = self;
        [self.officiant start];
        NSLog(@"%@, officiant-delegate", [self thank]);
    }
    return self;
}

- (void)orderFood {
    NSLog(@"i'm ordering soup");
}

- (void)goToTheKichen {
    NSLog(@"i'm going to the kitchen");
}

- (void)sayStartCooking {
    [self.cook startCooking];
}

- (NSString *)thank {
    return @"thanks!";
}

- (void)bringFoodToTheTable {
    NSLog(@"bring food to the table");
}



@end
