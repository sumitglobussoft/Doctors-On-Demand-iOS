//
//  VideoCallSetUPViewController.h
//  DoctorsOnDemandCode
//
//  Created by GBS-ios on 8/22/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <Quickblox/Quickblox.h>
#import <QuickbloxWebRTC/QuickbloxWebRTC.h>

@interface VideoCallSetUPViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
}
@property (strong, nonatomic) QBRTCSession *session;
@end
