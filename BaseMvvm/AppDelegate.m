//
//  AppDelegate.m
//  BaseMvvm
//
//  Created by 何锦涛 on 2018/3/8.
//  Copyright © 2018年 hither. All rights reserved.
//

#import "AppDelegate.h"
#import "AppMainTabBarVC.h"
#import "UIImageView+WebCache.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self configApp];
    
    return YES;
}

//项目初始化
-(void)configApp{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[AppMainTabBarVC alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //其他配置写在这里
    [self configSDWebImage];
    [self configNavigationBar];
    
    [self.window makeKeyAndVisible];
}

//配置导航栏
-(void)configNavigationBar{
    // 导航栏中间标题颜色
    UINavigationBar *appearance = [UINavigationBar appearance];
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = RGBCOLOR(51, 51, 51);
    textAttrs[NSFontAttributeName] = [UIFont fontWithName:@"Helvetica" size:18.f];
    [appearance setTitleTextAttributes:textAttrs];
    //设置导航栏颜色
    appearance.barTintColor = [UIColor whiteColor];
    //设置导航栏返回按钮的颜色
    appearance.tintColor = [UIColor whiteColor];
}

-(void)configSDWebImage{
    // 设置最大缓存200M，超出之后自动清除长时间未使用的图片
//    [[SDImageCache sharedImageCache] setMaxCacheSize:209715200];
    //缓存空间的最大成本，超出上限会自动回收对象。
    [[SDImageCache sharedImageCache] setMaxMemoryCost:100];
    //能够缓存对象的最大数值
    [[SDImageCache sharedImageCache] setMaxMemoryCountLimit:100];
    /*
     只会清除一半的缓存  因为if (self.maxCacheSize >0 && currentCacheSize > self.maxCacheSize)
     */
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
