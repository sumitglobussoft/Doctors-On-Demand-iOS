//
//  AddReferralSourceVC.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 9/11/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "AddReferralSourceVC.h"

@interface AddReferralSourceVC ()
{
    CGSize screenRect;
}


@end

@implementation AddReferralSourceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    screenRect = [[UIScreen mainScreen] bounds].size;
   
    
    
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    titleLable.text =@"REFERRAL";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font =[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
    [backButton setFrame:CGRectMake(15, 18, 55, 35)];    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
    
//   UIButton * skipButton =  [UIButton buttonWithType:UIButtonTypeCustom];
//    [skipButton setImage:[UIImage imageNamed:@"skip_btn.png"] forState:UIControlStateNormal];
//    [skipButton setFrame:CGRectMake(screenRect.width-60, 30, 45, 15)];
//    [skipButton addTarget:self action:@selector(skipAction) forControlEvents:UIControlEventTouchUpInside];
//    [headerView addSubview:skipButton];
//
    
    
    [self createUi];
    
    
    // Do any additional setup after loading the view.


    // Do any additional setup after loading the view.
}
-(void)createUi{
    UILabel *briefDescp=[[UILabel alloc]initWithFrame:CGRectMake(20,80, screenRect.width-30, 80)];

    briefDescp.numberOfLines=3;
    briefDescp.text=@"Did anyone refer you to\nDoctor On Demand?\nApply Coupon Code";
    briefDescp.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
    briefDescp.textColor=[UIColor blackColor];
    
    [self.view addSubview:briefDescp];
    
    
    UIButton *myEmployrBtn=[[UIButton alloc]initWithFrame:CGRectMake(10,160, screenRect.width-20, 50)];
    [myEmployrBtn setTitle:@"My Employer" forState:UIControlStateNormal];
    [myEmployrBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    myEmployrBtn.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
    [myEmployrBtn setBackgroundColor:[UIColor colorWithRed:(CGFloat)234/255 green:(CGFloat)30/255 blue:(CGFloat)99/255 alpha:(CGFloat)1.0]];
    [myEmployrBtn addTarget:self action:@selector(referalBtn1Action) forControlEvents:UIControlEventTouchUpInside];
    myEmployrBtn.layer.cornerRadius=10.0f;
    [self.view addSubview:myEmployrBtn];
    
    
    UIButton *myHealthCrBtn=[[UIButton alloc]initWithFrame:CGRectMake(10,220, screenRect.width-20, 50)];
    [myHealthCrBtn setTitle:@"My Health Care Provider" forState:UIControlStateNormal];
    myHealthCrBtn.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
    [myHealthCrBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [myHealthCrBtn setBackgroundColor:[UIColor colorWithRed:(CGFloat)234/255 green:(CGFloat)30/255 blue:(CGFloat)99/255 alpha:(CGFloat)1.0]];
    [myHealthCrBtn addTarget:self action:@selector(referalBtn2Action) forControlEvents:UIControlEventTouchUpInside];
    myHealthCrBtn.layer.cornerRadius=10.0f;
    [self.view addSubview:myHealthCrBtn];
    
    UIButton *myPharmBtn=[[UIButton alloc]initWithFrame:CGRectMake(10,280, screenRect.width-20, 50)];
    [myPharmBtn setTitle:@"My Pharmacy" forState:UIControlStateNormal];
    [myPharmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [myPharmBtn setBackgroundColor:[UIColor colorWithRed:(CGFloat)234/255 green:(CGFloat)30/255 blue:(CGFloat)99/255 alpha:(CGFloat)1.0]];
    myPharmBtn.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
    [myPharmBtn addTarget:self action:@selector(referalBtn3Action) forControlEvents:UIControlEventTouchUpInside];
    myPharmBtn.layer.cornerRadius=10.0f;
    [self.view addSubview:myPharmBtn];
    
    
    
    UIButton *noneBtn=[[UIButton alloc]initWithFrame:CGRectMake(10,340, screenRect.width-20, 50)];
    [noneBtn setTitle:@"None" forState:UIControlStateNormal];
    noneBtn.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
    [noneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [noneBtn setBackgroundColor:[UIColor grayColor]];
    [noneBtn addTarget:self action:@selector(noneBtnAction) forControlEvents:UIControlEventTouchUpInside];
    noneBtn.layer.cornerRadius=10.0f;
    [self.view addSubview:noneBtn];


    
}
-(void)noneBtnAction{
    
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",0] forKey:@"referalNo"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [self.navigationController popToRootViewControllerAnimated:YES];    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark-Referal Button Acion
-(void)referalBtn1Action{
    
    [[NSUserDefaults standardUserDefaults]setObject:@"BussinessType" forKey:@"CouponType"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d", 0] forKey:@"referalNo"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"hideSignIn" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"hideSignIn" object:nil];
    
   
   // if([SingletonClass sharedSingleton].deptId==4){
    ApplyCouponVC *coupon=[ApplyCouponVC new];
    [self.navigationController pushViewController:coupon animated:YES];
//    }
//    else{
//        SignUpView* signUp=[[SignUpView alloc]init];
//        [self.navigationController pushViewController:signUp animated:YES];
//
//    }
//    

    
}
-(void)referalBtn2Action{
  
    
    [[NSUserDefaults standardUserDefaults]setObject:@"BussinessType" forKey:@"CouponType"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",1] forKey:@"referalNo"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
   // if([SingletonClass sharedSingleton].deptId==4){
        ApplyCouponVC *coupon=[ApplyCouponVC new];
        [self.navigationController pushViewController:coupon animated:YES];
//    }
//    else{
//        SignUpView* signUp=[[SignUpView alloc]init];
//        [self.navigationController pushViewController:signUp animated:YES];
//        
//    }
//
//    
    
}
-(void)referalBtn3Action{
    
    [[NSUserDefaults standardUserDefaults]setObject:@"BussinessType" forKey:@"CouponType"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",2] forKey:@"referalNo"];
    [[NSUserDefaults standardUserDefaults]synchronize];

   // if([SingletonClass sharedSingleton].deptId==4){
        ApplyCouponVC *coupon=[ApplyCouponVC new];
        [self.navigationController pushViewController:coupon animated:YES];
    //}
//    else{
//        SignUpView* signUp=[[SignUpView alloc]init];
//        [self.navigationController pushViewController:signUp animated:YES];
//        
//    }
    
    
}

#pragma mark-skip Action
-(void)skipAction{
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",0] forKey:@"referalNo"];
    [[NSUserDefaults standardUserDefaults]synchronize];
     [self.navigationController popToRootViewControllerAnimated:YES];
//    CalendarViewController* calenderView=[[CalendarViewController alloc]init];
//    [self.navigationController pushViewController:calenderView animated:YES];
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
