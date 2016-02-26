//
//  MedicalView.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 8/8/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "MedicalView.h"
#import "PediatricsView.h"
@interface MedicalView (){
CGSize screenRect;
    NSArray *medicalViewCells,*medicalViewCellsImg;
    UIView *letsGetStartedPopUp;
    UIButton *couponButton;
    NSMutableArray *callCost;
    UIView * backPopUp;
    UIButton *letsGoButton;
    SignInView *signIn;
    id json;
    NSMutableArray *timtStampAr;
    UITableView *tableView;
    UIActivityIndicatorView *activityIndicator;
}
@end

@implementation MedicalView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"consultant"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"pshy"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    

    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"pop"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    screenRect=[[UIScreen mainScreen]bounds].size;
   
    [SingletonClass sharedSingleton].deptId=4;
    [[NSUserDefaults standardUserDefaults]setObject:nil
                                             forKey:@"MYHEALTH"];
    [[NSUserDefaults standardUserDefaults]synchronize];
   
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];

    
       
    
    UIView * headerView =[[UIView alloc]init];
    headerView.frame= CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55);
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]init];
    titleLable.frame= CGRectMake(60, 25, screenRect.width-120, 25);
    titleLable.font =[UIFont systemFontOfSize:15];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.text =@"MEDICAL";
    titleLable.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
     [backButton setFrame:CGRectMake(15, 18, 55, 35)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
    if (UIUserInterfaceIdiomPad== UI_USER_INTERFACE_IDIOM()) {
        
         headerView.frame= CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80);
        
        [backButton setImage:[UIImage imageNamed:@"back_btn_ipad.png"] forState:UIControlStateNormal];
        [backButton setFrame:CGRectMake(15, 30, 80, 30)];
        
//        titleLable.frame= CGRectMake(60, 25, screenRect.width-120, 35);
//        titleLable.font =[UIFont boldSystemFontOfSize:25];
        titleLable.frame= CGRectMake(60, 25, screenRect.width-120, 35);
        titleLable.font=[UIFont fontWithName:@"GothamRounded-Light" size:30];
    }
  
    [self createUi];
    
    
    

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)createUi{
    UIImageView *logoView = [[UIImageView alloc]init];
    
    
    if (UIUserInterfaceIdiomPad== UI_USER_INTERFACE_IDIOM()) {
        
         logoView.frame = CGRectMake(0, 80, screenRect.width,screenRect.height/2-50);
        logoView.image=[UIImage imageNamed:@"medical_img_back.png"];
        
    }
    
    else{

    
    if(screenRect.height==667){
        logoView.frame = CGRectMake(0, 70, screenRect.width, 190);
    }
    
    else if (screenRect.height>=736){
        logoView.frame = CGRectMake(0, 70, screenRect.width, 210);
    }
    else
    logoView.frame = CGRectMake(0, 70, screenRect.width, 160);
   
    
    logoView.image=[UIImage imageNamed:@"medical_img_back.png"];
    }
    [logoView setContentMode:UIViewContentModeScaleAspectFit];
    
    //[logoView sizeToFit];
    
    [self.view addSubview:logoView];
    
    tableView=[[UITableView alloc]init];
    
     if (UIUserInterfaceIdiomPad== UI_USER_INTERFACE_IDIOM())
         tableView.frame=CGRectMake(10, screenRect.height/2+20, screenRect.width-20, screenRect.height/2-30);

    
         else{
    if(screenRect.height==480){
   
        tableView.frame=CGRectMake(10, screenRect.height/2-5, screenRect.width-20, screenRect.height/2-5);

        
    }
    else{
    tableView.frame=CGRectMake(10, screenRect.height/2-50, screenRect.width-20, screenRect.height/2+40);
    }
         }
    tableView.backgroundColor=[UIColor clearColor];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:tableView];
    
    

    
    medicalViewCells=[NSArray arrayWithObjects:@"",@"Schedule an Appointment",@"What is a Video Visit?",@"What Do We treat?",@"Meet Our Doctors",@"About Doctor On Demand", nil];
    medicalViewCellsImg =[NSArray arrayWithObjects:@"",@"schedule_icon.png",@"videoplay_icon.png",@"question_icon.png",@"user_icon.png",@"dr_icon.png", nil];
    
   }
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    if(UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad){
        cell.textLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:25];

            }
    
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
  
    
    if (indexPath.section == 0) {
        UIButton *cellButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        
        if(screenRect.height>=667){
            
               cellButton.frame = CGRectMake(0, 0, screenRect.width-20,75);
        }
        else
        cellButton.frame = CGRectMake(0, 0, screenRect.width-20,60);
        [cellButton setBackgroundImage: [UIImage imageNamed:@"see_btn"] forState:UIControlStateNormal];
        [cellButton addTarget:self action:@selector(seeDocNowFun) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:cellButton];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
           
                [cellButton setBackgroundImage: [UIImage imageNamed:@"see_doctor_btn_ipad.png"] forState:UIControlStateNormal];
           cellButton.frame = CGRectMake(0, 0, screenRect.width-20,120);
        }

    }
    else{
        
        
       // cell.imageView.frame = CGRectMake(10, 2, 22, 22);
        cell.textLabel.text = [medicalViewCells objectAtIndex:indexPath.section];
        cell.textLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];
        cell.imageView.image = [UIImage imageNamed:[medicalViewCellsImg objectAtIndex:indexPath.section]];
        cell.accessoryView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"forward_arrow.png"]];
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
           cell.textLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:25];
        }

        }
    
    
  
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@ "ROW-%ld Content-%@",(long)indexPath.row+1,[medicalViewCells objectAtIndex:indexPath.row]);
    NSLog(@"section>>>>>>%ld",(long)indexPath.section);
 
    
    switch (indexPath.section) {
        case 0:
           // [self seeADoctor];
             [SingletonClass sharedSingleton].deptId=4;
           //[self fetchFreeDoctors];
            NSLog(@">>>>>>%ld",(long)indexPath.section);
            
            break;
        case 1:
            
            [SingletonClass sharedSingleton].deptId=4;

               [self seeADoctor];
            
            break;
            
        case 2:
        {
           // [SingletonClass sharedSingleton].deptId=4;

            [SingletonClass sharedSingleton].deptId=4;
            VideoVisitVC *videoVisit=[[VideoVisitVC alloc]init];
            [self.navigationController pushViewController:videoVisit animated:YES];
        }
            break;
            
        case 3:{
            [SingletonClass sharedSingleton].deptId=4;
            WhatWeTreatVC *whatWetreat=[WhatWeTreatVC new];
            [self.navigationController pushViewController:whatWetreat animated:YES];
        }
          
            break;
            
        case 4:{
            [SingletonClass sharedSingleton].deptId=4;
            OurDoctorsVC *doctor=[[OurDoctorsVC alloc]init];
            [self.navigationController pushViewController:doctor animated:YES];
        }
            break;
        case 5:{
            [SingletonClass sharedSingleton].deptId=4;
            AboutVC *about=[AboutVC new];
              [self.navigationController pushViewController:about animated:YES];
            
        }
           
            break;
        case 6:
            
            break;
            

            
            
        default:
            break;
    }
    
 
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [medicalViewCells count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad) {
        if (section == 0) {
            return  0;
        }

        return  30;
    }
    else{
        if (section == 0) {
            return  0;
        }

        return 10;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UIUserInterfaceIdiomPad==UI_USER_INTERFACE_IDIOM()) {
        if(indexPath.section==0 && indexPath.row==0){
            
            return 120;
        }
        else
            return 80;
    }
    else{
    if(indexPath.section==0 && indexPath.row==0){
        if(screenRect.height>=667){
            
            return 75;
        }
        else
        return 60;
    }
    else
        if(screenRect.height>=667){

            
              return 50;
          }
          else{
        return 40;
          }
    }
    
}


