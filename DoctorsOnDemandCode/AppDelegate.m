//
//  AppDelegate.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 8/7/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "AppDelegate.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <Quickblox/Quickblox.h>
#import <QuickbloxWebRTC/QuickbloxWebRTC.h>
#import "PayPalMobile.h"
#import "SVProgressHUD.h"

#define QB_DEFAULT_ICE_SERVERS 0

const CGFloat kQBRingThickness = 1.f;
const NSTimeInterval kQBAnswerTimeInterval = 60.f;
const NSTimeInterval kQBRTCDisconnectTimeInterval = 30.f;

const NSUInteger kQBApplicationID = 26488;
NSString *const kQBRegisterServiceKey = @"3JPMaCYJ5rgjV2U";
NSString *const kQBRegisterServiceSecret = @"VqQMaAZpdHVLyMX";
NSString *const kQBAccountKey = @"YGS4wJdm2kPyoppK1ELT";
@interface AppDelegate ()

@end

@implementation AppDelegate
//kChatPresenceTimeInterval

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
      
    
    
    
    //PayPal
    
    [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction : @"",
                                                           PayPalEnvironmentSandbox : @"AURFbviSNVYwBiqYtBhgRqUG9Qan0mqv6RLY3NGOQtU_EeJqM-4g6xRWX8Fq_mQcaUE8Hy6zh_PAD3QW"}];
    
   
    
    //
    //AbyWOQfI1dxQqOXV5OzoEhAXBy7B0dsN2BrbPMnuiuiegyYnnsW1C1wctvtMUHfavF2sP4z9iH6lMGC5
    
    //Quickblox preferences
    [QBApplication sharedApplication].applicationId = kQBApplicationID;
    [QBConnection registerServiceKey:kQBRegisterServiceKey];
    [QBConnection registerServiceSecret:kQBRegisterServiceSecret];
    [QBSettings setAccountKey:kQBAccountKey];
    [QBSettings setLogLevel:QBLogLevelDebug];
    
    
    //QuickbloxWebRTC preferences
    [QBRTCConfig setAnswerTimeInterval:kQBAnswerTimeInterval];
    [QBRTCConfig setDisconnectTimeInterval:kQBRTCDisconnectTimeInterval];
    //QBRTCConfig.disconnectTimeInterval=4;
    [QBRTCConfig setDialingTimeInterval:5];
    
    
    //SVProgressHUD preferences
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setRingThickness:kQBRingThickness];
  
    
    
    BaseViewController *firstViewController=[[BaseViewController alloc ]init];
    
   

    UINavigationController* navigation=[[UINavigationController alloc]initWithRootViewController:firstViewController];
    [self.window setRootViewController:navigation];
    
//    if(![[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"]){
//        BaseViewController  *baseVC=[BaseViewController new];
//        [baseVC changeSignInName];
//    }

    // Override point for customization after application launch.
    
    //Googlr map API key
    //[GMSServices provideAPIKey:@"AIzaSyBJ8TYBjPgF7ifOAuouJxASzOZX5mvEmGg"];
    NSLog(@"Current identifier: %@", [[NSBundle mainBundle] bundleIdentifier]);
    //[GMSServices provideAPIKey:@"AIzaSyCSK19u7iXzEMDy4HVZ6ZBYehDF8908c7s"];
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
