//
//  LCButton.h
//  团800电影票
//
//  Created by allenariel on 15/4/13.
//  Copyright (c) 2015年 allenariel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCButton : UIButton


@property(nonatomic,copy) void(^action)(UIButton *button);

@property(nonatomic,assign)BOOL symbol;



@end
