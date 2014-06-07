//
//  AppDelegate.m
//  IBeacon
//
//  Created by Tony on 14-6-2.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import "AppDelegate.h"
#import "YZBMainViewController.h"
#import "YZBMenuViewController.h"
#import "RWTSidebarViewController.h"

@interface AppDelegate ()<YZBMainTapMenuButtonDelegate,YZBMeunViewControllerDelegate>

@property (nonatomic, strong) RWTSidebarViewController *sideBarVC;

@property (nonatomic, strong) YZBMainViewController *mainVC;
@property (nonatomic, strong) YZBMenuViewController *menuVC;

@property (nonatomic, strong) UINavigationController *mainNav;
@property (nonatomic, strong) UINavigationController *menuNav;




@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    /**
     *  主界面
     */
    self.mainVC = [storyboard instantiateViewControllerWithIdentifier:@"mainVC"];
    self.mainVC.delegate = self;
    
    /**
     *  左边菜单界面
     */
    self.menuVC = [storyboard instantiateViewControllerWithIdentifier:@"menuVC"];
    self.menuVC.delegate = self;
    
    self.mainNav = [[UINavigationController alloc] initWithRootViewController:_mainVC];
    self.menuNav = [[UINavigationController alloc] initWithRootViewController:_menuVC];
    
    self.sideBarVC = [[RWTSidebarViewController alloc] initWithLeftViewController:_menuVC mainViewController:_mainVC gap:50];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.sideBarVC;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}



#pragma mark - main delegate

- (void)YZBMainViewDidTapMenuButton:(YZBMainViewController *)controller
{
    [self.sideBarVC toggleMenu];

}


#pragma mark - menu delegate

- (void)menuViewDidTapAbout:(YZBMenuViewController *)controller
{
    

}



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
