//
//  ViewController.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 8/7/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "ViewController.h"
#import "MedicalView.h"
#import "QuickBloxHelper.h"
//#import "VideoChatViewController.h"
#import "MyAccountVC.h"
#import "MyHealthVC.h"
#import "PregAndNewView.h"
#import "PsychologyView.h"
#import "PediatricsView.h"
#import "MyAppointmentsVC.h"

//const NSTimeInterval kChatPresenceTimeInterval = 45;

@interface ViewController (){
CGRect screenRect;
int height;
int width;
     NSMutableArray *callCost;
    UIButton *signIn;
    UIView * headerView;
    UIButton *signup,*seeDocButton,*letsGoButton;
    UIView *backPopUp,*letsGetStartedPopUp;
    id json;
    NSMutableArray *timtStampAr;
    UIButton *meetusButton;
    //UITabBarController *tabBar;
    UITabBar *customBar;
    
    NSArray *tabArr;
}


@property(nonatomic,strong)MedicalView * mdicalVC;
@property(nonatomic,strong)PsychologyView *psychologyVC;
@property(nonatomic,strong)PediatricsView *pediatricVC;
@property(nonatomic,strong)PregAndNewView *pregAndNewVC;

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
}

//-(void)changeSignInName{
////    [signIn removeFromSuperview];
//// UIButton * meBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
////    meBtn.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-60, 25,50,25);
////    meBtn.backgroundColor =[UIColor clearColor];
////    [meBtn setTitleColor:[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)30/255 blue:(CGFloat)49/255 alpha:(CGFloat)1] forState:UIControlStateNormal];
////    meBtn.titleLabel.font =[UIFont systemFontOfSize:12];
////    [meBtn setTitle:@"Me" forState:UIControlStateNormal];
////    [meBtn addTarget:self action:@selector(meBtn) forControlEvents:UIControlEventTouchUpInside];
////    [headerView addSubview:meBtn];
//    
//    signIn.hidden= YES;
//    meetusButton.hidden = YES;
//    signup.hidden= YES;
//    
//    
//   
//   /*
//    UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, screenRect.size.height-40, screenRect.size.width, 40)];
//    footerView.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:footerView];
//
//    
//   
//    
//    UIButton *health=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    health.frame=CGRectMake(20, 6, 25, 25) ;
//    [health setBackgroundImage:[UIImage imageNamed:@"health_menu.png"] forState:UIControlStateNormal];
//    [health addTarget:self action:@selector(healthAction) forControlEvents:UIControlEventTouchUpInside];
//    [footerView addSubview:health];
//    
//    
//    UIButton *myAppt=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    myAppt.frame=CGRectMake(80, 6, 25,25) ;
//    [myAppt setBackgroundImage:[UIImage imageNamed:@"myappt_menu.png"] forState:UIControlStateNormal];
//     [myAppt addTarget:self action:@selector(myApptAction) forControlEvents:UIControlEventTouchUpInside];
//    [footerView addSubview:myAppt];
//
//    
//    UIButton *video=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    video.frame=CGRectMake(140, 6, 25,25) ;
//    [video setBackgroundImage:[UIImage imageNamed:@"video_menu.png"] forState:UIControlStateNormal];
//     [video addTarget:self action:@selector(videoAction) forControlEvents:UIControlEventTouchUpInside];
//    
//    [footerView addSubview:video];
//    
//    
//    
//    UIButton *dr=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    dr.frame=CGRectMake(200, 6, 25,25) ;
//    [dr setBackgroundImage:[UIImage imageNamed:@"dr_icon.png"] forState:UIControlStateNormal];
//    [dr addTarget:self action:@selector(drAction) forControlEvents:UIControlEventTouchUpInside];
//    [footerView addSubview:dr];
//    
//
//    
//    UIButton *user=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    user.frame=CGRectMake(260, 6, 25,25) ;
//    [user setBackgroundImage:[UIImage imageNamed:@"user_menu.png"] forState:UIControlStateNormal];
//    [user addTarget:self action:@selector(userAction) forControlEvents:UIControlEventTouchUpInside];
//
//    [footerView addSubview:user];*/
//    
//    
//      //----------------------comment----------------------
//    /*MeetUsView *meetUs = [[MeetUsView alloc] init];
//    UINavigationController * meetUsNavi=[[UINavigationController alloc]initWithRootViewController:meetUs];
//    meetUsNavi.navigationBarHidden=YES;
//    
//    
//    MyAccountVC *account = [[MyAccountVC alloc] init];
//    UINavigationController * accountNavi=[[UINavigationController alloc]initWithRootViewController:account];
//    accountNavi.navigationBarHidden=YES;
//    
//    
//    MyHealthVC *health=[[MyHealthVC alloc]init];
//    UINavigationController * healthNavi=[[UINavigationController alloc]initWithRootViewController:health];
//    accountNavi.navigationBarHidden=YES;
//    
//
////    UINavigationController * selfNavi=[[UINavigationController alloc]initWithRootViewController:self];
////    selfNavi.navigationBarHidden=YES;
////
//    
//    NSArray *barele=[NSArray arrayWithObjects:healthNavi,self,meetUsNavi,accountNavi,nil];
//    tabBar=[[UITabBarController alloc] init];
//    tabBar.viewControllers=[NSArray arrayWithArray:barele];
//    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1]];
//    
//    
//    health.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"My Health" image:[UIImage imageNamed:@"health_menu.png"] tag:1];
//    
//    self.tabBarItem =
//    [[UITabBarItem alloc] initWithTitle:@""
//                                  image:[UIImage imageNamed:@"video_menu.png"]
//                                    tag:2];
//    
//    
//    meetUs.tabBarItem =
//    [[UITabBarItem alloc] initWithTitle:@"Meet Us"
//                                  image:[UIImage imageNamed:@"dr_icon.png"]
//                                    tag:3];
//    account.tabBarItem =
//    [[UITabBarItem alloc] initWithTitle:@"Account"
//                                  image:[UIImage imageNamed:@""]
//                                    tag:4];
//    
//    
//    [self.view addSubview:tabBar.view];
//  
//    
//  //  [tabBar setSelectedViewController:selfNavi];*/
//    
//      //[self createUI];
//    
//    
//    
//    
//    
//    
//    
//  
//    
//    
//    
//    
//        
//    
//        signIn.hidden=YES;
//        signup.hidden=YES;
//        meetusButton.hidden=YES;
//        
////        NSArray *barele=[NSArray arrayWithObjects:healthNavi,appointNavi,selfNavi,meetUsNavi,accountNavi,nil];
////        tabBar=[[UITabBarController alloc] init];
////        tabBar.viewControllers=[NSArray arrayWithArray:barele];
////        [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1]];
//    
//        
//    UITabBarItem * health=[[UITabBarItem alloc]initWithTitle:@"My Health"image:[UIImage imageNamed:@"health_menu.png"] selectedImage:[UIImage imageNamed:@"health_menu.png"]];
//    health.tag=0;
//    
//    
//    UITabBarItem * appointment=[[UITabBarItem alloc]initWithTitle:@"My Appts" image:[UIImage imageNamed:@"myappt_menu.png"] selectedImage:[UIImage imageNamed:@"myappt_menu.png"]];
//    appointment.tag=1;
//    
//    UITabBarItem * video=[[UITabBarItem alloc]initWithTitle:@"" image:[UIImage imageNamed:@"video_menu.png"] selectedImage:[UIImage imageNamed:@"video_menu.png"]];
//    video.tag=2;
//    
//    UITabBarItem * meetUs=[[UITabBarItem alloc]initWithTitle:@"Meet Us" image:[UIImage imageNamed:@"dr_icon.png"] selectedImage:[UIImage imageNamed:@"dr_icon.png"]];
//    meetUs.tag=3;
//    
//    UITabBarItem * account=[[UITabBarItem alloc]initWithTitle:@"Account" image:[UIImage imageNamed:@"user_menu.png"] selectedImage:[UIImage imageNamed:@"user_menu.png"]];
//    account.tag=4;
//    
//        
//        customBar = [[UITabBar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 55)];
//    customBar.items = @[health,appointment,video,meetUs,account];
//    
//    customBar.delegate = self;
//       customBar.selectedItem = account;
//    customBar.barTintColor = [UIColor whiteColor];
//    [[UITabBar appearance] setSelectedImageTintColor:[UIColor cyanColor]];
//    [self.view addSubview:customBar];
//
//  
//    MyHealthVC *healthVC=[[MyHealthVC alloc]init];
//    healthVC.title = @"My Health";
//    [self addChildViewController:healthVC];
//    
//    MyAppointmentsVC *appointmentVC=[[MyAppointmentsVC alloc]init];
//    appointmentVC.title = @"My Appointments";
//    [self addChildViewController:appointmentVC];
//    
//    
//    MeetUsView *meetUsVC= [[MeetUsView alloc] init];
//    meetUsVC.title = @"Meet Us";
//    [self addChildViewController:meetUsVC];
//    
//    MyAccountVC *accountVC = [[MyAccountVC alloc] init];
//    accountVC.title = @"My Account";
//    [self addChildViewController:accountVC];
//    
//        
//  
//    
//    NSArray *tabBarArray = @[healthVC,appointmentVC,self,meetUsVC,accountVC];
//    tabArr=[tabBarArray copy];
//    
//
//
//}
//
//
//#pragma mark-tab bar delegates
//-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
//    
//       UIViewController *newViewController = [tabArr objectAtIndex:item.tag];
//    [self.view addSubview:newViewController.view];
//    // }
//    
//    
//}
//-(void)getSelectedViewControllers:(UIViewController*)newViewController{
//    [self.navigationController pushViewController:newViewController animated:NO];
//}

