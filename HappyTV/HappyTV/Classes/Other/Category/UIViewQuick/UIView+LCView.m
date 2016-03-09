//
//  UIView+LCView.m
//  团800电影票
//
//  Created by allenariel on 15/4/13.
//  Copyright (c) 2015年 allenariel. All rights reserved.
//

#import "UIView+LCView.h"
#import "LCButton.h"

@implementation UIView (LCView)
-(UIButton *)addSystemButtonWithFrame:(CGRect)frame
                                title:(NSString *)title
                               action:(void(^)(UIButton *button))action
{
    LCButton *btn=[LCButton buttonWithType:UIButtonTypeCustom];
    btn.frame=frame;
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.action=action;
    [self addSubview:btn];
    return btn;
}
-(UIButton *)addImageButtonWithFrame:(CGRect)frame
                               title:(NSString *)title
                               image:(NSString *)image
                              action:(void(^)(UIButton *button))action
{
    LCButton *btn=[LCButton buttonWithType:UIButtonTypeCustom];
    btn.frame=frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    btn.action=action;
    [self addSubview:btn];
    return btn;
}

-(LCButton *)addLCButtonWithFrame:(CGRect)frame
                            title:(NSString *)title
                            image:(NSString *)image
                           action:(void(^)(UIButton *button))action
{
    LCButton *btn=[LCButton buttonWithType:UIButtonTypeCustom];
    btn.frame=frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    btn.action=action;
    [self addSubview:btn];
    return btn;

}

-(UILabel *)addLabelWithFrame:(CGRect)frame
                         text:(NSString *)text
{
    UILabel *labe=[[UILabel alloc]init];
    labe.frame=frame;
    labe.text=text;
    [self addSubview:labe];
    return labe;
}
-(UIImageView *)addImageViewWithFrame:(CGRect)frame
                                image:(NSString *)image
{
    UIImageView *imageView=[[UIImageView alloc]init];
    imageView.frame=frame;
    imageView.userInteractionEnabled=YES;
    imageView.image=[UIImage imageNamed:image];
    [self addSubview:imageView];
    return imageView;
}
@end
