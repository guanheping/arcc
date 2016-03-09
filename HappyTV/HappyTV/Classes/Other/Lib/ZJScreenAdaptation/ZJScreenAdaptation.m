//
//  ZJScreenAdaptation.m
//  ScreenAdaptationPage
//
//  Created by mac on 15/4/29.
//  Copyright (c) 2015年 zhang jian. All rights reserved.
//

#import "ZJScreenAdaptation.h"

@implementation ZJScreenAdaptation
static double autoSizeScaleX;
static double autoSizeScaleY;
//此方法在类加载的时候执行
+ (void)load;
{
    //NSLog(@"ZJScreenAdaptation load");
    
    //获取屏幕大小
    CGSize size = [[UIScreen mainScreen] bounds].size;
    
    //如果是iPhone6,6plus
    if(size.height > 480){
        autoSizeScaleX = size.width/320;
        autoSizeScaleY = size.height/568;
    }
    //如果是iPhone5,5s
    else{
        autoSizeScaleX = 1.0;
        autoSizeScaleY = 1.0;
    }
}
CGRect CGRectMakeAdaptation(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    CGRect rect;
    rect.origin.x = x * autoSizeScaleX;
    rect.origin.y = y * autoSizeScaleY;
    rect.size.width = width * autoSizeScaleX;
    rect.size.height = height * autoSizeScaleY;
    return rect;
}
CGSize CGSizeMakeAdaptation(CGFloat width, CGFloat height)
{
    CGSize size;
    size.width = autoSizeScaleX * width;
    size.height = autoSizeScaleY * height;
    return size;
}
//适配高度
double heightAdaptation(double height)
{
    return height * autoSizeScaleY;
}
//适配宽度
double widthAdaptation(double width)
{
    return width * autoSizeScaleX;
}
@end
