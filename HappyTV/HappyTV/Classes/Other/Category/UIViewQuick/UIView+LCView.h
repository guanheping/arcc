//
//  UIView+LCView.h
//  团800电影票
//
//  Created by allenariel on 15/4/13.
//  Copyright (c) 2015年 allenariel. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LCButton;
@interface UIView (LCView)
-(UIButton *)addSystemButtonWithFrame:(CGRect)frame
                                title:(NSString *)title
                               action:(void(^)(UIButton *button))action;


-(UIButton *)addImageButtonWithFrame:(CGRect)frame
                               title:(NSString *)title
                               image:(NSString *)image
                              action:(void(^)(UIButton *button))action;

-(UILabel *)addLabelWithFrame:(CGRect)frame
                         text:(NSString *)text;

-(UIImageView *)addImageViewWithFrame:(CGRect)frame
                                image:(NSString *)image;

-(LCButton *)addLCButtonWithFrame:(CGRect)frame
                                title:(NSString *)title
                                image:(NSString *)image
                               action:(void(^)(UIButton *button))action;

@end