//#pragma mark- After signout
//-(void)afterSignOut{
//    
//    signIn.hidden= NO;
//    meetusButton.hidden = NO;
//    signup.hidden= NO;
//    
//    [customBar removeFromSuperview];
//     [[NSNotificationCenter defaultCenter]removeObserver:self name:@"afterSignOut" object:nil];
//
//    [self createUI];
//}



//-(void)meBtn
//{
//    
//    ApplyCoupenViewController * applyVC =[[ApplyCoupenViewController alloc]init];
//    [self.navigationController pushViewController:applyVC animated:YES];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect frame;
    float hit,widt;
    if (UIUserInterfaceIdiomPad==UI_USER_INTERFACE_IDIOM()) {
        frame=  CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80);
        hit = 50;
        
    }
    else{
        frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55);
        hit = 25;
    }
    
    
    
   
    [SingletonClass sharedSingleton].deptId=0;
    
    headerView =[[UIView alloc]init];
    headerView.frame = frame;
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UIImageView * logo =[[UIImageView alloc]init];
    logo.frame=CGRectMake(10, 15, [[UIScreen mainScreen] bounds].size.width/2+70,35);
    
    logo.image= [UIImage imageNamed:@"logo.png"];
    
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad) {
        //        headerView.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-100, 20,100,60);
        logo.frame=CGRectMake(10, 30, [[UIScreen mainScreen] bounds].size.width/2+10,35);
        //signIn.titleLabel.font =[UIFont systemFontOfSize:25];
    }
    
    [headerView addSubview:logo];

    
      signIn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    signIn.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-60, 25,50,25);
    signIn.backgroundColor =[UIColor clearColor];
    [signIn setTitleColor:[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)30/255 blue:(CGFloat)49/255 alpha:(CGFloat)1] forState:UIControlStateNormal];
    signIn.titleLabel.font =[UIFont systemFontOfSize:12];
    [signIn setTitle:@"Sign In" forState:UIControlStateNormal];
    [signIn addTarget:self action:@selector(signIn) forControlEvents:UIControlEventTouchUpInside];
    //[headerView addSubview:signIn];

    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad) {
         signIn.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-150, 20,100,50);
         signIn.titleLabel.font =[UIFont systemFontOfSize:25];
    }
    
    
    [self createUI];
    [self createCollectionView];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)createUI{
    
    screenRect = [[UIScreen mainScreen] bounds];
    height=screenRect.size.height;
    width=screenRect.size.width;
    
    NSLog(@"height====%d",height);
    
    NSLog(@"width====%d",width);
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];

    
    
   

    
    seeDocButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad) {
        seeDocButton.frame=CGRectMake(40, 100,[UIScreen mainScreen].bounds.size.width-80,120);
        
        [seeDocButton setBackgroundImage:[UIImage imageNamed:@"see_doctor_btn_ipad@2x"] forState:UIControlStateNormal];
    }else{
    if(width>=375&&height>=667){
        seeDocButton.frame=CGRectMake(10, 70,width-20,80);
        
        [seeDocButton setBackgroundImage:[UIImage imageNamed:@"see_doctor_btn6.png"] forState:UIControlStateNormal];
        
    }
    else{
        
        seeDocButton.frame=CGRectMake(width/2-148, 70,297,72);
    
   [seeDocButton setBackgroundImage:[UIImage imageNamed:@"see_btn.png"] forState:UIControlStateNormal];
    }
    }
    [seeDocButton addTarget:self action:@selector(videoChatView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:seeDocButton];
    
    

}
//-(void)meetupAction
//{
//    QBUUser *user = [QBUUser user];
//    user.ID=4931841;
//    user.login = @"Sukhmeet";
//    user.password = @"globussoft";
//    //[helperObj chatLogin:user];
//    [QBChat.instance loginWithUser:user];
//    [QBChat.instance addDelegate:self];
//    
//    
//  
//    
//}
//-(void)signIn
//{
//    
//   // [self callUserForVideoChat];
//    SignInView *signInView=[[SignInView alloc]init];
//   
//    [self.navigationController pushViewController:signInView animated:YES];
//    
//}
-(void)createCollectionView{
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.minimumInteritemSpacing =5;
    layout.minimumLineSpacing=15;
    
    switch (height) {
        case 480:
                layout.itemSize = CGSizeMake(130, 130);
            break;
        case 568:
            layout.itemSize = CGSizeMake(145, 145);
            layout.minimumInteritemSpacing =5;
            layout.minimumLineSpacing=10;
            break;
        case 667:
                 layout.itemSize = CGSizeMake(170, 170);
            break;
        case 736:
                    layout.itemSize = CGSizeMake(190, 190);
            break;
            
        default: layout.itemSize = CGSizeMake(300, 300);
            break;
    }
    if (UIUserInterfaceIdiomPad==UI_USER_INTERFACE_IDIOM()) {
         layout.sectionInset = UIEdgeInsetsMake(20, 50, 20,50);
        _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 250, width,height-250) collectionViewLayout:layout];
    }
    else{
        if(height==480)
            _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 140, width,height-200) collectionViewLayout:layout];
        else if (height==667){
            _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 165, width,height-200) collectionViewLayout:layout];
        }
        else
            _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 160, width,height-200) collectionViewLayout:layout];
    }
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    _collectionView.scrollEnabled=NO;
    [self.view addSubview:_collectionView];
    
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    NSString * cell1,* cell2,*cell3,*cell4;
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad) {
        cell1 =@"medical_options_ipad.png";
        cell2 =@"psychology_options_ipad.png";
        cell3 =@"child_disease_options_ipad.png";
        cell4 =@"pregnancy_options_ipad.png";
    }
    
    else{
                cell1 =@"medical_img.png";
                cell2 =@"psychology_img.png";
                cell3 =@"child_img.png";
                cell4 =@"health_img.png";
    }
  
  
        UIImageView *rotateView=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,cell.frame.size.width,cell.frame.size.height)];
        if(indexPath.row==0){
            rotateView.image=[UIImage imageNamed:cell1];
        }
        else if (indexPath.row==1){
            rotateView.image=[UIImage imageNamed:cell2];
            
        }
        else if (indexPath.row==2){
            rotateView.image=[UIImage imageNamed:cell3];
            
        }
        else if (indexPath.row==3){
            rotateView.image=[UIImage imageNamed:cell4];
        }
        
                       [cell.contentView addSubview:rotateView];
        cell.layer.cornerRadius=45.0f;
    
    
    return cell;
    
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row==0)
    {
        if (!_mdicalVC) {
            _mdicalVC = nil;
        }
        
        _mdicalVC = [[MedicalView alloc]init];
        _mdicalVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController  pushViewController:_mdicalVC animated:YES];
    }
    else if(indexPath.row==1)
    {       if (!_psychologyVC) {
        _psychologyVC = nil;
    }
        
        _psychologyVC = [[PsychologyView alloc]init];
        _psychologyVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController  pushViewController:_psychologyVC animated:YES];
        
    }
    else if(indexPath.row==2)
    {
        if (!_pediatricVC) {
            _pediatricVC = nil;
        }
        
        _pediatricVC = [[PediatricsView alloc]init];
        _pediatricVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController  pushViewController:_pediatricVC animated:YES];
    }
    else if(indexPath.row==3)
    {if (!_pregAndNewVC) {
        _pregAndNewVC = nil;
    }
        
        _pregAndNewVC = [[PregAndNewView alloc]init];
        _pregAndNewVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController  pushViewController:_pregAndNewVC animated:YES];
        
    }
    
    
}
//#pragma mark-Sign up Action
//-(void)signUp{
//    SignUpView *signUp=[[SignUpView alloc]init];
//    [self.navigationController pushViewController:signUp animated:YES];
//    
//}
//
#pragma mark-Video Call
-(void)videoChatView
{
    //    VideoChatViewController * videoChat=[[VideoChatViewController alloc]init];
    //    [self presentViewController:videoChat animated:YES completion:nil];
    
    
//    self.navigationController.navigationBar.hidden = NO;
//    LoginViewController *chatLogin = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"startStoryBoard"];
//    
//    [self.navigationController pushViewController:chatLogin animated:YES];
//    
    [[NSUserDefaults standardUserDefaults]setObject:nil
forKey:@"MYHEALTH"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    if([[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"]==nil){
        SignInView *signIn=[SignInView new];
        [self.navigationController pushViewController:signIn animated:YES];
    }
    else{
        
        
          [SingletonClass sharedSingleton].deptId=5;
        [self fetchFreeDoctors];
    
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(afterCouponApply) name:@"changeCallRate" object:nil];
    }
    
    
}

-(void)afterCouponApply{
    dispatch_async(dispatch_get_global_queue(0, 0),^{
        
        [self fetchFreeDoctors];
        
        dispatch_async(dispatch_get_main_queue(),^{
            
            [self popUp];
        });
        
    });
    
    
    
    
    
    
    
}

#pragma mark-Fetch Free Doctors
-(void)fetchFreeDoctors{
    
    timtStampAr=[[NSMutableArray alloc]init];
    
    NSError *error;   NSURLResponse * urlResponse;
    
    
    NSURL * url =[NSURL URLWithString:fetchScheduleService];
    
    NSMutableURLRequest  * request =[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    
    
    
    
    
    NSString * body =[NSString stringWithFormat:@"departmentId=%d&timeZone=%@",4 ,[NSTimeZone localTimeZone].name];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (!data) {
        
        return;
    }
    json =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    //    NSLog(@"schedule jason---->%@",jsonResponse);
    
    
    
    
    if ([[json objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
        
        
        NSArray *timeStampDate=[json objectForKey:@"data"];
        //        for (int i=0; i<timeStampDate.count; i++) {
        //
        //
        //            [timtStampAr addObject:[timeStampDate objectAtIndex:i]];
        //
        //        }
        
        
        [self convertTimeStamp:[timeStampDate objectAtIndex:0]];
        
        
        dispatch_async(dispatch_get_global_queue(0, 0),^{
            
            [self doctorCallRate];
            
            dispatch_async(dispatch_get_main_queue(),^{
                
                [self popUp];
                
            });
            
        });
        
        
        
        
    }
    else{
        [self popUp];
    }
    
    
    
    
    
}



#pragma mark-convert timeStamp to date
-(void)convertTimeStamp:(NSString *)passedTimeStamp{
    
    
    
    
    
    
    
    NSTimeInterval timeSec=[passedTimeStamp doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeSec];
    
    
    NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *dateString = [formatter stringFromDate:date];
    
    NSDate *finalDate=[formatter dateFromString:dateString];
    
    
    NSLog(@"\ndate are-->%@",[formatter stringFromDate:finalDate]);
    
    
    
    
    
    [[NSUserDefaults standardUserDefaults]setObject:[formatter stringFromDate:finalDate] forKey:@"SeeDoctorStart"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
    
    NSDate *appendDate=[[formatter dateFromString:[formatter stringFromDate:finalDate]]dateByAddingTimeInterval:(1500) ];
    
    
    NSString *appentDateStr=[formatter stringFromDate:appendDate];
    
    
    
    [[NSUserDefaults standardUserDefaults]setObject:appentDateStr forKey:@"SeeDoctorEnd"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
    NSLog(@"append dfate%@",appendDate);
    
    
    
    
}


#pragma mark-Auto Allocate Doctor
-(void)autoAllocateDoctor{
    
    NSError * error;
    NSURLResponse *  urlResponse;
    
    
    //    NSURL * postUrl =[NSURL URLWithString:autoAllocateDoctorServie];
    
    NSURL * postUrl =[NSURL URLWithString:newAutoAllocateDoc];
    
    
    
    
    
    
    NSTimeZone *inputTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    
    
    //fetching local current time
    NSDate *now = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:inputTimeZone];
    
    NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:now]);
    
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone *inputTimeZone1 = [NSTimeZone localTimeZone];
    [dateFormatter1 setTimeZone:inputTimeZone1];
    
    
    
    [[NSUserDefaults standardUserDefaults]setObject:[dateFormatter stringFromDate:now] forKey:@"AppointmentStartTime"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
    
    
    
    //appending time by 30 min
    NSDate *timeAftrAppend=[now dateByAddingTimeInterval:(1800) ];
    NSString* timeAftrAppendStr =[dateFormatter stringFromDate:timeAftrAppend];
    
    NSString *timeAppendLocal=[dateFormatter1 stringFromDate:timeAftrAppend];
    
    
    
    
    
    
    [[NSUserDefaults standardUserDefaults]setObject:timeAftrAppendStr forKey:@"AppointmentEndTime"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
    
    
    NSMutableURLRequest * request =[[NSMutableURLRequest alloc]initWithURL:postUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    
    NSString * body =[NSString stringWithFormat:@"appointmentStartTime=%@&appointmentEndTime=%@&timeZone=%@",[dateFormatter1 stringFromDate:now],timeAppendLocal,[[NSTimeZone localTimeZone]name]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    if (!data) {
        NSLog(@"error...%@",error);
        NSLog(@"rturned.........");
        
        return;
    }
    
    json =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"json %@",json);
    if ([[json objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
        
        [SingletonClass sharedSingleton].deptId=5;
        
        //  NSArray *docNow=[json objectForKey:@"data"];
        
        [[NSUserDefaults standardUserDefaults]setObject:[json objectForKey:@"data"] forKey:@"DoctorNowId"];
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        dispatch_async(dispatch_get_global_queue(0, 0),^{
            
            [self doctorCallRate];
            
            dispatch_async(dispatch_get_main_queue(),^{
                
                [self popUp];
            });
            
        });
        
        
        
    }
    else{
        
        [self popUp];
        
    }
    
    
    
    
}


#pragma mark-Pop Up Action

-(void)popUp{
    
    
    
    
    
    
    backPopUp = [[UIView alloc]initWithFrame:CGRectMake(0, 800, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height)];
    backPopUp.backgroundColor =[UIColor lightGrayColor];
    [self.view addSubview:backPopUp];
    
    letsGetStartedPopUp=[[UIView alloc]init];
    letsGetStartedPopUp.frame = CGRectMake(10, 800, self.view.frame.size.width-20, self.view.frame.size.height-20);
    letsGetStartedPopUp.layer.cornerRadius=6.0f;
    letsGetStartedPopUp.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:1];
    letsGetStartedPopUp.clipsToBounds = YES;
    letsGetStartedPopUp.layer.shadowColor = [UIColor blackColor].CGColor;
    letsGetStartedPopUp.layer.shadowOffset = CGSizeMake(-2, 2);
    letsGetStartedPopUp.layer.shadowOpacity = 3;
    letsGetStartedPopUp.layer.shadowRadius = 15;
    letsGetStartedPopUp.layer.shadowPath = [UIBezierPath bezierPathWithRect:letsGetStartedPopUp.bounds].CGPath;
    
    [backPopUp addSubview:letsGetStartedPopUp];
    
    
    
    //[self.view insertSubview:letsGetStartedPopUp atIndex:2];
    
    [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        letsGetStartedPopUp.frame=CGRectMake(30, 40, self.view.frame.size.width-60, self.view.frame.size.height-140);
        backPopUp.frame=CGRectMake(00, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
    }completion:nil];
    
    
    
    
    UILabel *header=[[UILabel alloc]init];
    header.frame = CGRectMake(00,0,  letsGetStartedPopUp.frame.size.width, 150);
    
    if ([[json objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]){
        header.text=@"LETS GET\nSTARTED";
    }
    else{
        header.text=@"SORRY";
    }
    header.numberOfLines=2;
    header.font=[UIFont fontWithName:@"GothamRounded-Medium" size:30];
    header.textColor=[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1];
    header.textAlignment = NSTextAlignmentCenter;
    [letsGetStartedPopUp addSubview:header];
    
    UILabel *information=[[UILabel alloc]init];
    
    
    if(screenRect.size.height>=667){
        
        information.frame=CGRectMake(0,150,  self.view.frame.size.width-60-5, 80);
        
        information.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];
    }
    else{
        information.frame=CGRectMake(0,120,  self.view.frame.size.width-60-5, 60);
        information.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    }
    

    
    if ([[json objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]){
        
        information.text=@"Now we just need to set\nyou up with an account.\nDon't worry it wont take\nlong!.";
        
    }
    else{
        
        information.text=@"There is no doctors Available right now!!Please try after some time";
    }
    information.numberOfLines=7;
    information.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    information.textColor=[UIColor blackColor];
    information.textAlignment = NSTextAlignmentCenter;
    [letsGetStartedPopUp addSubview:information];
     UILabel *costInfo=[[UILabel alloc]init];
    UIButton*  couponButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];

    if ([[json objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]){
        
       

        if(screenRect.size.height>=667){
            
            costInfo.frame=CGRectMake(0,235,  self.view.frame.size.width-60-5, 70);
            costInfo.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
        }
        
        
        else{
            costInfo.frame=CGRectMake(0,175,  self.view.frame.size.width-60-5, 70);
            costInfo.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
        }
        
        costInfo.text=[NSString stringWithFormat:@"%@ minutes-$%@",[[callCost objectAtIndex:0]objectForKey:@"calltime"],[[callCost objectAtIndex:0]objectForKey:@"needtopay"] ] ;
        
        costInfo.textAlignment=NSTextAlignmentCenter;
        // costInfo.text=@"25 minutes-$50\n50 minutes-$95";
        costInfo.numberOfLines=2;
        costInfo.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
        costInfo.textColor=[UIColor blackColor];
        [letsGetStartedPopUp addSubview:costInfo];
        
               couponButton.frame=CGRectMake(10, letsGetStartedPopUp.frame.size.height-100,self.view.frame.size.width-60-30,20);
        [couponButton setTitle:@"Apply Coupon" forState:UIControlStateNormal];
        couponButton.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
        [couponButton setTitleColor:[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1] forState:UIControlStateNormal];
        [couponButton addTarget:self action:@selector(ApplyCouponActn) forControlEvents:UIControlEventTouchUpInside];
        [letsGetStartedPopUp addSubview:couponButton];
        
        
        
        
        
        
    }
    
    
    
    letsGoButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    letsGoButton.frame=CGRectMake(0,letsGetStartedPopUp.frame.size.height-50,letsGetStartedPopUp.frame.size.width, 50);
    [letsGoButton setTitle:@"OK!" forState:UIControlStateNormal];
    letsGoButton.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    [letsGoButton setBackgroundColor:[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1]];
    [letsGoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [letsGoButton addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
    letsGoButton.layer.cornerRadius=6.0f;
    
    [letsGetStartedPopUp addSubview:letsGoButton];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        header.frame = CGRectMake(0,0,  letsGetStartedPopUp.frame.size.width, 150);
        header.textAlignment = NSTextAlignmentCenter;
        header.font = [UIFont fontWithName:@"GothamRounded-Medium" size:50];
        
        costInfo.frame=CGRectMake(0,400,  self.view.frame.size.width-60-5, 70);
        costInfo.font=[UIFont fontWithName:@"GothamRounded-Medium" size:30];
        
        information.frame=  CGRectMake(40,150, letsGetStartedPopUp.frame.size.width-80, 300);
        information.font = [UIFont fontWithName:@"GothamRounded-Medium" size:30];
        information.textAlignment = NSTextAlignmentCenter;
        couponButton.frame=CGRectMake(letsGetStartedPopUp.frame.size.width/2-100, letsGetStartedPopUp.frame.size.height-200,250,80);
        couponButton.titleLabel.font = [UIFont fontWithName:@"GothamRounded-Medium" size:30];
        letsGoButton.frame=CGRectMake(0,letsGetStartedPopUp.frame.size.height-100,letsGetStartedPopUp.frame.size.width, 100);
        letsGoButton.titleLabel.font = [UIFont fontWithName:@"GothamRounded-Medium" size:30];
    }

}

#pragma mark-OK buttom Action

-(void)okAction{
    
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        letsGetStartedPopUp.frame=CGRectMake(30, 2000, self.view.frame.size.width-60, self.view.frame.size.height-60);
        backPopUp.frame = CGRectMake(0,2000, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }completion:^(BOOL finished){
        [backPopUp removeFromSuperview];
        
        if ([[json objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]])
        {
            AppointmentDurationVC *apptDuratn=[AppointmentDurationVC new];
            [self.navigationController pushViewController:apptDuratn animated:YES];
        }
        else
        {
            
        }
        
        
    }];
    
}
-(void)ApplyCouponActn{
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        letsGetStartedPopUp.frame=CGRectMake(30, 2000, self.view.frame.size.width-60, self.view.frame.size.height-60);
        backPopUp.frame = CGRectMake(0,2000, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }completion:^(BOOL finished){
        [backPopUp removeFromSuperview];
        [[NSUserDefaults standardUserDefaults]setObject:@"FreeCoupon" forKey:@"CouponType"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        ApplyCouponVC *coupon=[ApplyCouponVC new];
        [self.navigationController pushViewController:coupon animated:YES];
        
        
    }];
    
    
}
#pragma mark-Doctor Call Rate Services

-(void)doctorCallRate{
    callCost=[[NSMutableArray alloc]init];
    NSError * error ;
    NSURLResponse * urlResponse;
    
    NSURL * postUrl =[NSURL URLWithString:doctorCallCostService];
    
    
    NSLog(@"------->%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"symptomps"]);
    
    NSString * body;
    
  //  if([SingletonClass sharedSingleton].deptId==5)
        
      //  body =[NSString stringWithFormat:@"did=4&id=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"]];
    
   // else
        
        body =[NSString stringWithFormat:@"did=%@&id=%@",[NSString stringWithFormat:@"%d",[SingletonClass sharedSingleton].deptId],[[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"]];
    
    NSMutableURLRequest * request =[[NSMutableURLRequest alloc]initWithURL:postUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
    
    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (!data) {
        
        return;
    }
    
    id json =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    NSLog(@"json %@",json);
    if ([[json objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
        
        NSArray *ar=[json objectForKey:@"data"];
        for (int i=0; i<ar.count; i++) {
            
            
            [callCost addObject:[ar objectAtIndex:i]];
        }
    }
    else{
        
    }
    
    
    
    
    
}


@end
