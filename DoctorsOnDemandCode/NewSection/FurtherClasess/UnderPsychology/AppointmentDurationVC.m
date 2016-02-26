//
//  AppointmentDurationVC.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 8/26/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "AppointmentDurationVC.h"
#import "PuposeOfVisitView.h"

@interface AppointmentDurationVC (){
    CGSize screenRect;
    NSMutableArray *callCost;
}


@end

@implementation AppointmentDurationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    callCost=[[NSMutableArray alloc]init];
    
        dispatch_async(dispatch_get_global_queue(0, 0),^{
    
            [self doctorCallRate];
    
            dispatch_async(dispatch_get_main_queue(),^{
    
    [ self createUI];
            });
    
        });
        

    self.navigationController.navigationBar.hidden = YES;
    
    screenRect=[[UIScreen mainScreen]bounds].size;
    
    
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    titleLable.text =@"APPOINTMENT DURATION";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font =[UIFont fontWithName:@"GothamRounded-Light" size:12];

    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
 [backButton setFrame:CGRectMake(15, 18, 55, 35)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        headerView.frame= CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80);
        titleLable.frame= CGRectMake(60, 25, screenRect.width-120, 35);
        titleLable.font=[UIFont fontWithName:@"GothamRounded-Light" size:26];
        //titleLable.font =[UIFont systemFontOfSize:30];
        [backButton setImage:[UIImage imageNamed:@"back_btn_ipad.png"] forState:UIControlStateNormal];
        [backButton setFrame:CGRectMake(15, 30, 80, 25)];
        
//                [nextButton setImage:[UIImage imageNamed:@"next_btn-ipad.png"] forState:UIControlStateNormal];
//                [nextButton setFrame:CGRectMake(screenRect.width-100, 28, 80, 25)];
        
    }

    
    

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)createUI{
    UILabel *briefDescp=[[UILabel alloc]init];
    briefDescp.frame=CGRectMake(0,70, screenRect.width-30,40);
    briefDescp.numberOfLines=2;
    
    briefDescp.textAlignment=NSTextAlignmentCenter;
    if([SingletonClass sharedSingleton].item==2){
    briefDescp.text=@"How long would you like to meet\nwith your psychologist";
    }
    else if ([SingletonClass sharedSingleton].item==4){
         briefDescp.text=@"How long would you like to meet\nwith your lactation consultant";
    }
    else if ([SingletonClass sharedSingleton].deptId==5||[SingletonClass sharedSingleton].deptId==4){
        briefDescp.text=@"How long would you like to meet\nwith your Doctor";
    }
    else if ([SingletonClass sharedSingleton].deptId==2){
        briefDescp.text=@"How long would you like to meet\nwith your Padiatrician";
    }

    briefDescp.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];

    briefDescp.textColor=[UIColor blackColor];
    
    [self.view addSubview:briefDescp];
    
    
    if(callCost.count!=0){
    
  
    }
    
    
    
    UIButton *firstBtn=[[UIButton alloc]init];
    firstBtn.frame=CGRectMake(10,150, screenRect.width-20, 50);
    
    
   // if([SingletonClass sharedSingleton].item==2){
    
    if(callCost.count!=0){
        NSString*callTime= [[callCost objectAtIndex:0]objectForKey:@"calltime"];
        NSString *needToPay=[[callCost objectAtIndex:0]objectForKey:@"needtopay"];
          [firstBtn setTitle:[NSString stringWithFormat:@"%@ minutes for $%@",callTime,needToPay] forState:UIControlStateNormal];
        
        
        NSLog(@"25......$50");
   // }
//    else if ([SingletonClass sharedSingleton].item==4||[SingletonClass sharedSingleton].deptId==5){
//          [firstBtn setTitle:[NSString stringWithFormat:@"%@ minutes for %@",[[callCost objectAtIndex:0]objectForKey:@"calltime"],[[callCost objectAtIndex:1]objectForKey:@"callcost"] ] forState:UIControlStateNormal];
//        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"planId"];
//        [[NSUserDefaults standardUserDefaults]synchronize];
//
//        NSLog(@"25......$40");
//    }
    firstBtn.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];


        [firstBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [firstBtn setBackgroundColor:[UIColor colorWithRed:(CGFloat)234/255 green:(CGFloat)30/255 blue:(CGFloat)99/255 alpha:(CGFloat)1.0]];
    [firstBtn addTarget:self action:@selector(choosePlan1) forControlEvents:UIControlEventTouchUpInside];
    firstBtn.layer.cornerRadius=10.0f;
    [self.view addSubview:firstBtn];
    }
    
    
    
    
    UIButton *secondBtn=[[UIButton alloc]initWithFrame:CGRectMake(10,210, screenRect.width-20, 50)];
    
    
    
   // if([SingletonClass sharedSingleton].item==2){

    if(callCost.count!=0)

        [secondBtn setTitle:[NSString stringWithFormat:@"%@ minutes for $%@",[[callCost objectAtIndex:1]objectForKey:@"calltime"],[[callCost objectAtIndex:1]objectForKey:@"needtopay"] ] forState:UIControlStateNormal];
        
        NSLog(@"50......$95");
