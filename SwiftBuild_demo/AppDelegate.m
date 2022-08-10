//
//  AppDelegate.m
//  SwiftBuild_demo
//
//  Created by zhangzhenwei on 2022/7/14.
//

#import "AppDelegate.h"
#import "HomeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window.backgroundColor = [UIColor clearColor];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[HomeViewController new]];
    self.window.rootViewController = nav;
    [self.window makeKeyWindow];
    // Override point for customization after application launch.
    return YES;
}


@end
