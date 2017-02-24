//
//  ViewController.m
//  KSMoneyLoding
//
//  Created by 康帅 on 17/2/23.
//  Copyright © 2017年 Bujiaxinxi. All rights reserved.
//

#import "ViewController.h"
#import "KSMoneyLoding.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *back=[[UIImageView alloc]initWithFrame:self.view.bounds];
    back.image=[UIImage imageNamed:@"ViewBack.PNG"];
    [self.view addSubview:back];
    
    [KSMoneyLoding showLodingInView:self.view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
