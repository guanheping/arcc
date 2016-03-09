//
//  MyTabViewController.m
//  HappyTV
//
//  Created by allenariel on 15/4/30.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import "MyTabViewController.h"
#include "UIView+LCView.h"
#include "LCButton.h"

@interface MyTabViewController ()
{
    NSArray *highPhoto;
    
}
@property(nonatomic,strong)NSMutableArray *selectedBtn;
@end

@implementation MyTabViewController
-(NSMutableArray *)selectedBtn
{
    if (_selectedBtn==nil) {
        _selectedBtn=[NSMutableArray array];
    }
    return _selectedBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.tabBar.hidden=YES;
    [self createTab];
}

-(void)createTab
{
    CGSize size=[UIScreen mainScreen].bounds.size;
    _tabView=[[UIView alloc]initWithFrame:CGRectMake(0, size.height-50, size.width, 50)];
    _tabView.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [self.view addSubview:_tabView];
    
    NSArray *titleArr=@[@"推荐",@"频道",@"专题",@"排行榜"];
    NSArray *pohoto=@[@"recommend_normal@2x.png",@"channel_normal@2x.png",@"topic_normal@2x.png",@"rank_normal@2x.png"];
    highPhoto=@[@"recommend_highlight@2x.png",@"channel_highlight@2x.png",@"topic_highlight@2x.png",@"rank_highlight@2x.png"];
    float plus;
    if (size.width==375) {
        plus=12;
    }
    else if (size.width==414)
        plus=15;
    else
        plus=0;
    
    for (int i=0; i<4; i++) {
        LCButton *reBtn=[LCButton buttonWithType:UIButtonTypeCustom];
        reBtn.tag=100+i;
        [reBtn addTarget:self action:@selector(barClick:) forControlEvents:UIControlEventTouchUpInside];
        reBtn.frame=CGRectMakeEx(plus+80*i, 0, 60, 50);
        reBtn.titleLabel.font=[UIFont systemFontOfSize:14];
        reBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
        [reBtn setImage:[UIImage imageNamed:pohoto[i]] forState:UIControlStateNormal];
        [reBtn setImage:[UIImage imageNamed:highPhoto[i]] forState:UIControlStateSelected];
        [reBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [reBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [reBtn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        //判断手机
        //414   375
        CGSize size=[UIScreen mainScreen].bounds.size;
        float a;
        if (size.width==414) {
            a=10;
        }
        else if (size.width==375)
        {
            a=5;
        }
        else
            a=0;
        
        CGFloat x1=heightEx(-15);
        CGFloat x2=widthEx(10);
        CGFloat x3=heightEx(25);
        CGFloat x4=widthEx(-40);
        [reBtn setImageEdgeInsets:UIEdgeInsetsMake(x1, x2, 0, 0)];
        [reBtn setTitleEdgeInsets:UIEdgeInsetsMake(x3-a, x4, 0, 0)];
        [_tabView addSubview:reBtn];
        if (i==0) {
            [self.selectedBtn setArray:@[reBtn]];
            reBtn.selected=YES;
        }
    }
}

-(void)barClick:(LCButton *)btn
{
    LCButton *bb=self.selectedBtn[0];
    bb.selected=NO;
    
    self.selectedIndex=btn.tag-100;
    btn.selected=YES;
    [self.selectedBtn setArray:@[btn]];
    
}
- (BOOL)shouldAutorotate{
    return NO;
}

//返回最上层的子Controller的supportedInterfaceOrientations
- (NSUInteger)supportedInterfaceOrientations{
    return self.navigationController.topViewController.supportedInterfaceOrientations;
}

@end
