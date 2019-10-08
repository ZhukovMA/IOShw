//
//  ViewController.m
//  homeWork-2
//
//  Created by Максим Жуков on 07/10/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

#import "ViewController.h"
#import "Client.h"

@interface ViewController ()
@property(nonatomic, strong)Client *client;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.client = [[Client alloc] init];
    // Do any additional setup after loading the view.
}


@end
