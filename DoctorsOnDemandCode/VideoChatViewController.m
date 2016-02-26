//
//  VideoChatViewController.m
//  DoctorsOnDemandCode
//
//  Created by GBS-ios on 8/28/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "VideoChatViewController.h"
#import "SVProgressHUD.h"
@interface VideoChatViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton * acceptButton;
    UILabel * videoCall;
    UIView * tableFooter;
    UITableView * userTable;
    UIView * headerView;
}
@end

@implementation VideoChatViewController
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height
//const NSTimeInterval kChatPresenceTimeInterval = 10;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
        listOfDoctors=[[NSArray alloc]initWithObjects:@"Dr.Dharasis",@"Dr.Farooque",nil];
   headerView  =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, [UIScreen mainScreen].bounds.size.width-120, 25)];
    titleLable.text =@"Video Call";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font =[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
   [backButton setFrame:CGRectMake(15, 18, 55, 35)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];

    [self userLogin];
    [self createUi];
}

-(void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)createUi
{
    
    userTable=[[UITableView alloc]initWithFrame:CGRectMake(10, 60, Screen_Width-20, Screen_Height-80)];
    userTable.delegate=self;
    userTable.dataSource=self;
    [self.view addSubview:userTable];
    //----
    UIView * tableHeader=[[UIView alloc]init];
    tableHeader.frame=CGRectMake(0, 0, Screen_Width, 80);
    userTable.tableHeaderView=tableHeader;
    //---
    UILabel * titleLbl=[[UILabel alloc]init];
    titleLbl.frame=CGRectMake(0, 0, Screen_Width, 80);
    titleLbl.text=@"DOCTORS LIST";
    titleLbl.textAlignment=NSTextAlignmentCenter;
    titleLbl.textColor=[UIColor whiteColor];
    titleLbl.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)30/255 blue:(CGFloat)99/255 alpha:1];
    [tableHeader addSubview:titleLbl];
    //----
    tableFooter=[[UIView alloc]init];
    tableFooter.frame=CGRectMake(0, 0, Screen_Width, 80);
    tableFooter.hidden=YES;
    userTable.tableFooterView=tableFooter;
    //----
    videoCall=[[UILabel alloc]init];
    videoCall.frame=CGRectMake(0, 0, Screen_Width-150, 80);
    videoCall.text=@"Video Call to:";
    videoCall.textAlignment=NSTextAlignmentCenter;
    videoCall.textColor=[UIColor whiteColor];
    videoCall.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)30/255 blue:(CGFloat)99/255 alpha:1];
   [tableFooter addSubview:videoCall];

    //----
        //----
    acceptButton=[[UIButton alloc]initWithFrame:CGRectMake(0,Screen_Height-60, Screen_Width,60)];
    [acceptButton setTitle:@"Accept" forState:UIControlStateNormal];
    acceptButton.backgroundColor=[UIColor greenColor];
    acceptButton.hidden=YES;
    [acceptButton addTarget:self action:@selector(acceptCall) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:acceptButton];
    containerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    containerView.hidden=YES;
   // containerView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:containerView];
    //------
    
    //-------
    footerView=[[UIView alloc]init];
    footerView.frame=CGRectMake(0,Screen_Height-80, Screen_Width,80);
    footerView.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)30/255 blue:(CGFloat)99/255 alpha:1];
    footerView.hidden=YES;
    [self.view addSubview:footerView];
    //---
    UIButton * cameraSwitchButton=[[UIButton alloc]init];
    cameraSwitchButton.frame=CGRectMake(Screen_Width/4-20, 20,40, 40);
    [cameraSwitchButton addTarget:self action:@selector(pressSwitchCameraBtn:) forControlEvents:UIControlEventTouchUpInside];
    [cameraSwitchButton setBackgroundImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
    [footerView addSubview:cameraSwitchButton];
    //------
    UIButton * mikeButton=[[UIButton alloc]init];
    mikeButton.frame=CGRectMake(Screen_Width/2-20, 20,23, 39);
    [mikeButton addTarget:self action:@selector(pressSwitchAudioOutput:) forControlEvents:UIControlEventTouchUpInside];
    [mikeButton setBackgroundImage:[UIImage imageNamed:@"mute-ic.png"] forState:UIControlStateNormal];
    [footerView addSubview:mikeButton];
    //------
    UIButton * hangUpButton=[[UIButton alloc]init];
    hangUpButton.frame=CGRectMake(3*Screen_Width/4-20, 20,40, 14);
    [hangUpButton addTarget:self action:@selector(pressHandUpBtn:) forControlEvents:UIControlEventTouchUpInside];
    [hangUpButton setBackgroundImage:[UIImage imageNamed:@"decline-ic.png.png"] forState:UIControlStateNormal];
    [footerView addSubview:hangUpButton];

}
-(void)doctorCallingUI
{
    
    UIView * drCalling=[[UIView alloc]init];
    drCalling.frame=CGRectMake(0, 0, Screen_Width, Screen_Height);
    [self.view addSubview:drCalling];
    //------
}
#pragma mark
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:nil];
    if(cell==nil)
    {
    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentifier"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    if([checkedIndexPath isEqual:indexPath])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    //----
    UIButton * callButton=[[UIButton alloc]initWithFrame:CGRectMake(10,10,40, 40)];
    [callButton setBackgroundImage:[UIImage imageNamed:@"connect_calls.png"] forState:UIControlStateNormal];
    [callButton addTarget:self action:@selector(callUserForVideoChat) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:callButton];
    //----
    UILabel * nameLbl=[[UILabel alloc]init];
    nameLbl.frame=CGRectMake(70,20, 200, 20);
    nameLbl.text=[listOfDoctors objectAtIndex:indexPath.row];
    [cell.contentView addSubview:nameLbl];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(checkedIndexPath)
    {
        UITableViewCell* uncheckCell = [tableView
                                        cellForRowAtIndexPath:checkedIndexPath];
        uncheckCell.accessoryType = UITableViewCellAccessoryNone;
    }
    if([checkedIndexPath isEqual:indexPath])
    {
        checkedIndexPath = nil;
    }
    else
    {
        UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        checkedIndexPath = indexPath;
    }
    videoCall.text=[NSString stringWithFormat:@"Calling to....%@",[listOfDoctors objectAtIndex:indexPath.row]];
    tableFooter.hidden=NO;
    if(indexPath.row==0)
    {
        //[self callUserForVideoChat];
//        QBUUser *user = [QBUUser user];
//        user.ID=4931841;
//        user.login = @"Sukhmeet";
//        user.password = @"globussoft";
//        //[helperObj chatLogin:user];
//        [QBChat.instance loginWithUser:user];
//        [QBChat.instance addDelegate:self];
//        [SVProgressHUD setBackgroundColor:[UIColor blueColor]];
//        [SVProgressHUD showWithStatus:NSLocalizedString(@"Calling...", nil)];
       

    }
    else if (indexPath.row==1)
    {
//        QBUUser *user = [QBUUser user];
//        user.ID=4930056;
//        user.login = @"msnuser2";
//        user.password = @"globussoft";
//        //[helperObj chatLogin:user];
//        [QBChat.instance loginWithUser:user];
//        [QBChat.instance addDelegate:self];
//        [SVProgressHUD setBackgroundColor:[UIColor blueColor]];
//        [SVProgressHUD showWithStatus:NSLocalizedString(@"Calling...", nil)];


    }
}

