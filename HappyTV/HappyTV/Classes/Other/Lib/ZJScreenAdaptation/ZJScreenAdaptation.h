//
//  ZJScreenAdaptation.h
//  ScreenAdaptationPage
//
//  Created by mac on 15/4/29.
//  Copyright (c) 2015年 zhang jian. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#define CGRectMakeEx(x,y,width,height) CGRectMakeAdaptation(x, y, width, height)
#define CGSizeMakeEx(width,height) CGSizeMakeAdaptation(width, height)
#define widthEx(width) heightAdaptation(width)
#define heightEx(height) heightAdaptation(height)

@interface ZJScreenAdaptation : NSObject
//扩展函数适配Rect
CGRect CGRectMakeAdaptation(CGFloat x, CGFloat y, CGFloat width, CGFloat height);
//扩展适应Size
CGSize CGSizeMakeAdaptation(CGFloat width, CGFloat height);
//适配高度
double heightAdaptation(double height);
//适配宽度
double widthAdaptation(double width);
@end
