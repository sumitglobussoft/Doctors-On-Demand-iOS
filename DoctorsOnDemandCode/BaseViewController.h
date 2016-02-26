//
//  BaseViewController.h
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 10/7/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//



#import <UIKit/UIKit.h>
#import <Quickblox/Quickblox.h>
#import <QuickbloxWebRTC/QuickbloxWebRTC.h>
#import "AppointmentDurationVC.h"
#import "MyAppointmentsVC.h"
#import "ApplyCouponVC.h"


@interface BaseViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UITabBarDelegate,QBRTCClientDelegate,QBChatDelegate>{
    UICollectionViewCell *cell;
}

@property(nonatomic, strong)UICollectionView *collectionView;
@property (strong, nonatomic) QBRTCSession *session;
@property (strong, nonatomic) NSTimer *presenceTimer;
@property (weak, nonatomic)  QBGLVideoView *opponentVideoView;
@property (weak, nonatomic)  QBGLVideoView *localVideoView;
//-(void)changeSignInName;

@end