-(void)userLogin{
    QBUUser *user = [QBUUser user];
//    user.ID=4931841;
//    user.login = @"Sukhmeet";
//    user.password = @"globussoft";
    user.ID=7119388;
    user.login = @"farooqueazam";
    user.password = @"FAaz_2029";

    //[helperObj chatLogin:user];
    [QBChat.instance loginWithUser:user];
    [QBChat.instance addDelegate:self];
//    [SVProgressHUD setBackgroundColor:[UIColor blueColor]];
//    [SVProgressHUD showWithStatus:NSLocalizedString(@"Calling...", nil)];
    
    
    // Start
    

}

-(void)chatLogin:(QBUUser*)user
{
    [QBChat.instance loginWithUser:user];
    [QBChat.instance addDelegate:self];
    
}
#pragma mark - QBChatDelegate
//- (void)chatDidLogin
//{
//    [QBRTCClient.instance addDelegate:self];
//    self.presenceTimer =
//    [NSTimer scheduledTimerWithTimeInterval:kChatPresenceTimeInterval
//                                     target:self
//                                   selector:@selector(sendChatPresence:)
//                                   userInfo:nil
//                                    repeats:YES];
//    [SVProgressHUD dismiss];
////[self callUserForVideoChat];
//   // [self retrieveAllUsersFromPage:1];
//    
//}
- (void)chatDidNotLogin
{
    
    
}

