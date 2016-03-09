//
//  UITabBarController+Quick.m
//  HappyTV
//
//  Created by allenariel on 15/4/30.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import "UITabBarController+Quick.h"
#import "RootViewController.h"

@implementation UITabBarController (Quick)
-(RootViewController *)addVC:(Class)class title:(NSString *)title image:(NSString *)image
{
    //class 传入界面所对应的类
    RootViewController *vc=[[class alloc]init];
    UINavigationController *nc=[[UINavigationController alloc]initWithRootViewController:vc];
    nc.tabBarItem.image=[UIImage imageNamed:image];
    vc.bartitle=title;
    //添加到标签栏
    NSMutableArray *marr=[[NSMutableArray alloc]initWithArray:self.viewControllers];
    [marr addObject:nc];
    self.viewControllers=marr;
    
    return vc;
}
@end
