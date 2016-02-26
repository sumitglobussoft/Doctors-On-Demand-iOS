//
//  MyAccountVC.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 9/1/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "MyAccountVC.h"
#import "SingletonClass.h"
#import "ConnectionManager.h"

@interface MyAccountVC (){
    CGSize screenRect;
    NSArray *accountViewCells,*comment;
    UIView *letsGetStartedPopUp;
    
    
    UIView * backPopUp;
    

}

@end

@implementation MyAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    screenRect=[[UIScreen mainScreen]bounds].size;
    
    
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    titleLable.text =@"My Account";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font =[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [headerView addSubview:titleLable];
    
   
    
    
   UIButton *signOut=[UIButton buttonWithType:UIButtonTypeRoundedRect];
signOut.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-90, 25,100,25);
    
   // signOut.titleLabel.font =[UIFont systemFontOfSize:12];
    
    if([UIScreen mainScreen].bounds.size.width>=375&& [UIScreen mainScreen].bounds.size.height>=667){
        signOut.titleLabel.font =[UIFont fontWithName:@"GothamRounded-Medium" size:16];
    }
    else{
        signOut.titleLabel.font =[UIFont fontWithName:@"GothamRounded-Medium" size:14];
    }
    signOut.backgroundColor =[UIColor clearColor];
    [signOut setTitleColor:[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)30/255 blue:(CGFloat)49/255 alpha:(CGFloat)1] forState:UIControlStateNormal];

    [signOut setTitle:@"Sign Out" forState:UIControlStateNormal];
    
    
    [signOut addTarget:self action:@selector(signOutAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:signOut];
    
    
    
    
    [self createUi];
    
    if (UIUserInterfaceIdiomPad==UI_USER_INTERFACE_IDIOM()){
        
        headerView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80);
        signOut.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-130, 25,120,30);
        
         signOut.titleLabel.font =[UIFont fontWithName:@"GothamRounded-Medium" size:26];
        titleLable.frame= CGRectMake(60, 25, screenRect.width-120, 35);
        titleLable.font=[UIFont fontWithName:@"GothamRounded-Light" size:30];

        
        
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)signOutAction{
    
    self.tabBarController.tabBar.hidden=YES;
    
    backPopUp = [[UIView alloc]initWithFrame:CGRectMake(0, 800, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height)];
    backPopUp.backgroundColor =[UIColor lightGrayColor];
    [self.view addSubview:backPopUp];
    
    letsGetStartedPopUp=[[UIView alloc]initWithFrame:CGRectMake(10, 800, self.view.frame.size.width-20, self.view.frame.size.height-20)];
    letsGetStartedPopUp.layer.cornerRadius=6.0f;
    letsGetStartedPopUp.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:1];
    letsGetStartedPopUp.clipsToBounds = YES;
    letsGetStartedPopUp.layer.shadowColor = [UIColor blackColor].CGColor;
    letsGetStartedPopUp.layer.shadowOffset = CGSizeMake(-2, 2);
    letsGetStartedPopUp.layer.shadowOpacity = 3;
    letsGetStartedPopUp.layer.shadowRadius = 15;
    letsGetStartedPopUp.layer.shadowPath = [UIBezierPath bezierPathWithRect:letsGetStartedPopUp.bounds].CGPath;
    
    [backPopUp addSubview:letsGetStartedPopUp];
    UILabel *header=[[UILabel alloc]initWithFrame:CGRectMake(0,0,  self.view.frame.size.width-60-5, 150)];
    header.text=@"REALLY?";
    //header.font=[UIFont systemFontOfSize:30];
 header.font=[UIFont fontWithName:@"GothamRounded-Medium" size:30];
    header.textColor=[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1];
    header.textAlignment=NSTextAlignmentCenter;
    [letsGetStartedPopUp addSubview:header];
    
    [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        letsGetStartedPopUp.frame=CGRectMake(30, 70, self.view.frame.size.width-60, self.view.frame.size.height-140);
        backPopUp.frame=CGRectMake(00, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
    }completion:nil];
    

    
    UILabel *information=[[UILabel alloc]initWithFrame:CGRectMake(0,70,  self.view.frame.size.width-60-5, 300)];
    information.text=@"Are you sure you want to\nsign out?";
    information.numberOfLines=2;
   information.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    information.textColor=[UIColor blackColor];
    information.textAlignment=NSTextAlignmentCenter;
    [letsGetStartedPopUp addSubview:information];
    

   UIButton * noButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    noButton.frame=CGRectMake(0, letsGetStartedPopUp.frame.size.height-50,letsGetStartedPopUp.frame.size.width/2, 50);
    [noButton setTitle:@"No" forState:UIControlStateNormal];
    noButton.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    [noButton setBackgroundColor:[UIColor grayColor]];
    [noButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [noButton addTarget:self action:@selector(noAction) forControlEvents:UIControlEventTouchUpInside];
    [letsGetStartedPopUp addSubview:noButton];
 
    
    UIButton * yesButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    yesButton.frame=CGRectMake(letsGetStartedPopUp.frame.size.width/2, letsGetStartedPopUp.frame.size.height-50,letsGetStartedPopUp.frame.size.width/2, 50);
    [yesButton setTitle:@"Yes" forState:UIControlStateNormal];
    yesButton.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    [yesButton setBackgroundColor:[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1]];
    [yesButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [yesButton addTarget:self action:@selector(yesAction) forControlEvents:UIControlEventTouchUpInside];
    [letsGetStartedPopUp addSubview:yesButton];

    
    
  
    
    
    
    

    
}
-(void)yesAction

{
    [[NSUserDefaults standardUserDefaults]setObject:nil  forKey:@"patientid"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
   BaseViewController * baseVC=[[BaseViewController alloc]init];
    
//    AppDelegate *appdelegate =[UIApplication sharedApplication].delegate;
//    [appdelegate.window setRootViewController:firstViewVC];

    // [ConnectionManager.instance logOut];
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        
        letsGetStartedPopUp.frame=CGRectMake(30, 2000, self.view.frame.size.width-60, self.view.frame.size.height-60);
        backPopUp.frame = CGRectMake(0,2000, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }completion:^(BOOL finished){
//        ViewController *viewController=[[ViewController alloc]init];
//        [self.navigationController pushViewController:viewController animated:NO];
       // [self.navigationController popToRootViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"afterSignOut" object:nil];
        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"afterSignOut" object:nil];
        [self.navigationController pushViewController:baseVC animated:NO];
//       // [self.navigationController popViewControllerAnimated:YES];
//        [self dismissViewControllerAnimated:YES completion:nil];

    }];


    
    
    //viewController.hidesBottomBarWhenPushed=YES;
}
-(void)noAction{
     self.tabBarController.tabBar.hidden=NO;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        
        letsGetStartedPopUp.frame=CGRectMake(30, 2000, self.view.frame.size.width-60, self.view.frame.size.height-60);
        backPopUp.frame = CGRectMake(0,2000, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }completion:^(BOOL finished){
        
    }];

    
}
-(void)createUi{
    
    UIImageView *logoView = [[UIImageView alloc] init];
    if  (screenRect.height>=736){
        logoView.frame = CGRectMake(0, 70, screenRect.width, 210);
    }
    else{
    logoView.frame= CGRectMake(0, 70, screenRect.width, 160);

    }
    logoView.image=[UIImage imageNamed:@"my_account.jpg"];
    [logoView setContentMode:UIViewContentModeScaleAspectFit];
    
    
    
    [self.view addSubview:logoView];
    
    
    
    
//    UILabel *label=[[UILabel alloc]init];
//    label.frame=CGRectMake(10, 400, 100, 30);
//    label.text=@"Account:";
//    label.textColor=[UIColor blackColor];
//    [self.view addSubview:label];
    
    
    
    
    UITableView *tableView=[[UITableView alloc]init];
   // tableView.frame=CGRectMake(10, screenRect.height/2-50, screenRect.width-20, 300);
    tableView.backgroundColor=[UIColor clearColor];
    
    if(screenRect.height==480){
        
        tableView.frame=CGRectMake(10, screenRect.height/2-5, screenRect.width-20, screenRect.height/2-5);
        
        
    }
    else{
        tableView.frame=CGRectMake(10, screenRect.height/2-50, screenRect.width-20, screenRect.height/2+40);
    }

    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView setShowsVerticalScrollIndicator:NO];
    
    
    
    //table footer
   

    
    UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, screenRect.width-20, 200)];
     footerView.backgroundColor =[UIColor clearColor];

    
    UILabel *accntLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, screenRect.width, 30)];
    accntLbl.text=[NSString stringWithFormat:@"Account: %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"patientEmail"]];
    accntLbl.font=[UIFont fontWithName:@"Avenir-Light" size:12];
    accntLbl.textColor=[UIColor blackColor];
    [footerView addSubview:accntLbl];
    
    
    
    UILabel *versionLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, screenRect.width, 30)];
    versionLbl.text=@"Version 1.0 Build 1.0";
    versionLbl.font=[UIFont fontWithName:@"Avenir-Light" size:12];
    versionLbl.textColor=[UIColor blackColor];
    [footerView addSubview:versionLbl];
    
    
    tableView.tableFooterView = footerView;
    [self.view addSubview:tableView];
    
    
    accountViewCells=[NSArray arrayWithObjects:@"Get free Visit!",@"Apply Coupon",@"Add Referral Source",@"Update Name & Address",@"Update Password",@"Privacy Policy",@"Support",@"Apply Business Application",@"Feedback",nil];
