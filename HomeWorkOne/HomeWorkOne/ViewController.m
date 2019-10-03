//
//  ViewController.m
//  HomeWorkOne
//
//  Created by Максим Жуков on 28/09/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    currentArray = [NSMutableArray arrayWithObjects:@(3), @(6), @(32), @(24), @(81), nil];
    //1.1
    [self sortArrayToUP];
    //1.2
    NSArray *moreThan = [NSArray new];
    moreThan = [self moreThanTwenty];
    //1.3
    NSArray *multiplicity =  [self multipleOfThree];
    //1.4
    for(NSNumber * key in multiplicity) {
        [currentArray addObject:key];
    }
    //1.5
    [self sortToDownArray];
    
    
    //2.1
    NSString  *cat = @"cat";
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"cataclism", @"catepillar", @"cat", @"teapot", @"truncate", nil];
    NSPredicate *prdct = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@ ", cat];
    NSArray *beginWithCat = [array filteredArrayUsingPredicate:prdct];
    //2.2
    NSLog(@"%@", beginWithCat);
    //2.3
    NSMutableDictionary *dict = [NSMutableDictionary new];
    for (NSString *str in array) {
        NSNumber *ad = @([str length]);
        [dict setObject:ad forKey:str];
    }
}

- (void)sortArrayToUP {
    NSArray *localArr = [currentArray sortedArrayUsingComparator:^(id val1, id val2) {
        return [val1 compare:val2];
    }];
    for(int i = 0; i < localArr.count; i++) {
        currentArray[i] = localArr[i];
    }
}

- (NSArray *)moreThanTwenty {
    NSMutableArray *moreThan = [NSMutableArray new];
    for(NSNumber *key in currentArray) {
        if([key intValue] > 20) {
            [moreThan addObject:key];
        }
    }
    return moreThan;
}

- (NSArray *)multipleOfThree {
    NSMutableArray *arr = [NSMutableArray new];
    for(NSNumber * key in currentArray) {
        NSInteger local = [key intValue];
        if((local % 3) == 0) {
            [arr addObject:key];
        }
    }
    return arr;
}


- (void)sortToDownArray{
    NSArray *localArr = [currentArray sortedArrayUsingComparator:^(id val1, id val2) {
        return [val2 compare:val1];
    }];
    for(int i = 0; i < localArr.count; i++) {
        currentArray[i] = localArr[i];
    }
}

@end
