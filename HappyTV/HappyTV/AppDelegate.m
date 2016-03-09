//
//  AppDelegate.m
//  HappyTV
//
//  Created by allenariel on 15/4/30.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import "AppDelegate.h"
#import "UITabBarController+Quick.h"
#import "MyTabViewController.h"
#import "RecommendViewController.h"
#import "ChannelViewController.h"
#import "TopicViewController.h"
#import "ChartsViewController.h"
#import "MoreViewController.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    MyTabViewController *tab=[[MyTabViewController alloc]init];
    [tab addVC:[RecommendViewController class] title:@"开心影视" image:@"首页-频道_12.png"];
    [tab addVC:[ChannelViewController class] title:@"频道" image:@"channel_normal@2x.png"];
    [tab addVC:[TopicViewController class] title:@"专题" image:@"topic_normal@2x.png"];
    [tab addVC:[ChartsViewController class] title:@"排行榜" image:@"rank_normal@2x.png"];
//    [tab addVC:[MoreViewController class] title:@"更多" image:@"more_normal@2x.png"];

    self.window.rootViewController=tab;
    self.window.backgroundColor=[UIColor whiteColor];
    [self configUMShare];
    
    return YES;
}
-(void)configUMShare
{
    //支持新浪微博 短信 邮件
    [UMSocialData setAppKey:@"554b62fb67e58e73bd0029d9"];
    //wx56380efb4f772db4 5cef1937fbab0e64d266a5968469764d
    [UMSocialWechatHandler setWXAppId:@"wx56380efb4f772db4" appSecret:@"5cef1937fbab0e64d266a5968469764d" url:@"itms-apps://itunes.apple.com/"];
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"itms-apps://itunes.apple.com/"];
}
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
