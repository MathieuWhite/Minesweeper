//
//  AppDelegate.m
//  Minesweeper
//
//  Created by Mathieu White on 2014-09-30.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import "AppDelegate.h"
#import "MenuViewController.h"
#import "HowToViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    UIWindow *window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    UINavigationController *navigationController = [[UINavigationController alloc] init];
    MenuViewController *menuViewController = [[MenuViewController alloc] init];
    HowToViewController *howToViewController = [[HowToViewController alloc] init];
    [howToViewController setModalPresentationStyle: UIModalPresentationFullScreen];
    [howToViewController setModalTransitionStyle: UIModalTransitionStyleCoverVertical];
    
    [navigationController pushViewController: menuViewController animated: YES];
    [window setRootViewController: navigationController];
    [window makeKeyAndVisible];
    
    // User Defaults to check first launch
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if (![userDefaults objectForKey: @"kUserDidLaunchAppBefore"])
    {
        NSLog(@"First Launch");
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 *   NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [navigationController presentViewController: howToViewController animated: YES completion: nil];
        });
        [userDefaults setObject: @"YES" forKey: @"kUserDidLaunchAppBefore"];
    }
    [userDefaults synchronize];
    
    [self setWindow: window];
    
    return YES;
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
