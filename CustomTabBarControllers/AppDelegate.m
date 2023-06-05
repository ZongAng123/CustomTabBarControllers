//
//  AppDelegate.m
//  CustomTabBarControllers
//
//  Created by 纵昂 on 2023/6/5.
//

#import "AppDelegate.h"
#import "ZATabbarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor =[UIColor whiteColor];
    self.window.rootViewController = [[ZATabbarController alloc]init];
    [self.window makeKeyAndVisible];
    
    return YES;
}




@end
