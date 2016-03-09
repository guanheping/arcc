//
//  RootTwoViewController.m
//  HappyTV
//
//  Created by allenariel on 15/5/4.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import "RootTwoViewController.h"
#import "MyTabViewController.h"

@interface RootTwoViewController ()

@end

@implementation RootTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBar];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:17],NSFontAttributeName, nil]];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    MyTabViewController *tabVC=(MyTabViewController *)self.tabBarController;
    tabVC.tabView.hidden=YES;

}
-(void)createBar
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 30, 30);
    [btn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"返回@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem *leftBar=[[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem=leftBar;
}

-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
