//
//  ViewController.m
//  WECustomTableView
//
//  Created by michael on 2018/11/7.
//  Copyright © 2018年 michael. All rights reserved.
//

#import "ViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "FBChangeEnvironment.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    
    UIButton *oneButton = [UIButton new];
    [oneButton setTitle:@"非继承关系" forState:UIControlStateNormal];
    [oneButton addTarget:self action:@selector(nonInheritanceRelationship) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:oneButton];
    
    UIButton *twoButton = [UIButton new];
    [twoButton setTitle:@"继承关系" forState:UIControlStateNormal];
    [twoButton addTarget:self action:@selector(InheritanceRelationship) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:twoButton];
    
    oneButton.backgroundColor = [UIColor blueColor];
    twoButton.backgroundColor = [UIColor blueColor];
    
    oneButton.frame = CGRectMake(100, 100, 100, 50);
    twoButton.frame = CGRectMake(100, 170, 100, 50);
    
}

- (void)nonInheritanceRelationship {
    
      [[FBChangeEnvironment sharedInstance]changeEnvironment];
//    OneViewController *one = [OneViewController new];
//    one.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:one animated:YES];
}
- (void)InheritanceRelationship {
    
    TwoViewController *two = [TwoViewController new];
    two.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:two animated:YES];
}



@end