- (void)chatDidFailWithError:(NSInteger)code
{
    
}
-(void)callUserForVideoChat
{
    [QBSoundRouter.instance initialize];
    QBSoundRouter.instance.currentSoundRoute = QBSoundRouteReceiver;
    //or set speaker
    //QBSoundRouter.instance.currentSoundRoute = QBSoundRouteSpeaker;
    
    [QBRTCClient.instance addDelegate:self];
    
    
    // 2123, 2123, 3122 - opponent's
    NSArray *opponentsIDs = @[@6254135];
    QBRTCSession *newSession = [QBRTCClient.instance createNewSessionWithOpponents:opponentsIDs
                                                                withConferenceType:QBConferenceTypeVideo];
    // userInfo - the custom user information dictionary for the call. May be nil.
    NSDictionary *userInfo = @{ @"newcall" : @"newcall" };
    [newSession startCall:userInfo];
}
- (void)sendChatPresence:(NSTimer *)timer {
    
    [[QBChat instance] sendPresence];
}

#pragma mark -
#pragma mark QBRTCClientDelegate

- (void)didReceiveNewSession:(QBRTCSession *)session userInfo:(NSDictionary *)userInfo
{
    
    if (self.session)
    {
        // userInfo - the custom user information dictionary for the call from caller. May be nil.
        NSDictionary *userInfo = @{ @"accept" : @"hello" };
        [session acceptCall:userInfo];
        return;
    }
    self.session = session;
    acceptButton.hidden=NO;
    //[QMSoundManager playRingtoneSound];
    
    
}

-(void)acceptCall
{
    [QBSoundRouter.instance initialize];
    QBSoundRouter.instance.currentSoundRoute = QBSoundRouteReceiver;
    //or set speaker
//QBSoundRouter.instance.currentSoundRoute = QBSoundRouteSpeaker;
    NSDictionary *userInfoTosend = @{ @"accept" : @"hello" };
    [self.session acceptCall:userInfoTosend];
    
}

-(void)signUp
{
    QBUUser *user = [QBUUser user];
    user.password = @"password";
    user.login = @"login";
    
    // Registration/sign up of User
    [QBRequest signUp:user successBlock:^(QBResponse *response, QBUUser *user) {
        // Sign up was successful
    } errorBlock:^(QBResponse *response) {
        // Handle error here
    }];
}
#pragma mark - QBWebRTCChatDelegate

/**
 * Called in case when you are calling to user, but he hasn't answered
 */
- (void)session:(QBRTCSession *)session userDoesNotRespond:(NSNumber *)userID
{
    
    
        [self reloadWithUserID:userID];
    
}

- (void)session:(QBRTCSession *)session acceptByUser:(NSNumber *)userID userInfo:(NSDictionary *)userInfo
{
    
}

/**
 * Called in case when opponent has rejected you call
 */
- (void)session:(QBRTCSession *)session rejectedByUser:(NSNumber *)userID userInfo:(NSDictionary *)userInfo
{
    
    
        [self reloadWithUserID:userID];
        NSLog(@"%@", userInfo);
}

/**
 *  Called in case when opponent hung up
 */
- (void)sessionDidClose:(QBRTCSession *)session {
    
    // release session instance
    self.session = nil;
}
- (void)session:(QBRTCSession *)session hungUpByUser:(NSNumber *)userID userInfo:(NSDictionary *)userInfo
{
    containerView.hidden=YES;
    footerView.hidden=YES;
   // [self dismissViewControllerAnimated:YES completion:nil];    if (self.session == session)
    //{
    self.session = nil;

        
        NSLog(@"%@", userInfo);
   // }
//    containerView.hidden=YES;
//    footerView.hidden=YES;

}

/**
 *  Called in case when receive local video track
 */
- (void)session:(QBRTCSession *)session didReceiveLocalVideoTrack:(QBRTCVideoTrack *)videoTrack
{
    
    self.localVideoView = [[QBGLVideoView alloc] initWithFrame:CGRectMake(20,20,100 ,100)];
    self.localVideoView.layer.borderWidth=1;
    self.localVideoView.layer.borderColor=[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:1].CGColor;
    self.localVideoView.layer.shadowOffset = CGSizeMake(0,0);
    self.localVideoView.layer.shadowRadius =5;
    self.localVideoView.layer.shadowOpacity = 0.5;
    [containerView addSubview:self.localVideoView];
    [self.localVideoView setVideoTrack:videoTrack];
    //  NSAssert(self.session == session, @"Need update this case");
    self.localVideoView.hidden = NO;
    headerView.hidden=YES;
  
}

/**
 *  Called in case when receive remote video track from opponent
 */
