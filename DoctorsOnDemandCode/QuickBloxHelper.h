//
//  QuickBloxHelper.h
//  DoctorsOnDemandCode
//
//  Created by GLB-254 on 8/26/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Quickblox/Quickblox.h>
#import <QuickbloxWebRTC/QuickbloxWebRTC.h>
@interface QuickBloxHelper : NSObject<QBChatDelegate,QBRTCClientDelegate>
-(void)chatLogin:(QBUUser*)user;
@property (strong, nonatomic) QBRTCSession *session;

@end
