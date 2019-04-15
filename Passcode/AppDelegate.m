//
//  AppDelegate.m
//  Passcode
//
//  Created by hileo on 3/25/19.
//  Copyright © 2019 hileo. All rights reserved.
//

#import "AppDelegate.h"
#import "PasscodeViewController.h"
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface AppDelegate ()
@property (nonatomic, assign) BOOL isAllNewLaunch;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"全新进入");
    self.isAllNewLaunch = YES;
    // Override point for customization after application launch.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showPasscodeNotification:)
                                                 name:@"showPasscodeNotification"
                                               object:nil];
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.15 /*延迟执行时间*/ * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *passcode = [userDefaults objectForKey:@"passcode"];
        if (passcode.length > 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showPasscodeNotification" object:@"passcodeVerify"];
        }
    });
    return YES;
}



- (void)showPasscodeNotification:(NSNotification*)nObject
{
    PasscodeViewController* viewController = [[PasscodeViewController alloc] init];
    viewController.passcodeType = (NSString*)[nObject object];
    UIViewController *topVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    [topVC presentViewController:viewController
                        animated:NO
                      completion:^{
                          NSLog(@"分享完成");
                      }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"即将退出");
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"已退出");
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *passcode = [userDefaults objectForKey:@"passcode"];
    if (passcode.length > 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"showPasscodeNotification" object:@"passcodeVerify"];
    }
    
    //广告
    NSDate *nowDate = [NSDate date];
    [[NSUserDefaults standardUserDefaults] setObject:nowDate forKey:@"adOldDate"];
    self.isAllNewLaunch = NO;
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"即将进入");
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"showPasscodeNotification" object:@"passcodeVerify"];
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"已经进入");
    //广告
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"adOldDate"] != NULL) {
        //Get
        NSDate *oldDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"adOldDate"];
        NSDate *nowDate = [NSDate date];
        NSTimeInterval differenceTime = [nowDate timeIntervalSinceDate:oldDate];
        if (differenceTime > 15) {
            NSLog(@"广告");
        }else if(self.isAllNewLaunch){
            NSLog(@"每次全新进入启动广告");
        }
    }
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"fffwww");
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
