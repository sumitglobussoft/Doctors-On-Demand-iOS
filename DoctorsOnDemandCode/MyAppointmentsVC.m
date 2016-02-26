//
//  MyAppointmentsVC.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 9/14/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "MyAppointmentsVC.h"

@interface MyAppointmentsVC (){
    CGSize screenRect;
   
    BOOL response;
}

@end

@implementation MyAppointmentsVC

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:YES];
//    [self activityAction];
//    
//    dispatch_async(dispatch_get_global_queue(0, 0),^{
//        
//        [self getAppointment];
//        
//        
//        dispatch_async(dispatch_get_main_queue(),^{
//            
//            
//            
//            
//             [self createUi];
//            
//            [activityIndicator stopAnimating];
//
//            
//        });
//        
//        
//    });
//    
//    
//    
//}
//- (void)viewDidDisappear:(BOOL)animated {
//    [super viewDidDisappear:(BOOL)animated];    // Call the super class implementation.
//    
//}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    screenRect=[[UIScreen mainScreen]bounds].size;
    
    
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    titleLable.text =@"My Appointments";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font =[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [headerView addSubview:titleLable];
    
    if (UIUserInterfaceIdiomPad==UI_USER_INTERFACE_IDIOM()){
        
        headerView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80);
      
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
    
    
    UIImageView *logoView = [[UIImageView alloc] init];
    
    
    if(screenRect.height<736)
    {
        logoView.frame=CGRectMake(0, 70, screenRect.width, 175);    }
    else if (screenRect.height>=736){
        logoView.frame = CGRectMake(0, 70, screenRect.width, 240);
    }

    
    
    logoView.image=[UIImage imageNamed:@"my_appointment.jpg"];
    [logoView setContentMode:UIViewContentModeScaleAspectFit];
    
    //[logoView sizeToFit];
    
   [self.view addSubview:logoView];
    
    
    
    
    
    
    
    
    
    UIButton *showAppointmntBtn=[[UIButton alloc]init];
    
    
    if(screenRect.height<736){
        showAppointmntBtn.frame=CGRectMake(10,250, screenRect.width-20, 50);
    }
    else if (screenRect.height>=736){
        showAppointmntBtn.frame=CGRectMake(10,320, screenRect.width-20, 50);
    }

    [showAppointmntBtn setTitle:@"Show Appointments" forState:UIControlStateNormal];
    [showAppointmntBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [showAppointmntBtn setBackgroundColor:[UIColor colorWithRed:(CGFloat)234/255 green:(CGFloat)30/255 blue:(CGFloat)99/255 alpha:(CGFloat)1.0]];
    showAppointmntBtn.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
    [showAppointmntBtn addTarget:self action:@selector(showAppButtonActn) forControlEvents:UIControlEventTouchUpInside];
    showAppointmntBtn.layer.cornerRadius=10.0f;
    [self.view addSubview:showAppointmntBtn];

    
    
    
    UIButton *scheduleAppButton=[[UIButton alloc]init];
    
    
    if(screenRect.height<736){
        scheduleAppButton.frame=CGRectMake(10,310, screenRect.width-20, 50);
    }
    else if (screenRect.height>=736){
        scheduleAppButton.frame=CGRectMake(10,380, screenRect.width-20, 50);
    }

    [scheduleAppButton setTitle:@"Schedule Appointments" forState:UIControlStateNormal];
    [scheduleAppButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [scheduleAppButton setBackgroundColor:[UIColor colorWithRed:(CGFloat)234/255 green:(CGFloat)30/255 blue:(CGFloat)99/255 alpha:(CGFloat)1.0]];
    scheduleAppButton.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
    [scheduleAppButton addTarget:self action:@selector(scheduleAppButtonActn) forControlEvents:UIControlEventTouchUpInside];
    scheduleAppButton.layer.cornerRadius=10.0f;
    [self.view addSubview:scheduleAppButton];
    if (UIUserInterfaceIdiomPad==UI_USER_INTERFACE_IDIOM()){
        
        logoView.frame = CGRectMake(0, 80, screenRect.width,screenRect.height/2-50);
        logoView.image=[UIImage imageNamed:@"my_appointment.jpg"];
        
        showAppointmntBtn.frame= CGRectMake(10, logoView.frame.origin.y+logoView.frame.size.height+20, screenRect.width-20,80);
         showAppointmntBtn.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:25];
        
        scheduleAppButton.frame= CGRectMake(10, showAppointmntBtn.frame.origin.y+showAppointmntBtn.frame.size.height+10, screenRect.width-20,80);
        scheduleAppButton.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:25];
    }

    
}
-(void)scheduleAppButtonActn{
    ProviderTypeVC *provider=[[ProviderTypeVC alloc]init];
    [self.navigationController pushViewController:provider animated:YES];
}

#pragma mark-Show Appointments
-(void)showAppButtonActn{
    

    AppointmentDetails *appointmentDetail=[[AppointmentDetails alloc]init];
    [self.navigationController pushViewController:appointmentDetail animated:YES];
    
    
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