//    comment=[NSArray arrayWithObjects:@" Free Vists!",@" Coupon",@" Referral Source",@" Email & Password",@" Name & Address",@" Payment Method",@"",@"",@"", nil];
    if (UIUserInterfaceIdiomPad==UI_USER_INTERFACE_IDIOM()){
   
        logoView.frame = CGRectMake(0, 80, screenRect.width,screenRect.height/2-50);
        logoView.image=[UIImage imageNamed:@"my_account.jpg"];
        
         tableView.frame=CGRectMake(10, screenRect.height/2+20, screenRect.width-20, screenRect.height/2-30);
        accntLbl.font=[UIFont fontWithName:@"GothamRounded-Medium" size:20];
 versionLbl.font=[UIFont fontWithName:@"GothamRounded-Medium" size:20];
        
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
    
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    cell.layer.cornerRadius = 3;
    cell.clipsToBounds = YES;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    
    
     cell.textLabel.text=[accountViewCells objectAtIndex:indexPath.section];
    cell.textLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];
    
    
      cell.accessoryView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"forward_arrow.png"]];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        cell.textLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:25];
    }

    
    
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    
    
    

    switch (indexPath.section) {
        case 0:{
           
            NSLog(@">>>>>>%ld",(long)indexPath.section);
            
            
            GetFreeVisitVc *freeVist=[GetFreeVisitVc new];
            [self.navigationController pushViewController:freeVist animated:YES];
        }
            break;
        
        case 1:{
            
            [[NSUserDefaults standardUserDefaults]setObject:@"FreeCoupon" forKey:@"CouponType"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            ApplyCouponVC *applyCoupon=[[ApplyCouponVC alloc]init];

            applyCoupon.hidesBottomBarWhenPushed = YES;

            [self.navigationController pushViewController:applyCoupon animated:YES];

            
            break;
        }
            
        case 2:{
            AddReferralSourceVC *addReferralVC=[[AddReferralSourceVC alloc]init];
            addReferralVC.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:addReferralVC animated:YES];
            break;
        }
            
        case 3:
        {
            
            UpdtNameAddressVC *updateProfile=[[UpdtNameAddressVC  alloc]init];
            [self.navigationController pushViewController:updateProfile animated:YES];

            
        }
            break;
            
        case 4:{
            UpdatePasswordVC *updatePass=[[UpdatePasswordVC  alloc]init];
            [self.navigationController pushViewController:updatePass animated:YES];
        }
                    break;
        case 5:{
                    }
            break;
        case 6:{
            SupportVC *support=[SupportVC new];
            [self.navigationController pushViewController:support animated:YES];
        }
            break;
            
        case 7:{
            
            BussinessApplication *bussiness=[[BussinessApplication alloc]init];
            [self.navigationController pushViewController:bussiness animated:YES];
            
        }
            break;
            

            

            
            
        default:
            break;
    }
    
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [accountViewCells count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

#pragma mark- See a doctor
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UIUserInterfaceIdiomPad==UI_USER_INTERFACE_IDIOM()) {
                    return 80;
    }
    else{
    
    
    
    if(screenRect.height>=667){
        
        
        return 50;
    }
    else{
        return 40;
    }
    }

}


@end
