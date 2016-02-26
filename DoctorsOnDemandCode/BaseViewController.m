//
//  BaseViewController.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 10/7/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "BaseViewController.h"
#import "MedicalView.h"
#import "PsychologyView.h"
#import "PediatricsView.h"
#import "PregAndNewView.h"
#import "SignInView.h"
#import "SignUpView.h"
#import "MeetUsView.h"
#import "MyAppointmentsVC.h"
#import "MyAccountVC.h"
#import "MyHealthVC.h"

#import "VideoChatViewController.h"
//const NSTimeInterval kChatPresenceTimeInterval = 45;


@interface BaseViewController (){
    UIButton *signup,*letsGoButton,*seeDocButton,*meetusButton,*signIn;
    CGRect screenRect;
    int height;
    id json;
    NSArray *jsonDate;
    int width;
    UIView *headerView,*backPopUp,*letsGetStartedPopUp;
    UIView *backView;
     NSMutableArray *callCost;
    NSMutableArray *timtStampAr;
    UITabBar *customBar;
    NSArray *tabArr;
    NSMutableArray *doctorNow;
    UIViewController *newViewController;

}
@property(nonatomic,strong)MedicalView * mdicalVC;
@property(nonatomic,strong)PsychologyView *psychologyVC;
@property(nonatomic,strong)PediatricsView *pediatricVC;
@property(nonatomic,strong)PregAndNewView *pregAndNewVC;


@end


@implementation BaseViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    
    
    screenRect = [[UIScreen mainScreen] bounds];
    height=screenRect.size.height;
    width=screenRect.size.width;
    
    NSLog(@"height====%d",height);
    
    NSLog(@"width====%d",width);
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeSignInName) name:@"changeSignInName" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(afterSignOut) name:@"afterSignOut" object:nil];

    
    [super viewDidLoad];
    
    
