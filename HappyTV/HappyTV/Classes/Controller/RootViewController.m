//
//  RootViewController.m
//  HappyTV
//
//  Created by allenariel on 15/4/30.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import "RootViewController.h"
#import "MyTabViewController.h"
#import "MyDatabaseQueue.h"
#import "CollectViewController.h"
#import "SearchViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent=NO;

    [self createNav];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    MyTabViewController *tabVC=(MyTabViewController *)self.tabBarController;
    tabVC.tabView.hidden=NO;
    [self.bartitleLabel setHidden:NO];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.bartitleLabel setHidden:YES];
}

-(void)createNav
{
    self.bartitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, 40)];
    _bartitleLabel.textColor=[UIColor blueColor];
    _bartitleLabel.text=self.bartitle;
    _bartitleLabel.font=[UIFont boldSystemFontOfSize:16];
    [self.navigationController.navigationBar addSubview:_bartitleLabel];
    
    NSMutableArray *allItem=[NSMutableArray array];
    NSArray *buphoto=@[@"favor@2x.png",@"history@2x.png",@"main_search@2x.png"];
    NSArray *hiphoto=@[@"favor@2x.png",@"main_history_click@2x.png",@"main_search_click@2x.png"];
    for (int i=0; i<3; i++) {
        UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
        btn1.tag=330+i;;
        btn1.frame=CGRectMake(0, 0, 35, 40);
        [btn1 addTarget:self action:@selector(dealBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 setImage:[UIImage imageNamed:buphoto[2-i]] forState:UIControlStateNormal];
        [btn1 setImage:[UIImage imageNamed:hiphoto[2-i]] forState:UIControlStateHighlighted];
        UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithCustomView:btn1];
        [allItem addObject:bar];
    }
    self.navigationItem.rightBarButtonItems=allItem;
}

-(void)dealBtnClick:(UIButton *)btn
{
    //处理nav点击
    if (btn.tag==331) {
        CollectViewController *vc=[[CollectViewController alloc]init];
        vc.type=RecordTypeHis;
        vc.nameTitle=@"浏览历史";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (btn.tag==330) {
        SearchViewController *svc=[[SearchViewController alloc]init];
        [self.navigationController pushViewController:svc animated:YES];
    }
    if (btn.tag==332) {
        CollectViewController *cvc=[[CollectViewController alloc]init];
        cvc.type=RecordTypeFav;
        cvc.nameTitle=@"收藏夹";
        [self.navigationController pushViewController:cvc animated:YES];

    }
}


-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscapeRight;
}


@end
