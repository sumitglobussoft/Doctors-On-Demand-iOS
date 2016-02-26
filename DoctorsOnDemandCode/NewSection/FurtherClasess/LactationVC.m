//
//  LactationVC.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 9/14/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "LactationVC.h"

@interface LactationVC (){
    CGSize screenRect;
    NSArray *lactationCell,*lactationViewCellsImg;
    UIView *letsGetStartedPopUp;
    UIButton *couponButton;
    
    UIView * backPopUp;
    LactationConsultVC *lactation;
    UIButton *letsGoButton;
    NSMutableArray *callCost;
   
    
    UIActivityIndicatorView *activityIndicator;

    
}


@end

@implementation LactationVC

- (void)viewDidLoad {
    [super viewDidLoad];
        self.navigationController.navigationBar.hidden = YES;
    [[NSUserDefaults standardUserDefaults]setObject:nil
                                             forKey:@"MYHEALTH"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    screenRect=[[UIScreen mainScreen]bounds].size;
    
     [SingletonClass sharedSingleton].deptId=1;
    
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"OurDoctors"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"pop"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    titleLable.text =@"Lactation";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
    [backButton setFrame:CGRectMake(15, 18, 55, 35)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
    
    
    
    
    /* UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
     barButton.title=@"";
     self.navigationController.navigationBar.topItem.backBarButtonItem = barButton;
     
     
     UIButton *backButtonImage =  [UIButton buttonWithType:UIButtonTypeCustom];
     [backButtonImage setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
     [backButtonImage setFrame:CGRectMake(0, 0, 61, 21)];
     barButton = [[UIBarButtonItem alloc] initWithCustomView:backButtonImage];
     self.navigationItem.leftBarButtonItem = barButton;
     [backButtonImage addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
     self.navigationItem.leftBarButtonItem=barButton;*/
    
    
    
   [self createUi];
    
    
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-Create UI
-(void)createUi{
    UIImageView *logoView = [[UIImageView alloc] init];
                           
    if(screenRect.height>=667)
    {
        logoView.frame = CGRectMake(0, 70, screenRect.width, 190);
    }
    else if (screenRect.height>=736){
        logoView.frame = CGRectMake(0, 70, screenRect.width, 210);
    }
      else
          
          logoView.frame = CGRectMake(0, 70, screenRect.width, 160);

    
    
    logoView.image=[UIImage imageNamed:@"lactation_img.png"];
    [logoView setContentMode:UIViewContentModeScaleAspectFit];
    
    //[logoView sizeToFit];
    
    [self.view addSubview:logoView];
    
    
    
    
    
    
    
    
    
    UITableView *tableView=[[UITableView alloc]init];
    
    if(screenRect.height==480){
        
        tableView.frame=CGRectMake(10, screenRect.height/2-5, screenRect.width-20, screenRect.height/2-5);
        
        
    }
    else
    tableView.frame=CGRectMake(10, screenRect.height/2-50, screenRect.width-20, screenRect.height/2+40);
    tableView.backgroundColor=[UIColor clearColor];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:tableView];
    
    
    lactationCell=[NSArray arrayWithObjects:@"",@"What is Lactation\nConsulting?",@"Lactation Consulting\nThrough Video",@"What Do We treat?",@"Our Lactation Consultants",@"About Doctor On Demand", nil];
    lactationViewCellsImg =[NSArray arrayWithObjects:@"",@"question_icon.png",@"videoplay_icon.png",@"question_icon.png",@"user_icon.png",@"dr_icon.png", nil];
    
    
    
}


#pragma mark-Table Delegates
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
    
    
    if (indexPath.section == 0) {
        UIButton *cellButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        if(screenRect.height>=667){
            
            cellButton.frame = CGRectMake(0, 0, screenRect.width-20,75);
        }
        else
            cellButton.frame = CGRectMake(0, 0, screenRect.width-20,60);
        [cellButton setBackgroundImage: [UIImage imageNamed:@"schedule_appointment_btn.png"] forState:UIControlStateNormal];
        [cellButton addTarget:self action:@selector(seeADoctor) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:cellButton];
    }
    else{
        
        
        // cell.imageView.frame = CGRectMake(10, 2, 22, 22);
        cell.textLabel.text = [lactationCell objectAtIndex:indexPath.section];
        cell.textLabel.numberOfLines=2;
        cell.textLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];
        cell.imageView.image = [UIImage imageNamed:[lactationViewCellsImg objectAtIndex:indexPath.section]];
        cell.accessoryView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"forward_arrow.png"]];
    }
    
    
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    lactation=[[LactationConsultVC alloc]init];

    
    switch (indexPath.section) {
        case 0:
            // [self seeADoctor];
            NSLog(@">>>>>>%ld",(long)indexPath.section);
            
            break;
        case 1:
        {
            [[NSUserDefaults standardUserDefaults]setObject:@"whatIsLactation" forKey:@"lactation"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [self.navigationController pushViewController:lactation animated:YES];
        
        }
            
            break;
            
        case 2:{
            [[NSUserDefaults standardUserDefaults]setObject:@"lactationVideo" forKey:@"lactation"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [self.navigationController pushViewController:lactation animated:YES];
            

        }
            
            break;
            
        case 3:
        {
            WhatWeTreatVC *whatWeTreat=[[WhatWeTreatVC alloc]init];
            [self.navigationController pushViewController:whatWeTreat animated:YES];
            
        }
            break;
            
        case 4:{
            
            OurDoctorsVC *doctor=[[OurDoctorsVC alloc]init];
            [self.navigationController pushViewController:doctor animated:YES];
        }
            break;
        case 5:
            
            break;
        case 6:{
            
            AboutVC *about=[[AboutVC alloc]init];
                            [self.navigationController pushViewController:about animated:YES];
        }
            
            break;
            
            
            
            
        default:
            break;
    }
    
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [lactationCell count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

#pragma mark- See a doctor
-(void)seeADoctor{
    
    if([[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"]!=nil){
        [self activityAction];

        dispatch_async(dispatch_get_global_queue(0, 0),^{
            
            [self doctorCallRate];
            
            dispatch_async(dispatch_get_main_queue(),^{
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
                
                
                
                //[self.view insertSubview:letsGetStartedPopUp atIndex:2];
                
                [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    
                    letsGetStartedPopUp.frame=CGRectMake(30, 60, self.view.frame.size.width-60, self.view.frame.size.height-110);
                    backPopUp.frame=CGRectMake(00, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                    
                }completion:nil];
                
                
                
                
                UILabel *header=[[UILabel alloc]initWithFrame:CGRectMake(0,0,  self.view.frame.size.width-60-5, 150)];
                header.text=@"LET'S GET\nSTARTED!";
                header.numberOfLines=2;
                header.font=[UIFont fontWithName:@"GothamRounded-Medium" size:30];
                header.textColor=[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1];
                header.textAlignment=NSTextAlignmentCenter;
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
                information.numberOfLines=5;
                information.textAlignment=NSTextAlignmentCenter;
                information.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
                information.textColor=[UIColor blackColor];
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
                

                

             costInfo.text=[NSString stringWithFormat:@"%@ minutes-$%@",[[callCost objectAtIndex:0]objectForKey:@"calltime"],[[callCost objectAtIndex:0]objectForKey:@"needtopay"]] ;
                
                
                costInfo.numberOfLines=2;
                costInfo.textAlignment=NSTextAlignmentCenter;
                costInfo.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
                costInfo.textColor=[UIColor blackColor];
                [letsGetStartedPopUp addSubview:costInfo];
                
                
                
                
                
                couponButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
                couponButton.frame=CGRectMake(10, letsGetStartedPopUp.frame.size.height-100,self.view.frame.size.width-60-30,50);
                

                
                [couponButton setTitle:@"Apply Coupon" forState:UIControlStateNormal];
                [couponButton setTitleColor:[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1] forState:UIControlStateNormal];
                couponButton.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
                
                [couponButton addTarget:self action:@selector(couponBtnAction) forControlEvents:UIControlEventTouchUpInside];
                [letsGetStartedPopUp addSubview:couponButton];
                
                letsGoButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
                letsGoButton.frame=CGRectMake(0, letsGetStartedPopUp.frame.size.height-50,self.view.frame.size.width-60, 50);
                [letsGoButton setTitle:@"Let's Go!" forState:UIControlStateNormal];
                letsGoButton.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
                [letsGoButton setBackgroundColor:[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1]];
                [letsGoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [letsGoButton addTarget:self action:@selector(letsGo) forControlEvents:UIControlEventTouchUpInside];
                letsGoButton.layer.cornerRadius=6.0f;
                
                [letsGetStartedPopUp addSubview:letsGoButton];
                [activityIndicator stopAnimating];

            });
            
        });

 
    
   
    
    }else{
    
    
    SignInView *signIn=[[SignInView alloc]init];
    [self.navigationController pushViewController:signIn animated:YES];
        
    }
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UIUserInterfaceIdiomPad==UI_USER_INTERFACE_IDIOM()) {
        if(indexPath.section==0 && indexPath.row==0){
            
            return 100;
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
-(void)letsGo{
    [SingletonClass sharedSingleton].item=4;
    HowToScheduleVC *schedule=[[HowToScheduleVC alloc]init];
       [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        letsGetStartedPopUp.frame=CGRectMake(30, 700, self.view.frame.size.width-60, self.view.frame.size.height-60);
        backPopUp.frame = CGRectMake(0,800, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }completion:^(BOOL finished){
        [self.navigationController pushViewController:schedule animated:YES];
        
    }];
    
    
}
-(void)couponBtnAction{
    
   
    
    ApplyCouponVC *applyCoupon=[[ApplyCouponVC alloc]init];
    
    
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        letsGetStartedPopUp.frame=CGRectMake(30, 700, self.view.frame.size.width-60, self.view.frame.size.height-60);
        backPopUp.frame = CGRectMake(0,800, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }completion:^(BOOL finished){
        applyCoupon.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:applyCoupon animated:YES];
        
        
    }];
    
    
}
//#pragma mark-After Coupo Apply
//
//-(void)afterCouponApply{
//    dispatch_async(dispatch_get_global_queue(0, 0),^{
//        
//        [self doctorCallRate];
//        
//        dispatch_async(dispatch_get_main_queue(),^{
//            
//            [self popUp];
//        });
//        
//    });
//    
//    
//}
#pragma mark-Doctor Call Rate Services

-(void)doctorCallRate{
    callCost=[[NSMutableArray alloc]init];

    NSError * error ;
    NSURLResponse * urlResponse;
    
    NSURL * postUrl =[NSURL URLWithString:doctorCallCostService];
    
    
    NSLog(@"------->%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"symptomps"]);
    
    NSString * body;
    
    if([SingletonClass sharedSingleton].deptId==5)
        
        body =[NSString stringWithFormat:@"did=4&id=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"]];
    
    else
        
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
    

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