//    if([[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"]!=nil){
//        [self createView];
//        [self createCollectionView];
//        [self  changeSignInName];
//    }
//    else{
    [self createUI];
   
    
    if([[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"]!=nil){
        
        
        
        [self changeSignInName];
    }
    
    


   //}
    
    // Do any additional setup after loading the view.
}
-(void)changeSignInName{
    
    
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dismissVC) name:@"dismissViewController" object:nil];

    
    
    signIn.hidden=YES;
    signup.hidden=YES;
    meetusButton.hidden=YES;
    
    
    if (UIUserInterfaceIdiomPad==UI_USER_INTERFACE_IDIOM()) {
        UITabBarItem * health=[[UITabBarItem alloc]initWithTitle:@"My Health"image:[UIImage imageNamed:@"health_menu.png"] selectedImage:[UIImage imageNamed:@"health_menu.png"]];
        health.tag=0;
        
        
        UITabBarItem * appointment=[[UITabBarItem alloc]initWithTitle:@"My Appts" image:[UIImage imageNamed:@"myappt_menu.png"] selectedImage:[UIImage imageNamed:@"myappt_menu.png"]];
        appointment.tag=1;
        
        UITabBarItem * video=[[UITabBarItem alloc]initWithTitle:@"" image:[UIImage imageNamed:@"video_menu.png"] selectedImage:[UIImage imageNamed:@"video_menu.png"]];
        video.tag=2;
        
        UITabBarItem * meetUs=[[UITabBarItem alloc]initWithTitle:@"Meet Us" image:[UIImage imageNamed:@"dr_icon.png"] selectedImage:[UIImage imageNamed:@"dr_icon.png"]];
        meetUs.tag=3;
        
        UITabBarItem * account=[[UITabBarItem alloc]initWithTitle:@"Account" image:[UIImage imageNamed:@"user_menu.png"] selectedImage:[UIImage imageNamed:@"user_menu.png"]];
        account.tag=4;
        
        customBar = [[UITabBar alloc] init];
        if (UIUserInterfaceIdiomPad==UI_USER_INTERFACE_IDIOM()) {
            
            customBar.frame=CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 55);
        }else{
            customBar.frame=CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 55);
            
        }
        
        customBar.items = @[health,appointment,video,meetUs,account];
        
        customBar.delegate = self;
        customBar.selectedItem = video;
        customBar.barTintColor = [UIColor whiteColor];
        [[UITabBar appearance] setSelectedImageTintColor:[UIColor blueColor]];
        [self.view addSubview:customBar];

    }else{
    UITabBarItem * health=[[UITabBarItem alloc]initWithTitle:@"My Health"image:[UIImage imageNamed:@"health_menu.png"] selectedImage:[UIImage imageNamed:@"health_menu.png"]];
    health.tag=0;
    
    
    UITabBarItem * appointment=[[UITabBarItem alloc]initWithTitle:@"My Appts" image:[UIImage imageNamed:@"myappt_menu.png"] selectedImage:[UIImage imageNamed:@"myappt_menu.png"]];
    appointment.tag=1;
    
    UITabBarItem * video=[[UITabBarItem alloc]initWithTitle:@"" image:[UIImage imageNamed:@"video_menu.png"] selectedImage:[UIImage imageNamed:@"video_menu.png"]];
    video.tag=2;
    
    UITabBarItem * meetUs=[[UITabBarItem alloc]initWithTitle:@"Meet Us" image:[UIImage imageNamed:@"dr_icon.png"] selectedImage:[UIImage imageNamed:@"dr_icon.png"]];
    meetUs.tag=3;
    
    UITabBarItem * account=[[UITabBarItem alloc]initWithTitle:@"Account" image:[UIImage imageNamed:@"user_menu.png"] selectedImage:[UIImage imageNamed:@"user_menu.png"]];
    account.tag=4;
        
        customBar = [[UITabBar alloc] init];
        if (UIUserInterfaceIdiomPad==UI_USER_INTERFACE_IDIOM()) {
            
            customBar.frame=CGRectMake(0, self.view.frame.size.height-80, self.view.frame.size.width, 80);
        }else{
            customBar.frame=CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 55);
            
        }
        
        customBar.items = @[health,appointment,video,meetUs,account];
        
        customBar.delegate = self;
        customBar.selectedItem = video;
        customBar.barTintColor = [UIColor whiteColor];
        [[UITabBar appearance] setSelectedImageTintColor:[UIColor blueColor]];
        [self.view addSubview:customBar];

    }
    
    
    MyHealthVC *healthVC=[[MyHealthVC alloc]init];
    healthVC.title = @"My Health";
    [self addChildViewController:healthVC];
    
    MyAppointmentsVC *appointmentVC=[[MyAppointmentsVC alloc]init];
    appointmentVC.title = @"My Appointments";
    [self addChildViewController:appointmentVC];
    
    ViewController *mainVC=[[ViewController alloc]init];
    mainVC.title=@"";
    [self addChildViewController:mainVC];

    
    MeetUsView *meetUsVC= [[MeetUsView alloc] init];
    meetUsVC.title = @"Meet Us";
    [self addChildViewController:meetUsVC];
    
    MyAccountVC *accountVC = [[MyAccountVC alloc] init];
    accountVC.title = @"My Account";
    [self addChildViewController:accountVC];
    
   
    
    
    
    
    NSArray *tabBarArray = @[healthVC,appointmentVC,mainVC,meetUsVC,accountVC];
    tabArr=[tabBarArray copy];
    
    
 //   [customBar setSelectedItem:mainVC];
    
    
}
#pragma mark- After signout
-(void)afterSignOut{
    
    //customBar.hidden=YES;
    
    
//    meetusButton.hidden = NO;
//    signup.hidden= NO;
    

    
    
 [self createUI];
   // [self createCollectionView];
  [[NSNotificationCenter defaultCenter]removeObserver:self name:@"afterSignOut" object:nil];
    [newViewController.view removeFromSuperview];
}

#pragma mark-tab bar delegates
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
   newViewController= [tabArr objectAtIndex:item.tag];

[backView addSubview:newViewController.view];
    
    

   
    
}




