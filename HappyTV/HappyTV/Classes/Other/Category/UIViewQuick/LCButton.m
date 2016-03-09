//
//  LCButton.m
//  团800电影票
//
//  Created by allenariel on 15/4/13.
//  Copyright (c) 2015年 allenariel. All rights reserved.
//

#import "LCButton.h"

@implementation LCButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
-(void)btnClick:(UIButton *)btn
{
    if (self.action) {
        _action(self);
    }
}


@end
