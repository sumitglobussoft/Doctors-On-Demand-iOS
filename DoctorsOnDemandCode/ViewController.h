//
//  ViewController.h
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 8/7/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "SignInView.h"
#import "SignUpView.h"
#import <Quickblox/Quickblox.h>
#import <QuickbloxWebRTC/QuickbloxWebRTC.h>
#import "SingletonClass.h"
#import "MeetUsView.h"

#import "AppDelegate.h"




@interface ViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,QBRTCClientDelegate,QBChatDelegate,UITabBarDelegate>{
    UICollectionViewCell *cell;
    int noOfCell;
}
@property(nonatomic, strong)UICollectionView *collectionView;
@property (strong, nonatomic) QBRTCSession *session;
@property (strong, nonatomic) NSTimer *presenceTimer;
@property (weak, nonatomic)  QBGLVideoView *opponentVideoView;
@property (weak, nonatomic)  QBGLVideoView *localVideoView;


@end

