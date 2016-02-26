//
//  VideoCallSetUPViewController.m
//  DoctorsOnDemandCode
//
//  Created by GBS-ios on 8/22/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "VideoCallSetUPViewController.h"
#import <Quickblox/Quickblox.h>
@interface VideoCallSetUPViewController ()

@end

@implementation VideoCallSetUPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // [self createSession];
   // [self createUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*#pragma create UI

-(void)createUI{
    
    UITableView * listOfUserTbl = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-55)];
    listOfUserTbl.delegate = self;
    listOfUserTbl.dataSource = self;
    [self.view addSubview:listOfUserTbl];
}



-(void)createSession
{
    
    QBUUser *user = [QBUUser user];
    user.login = @"msnuser2";
    user.password = @"msnuser2";
    
    [QBRequest signUp:user successBlock:^(QBResponse *response, QBUUser *user) {
        // Success, do something
    
      //  [self userLogin];
        
         [[QBChat instance] addDelegate:self];
        [[QBChat instance]loginWithUser:user];
        
    } errorBlock:^(QBResponse *response) {
        // error handling
        NSLog(@"error: %@", response.error);
    }];
}

-(void)userLogin{
//    [QBRequest logInWithUserLogin:@"msnuser2" password:@"msnuser2" successBlock:^(QBResponse *response, QBUUser *user) {
//        // Success, do something
//    } errorBlock:^(QBResponse *response) {
//        // error handling
//        NSLog(@"error: %@", response.error);
//    }];
   
}

#pragma tableView delgate methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}



#pragma mark

-(void)makevideoCall
{
    [QBRTCClient.instance addDelegate:self];
    
    // 2123, 2123, 3122 - opponent's
    NSArray *opponentsIDs = @[@4928711];
    QBRTCSession *newSession = [QBRTCClient.instance createNewSessionWithOpponents:opponentsIDs
                                                                withConferenceType:QBConferenceTypeVideo];
    // userInfo - the custom user information dictionary for the call. May be nil.
    NSDictionary *userInfo = @{ @"newcall" : @"newcall" };
    [newSession startCall:userInfo];
}

#pragma mark -
#pragma mark QBRTCClientDelegate

- (void)didReceiveNewSession:(QBRTCSession *)session userInfo:(NSDictionary *)userInfo {
    
    if (self.session) {
        // userInfo - the custom user information dictionary for the call from caller. May be nil.
        NSDictionary *userInfo = @{ @"key" : @"value" };
        [session rejectCall:userInfo];
        return;
    }
    self.session = session;
}
*/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
