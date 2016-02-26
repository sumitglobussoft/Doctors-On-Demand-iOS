//
//  HowToScheduleVC.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 8/26/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "HowToScheduleVC.h"

@interface HowToScheduleVC (){
     CGSize screenRect;
}

@end

@implementation HowToScheduleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    screenRect=[[UIScreen mainScreen]bounds].size;
    
    
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    titleLable.text =@"HOW TO SCHEDULE";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font =[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
  [backButton setFrame:CGRectMake(15, 18, 55, 35)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        headerView.frame= CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80);
        titleLable.frame= CGRectMake(60, 25, screenRect.width-120, 35);
        titleLable.font=[UIFont fontWithName:@"GothamRounded-Light" size:26];
        //titleLable.font =[UIFont systemFontOfSize:30];
        [backButton setImage:[UIImage imageNamed:@"back_btn_ipad.png"] forState:UIControlStateNormal];
        [backButton setFrame:CGRectMake(15, 30, 80, 25)];
        
       
        
        
    }

    [ self createUI];
    
    
    
    
    // Do any additional setup after loading the view.
}
-(void)createUI{
    UILabel *briefDescp=[[UILabel alloc]init];
    briefDescp.frame=CGRectMake(45, 70, screenRect.width-30, 30);
    
    briefDescp.numberOfLines=1;
    briefDescp.text=@"How would you like to schedule?";
    briefDescp.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
    briefDescp.textColor=[UIColor blackColor];
    
    [self.view addSubview:briefDescp];
    
    
     if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
         
         briefDescp.frame=CGRectMake(45, 100, screenRect.width-30, 30);
         briefDescp.text=@"How would you like to schedule?";
         briefDescp.font=[UIFont fontWithName:@"GothamRounded-Medium" size:30];
     }
    
    
    
    
    UIButton *findPsycholigistbtn=[[UIButton alloc]init];
    findPsycholigistbtn.frame=CGRectMake(10,120, screenRect.width-20, 50);
    if([SingletonClass sharedSingleton].deptId==3){
        [findPsycholigistbtn setTitle:@"Find a Psychologist" forState:UIControlStateNormal];
    }
    else if([SingletonClass sharedSingleton].deptId==1){
        [findPsycholigistbtn setTitle:@"Find a Lactation Consultant" forState:UIControlStateNormal];
        
    }
    else if([SingletonClass sharedSingleton].deptId==4){
        [findPsycholigistbtn setTitle:@"Find a Medical Doctor" forState:UIControlStateNormal];
        
    }
    else if([SingletonClass sharedSingleton].deptId==2){
        [findPsycholigistbtn setTitle:@"Find a Pediatric" forState:UIControlStateNormal];
        
    }
    findPsycholigistbtn.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];

    [findPsycholigistbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [findPsycholigistbtn setBackgroundColor:[UIColor colorWithRed:(CGFloat)234/255 green:(CGFloat)30/255 blue:(CGFloat)99/255 alpha:(CGFloat)1.0]];
    [findPsycholigistbtn addTarget:self action:@selector(findPsycholigistBtnAction) forControlEvents:UIControlEventTouchUpInside];
    findPsycholigistbtn.layer.cornerRadius=10.0f;
    
    
     if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
         
         findPsycholigistbtn.frame=CGRectMake(10,160, screenRect.width-20, 80);
         findPsycholigistbtn.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:25];
         
     }
    
    [self.view addSubview:findPsycholigistbtn];
    
    
    
    
    UIButton *findaTimeBtn=[[UIButton alloc]initWithFrame:CGRectMake(10,180, screenRect.width-20, 50)];
    findaTimeBtn.frame=CGRectMake(10,180, screenRect.width-20, 50);
    [findaTimeBtn setTitle:@"Find a Time" forState:UIControlStateNormal];
    [findaTimeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [findaTimeBtn setBackgroundColor:[UIColor colorWithRed:(CGFloat)234/255 green:(CGFloat)30/255 blue:(CGFloat)99/255 alpha:(CGFloat)1.0]];
    findaTimeBtn.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
    [findaTimeBtn addTarget:self action:@selector(findaTimeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    findaTimeBtn.layer.cornerRadius=10.0f;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        
        findaTimeBtn.frame=CGRectMake(10,260, screenRect.width-20, 80);
        findaTimeBtn.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:25];
        
    }
    
    [self.view addSubview:findaTimeBtn];
    




    
    
}
-(void)findPsycholigistBtnAction{
    
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"pshy"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"consultant"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    
    
    [[NSUserDefaults standardUserDefaults]setObject:@"byDoc" forKey:@"scheduleMethod"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
    
    
    ChoosePsychologistVC *choosePsychologist=[[ChoosePsychologistVC alloc]init];
    [self.navigationController pushViewController:choosePsychologist animated:YES];
    
    
}
-(void)findaTimeBtnAction{
    
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"pshy"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    [[NSUserDefaults standardUserDefaults]setObject:@"byTime" forKey:@"scheduleMethod"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    AppointmentDurationVC *appointmentDurationVC=[[AppointmentDurationVC alloc]init];
    [self.navigationController pushViewController:appointmentDurationVC animated:YES];
    
}


-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