- (void)session:(QBRTCSession *)session didReceiveRemoteVideoTrack:(QBRTCVideoTrack *)videoTrack fromUser:(NSNumber *)userID
{
    containerView.hidden=NO;
    userTable.hidden=YES;
    footerView.hidden=NO;
    
    headerView.hidden=YES;

    remoteVideoView = [[QBGLVideoView alloc] initWithFrame:CGRectMake(0,0,Screen_Width,Screen_Height)];
    //Skip black frames (experimental)
    remoteVideoView.skipBlackFrames = YES;
    [self.view insertSubview:remoteVideoView belowSubview:containerView];
    [remoteVideoView setVideoTrack:videoTrack];
    
    //  NSAssert(self.session == session, @"Need update this case");
     [self reloadWithUserID:userID];
}

/**
 *  Called in case when connection initiated
 */
- (void)session:(QBRTCSession *)session startConnectionToUser:(NSNumber *)userID
{
//    self.localVideoView = [[QBGLVideoView alloc] initWithFrame:CGRectMake(0,0,Screen_Width,Screen_Height)];
   //[self.view addSubView: self.localVideoView];
   // [self.localVideoView setVideoTrack:videoTrack];
    //NSAssert(self.session == session, @"Need update this case");
    [self reloadWithUserID:userID];
}


/**
 *  Called in case when connection is established with opponent
 */
- (void)session:(QBRTCSession *)session connectedToUser:(NSNumber *)userID
{
    
    
    
    [self reloadWithUserID:userID];

    //NSAssert(self.session == session, @"Need update this case");
    
    //[self reloadWithUserID:userID];
}

/**
 *  Called in case when connection state changed
 */
- (void)session:(QBRTCSession *)session connectionClosedForUser:(NSNumber *)userID
{
//    containerView.hidden=YES;
//    footerView.hidden=YES;
//    [self reloadWithUserID:userID];

   // NSAssert(self.session == session, @"Need update this case");
}

/**
 *  Called in case when disconnected from opponent
 */
- (void)session:(QBRTCSession *)session disconnectedFromUser:(NSNumber *)userID
{
//    containerView.hidden=YES;
//    footerView.hidden=YES;
   // [self dismissViewControllerAnimated:YES completion:nil];
//    NSAssert(self.session == session, @"Need update this case");
}

/**
 *  Called in case when disconnected by timeout
 */
- (void)session:(QBRTCSession *)session disconnectTimeoutForUser:(NSNumber *)userID
{
    
 //   NSAssert(self.session == session, @"Need update this case");
}

/**
 *  Called in case when connection failed with user
 */
- (void)session:(QBRTCSession *)session connectionFailedWithUser:(NSNumber *)userID
{
//    containerView.hidden=YES;
//    footerView.hidden=YES;
    //NSAssert(self.session == session, @"Need update this case");
}

/**
 *  Called in case when session will close
 */
- (void)sessionWillClose:(QBRTCSession *)session
{
    
}
#pragma mark - Actions

- (void)pressMicBtn:(id)sender
{
    
    self.session.audioEnabled = !self.session.audioEnabled;
}

- (void)pressEnableVideoBtn:(id)sender
{
    
    self.session.videoEnabled = !self.session.videoEnabled;
   // self.switchCameraBtn.hidden = !self.session.videoEnabled;
}

- (void)pressHandUpBtn:(id)sender
{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    [self.session hangUp:@{@"hangup" : @"hang up"}];
    [self.session hangUp:sender];
    
    self.session = nil;

    
    headerView.hidden=NO;
    
    containerView.hidden=YES;
    remoteVideoView.hidden=YES;

}

- (void)pressSwitchCameraBtn:(UIButton*)sender
{
    [self.session switchCamera:^(BOOL isFrontCamera) {
        NSLog(@"Is Front Camera %d",isFrontCamera);
    }];
}


- (void)pressSwitchAudioOutput:(id)sender
    {
    
    QBSoundRoute route = [QBSoundRouter instance].currentSoundRoute;
    
    if (route == QBSoundRouteSpeaker) {
        
        [QBSoundRouter instance].currentSoundRoute = QBSoundRouteReceiver;
    }
    else {
        
        [QBSoundRouter instance].currentSoundRoute = QBSoundRouteSpeaker;
    }
}
- (void)reloadWithUserID:(NSNumber *)userID
{
    
    
    NSLog(@"Reload with......");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark- retreive all users

- (void)retrieveAllUsersFromPage:(int)page{
    
    // Number of page you want to fetch + number of items in this page
    QBGeneralResponsePage *pageResponse = [QBGeneralResponsePage responsePageWithCurrentPage:page perPage:10];
    
    [QBRequest usersForPage:pageResponse successBlock:^(QBResponse *response, QBGeneralResponsePage *pageInformation, NSArray *users) {
        NSLog(@" list of users %@",users);
        // Successful response contains current page infromation + list of users
    } errorBlock:^(QBResponse *response) {
        // Handle error
    }];
}

@end