-(void)createUI{
    
    
    screenRect = [[UIScreen mainScreen] bounds];
    height=screenRect.size.height;
    width=screenRect.size.width;
    
    NSLog(@"height====%d",height);
    
    NSLog(@"width====%d",width);
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    
    
    
    signup=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    if(screenRect.size.height==480){
         signup.frame=CGRectMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height-50,160,50);
    }
    else if (screenRect.size.height==568){
        signup.frame=CGRectMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height-50,160,50);
    }
    else if (screenRect.size.height==667)
        signup.frame=CGRectMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height-60,[UIScreen mainScreen].bounds.size.width/2,60);
    else
        
        signup.frame=CGRectMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height-70,[UIScreen mainScreen].bounds.size.width/2,70);
    
   
    signup.backgroundColor=[UIColor redColor];
    [signup setBackgroundImage:[UIImage imageNamed:@"signup_home.png"] forState:UIControlStateNormal];
    [signup addTarget:self action:@selector(signUp) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signup];
    
    meetusButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    if(screenRect.size.height==480 || screenRect.size.height==568)
    meetusButton.frame=CGRectMake(0, height-50,165,49);
    
    else if(screenRect.size.height==667)
        meetusButton.frame=CGRectMake(0, [UIScreen mainScreen].bounds.size.height-60,[UIScreen mainScreen].bounds.size.width/2,60);
    else
          meetusButton.frame=CGRectMake(0, [UIScreen mainScreen].bounds.size.height-70,[UIScreen mainScreen].bounds.size.width/2,70);
        
    meetusButton.backgroundColor=[UIColor colorWithRed:(CGFloat)242/255 green:(CGFloat)246/255 blue:(CGFloat)247/255 alpha:1];
    [meetusButton setBackgroundImage:[UIImage imageNamed:@"meetup_btn.png"] forState:UIControlStateNormal];
    // meetusButton.layer.shadowColor=[UIColor blackColor].CGColor;
    [meetusButton addTarget:self action:@selector(meetupAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:meetusButton];
    
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        meetusButton.frame= CGRectMake(0, height-90,width/2,90);
        [meetusButton setBackgroundImage:[UIImage imageNamed:@"meet_up_btn_ipad.png"] forState:UIControlStateNormal];
        
        signup.frame=CGRectMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height-90,width/2,90);
        signup.backgroundColor=[UIColor redColor];
        [signup setBackgroundImage:[UIImage imageNamed:@"signup_btn_ipad.png"] forState:UIControlStateNormal];
        
    }
    
    
    
    [self createView];
    [self createCollectionView];
    
}
-(void)createView{
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
    
    backView =[[UIView alloc]init];
    backView.frame=CGRectMake(0, 0, screenRect.size.width, screenRect.size.height-75);
    
    
    if (UIUserInterfaceIdiomPad==UI_USER_INTERFACE_IDIOM()) {
        backView.frame=  CGRectMake(0, 0, screenRect.size.width, screenRect.size.height-90);
        hit = 50;
    }
    backView.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    [self.view addSubview:backView];

    
    
    
    headerView =[[UIView alloc]init];
    headerView.frame = frame;
    headerView.backgroundColor =[UIColor whiteColor];
    [backView addSubview:headerView];
    
    UIImageView * logo =[[UIImageView alloc]init];
    logo.frame=CGRectMake(10, 15, [[UIScreen mainScreen] bounds].size.width/2+70,35);
    
    logo.image= [UIImage imageNamed:@"logo.png"];
    
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad) {
        //        headerView.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-100, 20,100,60);
        logo.frame=CGRectMake(10, 30, [[UIScreen mainScreen] bounds].size.width/2+10,35);
        //signIn.titleLabel.font =[UIFont systemFontOfSize:25];
    }

    [headerView addSubview:logo];

    seeDocButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad) {
        seeDocButton.frame=CGRectMake(40, 100,[UIScreen mainScreen].bounds.size.width-80,120);
        
        [seeDocButton setBackgroundImage:[UIImage imageNamed:@"see_doctor_btn_ipad@2x"] forState:UIControlStateNormal];
    }else{
    if(screenRect.size.width>=375&&screenRect.size.height>=667){
        seeDocButton.frame=CGRectMake(10, 70,screenRect.size.width-20,80);
        
        [seeDocButton setBackgroundImage:[UIImage imageNamed:@"see_doctor_btn6.png"] forState:UIControlStateNormal];

    }
    else{
    
    seeDocButton.frame=CGRectMake(width/2-148, 70,297,72);
   
    [seeDocButton setBackgroundImage:[UIImage imageNamed:@"see_btn.png"] forState:UIControlStateNormal];
    }
    }
       [seeDocButton addTarget:self action:@selector(videoChatView) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:seeDocButton];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeSignInName) name:@"changeSignInName" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(afterSignOut) name:@"afterSignOut" object:nil];
    
    signIn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    signIn.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-66, 25,66,25);
    signIn.backgroundColor =[UIColor clearColor];
    [signIn setTitleColor:[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)30/255 blue:(CGFloat)49/255 alpha:(CGFloat)1] forState:UIControlStateNormal];
    
    
    if(screenRect.size.width>=375&&screenRect.size.height>=667){
    signIn.titleLabel.font =[UIFont fontWithName:@"GothamRounded-Medium" size:16];
    }
    else{
        signIn.titleLabel.font =[UIFont fontWithName:@"GothamRounded-Medium" size:14];
    }
    [signIn setTitle:@"Sign In" forState:UIControlStateNormal];
    [signIn addTarget:self action:@selector(signIn) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:signIn];
    

    
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad) {
        signIn.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-150, 30,130,30);
        signIn.titleLabel.font =[UIFont fontWithName:@"GothamRounded-Medium" size:26];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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
            layout.itemSize = CGSizeMake(190,190);
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
    _collectionView.scrollEnabled=NO;
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    [backView addSubview:_collectionView];
    
    
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
        
        
        [SingletonClass sharedSingleton].deptId=4;
        _mdicalVC = [[MedicalView alloc]init];
        _mdicalVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController  pushViewController:_mdicalVC animated:YES];
    }
    else if(indexPath.row==1)
    {       if (!_psychologyVC) {
        _psychologyVC = nil;
    }
        [SingletonClass sharedSingleton].deptId=3;
        _psychologyVC = [[PsychologyView alloc]init];
        _psychologyVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController  pushViewController:_psychologyVC animated:YES];
        
    }
    else if(indexPath.row==2)
    {
        if (!_pediatricVC) {
            _pediatricVC = nil;
        }
        
        [SingletonClass sharedSingleton].deptId=2;
        _pediatricVC = [[PediatricsView alloc]init];
        _pediatricVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController  pushViewController:_pediatricVC animated:YES];
    }
    else if(indexPath.row==3)
    {if (!_pregAndNewVC) {
        _pregAndNewVC = nil;
    }
        [SingletonClass sharedSingleton].deptId=1;
        _pregAndNewVC = [[PregAndNewView alloc]init];
        _pregAndNewVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController  pushViewController:_pregAndNewVC animated:YES];
        
    }
    
    
}

