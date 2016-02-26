//
//  VideoChatViewController.h
//  DoctorsOnDemandCode
//
//  Created by GBS-ios on 8/28/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Quickblox/Quickblox.h>
#import <QuickbloxWebRTC/QuickbloxWebRTC.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <MobileCoreServices/MobileCoreServices.h>
@interface VideoChatViewController : UIViewController<QBRTCClientDelegate,QBChatDelegate>
{
    QBGLVideoView *remoteVideoView;
    UIView * footerView;
    NSTimer * callTimer;
    UIView * containerView;
    NSArray * listOfDoctors;
    NSIndexPath * checkedIndexPath;
}
@property (strong, nonatomic) QBRTCSession *session;
@property (weak, nonatomic)  QBGLVideoView *opponentVideoView;
@property (strong, nonatomic)  QBGLVideoView *localVideoView;
@property (strong, nonatomic) NSTimer *presenceTimer;

@end
