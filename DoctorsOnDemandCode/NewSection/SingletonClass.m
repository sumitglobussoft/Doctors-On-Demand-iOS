//
//  SingletonClass.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 8/26/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "SingletonClass.h"
#import "Reachability.h"
static SingletonClass *sharedSingleton;

@implementation SingletonClass
+(SingletonClass*)sharedSingleton{
    
    
    @synchronized(self){
        
        if(!sharedSingleton){
            sharedSingleton=[[SingletonClass alloc]init];
        }
    }return sharedSingleton;
}

+(BOOL)networkcheck{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    //BOOL netWorkConnection;
    if(status == NotReachable)
    {
        //netWorkConnection=NO;
        return NO;
    }
    else if (status == ReachableViaWiFi){
        //   netWorkConnection=YES;
        return YES;
    }else if (status==ReachableViaWWAN){
        //  netWorkConnection=YES;
        return YES;
        
    }else
        // netWorkConnection=NO;
        return NO;
    
    
    // [[NSUserDefaults standardUserDefaults] setBool:netWorkConnection forKey:@"ConnectionAvilable"];
}

@end