//    }
//    else if ([SingletonClass sharedSingleton].item==4|[SingletonClass sharedSingleton].deptId==5){
//        [secondBtn setTitle:@"50 minutes for $70" forState:UIControlStateNormal];
//        [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:@"planId"];
//        [[NSUserDefaults standardUserDefaults]synchronize];
//        NSLog(@"50......$70");
//    }
    secondBtn.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];

    
   
    [secondBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [secondBtn setBackgroundColor:[UIColor colorWithRed:(CGFloat)234/255 green:(CGFloat)30/255 blue:(CGFloat)99/255 alpha:(CGFloat)1.0]];
    [secondBtn addTarget:self action:@selector(choosePlan2) forControlEvents:UIControlEventTouchUpInside];
    secondBtn.layer.cornerRadius=10.0f;
   // [self.view addSubview:secondBtn];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        briefDescp.frame=CGRectMake(0,100, screenRect.width-30,80);
          briefDescp.font=[UIFont fontWithName:@"GothamRounded-Medium" size:30];
        firstBtn.frame=CGRectMake(10,190, screenRect.width-20,80);
        firstBtn.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:25];
        
    }
    
    

}
-(void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark-Choose Plan button
-(void)choosePlan1{
    
    [[NSUserDefaults standardUserDefaults]setObject:[[callCost objectAtIndex:0]objectForKey:@"callcost"] forKey:@"PatientCallCost"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    [[NSUserDefaults standardUserDefaults]setObject:[[callCost objectAtIndex:0]objectForKey:@"calltime"] forKey:@"PatientCallTime"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
    [[NSUserDefaults standardUserDefaults]setObject:[[callCost objectAtIndex:0]objectForKey:@"needtopay"] forKey:@"PatientNeedToPay"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
    [[NSUserDefaults standardUserDefaults]setObject:[[callCost objectAtIndex:0]objectForKey:@"creditremains"] forKey:@"PatientCredRem"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    [[NSUserDefaults standardUserDefaults]setObject:[[callCost objectAtIndex:0]objectForKey:@"pid"] forKey:@"PatientPlanId"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    


    
    
    
    [self calenderAction];
    
}
-(void)choosePlan2{
    
    [[NSUserDefaults standardUserDefaults]setObject:[[callCost objectAtIndex:1]objectForKey:@"callcost"] forKey:@"PatientCallCost"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    [[NSUserDefaults standardUserDefaults]setObject:[[callCost objectAtIndex:1]objectForKey:@"calltime"] forKey:@"PatientCallTime"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
    [[NSUserDefaults standardUserDefaults]setObject:[[callCost objectAtIndex:1]objectForKey:@"needtopay"] forKey:@"PatientNeedToPay"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
    [[NSUserDefaults standardUserDefaults]setObject:[[callCost objectAtIndex:1]objectForKey:@"creditremains"] forKey:@"PatientCredRem"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    [[NSUserDefaults standardUserDefaults]setObject:[[callCost objectAtIndex:1]objectForKey:@"pid"] forKey:@"PatientPlanId"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    
    [self calenderAction];
}

#pragma mark-Calender Option
-(void)calenderAction{
    
    if ([SingletonClass sharedSingleton].deptId==5){
        
        PuposeOfVisitView *porpose=[[PuposeOfVisitView alloc]init];
         [self.navigationController pushViewController:porpose animated:YES];
        
      //  AllergiesView *allergies=[AllergiesView new];
       
    }
    else{
        CalendarViewController *calender=[[CalendarViewController alloc]init];
        [self.navigationController pushViewController:calender animated:YES];
    }

}
-(void)doctorCallRate{
    
        NSError * error ;
        NSURLResponse * urlResponse;
        
        NSURL * postUrl =[NSURL URLWithString:doctorCallCostService];
        
        
     //   NSLog(@"------->%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"symptomps"]);
    
    NSString * body;
    
//    if([SingletonClass sharedSingleton].deptId==5)
//        
//     body =[NSString stringWithFormat:@"did=4&id=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"]];
//    
//    else
    
             body =[NSString stringWithFormat:@"did=%@&id=%@",[NSString stringWithFormat:@"%d",[SingletonClass sharedSingleton].deptId],[[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"]];
        
        NSMutableURLRequest * request =[[NSMutableURLRequest alloc]initWithURL:postUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
        
        NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
        if (!data) {
            
            return;
        }
        
        id json =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
       // NSLog(@"json %@",json);
        if ([[json objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
            
            NSArray *ar=[json objectForKey:@"data"];
            for (int i=0; i<ar.count; i++) {
                
                
                [callCost addObject:[ar objectAtIndex:i]];
               
            }
            
             NSLog(@"plan Arry-->%@",callCost);
        }
        else{
            
        }
        
        
        

    
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
