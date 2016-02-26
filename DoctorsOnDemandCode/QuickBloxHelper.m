//
//  QuickBloxHelper.m
//  DoctorsOnDemandCode
//
//  Created by GLB-254 on 8/26/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "QuickBloxHelper.h"
#import <Quickblox/Quickblox.h>
#import <QuickbloxWebRTC/QuickbloxWebRTC.h>
@implementation QuickBloxHelper


-(void)createSession
{
   
    
  
    
    // userInfo - the custom user information dictionary for the call. May be nil.
}
-(void)chatLogin:(QBUUser*)user
{
    [QBChat.instance loginWithUser:user];
    [QBChat.instance addDelegate:self];

}
#pragma mark - QBChatDelegate

- (void)chatDidNotLogin
{
    
   
}

- (void)chatDidFailWithError:(NSInteger)code
{
    
}

- (void)chatDidLogin
{
     [QBRTCClient.instance addDelegate:self];
    

}

-(void)acceptCall
{
    // userInfo - the custom user information dictionary for the accept call. May be nil.
    NSDictionary *userInfo = @{ @"accept" : @"hello" };
    [self.session acceptCall:userInfo];
}
#pragma mark -
#pragma mark QBRTCClientDelegate

- (void)didReceiveNewSession:(QBRTCSession *)session userInfo:(NSDictionary *)userInfo {
    
    if (self.session) {
        // userInfo - the custom user information dictionary for the call from caller. May be nil.
        NSDictionary *userInfo = @{ @"reject" : @"busy" };
        [session rejectCall:userInfo];
        return;
    }
    self.session = session;
}
@end