#pragma mark- See a doctor
-(void)seeADoctor{
    
    
    if([[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"]!=nil){
    
        
        if([SingletonClass networkcheck]==YES){
        [self activityAction];
        callCost=[[NSMutableArray alloc]init];
        
        
        
        
        dispatch_async(dispatch_get_global_queue(0, 0),^{
            
            
            [self doctorCallRate];
            
            dispatch_async(dispatch_get_main_queue(),^{
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
                header.text=@"LET'S GET\nSTARTED!";
                header.numberOfLines=2;
                header.font=[UIFont fontWithName:@"GothamRounded-Medium" size:30];
                header.textColor=[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1];
                header.textAlignment = NSTextAlignmentCenter;
                [letsGetStartedPopUp addSubview:header];
                
                UILabel *information=[[UILabel alloc]init];
                
                
                if(screenRect.height>=667){
                    
                    information.frame=CGRectMake(0,150,  self.view.frame.size.width-60-5, 80);
                    
                    information.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];
                }
                else{
                    information.frame=CGRectMake(0,120,  self.view.frame.size.width-60-5, 60);
                    information.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
                }
                

                information.text=@"We need some info to get\nyou the best possible care.\nYour visit costs:";
                information.numberOfLines=7;
                information.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
                information.textColor=[UIColor blackColor];
                information.textAlignment = NSTextAlignmentCenter;
                [letsGetStartedPopUp addSubview:information];
                
                UILabel *costInfo=[[UILabel alloc]init];
                
                
                if(screenRect.height>=667){
                    
                    costInfo.frame=CGRectMake(0,235,  self.view.frame.size.width-60-5, 70);
                    costInfo.font=[UIFont fontWithName:@"GothamRounded-Medium" size:15];
                }
                
                
                else{
                    costInfo.frame=CGRectMake(0,175,  self.view.frame.size.width-60-5, 70);
                    costInfo.font=[UIFont fontWithName:@"GothamRounded-Medium" size:13];
                }
                
                if(callCost.count!=0){
                
                costInfo.text=[NSString stringWithFormat:@"%@ minutes-$%@",[[callCost objectAtIndex:0]objectForKey:@"calltime"],[[callCost objectAtIndex:0]objectForKey:@"needtopay"]] ;
                }
                
                
                
                costInfo.textAlignment=NSTextAlignmentCenter;
                costInfo.numberOfLines=2;
                costInfo.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
                costInfo.textColor=[UIColor blackColor];
                [letsGetStartedPopUp addSubview:costInfo];

                
                couponButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
               couponButton.frame=CGRectMake(10, letsGetStartedPopUp.frame.size.height-100,self.view.frame.size.width-60-30,20);
                
                [couponButton setTitle:@"Apply Coupon" forState:UIControlStateNormal];
                couponButton.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
                [couponButton setTitleColor:[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1] forState:UIControlStateNormal];
                [couponButton addTarget:self action:@selector(ApplyCouponActn) forControlEvents:UIControlEventTouchUpInside];
                [letsGetStartedPopUp addSubview:couponButton];
                
                letsGoButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
                letsGoButton.frame=CGRectMake(0,letsGetStartedPopUp.frame.size.height-50,letsGetStartedPopUp.frame.size.width, 50);
                [letsGoButton setTitle:@"Let's Go!" forState:UIControlStateNormal];
                letsGoButton.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
                [letsGoButton setBackgroundColor:[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1]];
                [letsGoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [letsGoButton addTarget:self action:@selector(letsGo) forControlEvents:UIControlEventTouchUpInside];
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
                [activityIndicator stopAnimating];
            });
            
        });

            }
        
        
        else
            [self networkWarning];
        
    }
    
        else{
            
            signIn=[[SignInView alloc]init];
            [self.navigationController pushViewController:signIn animated:YES];
            
        }
    
    
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)letsGo{

    SetUpView *setUpView=[[SetUpView alloc]init];
    
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        letsGetStartedPopUp.frame=CGRectMake(30, 2000, self.view.frame.size.width-60, self.view.frame.size.height-60);
        backPopUp.frame = CGRectMake(0,2000, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }completion:^(BOOL finished){
        [backPopUp removeFromSuperview];
        [self.navigationController pushViewController:setUpView animated:YES];
        
        
      
        
    }];
    
    
}


#pragma mark-Apply coupon Btn Action

-(void)ApplyCouponActn{
    [[NSUserDefaults standardUserDefaults]setObject:@"FreeCoupon" forKey:@"CouponType"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    NSString *patientID=[[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"];
    
    if(patientID == nil){
        SignUpView *signUp=[[SignUpView alloc]init];
        [self.navigationController pushViewController:signUp animated:YES];
    }
    else{
   
    ApplyCouponVC *applyCoupon=[[ApplyCouponVC alloc]init];
    
    
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        letsGetStartedPopUp.frame=CGRectMake(30, 700, self.view.frame.size.width-60, self.view.frame.size.height-60);
        backPopUp.frame = CGRectMake(0,800, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }completion:^(BOOL finished){
        applyCoupon.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:applyCoupon animated:YES];
        
        
    }];
    }
    
    
}



#pragma mark-SeeDocNowFun

-(void)seeDocNowFun{
    
    
    
    NSLog(@"--->%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"]);
    if([[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"]!=nil){
      
        [SingletonClass sharedSingleton].deptId=5;
        [self fetchFreeDoctors];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(afterCouponApply) name:@"changeCallRate" object:nil];
    }
    
    else{
        
        signIn=[[SignInView alloc]init];
        [self.navigationController pushViewController:signIn animated:YES];
    }
    

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
        
        [self activityAction];
        dispatch_async(dispatch_get_global_queue(0, 0),^{
            
            [self doctorCallRate];
            
            dispatch_async(dispatch_get_main_queue(),^{
                
                [self popUp];
                [activityIndicator stopAnimating ];
                
            });
            
        });
        
        
        
        
    }
    else{
        [self popUp];
    }
    
    
    
    
    
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
    
    
    if(screenRect.height>=667){
        
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
    

    
    if ([[json objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]){
        
        
        if(screenRect.height>=667){
            
            costInfo.frame=CGRectMake(0,235,  self.view.frame.size.width-60-5, 70);
            costInfo.font=[UIFont fontWithName:@"GothamRounded-Medium" size:15];
        }
        
        
        else{
            costInfo.frame=CGRectMake(0,175,  self.view.frame.size.width-60-5, 70);
            costInfo.font=[UIFont fontWithName:@"GothamRounded-Medium" size:13];
        }
        

        
        
        costInfo.text=[NSString stringWithFormat:@"%@ minutes-$%@",[[callCost objectAtIndex:0]objectForKey:@"calltime"],[[callCost objectAtIndex:0]objectForKey:@"needtopay"]] ;
        
        costInfo.textAlignment=NSTextAlignmentCenter;
        // costInfo.text=@"25 minutes-$50\n50 minutes-$95";
        costInfo.numberOfLines=2;
        costInfo.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
        costInfo.textColor=[UIColor blackColor];
        [letsGetStartedPopUp addSubview:costInfo];
        
       couponButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
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
#pragma mark-Doctor Call Rate Services

-(void)doctorCallRate{
    callCost=[[NSMutableArray alloc]init];
    NSError * error ;
   NSURLResponse * urlResponse;
    
    NSURL * postUrl =[NSURL URLWithString:doctorCallCostService];
    
    
    NSLog(@"------->%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"symptomps"]);
    
    NSString * body;
    
    //if([SingletonClass sharedSingleton].deptId==5)
        
       // body =[NSString stringWithFormat:@"did=4&id=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"]];
    
   // else
        
        body =[NSString stringWithFormat:@"did=%@&id=%@",[NSString stringWithFormat:@"%d",[SingletonClass sharedSingleton].deptId],[[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"]];
    
    NSMutableURLRequest * request =[[NSMutableURLRequest alloc]initWithURL:postUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
    
    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (!data) {
        
        return;
    }
//   // id json;
//    NSURLSession *session=[NSURLSession sharedSession];
//    [[session dataTaskWithRequest:request completionHandler:^(NSData *data,NSURLResponse *urlResponse,NSError *error)
//    {
    
         id json =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        
   // }]resume];
    
  
    
    //NSLog(@"json %@",json);
    if ([[json objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
        
        NSArray *ar=[json objectForKey:@"data"];
        for (int i=0; i<ar.count; i++) {
            
            
            [callCost addObject:[ar objectAtIndex:i]];
        }
    }
    else{
        
    }
    
    
    
    
    
}


#pragma mark-Activity Indicator
-(void)activityAction{
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.frame = CGRectMake(screenRect.width/2-20, screenRect.height/2-55,40 ,40);
    activityIndicator.color = [UIColor blackColor];
    activityIndicator.alpha = 1;
    [self.view addSubview:activityIndicator];
    //[self placeSearchbaseId];
    
    [activityIndicator startAnimating];
    
    
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
    [okButton addTarget:self action:@selector(okAction1) forControlEvents:UIControlEventTouchUpInside];
    okButton.layer.cornerRadius=6.0f;
    
    [letsGetStartedPopUp addSubview:okButton];
    
}

-(void)okAction1{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        letsGetStartedPopUp.frame=CGRectMake(30, 700, self.view.frame.size.width-60, self.view.frame.size.height-60);
        backPopUp.frame = CGRectMake(0,800, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
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
