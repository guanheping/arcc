//
//  UITabBarController+Quick.h
//  HappyTV
//
//  Created by allenariel on 15/4/30.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RootViewController;
@interface UITabBarController (Quick)
-(RootViewController *)addVC:(Class)class title:(NSString *)title image:(NSString *)image;

@end
