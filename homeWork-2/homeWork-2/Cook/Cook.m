//
//  Cook.m
//  homeWork-2
//
//  Created by Максим Жуков on 07/10/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

#import "Cook.h"

@interface Cook ()

@property(nonatomic, assign)BOOL isProductsInStock;

@end

@implementation Cook

- (instancetype)init
{
    self = [super init];
    if(self) {
        self.isProductsInStock = YES;
    }
    return self;
}

- (void)startCooking{
    [self prepareFood];
    [self foodIsCooked];
}

- (void)prepareFood {
    NSLog(@"food is preparing");
}

- (void)foodIsCooked {
    if(self.isProductsInStock) {
        NSLog(@"take the food");
    }
}
@end