#pragma mark-Sign up Action
-(void)signUp{
    SignUpView *signUp=[[SignUpView alloc]init];
    [self.navigationController pushViewController:signUp animated:YES];
    
}
#pragma MeetUp in Action
-(void)meetupAction
{
//    QBUUser *user = [QBUUser user];
//    user.ID=4931841;
//    user.login = @"Sukhmeet";
//    user.password = @"globussoft";
//    //[helperObj chatLogin:user];
//    [QBChat.instance loginWithUser:user];
//    [QBChat.instance addDelegate:self];
    MeetUsView *meetUs=[[MeetUsView alloc]init];
    [self .navigationController pushViewController:meetUs animated:YES];
}
#pragma mark-Sign in Action
-(void)signIn
{
    
    // [self callUserForVideoChat];
    SignInView *signInView=[[SignInView alloc]init];
    
    [self.navigationController pushViewController:signInView animated:YES];
    
}

-(void)videoChatView
{
    [[NSUserDefaults standardUserDefaults]setObject:nil
                                             forKey:@"MYHEALTH"];
    [[NSUserDefaults standardUserDefaults]synchronize];
//    self.navigationController.navigationBar.hidden = NO;
//    LoginViewController *chatLogin = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"startStoryBoard"];
//    
//    [self.navigationController pushViewController:chatLogin animated:YES];
//    
   // ---------------------------------------------------------------------------------------
    
    
    if([[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"]==nil){
        SignInView *signIn=[SignInView new];
        [self.navigationController pushViewController:signIn animated:YES];
    }
    else{
        if([SingletonClass networkcheck]==YES){
            [SingletonClass sharedSingleton].deptId=5;

    [self fetchFreeDoctors];
        }
        
        else
            [self networkWarning];
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(afterCouponApply) name:@"changeCallRate" object:nil];
    }
    //---------------------------------------------------------------------------------------

    
}
#pragma mark-Dismiss VC
-(void)dismissVC{
    
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"dismissViewController" object:nil];

   
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
#pragma mark-Convert UTC to local
-(NSString*)fetchdate:(NSString *)dateStr{
    
    
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    
    // [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    //
    NSDate *date=[dateFormat dateFromString:dateStr];
    
    
    
    NSDateFormatter *utc=[[NSDateFormatter alloc]init];
    //[utc setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    [utc setTimeZone:[NSTimeZone localTimeZone]];
    //  NSString *utcstr=[utc stringFromDate:date];
    
    [utc setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString * resultDate =[utc stringFromDate:date];
    
    
    return resultDate;
    
}



#pragma mark-After Coupo Apply

-(void)afterCouponApply{
    dispatch_async(dispatch_get_global_queue(0, 0),^{
        
        [self doctorCallRate];
        
        dispatch_async(dispatch_get_main_queue(),^{
            
            [self popUp];
        });
        
    });
    
    
    
    
    
    

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
        
        letsGetStartedPopUp.frame=CGRectMake(30, 60, self.view.frame.size.width-60, self.view.frame.size.height-100);
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
        
        
        
        costInfo.text=[NSString stringWithFormat:@"%@ minutes-$%@",[[callCost objectAtIndex:0]objectForKey:@"calltime"],[[callCost objectAtIndex:0]objectForKey:@"needtopay"]] ;
        
        costInfo.textAlignment=NSTextAlignmentCenter;
        // costInfo.text=@"25 minutes-$50\n50 minutes-$95";
        costInfo.numberOfLines=2;
       
        costInfo.textColor=[UIColor blackColor];
        [letsGetStartedPopUp addSubview:costInfo];
        
     
       couponButton.frame=CGRectMake(10, letsGetStartedPopUp.frame.size.height-100,self.view.frame.size.width-60-30,20);
        [couponButton setTitle:@"Apply Coupon" forState:UIControlStateNormal];
        couponButton.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
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
        
        letsGetStartedPopUp.frame=CGRectMake(30, 2200, self.view.frame.size.width-60, self.view.frame.size.height-60);
        backPopUp.frame = CGRectMake(0,2200, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
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
    
    //if([SingletonClass sharedSingleton].deptId==5)
        
     //   body =[NSString stringWithFormat:@"did=4&id=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"]];
    
    //else
        
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
#pragma mark-Network Warning
-(void)networkWarning{
    
    
    
    
    
    
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
        
        letsGetStartedPopUp.frame=CGRectMake(30, 60, self.view.frame.size.width-60, self.view.frame.size.height-100);
        backPopUp.frame=CGRectMake(00, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
    }completion:nil];
    
    
    
    
    UILabel *header=[[UILabel alloc]init];
    header.frame = CGRectMake(00,0,  letsGetStartedPopUp.frame.size.width, 150);
    
    
    header.text=@"NETWORK\nISSUE!";
    
    header.numberOfLines=2;
    header.font=[UIFont fontWithName:@"GothamRounded-Medium" size:30];
    header.textColor=[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1];
    header.textAlignment = NSTextAlignmentCenter;
    [letsGetStartedPopUp addSubview:header];
    
    UILabel *information=[[UILabel alloc]init];
    information.frame=  CGRectMake(20,50, letsGetStartedPopUp.frame.size.width-40, 300);
    
    
    
    information.text=@"The network appears to be\nunavailable.\n\nPlease check your\nconnection and try again";
    
    information.numberOfLines=8;
    information.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    information.textColor=[UIColor blackColor];
    information.textAlignment = NSTextAlignmentCenter;
    [letsGetStartedPopUp addSubview:information];
    
    
    UIButton*  okButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    okButton.frame=CGRectMake(0,letsGetStartedPopUp.frame.size.height-50,letsGetStartedPopUp.frame.size.width, 50);
    [okButton setTitle:@"OK!" forState:UIControlStateNormal];
    okButton.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    [okButton setBackgroundColor:[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1]];
    [okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okButton addTarget:self action:@selector(networkOk) forControlEvents:UIControlEventTouchUpInside];
    okButton.layer.cornerRadius=6.0f;
    
    [letsGetStartedPopUp addSubview:okButton];
    
}

-(void)networkOk{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        letsGetStartedPopUp.frame=CGRectMake(30, 2000, self.view.frame.size.width-60, self.view.frame.size.height-60);
        backPopUp.frame = CGRectMake(0,2000, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }completion:^(BOOL finished){
        [backPopUp removeFromSuperview];
        
    }];
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
