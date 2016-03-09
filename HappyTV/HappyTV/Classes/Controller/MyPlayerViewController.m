//
//  MyPlayerViewController.m
//  HappyTV
//
//  Created by allenariel on 15/5/14.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import "MyPlayerViewController.h"

@interface MyPlayerViewController ()
{
    UIView *topView;
}
@end

@implementation MyPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置应用程序的状态栏到指定的方向
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
    //view旋转
    [self.view setTransform:CGAffineTransformMakeRotation(M_PI/2)];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
}
@end
