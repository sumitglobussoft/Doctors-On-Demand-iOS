
//
//  PaymentViewController.m
//  DoctorsOnDemandCode
//
//  Created by GBS-ios on 9/11/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "PaymentViewController.h"

@interface PaymentViewController (){
    NSMutableDictionary *paymenDetails;
    UIView *backPopUp,*letsGetStartedPopUp;
    UIButton *letsGoButton;
    NSString *ack;
    UIActivityIndicatorView* activityIndicator;
    id json;
    BOOL doctorFound;
    id paymentJson;
}

@end

@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
       //Header View
    self.navigationController.navigationBar.hidden=YES;
    paymenDetails=[[NSMutableDictionary alloc]init];
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, [UIScreen mainScreen].bounds.size.width-120, 25)];
    titleLable.text =@"Payment";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font =[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
  [backButton setFrame:CGRectMake(15, 18, 55, 35)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad) {
        
        headerView.frame=  CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 75);
        titleLable.frame= CGRectMake(60, 25, [UIScreen mainScreen].bounds.size.width-120, 30);
        titleLable.font =  [UIFont fontWithName:@"GothamRounded-Light" size:26];        [backButton setImage:[UIImage imageNamed:@"back_btn_ipad.png"] forState:UIControlStateNormal];
        [backButton setFrame:CGRectMake(15, 30, 80, 25)];
        
        
    }
    

    
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"PatientNeedToPay"]intValue]==0)
    {
        
        
        
        
        
        
        UIButton * payBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        payBtn.frame = CGRectMake(10,150 ,[UIScreen mainScreen].bounds.size.width-20, 50);
        [payBtn setTitle:@"Schedule for FREE" forState:UIControlStateNormal];
        [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        payBtn.titleLabel.font =[UIFont boldSystemFontOfSize:14];
        [payBtn setBackgroundColor:[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1]];
       [payBtn addTarget:self action:@selector(freeSchedule) forControlEvents:UIControlEventTouchUpInside];
        
        //[payBtn addTarget:self action:@selector(checkDocSchedule) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:payBtn];

        if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad){
            
            
              payBtn.frame = CGRectMake(10,150 ,[UIScreen mainScreen].bounds.size.width-20, 80);
            payBtn.titleLabel.font =[UIFont boldSystemFontOfSize:25];
            
        }
        
        
    }
    
    else{
        UIButton * payBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        payBtn.frame = CGRectMake(10,150 ,[UIScreen mainScreen].bounds.size.width-20, 50);
        [payBtn setTitle:@"Payment" forState:UIControlStateNormal];
        [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        payBtn.titleLabel.font =[UIFont boldSystemFontOfSize:14];
        [payBtn setBackgroundColor:[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1]];
        [payBtn addTarget:self action:@selector(callPayPalMethod) forControlEvents:UIControlEventTouchUpInside];
       //  [payBtn addTarget:self action:@selector(checkDocSchedule) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:payBtn];
        
        
        self.payPalConfig = [[PayPalConfiguration alloc] init];
        self.payPalConfig.merchantName = @"Ultramagnetic Omega Supreme";
        self.payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.omega.supreme.example/privacy"];
        self.payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.omega.supreme.example/user_agreement"];
        
        if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad){
            
            
            payBtn.frame = CGRectMake(10,150 ,[UIScreen mainScreen].bounds.size.width-20, 80);
            payBtn.titleLabel.font =[UIFont boldSystemFontOfSize:25];
            
        }


    }
    
    if([SingletonClass sharedSingleton].deptId==5)
    
        
    //    [self performSelector:@selector(autoAllocateDoctor) withObject:nil afterDelay:3];
  [self autoAllocateDoctor];
    
   // [self popUp];

    //----------------
    
    
    
    // Do any additional setup after loading the view.
}
- (void)verifyCompletedPayment:(PayPalPayment *)completedPayment {
    // Send the entire confirmation dictionary
   
    
    // Send confirmation to your server; your server should verify the proof of payment
    // and give the user their goods or services. If the server is not reachable, save
    // the confirmation and try again later.
}
-(void)getAccessToken{
  
    
    
}
#pragma mark-FREE schedule Button
-(void)freeSchedule{
    
    [self activityAction];
    
    if([SingletonClass networkcheck]==YES){
    
        dispatch_async(dispatch_get_global_queue(0, 0),^{
    
    
            dispatch_async(dispatch_get_main_queue(),^{
                if([SingletonClass sharedSingleton].deptId==5)
                    [self scheduleSeeDocNow];
                else
                    [self scheduleAppointment];

    
                [activityIndicator stopAnimating];
            });
            
        });
    }
    else{
        
        [self networkWarning];
    }
    

    
    
}

#pragma mark- instance method

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [PayPalMobile preconnectWithEnvironment:PayPalEnvironmentSandbox];
}

#pragma mark -
#pragma mark PayPal InstaceMethod
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.payPalConfig = [[PayPalConfiguration alloc] init];
        
        
        // See PayPalConfiguration.h for details and default values.
        // Should you wish to change any of the values, you can do so here.
        // For example, if you wish to accept PayPal but not payment card payments, then add:
        self.acceptCreditCards=YES;
        self.payPalConfig.acceptCreditCards = YES;
        // Or if you wish to have the user choose a Shipping Address from those already
        // associated with the user's PayPal account, then add:
        self.payPalConfig.payPalShippingAddressOption = PayPalShippingAddressOptionPayPal;
        self.payPalConfig.merchantName = @"Ultramagnetic Omega Supreme";
        self.payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.omega.supreme.example/privacy"];
        self.payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.omega.supreme.example/user_agreement"];
        
        
    }
    return self;
}

- (instancetype)initWithConfiguration:(PayPalConfiguration *)configuration
                             delegate:(id<PayPalFuturePaymentDelegate>)delegate{
    self.payPalConfig = [[PayPalConfiguration alloc] init];
    
    self.payPalConfig.merchantName = @"Ultramagnetic Omega Supreme";
    self.payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.omega.supreme.example/privacy"];
    self.payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.omega.supreme.example/user_agreement"];
    
    
    return  self;
}

-(void)callPayPalMethod{
    
    if([SingletonClass networkcheck]==YES){
  
        
        [self checkDocSchedule];
        
        
    
    PayPalPayment *payment = [[PayPalPayment alloc] init];

    
    
    
    NSNumber* total =[NSNumber numberWithInt:[[[NSUserDefaults standardUserDefaults]objectForKey:@"PatientNeedToPay"]intValue ]];
   
    
    if(total!=0)
    
    
    payment.amount = (NSDecimalNumber*)total;
  
   
        
        
    
    payment.currencyCode = @"USD";
    payment.shortDescription =[NSString stringWithFormat:@"%@ Points Credit",total];
// payment.items = items;  // if not including multiple items, then leave payment.items as nil
//payment.paymentDetails = paymentDetails; // if not including payment details, then leave payment.paymentDetails as nil

    if (!payment.processable) {
    // This particular payment will always be processable. If, for
    // example, the amount was negative or the shortDescription was
    // empty, this payment wouldn't be processable, and you'd want
    // to handle that here.
    }

// Update payPalConfig re accepting credit cards.
    self.payPalConfig.acceptCreditCards = YES;

        
        
        
        
    PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
                                                                                            configuration:self.payPalConfig
                                                                                                 delegate:self];
    [self presentViewController:paymentViewController animated:YES completion:nil];
    }
    
    else{
        [self networkWarning];
    }
    
}

#pragma mark- delegate methods
#pragma mark PayPalPaymentDelegate methods

- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
    NSLog(@"PayPal Payment Success!");
   //  NSLog(@"---->%@",[completedPayment  confirmation]);
    
    
  //  NSLog(@"Payment Details---->%@",[completedPayment paymentDetails]);
    
    if([[[[completedPayment  confirmation]objectForKey:@"response"] objectForKey:@"state"]isEqual:@"approved"])
        ack=@"success";
    
    
    NSLog(@"amount-->%@",[completedPayment amount]);
    
    
    [[NSUserDefaults standardUserDefaults]setObject:[completedPayment amount] forKey:@"Amount"];
    [[NSUserDefaults standardUserDefaults]setObject:[[[completedPayment confirmation] objectForKey:@"response"]objectForKey:@"create_time"] forKey:@"paymentTime"];

    [[NSUserDefaults standardUserDefaults]setObject:[[[completedPayment confirmation]objectForKey:@"response"]objectForKey:@"id"] forKey:@"PayPalPaymentId"];
    
    
    
    
    [self checkDocSchedule];
    
    
    [self finalCheckAndAppointment];
  
//    if([SingletonClass  sharedSingleton].deptId==5){
//        
//        [self scheduleSeeDocNow];
//        
//    }else{
//    [self scheduleAppointment];
//        
//    }
//    
    //[self payment];
    
   // [self retrievePaymentInfo];
  // Payment was processed successfully; send to server for verification and fulfillment
    [self dismissViewControllerAnimated:YES completion:nil];
    
   }

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    NSLog(@"PayPal Payment Canceled");

    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (void)paymentSuccessWithKey {
////    status = PAYMENTSTATUS_SUCCESS;
//    
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://svcs.paypal.com/AdaptivePayments/PaymentDetails"]];
//    
//    NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL:url];
//    
//    
//    NSString *parameterString = [NSString stringWithFormat:@"payKey=%@&requestEnvelope.errorLanguage=%@",payKey,@"en_US"];
//    
//    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[parameterString length]];
//    
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    
//    //do post request for parameter passing
//    [theRequest setHTTPMethod:@"POST"];
//    
//    [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    
//    //passing key as a http header request
//    [theRequest addValue:api_username forHTTPHeaderField:@"X-PAYPAL-SECURITY-USERID"];
//    
//    //passing key as a http header request
//    [theRequest addValue:api_password forHTTPHeaderField:@"X-PAYPAL-SECURITY-PASSWORD"];
//    
//    [theRequest addValue:api_signature forHTTPHeaderField:@"X-PAYPAL-SECURITY-SIGNATURE"];
//    
//    [theRequest addValue:@"NV" forHTTPHeaderField:@"X-PAYPAL-REQUEST-DATA-FORMAT"];
//    
//    [theRequest addValue:@"NV" forHTTPHeaderField:@"X-PAYPAL-RESPONSE-DATA-FORMAT"];
//    
//    [theRequest addValue:app_id forHTTPHeaderField:@"X-PAYPAL-APPLICATION-ID"];
//    
//    [theRequest setHTTPBody: [parameterString dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
//    
//    if( connection )
//    {
//       // webData = [[NSMutableData data] retain];
//    }
//    else
//    {
//        NSLog(@"theConnection is NULL");
//    }
//}


#pragma mark- backAction

-(void)backAction{
    
    
    NSArray *array = [self.navigationController viewControllers];
//    NSLog(@"array--->%@",array);
//    if([SingletonClass sharedSingleton].deptId==4)
//    [self.navigationController popToViewController:[array objectAtIndex:11] animated:YES];
//    else if ([SingletonClass sharedSingleton].deptId==3)
//        [self.navigationController popToViewController:[array objectAtIndex:10] animated:YES];
//    else if ([SingletonClass sharedSingleton].deptId==1)
//        [self.navigationController popToViewController:[array objectAtIndex:15] animated:YES];
//    else if ([SingletonClass sharedSingleton].deptId==2)
//        [self.navigationController popToViewController:[array objectAtIndex:9] animated:YES];
//    
//    else if ([SingletonClass sharedSingleton].deptId==5)
//        [self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];
    
    if([SingletonClass sharedSingleton].scheduledAppointment==YES){
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
    else{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    }

}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-fetch random doctor
//-(void)fetchRandomDoctor
//{
//    NSError * error ;
//    NSURLResponse * urlResponse;
//    
//    NSURL * postUrl =[NSURL URLWithString:fetchRandmdoctorServce];
//    NSString *dicID=[NSString stringWithFormat:@"%d",[SingletonClass sharedSingleton].deptId] ;
//    
//    NSString * body =[NSString stringWithFormat:@"appointmentStartTime=%@&appointmentEndTime=%@&patientId=%@&departmentId=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"apptStartTime" ],[[NSUserDefaults standardUserDefaults]objectForKey:@"apptEndTime"],[[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"],dicID];
//    
//    dicID=nil;
//    
//    NSMutableURLRequest * request =[[NSMutableURLRequest alloc]initWithURL:postUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
//    
//    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
//    if (!data) {
//        
//        return;
//    }
//    
//    id json =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
//    
//    NSLog(@"json %@",json);
//    if ([[json objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
//
//    
//    
//    }
//
//}


#pragma mark-check See Doc now Schedule
-(void)checkSeeDocNowSchedule{
    NSError *error;
    NSURLResponse *urlResponse;
    NSURL  *url=[NSURL URLWithString:checkSeeDocNowScheduleService];
    NSString *body;
  
    
    body=[NSString stringWithFormat:@"doctorId=%@&appointmentStartTime=%@& appointmentEndTime=%@&timeZone=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"DoctorNowId"],[[NSUserDefaults standardUserDefaults]objectForKey:@"DoctorNowStartTime"],[[NSUserDefaults standardUserDefaults]objectForKey:@"DoctorNowEndTime"],[NSTimeZone localTimeZone].name];
        
        
    
    
    NSMutableURLRequest * request =[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (!data) {
        
        return;
    }
    
    id checkJson =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if ([[checkJson objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]])
    
    {
        doctorFound=YES;

    }
}


//-(void)distingushTypeOFSchedule{
//    if([SingletonClass sharedSingleton].deptId==5){
//        [self checkSeeDocNowSchedule];
//    }
//    else{
//        [self checkDocSchedule];
//    }
//}


#pragma check Doctor Availability before Payment
-(void)checkDocSchedule{
   
    
    
    
    doctorFound=NO;
    
    
    if([SingletonClass sharedSingleton].deptId==5){
        [self checkSeeDocNowSchedule];
    }else{
    
    
    NSError *error;
    NSURLResponse *urlResponse;
    NSURL  *url=[NSURL URLWithString:fetchDoctorsByTimeService];
    NSString *body;
    if([SingletonClass sharedSingleton].deptId==5){
        body=[NSString stringWithFormat:@"departmentId=%d&appointmentStartTime=%@& appointmentEndTime=%@&timeZone=%@",4,[[NSUserDefaults standardUserDefaults]objectForKey:@"SeeDoctorStart"],[[NSUserDefaults standardUserDefaults]objectForKey:@"SeeDoctorEnd"],[NSTimeZone localTimeZone].name];
    }else
   body=[NSString stringWithFormat:@"departmentId=%d&appointmentStartTime=%@& appointmentEndTime=%@&timeZone=%@",[SingletonClass sharedSingleton].deptId,[[NSUserDefaults standardUserDefaults]objectForKey:@"appointment_start_time"],[[NSUserDefaults standardUserDefaults]objectForKey:@"appointment_end_time"],[NSTimeZone localTimeZone].name];
    
    NSMutableURLRequest * request =[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (!data) {
        
        return;
    }
    
   id checkJson =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if ([[checkJson objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
       
        NSArray *ar=[checkJson objectForKey:@"data"];
        
        for (int i=0; i<ar.count; i++) {

                if([[[ar objectAtIndex:i]objectForKey:@"doctor_id"]isEqual:[[NSUserDefaults standardUserDefaults] objectForKey:@"doctorid"]])
                    
                {
                    doctorFound=YES;
                    break;
                }

        }
    
        
    }
    }
    
}

-(void)finalCheckAndAppointment{
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"PatientNeedToPay"]intValue]==0 && doctorFound==YES){
        [self freeSchedule];
    }
    else if(doctorFound==YES){
        
        [self getTransactionId];
        
    }
    // }
    //}
    else{
        
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
        
        
        header.text=@"SORRY";
        header.numberOfLines=2;
        header.font=[UIFont fontWithName:@"GothamRounded-Medium" size:30];
        header.textColor=[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1];
        header.textAlignment = NSTextAlignmentCenter;
        [letsGetStartedPopUp addSubview:header];
        
        UILabel *information=[[UILabel alloc]init];
        information.frame=  CGRectMake(20,50, letsGetStartedPopUp.frame.size.width-40, 300);
        information.text=@"Scheduled Time Already Booked\nTry some other time";
        information.numberOfLines=7;
        information.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];
        information.textColor=[UIColor blackColor];
        information.textAlignment = NSTextAlignmentCenter;
        [letsGetStartedPopUp addSubview:information];
        
        
        
        
        letsGoButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        letsGoButton.frame=CGRectMake(0,letsGetStartedPopUp.frame.size.height-50,letsGetStartedPopUp.frame.size.width, 50);
        [letsGoButton setTitle:@"OK!" forState:UIControlStateNormal];
        letsGoButton.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
        [letsGoButton setBackgroundColor:[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1]];
        [letsGoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [letsGoButton addTarget:self action:@selector(okAction2) forControlEvents:UIControlEventTouchUpInside];
        letsGoButton.layer.cornerRadius=6.0f;
        
        [letsGetStartedPopUp addSubview:letsGoButton];
        
        
    }
    

}

-(void)okAction2{
    
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        letsGetStartedPopUp.frame=CGRectMake(30, 2000, self.view.frame.size.width-60, self.view.frame.size.height-60);
        backPopUp.frame = CGRectMake(0,2000, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }completion:^(BOOL finished){
        [backPopUp removeFromSuperview];
        
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    
        
    }];

    
    
    
}


#pragma mark-Schedule Appointment
-(void)scheduleAppointment{
    
    NSError * error ;
    NSURLResponse * urlResponse;
    
    NSURL * postUrl =[NSURL URLWithString:makeAppointmentService];
    
    
    
    
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"PatientNeedToPay"]intValue]==0)
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"0"forKey:@"PatientTransactionID"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        [[NSUserDefaults standardUserDefaults]setObject:@"0"forKey:@"Amount"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        ack=@"Free_User";
        
    }
    
    
    
    
    

    
    //NSLog(@"------->%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"symptomps"]);
    NSString * body;
    if([SingletonClass sharedSingleton].deptId==4){
        [[NSUserDefaults standardUserDefaults]setObject:@"0"  forKey:@"childId"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    
        body =[NSString stringWithFormat:@"appointment_start_time=%@&appointment_end_time=%@&patient_id=%@&doctor_id=%@&planid=%@&departmentId=%d&calltime=%@&callcost=%@&needtopay=%@&creditremains=%@&id=%@&purpose=%@&allergies=%@&medication=%@&medicationTime=%@&generalSymptoms=%@&headNeckSymptoms=%@&skinSymptoms=%@&chestSymptoms=%@&digestiveSymptoms=%@&pelvicSymptoms=%@&muscleSymptoms=%@  &medicalConditions=%@&pharmacyId=%@&transactionId=%@&acknowledgement=%@&amount=%@&paymentTime=%@&patient=%@&childId=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"appointment_start"],[[NSUserDefaults standardUserDefaults]objectForKey:@"appointment_end"],[[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"],[[NSUserDefaults standardUserDefaults]objectForKey:@"doctorid"],[[NSUserDefaults standardUserDefaults]objectForKey:@"PatientPlanId"],[SingletonClass sharedSingleton].deptId,[[NSUserDefaults standardUserDefaults]objectForKey:@"PatientCallTime"],[[NSUserDefaults standardUserDefaults]objectForKey:@"PatientCallCost"],[[NSUserDefaults standardUserDefaults]objectForKey:@"PatientNeedToPay"],[[NSUserDefaults standardUserDefaults]objectForKey:@"PatientCredRem"],[[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"],[[NSUserDefaults standardUserDefaults]objectForKey:@"purposeOfVisit"],[[NSUserDefaults standardUserDefaults] objectForKey:@"allergies"],[[NSUserDefaults standardUserDefaults]objectForKey:@"medications"],[[NSUserDefaults standardUserDefaults]objectForKey:@"medicationsTimme"],[[NSUserDefaults standardUserDefaults]objectForKey:@"generalSymp"],[[NSUserDefaults standardUserDefaults]objectForKey:@"headNeckStr"],[[NSUserDefaults standardUserDefaults]objectForKey:@"skinSymp"],[[NSUserDefaults standardUserDefaults]objectForKey:@"chesttSym"],[[NSUserDefaults standardUserDefaults]objectForKey:@"digestiveSymp"],[[NSUserDefaults standardUserDefaults]objectForKey:@"pelvicSymp"],[[NSUserDefaults standardUserDefaults]objectForKey:@"muscleSymp"],[[NSUserDefaults standardUserDefaults]objectForKey:@"medicalCondition"],[[NSUserDefaults standardUserDefaults]objectForKey:@"pharmacyId"],[[NSUserDefaults standardUserDefaults]objectForKey:@"PatientTransactionID"],ack,[[NSUserDefaults standardUserDefaults]objectForKey:@"Amount"],[[NSUserDefaults standardUserDefaults]objectForKey:@"paymentTime"],[[NSUserDefaults standardUserDefaults]objectForKey:@"patientNo"],[[NSUserDefaults standardUserDefaults]objectForKey:@"childId"]];
        
    }
    else if ([SingletonClass sharedSingleton].deptId==2){
        body =[NSString stringWithFormat:@"appointment_start_time=%@&appointment_end_time=%@&patient_id=%@&doctor_id=%@&planid=%@&departmentId=%d&calltime=%@&callcost=%@&needtopay=%@&creditremains=%@&id=%@&purpose=%@&medication=%@&medicationTime=%@&generalSymptoms=%@&neckSymptoms=%@&chestSymptoms=%@&digestiveSymptoms=%@&pelvisSymptoms=%@&skinSymptoms=%@&musclesSymptoms=%@&medicalConditions=%@&pharmacyId=%@&transactionId=%@&acknowledgement=%@&amount=%@&paymentTime=%@&patient=%@&allergies=%@&childId=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"appointment_start"],[[NSUserDefaults standardUserDefaults]objectForKey:@"appointment_end"],[[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"],[[NSUserDefaults standardUserDefaults]objectForKey:@"doctorid"],[[NSUserDefaults standardUserDefaults]objectForKey:@"PatientPlanId"],[SingletonClass sharedSingleton].deptId,[[NSUserDefaults standardUserDefaults]objectForKey:@"PatientCallTime"],[[NSUserDefaults standardUserDefaults]objectForKey:@"PatientCallCost"],[[NSUserDefaults standardUserDefaults]objectForKey:@"PatientNeedToPay"],[[NSUserDefaults standardUserDefaults]objectForKey:@"PatientCredRem"],[[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"],[[NSUserDefaults standardUserDefaults]objectForKey:@"purposeOfVisit"],[[NSUserDefaults standardUserDefaults]objectForKey:@"medications"],[[NSUserDefaults standardUserDefaults]objectForKey:@"medicationsTimme"],[[NSUserDefaults standardUserDefaults]objectForKey:@"generalSymp"],[[NSUserDefaults standardUserDefaults]objectForKey:@"headNeckStr"],[[NSUserDefaults standardUserDefaults]objectForKey:@"chesttSym"],[[NSUserDefaults standardUserDefaults]objectForKey:@"digestiveSymp"],[[NSUserDefaults standardUserDefaults]objectForKey:@"pelvicSymp"],[[NSUserDefaults standardUserDefaults]objectForKey:@"skinSymp"],[[NSUserDefaults standardUserDefaults]objectForKey:@"muscleSymp"],[[NSUserDefaults standardUserDefaults]objectForKey:@"medicalCondition"],[[NSUserDefaults standardUserDefaults]objectForKey:@"pharmacyId"],[[NSUserDefaults standardUserDefaults]objectForKey:@"PatientTransactionID"],ack,[[NSUserDefaults standardUserDefaults]objectForKey:@"Amount"],[[NSUserDefaults standardUserDefaults]objectForKey:@"paymentTime"],[[NSUserDefaults standardUserDefaults]objectForKey:@"patientNo"],[[NSUserDefaults standardUserDefaults] objectForKey:@"allergies"],[[NSUserDefaults standardUserDefaults]objectForKey:@"childId"]];

    }
    else if([SingletonClass sharedSingleton].deptId==3){
        [[NSUserDefaults standardUserDefaults]setObject:@"0"  forKey:@"childId"];
        [[NSUserDefaults standardUserDefaults]synchronize];

        
        body =[NSString stringWithFormat:@"appointment_start_time=%@&appointment_end_time=%@&patient_id=%@&doctor_id=%@&planid=%@&departmentId=%d&calltime=%@&callcost=%@&needtopay=%@&creditremains=%@&id=%@&purpose=%@&medication=%@&medicationTime=%@&generalSymptoms=%@&relationshipSymptoms=%@&habitSymptoms=%@&medicalConditions=%@&pharmacyId=%@&transactionId=%@&acknowledgement=%@&amount=%@&paymentTime=%@&patient=%@&Exercise1=%@&Exercise2=%@&allergies=%@&childId=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"appointment_start"],[[NSUserDefaults standardUserDefaults]objectForKey:@"appointment_end"],[[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"],[[NSUserDefaults standardUserDefaults]objectForKey:@"doctorid"],[[NSUserDefaults standardUserDefaults]objectForKey:@"PatientPlanId"],[SingletonClass sharedSingleton].deptId,[[NSUserDefaults standardUserDefaults]objectForKey:@"PatientCallTime"],[[NSUserDefaults standardUserDefaults]objectForKey:@"PatientCallCost"],[[NSUserDefaults standardUserDefaults]objectForKey:@"PatientNeedToPay"],[[NSUserDefaults standardUserDefaults]objectForKey:@"PatientCredRem"],[[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"],[[NSUserDefaults standardUserDefaults]objectForKey:@"purposeOfVisit"],[[NSUserDefaults standardUserDefaults]objectForKey:@"medications"],[[NSUserDefaults standardUserDefaults]objectForKey:@"medicationsTimme"],[[NSUserDefaults standardUserDefaults]objectForKey:@"generalSymp"],[[NSUserDefaults standardUserDefaults]objectForKey:@"relationshipSymp"],[[NSUserDefaults standardUserDefaults]objectForKey:@"habitSym"],[[NSUserDefaults standardUserDefaults]objectForKey:@"medicalCondition"],[[NSUserDefaults standardUserDefaults]objectForKey:@"pharmacyId"],[[NSUserDefaults standardUserDefaults]objectForKey:@"PatientTransactionID"],ack,[[NSUserDefaults standardUserDefaults]objectForKey:@"Amount"],[[NSUserDefaults standardUserDefaults]objectForKey:@"paymentTime"],[[NSUserDefaults standardUserDefaults]objectForKey:@"patientNo"],[[[SingletonClass sharedSingleton].globalDictionry1 allValues] componentsJoinedByString:@","],[[[SingletonClass sharedSingleton].globalDictionry2 allValues] componentsJoinedByString:@","],[[NSUserDefaults standardUserDefaults] objectForKey:@"allergies"],[[NSUserDefaults standardUserDefaults] objectForKey:@"childId"]];
        
    }
    else if([SingletonClass sharedSingleton].deptId==1){
//        [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"childId"];
//        [[NSUserDefaults standardUserDefaults]synchronize];
//        
        
//        [[NSUserDefaults standardUserDefaults]setObject:@""  forKey:@"generalSymp"];
//        [[NSUserDefaults standardUserDefaults]synchronize];

        
        body =[NSString stringWithFormat:@"appointment_start_time=%@&appointment_end_time=%@&patient_id=%@&doctor_id=%@&planid=%@&departmentId=%d&calltime=%@&callcost=%@&needtopay=%@&creditremains=%@&purpose=%@&babyAge=%@&gestutionDuration=%@&breastFedChildNum=%@&breastFedDuration=%@&breastPump=%@&allergies=%@&medication=%@&medicationTime=%@&generalSymptoms=%@&babySymptoms=%@&nippleSymptoms=%@&breastSymptoms=%@&medicalConditions=%@&pharmacyId=%@&transactionId=%@&acknowledgement=%@&amount=%@&paymentTime=%@&patient=%@&childId=0",[[NSUserDefaults standardUserDefaults]objectForKey:@"appointment_start"],[[NSUserDefaults standardUserDefaults]objectForKey:@"appointment_end"],[[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"],[[NSUserDefaults standardUserDefaults]objectForKey:@"doctorid"],[[NSUserDefaults standardUserDefaults]objectForKey:@"PatientPlanId"],[SingletonClass sharedSingleton].deptId,[[NSUserDefaults standardUserDefaults]objectForKey:@"PatientCallTime"],[[NSUserDefaults standardUserDefaults]objectForKey:@"PatientCallCost"],[[NSUserDefaults standardUserDefaults]objectForKey:@"PatientNeedToPay"],[[NSUserDefaults standardUserDefaults]objectForKey:@"PatientCredRem"],[[NSUserDefaults standardUserDefaults]objectForKey:@"purposeOfVisit"],[[NSUserDefaults standardUserDefaults]objectForKey:@"babyAge"],[[NSUserDefaults standardUserDefaults]objectForKey:@"gestationWeeks"],[[NSUserDefaults standardUserDefaults]objectForKey:@"breastFeedNo"],[[NSUserDefaults standardUserDefaults]objectForKey:@"breastFeedingPeroid"],[[NSUserDefaults standardUserDefaults]objectForKey:@"breastPump"],[[NSUserDefaults standardUserDefaults] objectForKey:@"allergies"],[[NSUserDefaults standardUserDefaults]objectForKey:@"medications"],[[NSUserDefaults standardUserDefaults]objectForKey:@"medicationsTimme"],[[NSUserDefaults standardUserDefaults]objectForKey:@"generalSymp"],[[NSUserDefaults standardUserDefaults]objectForKey:@"babySym"],[[NSUserDefaults standardUserDefaults]objectForKey:@"nippleSym"],[[NSUserDefaults standardUserDefaults]objectForKey:@"breastSym"],[[NSUserDefaults standardUserDefaults]objectForKey:@"medicalCondition"],[[NSUserDefaults standardUserDefaults]objectForKey:@"pharmacyId"],[[NSUserDefaults standardUserDefaults]objectForKey:@"PatientTransactionID"],ack,[[NSUserDefaults standardUserDefaults]objectForKey:@"Amount"],[[NSUserDefaults standardUserDefaults]objectForKey:@"paymentTime"],[[NSUserDefaults standardUserDefaults]objectForKey:@"patientNo"]];
        
    }

    
    NSMutableURLRequest * request =[[NSMutableURLRequest alloc]initWithURL:postUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (!data) {
        
        return;
    }
    
     paymentJson =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    NSLog(@"json %@",paymentJson);
    if ([[paymentJson objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
        
            [SingletonClass sharedSingleton].scheduledAppointment=YES;
        
        
        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"PatientTransactionID"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"Amount"];
        [[NSUserDefaults standardUserDefaults]synchronize];
   
        
        
        
        
        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"doctorid"];
        [[NSUserDefaults standardUserDefaults]synchronize];

        
        ack=nil;

//                     UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"SignUp Successfull" message:@"Check your mail for confirmation mail" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//                [alert show];
       
        [[NSUserDefaults standardUserDefaults]setObject:[paymentJson objectForKey:@"id"]  forKey:@"appointmentId"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
      [self popUp];
        
    }
    else{
        
            [SingletonClass sharedSingleton].scheduledAppointment=NO;
[self popUp];
    
    }

    
    
    
}
-(void)payment{
    
//    NSError * error ;
//    NSURLResponse * urlResponse;
//    
//    NSURL * postUrl =[NSURL URLWithString:appointmentPaymentService];
//    
//    
//   
//    
//    NSString * body =[NSString stringWithFormat:@"paymentTime=%@&acknowledgement=1&amount=%@&transactionId=%@&memberId=%@&appointmentid=%@",[paymenDetails objectForKey:@"paymentTime"],[paymenDetails objectForKey:@"Amount"],[paymenDetails objectForKey:@"transactionId"],[[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"],[[NSUserDefaults standardUserDefaults] objectForKey:@"appointmentId"]];
//    
//
//    
//    
//    NSMutableURLRequest * request =[[NSMutableURLRequest alloc]initWithURL:postUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
//    
//    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
//    if (!data) {
//        
//        return;
//    }
//    
//    id json =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
//    
//    NSLog(@"json %@",json);
//    if ([[json objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
//       
//        
//        
//        
//    }
//    
//
    
}

#pragma mark-Get transaction ID and Payment ID
-(void)getTransactionId{
    
    if([SingletonClass networkcheck]==YES){
        
        NSError *error;
        NSURLResponse * urlResponse;
        
        
        NSString * urlStr =[NSString stringWithFormat:getTransactionIDService];
        NSURL * url =[NSURL URLWithString:urlStr];
        
        NSMutableURLRequest  * request =[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
        
        NSString * body =[NSString stringWithFormat:@"paymentid=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"PayPalPaymentId"]];
        
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        
        NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
        if (!data) {
            return;
        }
        id jsonResponse =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        
   //       NSLog(@"Appointment---->%@",jsonResponse);
        
        if ([[jsonResponse objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
            
            
            [[NSUserDefaults standardUserDefaults]setObject:[[[[[[[jsonResponse objectForKey:@"data"]objectForKey:@"transactions"]objectAtIndex:0]objectForKey:@"related_resources"]objectAtIndex:0] objectForKey:@"sale"]objectForKey:@"id"] forKey:@"PatientTransactionID"];
            
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            [[NSUserDefaults standardUserDefaults]setObject:[[jsonResponse objectForKey:@"data"]objectForKey:@"accesstoken"]forKey:@"AccessToken"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            
            
                        if([SingletonClass  sharedSingleton].deptId==5){
            
                            [self scheduleSeeDocNow];
            
                        }else{
                            [self scheduleAppointment];
                            
                        }

            
            
            
        }
    }
    
    else
        [self networkWarning];
    
    
}



-(void)scheduleSeeDocNow{
    
    NSError * error ;
    NSURLResponse * urlResponse;
    
    NSURL * postUrl =[NSURL URLWithString:seeDocNowService];
    
    
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"PatientNeedToPay"]intValue]==0)
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"0"forKey:@"PatientTransactionID"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        [[NSUserDefaults standardUserDefaults]setObject:@"0"forKey:@"Amount"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        ack=@"Free_User";

    }
    
    
    
    
    NSString * body =[NSString stringWithFormat:@"generalSymptoms=%@&headNeckSymptoms=%@&digestiveTrack=%@&allergies=%@&medicalConditions=%@&appointmentStartTime=%@&appointmentEndTime=%@&doctorID=%@&patientId=%@&planId=%@&pharmacyId=%@&AMT=%@&TRANSACTIONID=%@&ACK=%@&creditRemains=%@&purposeOfVisit=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"generalSympStr"],[[NSUserDefaults standardUserDefaults]objectForKey:@"headNeckStr"],[[NSUserDefaults standardUserDefaults]objectForKey:@"digestivetrackStr"],[[NSUserDefaults standardUserDefaults]objectForKey:@"allergies"],[[NSUserDefaults standardUserDefaults] objectForKey:@"medicalCondition"],[self fetchdate:[[NSUserDefaults standardUserDefaults] objectForKey:@"DoctorNowStartTime"]],[self fetchdate:[[NSUserDefaults standardUserDefaults] objectForKey:@"DoctorNowEndTime"]],[[NSUserDefaults standardUserDefaults] objectForKey:@"DoctorNowId"],[[NSUserDefaults standardUserDefaults] objectForKey:@"patientid"],[[NSUserDefaults standardUserDefaults] objectForKey:@"PatientPlanId"],[[NSUserDefaults standardUserDefaults] objectForKey:@"pharmacyId"],[[NSUserDefaults standardUserDefaults]objectForKey:@"Amount"],[[NSUserDefaults standardUserDefaults]objectForKey:@"PatientTransactionID"],ack,[[NSUserDefaults standardUserDefaults]objectForKey:@"PatientCredRem"],[[NSUserDefaults standardUserDefaults]objectForKey:@"purposeOfVisit"]];
    
    
    
    
    NSMutableURLRequest * request =[[NSMutableURLRequest alloc]initWithURL:postUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
    
    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (!data) {
        
        return;
    }
    
    paymentJson =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    NSLog(@"json %@",paymentJson);
    if ([[paymentJson objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
        
        
//        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"transactionId"];
//        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"Amount"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        ack=nil;
        
        
        [[NSUserDefaults standardUserDefaults]setObject:[paymentJson objectForKey:@"data"] forKey:@"appointmentId"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
      [SingletonClass sharedSingleton].scheduledAppointment=YES;
      //  [self popUp];
        
        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"PatientTransactionID"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        //-------------------------------------------------------------------
        
        
        NSDate *now = [NSDate date];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
        
        
        NSLog(@"%@",[dateFormatter stringFromDate:now]);
        NSLog(@"upto%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"callStartTime"]);
        
        if([[dateFormatter stringFromDate:now] compare:[[NSUserDefaults standardUserDefaults]objectForKey:@"SeeDoctorStart"]]==NSOrderedDescending && [[dateFormatter stringFromDate:now] compare:[[NSUserDefaults standardUserDefaults]objectForKey:@"SeeDoctorEnd"]]==NSOrderedAscending){
            
            [self videoCall];
            
            
        }
        else{
            [self popUp];
        }
        
        

        
        
        
        //-------------------------------------------------------------------
        
        
        
    

        
    }
    else{
        
        [SingletonClass sharedSingleton].scheduledAppointment=NO;

        [self popUp];
        
    }
    
    

    
}


#pragma mark-Video Call
-(void)videoCall{
    
    
    

                    
                    
                    NSError *error;   NSURLResponse * urlResponse;
                    
                    NSString * urlStr =[NSString stringWithFormat:fetchQuickBloxDetails];
                    NSURL * url =[NSURL URLWithString:urlStr];
                    
                    NSMutableURLRequest  * request =[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
                    
                NSString * body =[NSString stringWithFormat:@"patientId=%@&doctorID=%@"
                                  ,[[NSUserDefaults standardUserDefaults] objectForKey:@"patientid"],[[NSUserDefaults standardUserDefaults] objectForKey:@"DoctorNowId"]];
                    
                    [request setHTTPMethod:@"POST"];
                    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
                    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
                    
                    
                    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
                    if (!data) {
                        return;
                    }
                    id jsonResponse1 =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                    
                    
                    if ([[jsonResponse1 objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
                        
               //Save Receiver(Doctors) Quick Blox Creds
                        
                        [[NSUserDefaults standardUserDefaults]setObject: [[[jsonResponse1 objectForKey:@"data"] objectForKey:@"receiverDetails"] objectForKey:@"qId"] forKey:@"doctorQuickBloxId"];
                        [[NSUserDefaults standardUserDefaults]synchronize];
                        
                        
                        [[NSUserDefaults standardUserDefaults]setObject: [[[jsonResponse1 objectForKey:@"data"] objectForKey:@"receiverDetails"] objectForKey:@"email"] forKey:@"doctorQuickBloxUserName"];
                        [[NSUserDefaults standardUserDefaults]synchronize];
                        
                        
                        [[NSUserDefaults standardUserDefaults]setObject: [[[jsonResponse1 objectForKey:@"data"] objectForKey:@"receiverDetails"] objectForKey:@"name"] forKey:@"doctorQuickBloxName"];
                        [[NSUserDefaults standardUserDefaults]synchronize];
                        
                        // Save Caller(Patient) Quick Blox Creds


                        
                        [[NSUserDefaults standardUserDefaults]setObject: [[[jsonResponse1 objectForKey:@"data"] objectForKey:@"callerDetails"] objectForKey:@"qId"] forKey:@"patientQuickBloxId"];
                        [[NSUserDefaults standardUserDefaults]synchronize];
                        
                        
                        
                        
           //---------------------------------------------
                        [[NSUserDefaults standardUserDefaults]setObject: [[[jsonResponse1 objectForKey:@"data"] objectForKey:@"callerDetails"] objectForKey:@"name"] forKey:@"patientQuickBloxName"];
                        [[NSUserDefaults standardUserDefaults]synchronize];

                        
                        
                        [[NSUserDefaults standardUserDefaults]setObject: [[[jsonResponse1 objectForKey:@"data"] objectForKey:@"callerDetails"] objectForKey:@"email"] forKey:@"patientQuickBloxEmail"];
                        [[NSUserDefaults standardUserDefaults]synchronize];

                        
                //                        QBUUser *user = ConnectionManager.instance.users[0];
//                        
//                        
//                        [self logInChatWithUser:user];
                        
                        self.navigationController.navigationBar.hidden = NO;
                        
                        LoginViewController *chatLogin = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"startStoryBoard"];
                        
                        chatLogin.title=@"Video & Audio Chat";
                        
                        [self.navigationController pushViewController:chatLogin animated:YES];
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                    
              

//            });
//            
//        });
    

    
    
    
    
    
    
    

    

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
    
    
    if([[paymentJson objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]])
    header.text=@"Congratulation";
    
    else
        
        header.text=@"SORRY";
    header.numberOfLines=2;
    header.font=[UIFont fontWithName:@"GothamRounded-Medium" size:30];
    header.textColor=[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1];
    header.textAlignment = NSTextAlignmentCenter;
    [letsGetStartedPopUp addSubview:header];
    
    UILabel *information=[[UILabel alloc]init];
    information.frame=  CGRectMake(20,50, letsGetStartedPopUp.frame.size.width-40, 300);
    if([[paymentJson objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]){
        information.text=@"Successfully Scheduled an Appointment!!";
    }
    else
    information.text=@"Operation Unsuccessful!!";
    information.numberOfLines=7;
    information.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];
    information.textColor=[UIColor blackColor];
    information.textAlignment = NSTextAlignmentCenter;
    [letsGetStartedPopUp addSubview:information];
    
    
    
    
    letsGoButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    letsGoButton.frame=CGRectMake(0,letsGetStartedPopUp.frame.size.height-50,letsGetStartedPopUp.frame.size.width, 50);
    [letsGoButton setTitle:@"OK!" forState:UIControlStateNormal];
    letsGoButton.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    [letsGoButton setBackgroundColor:[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1]];
    [letsGoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [letsGoButton addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
    letsGoButton.layer.cornerRadius=6.0f;
    
    [letsGetStartedPopUp addSubview:letsGoButton];
    if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()) {
        header.font=[UIFont  fontWithName:@"GothamRounded-Medium" size:50];
        header.frame= CGRectMake(00,0,  letsGetStartedPopUp.frame.size.width, 200);
        information.frame= CGRectMake(0,250,  letsGetStartedPopUp.frame.size.width, 300);
        information.font = [UIFont fontWithName:@"GothamRounded-Medium" size:30];
        
        
        letsGoButton.frame=CGRectMake(0, letsGetStartedPopUp.frame.size.height-100,letsGetStartedPopUp.frame.size.width, 100);
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
        
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        //        [SingletonClass sharedSingleton].deptId=5;
        //        AppointmentDurationVC *apptDuratn=[AppointmentDurationVC new];
        //        [self.navigationController pushViewController:apptDuratn animated:YES];
        
    }];
    
}

#pragma mark-Activity Indicator
-(void)activityAction{
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.frame = CGRectMake([UIScreen mainScreen].bounds.size .width/2-20, [UIScreen mainScreen].bounds.size.height/2-55,80 ,80);
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
    [okButton addTarget:self action:@selector(networkOk) forControlEvents:UIControlEventTouchUpInside];
    okButton.layer.cornerRadius=6.0f;
    
    [letsGetStartedPopUp addSubview:okButton];
    
}

-(void)networkOk{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        letsGetStartedPopUp.frame=CGRectMake(30, 700, self.view.frame.size.width-60, self.view.frame.size.height-60);
        backPopUp.frame = CGRectMake(0,800, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }completion:^(BOOL finished){
        [backPopUp removeFromSuperview];
        
    }];
    
    
}


#pragma mark-Auto Allocate Doctor
-(void)autoAllocateDoctor{
    
    NSError * error;
    NSURLResponse *  urlResponse;
    
    
    //    NSURL * postUrl =[NSURL URLWithString:autoAllocateDoctorServie];
    
    NSURL * postUrl =[NSURL URLWithString:newAutoAllocateDoc];
    
    
//    NSLog(@"See Doc Now Start time->%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"SeeDoctorStart"]);
//   
//    
//    NSLog(@"See Doc Now End time->%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"SeeDoctorEnd"]);

    
    
    
    NSMutableURLRequest * request =[[NSMutableURLRequest alloc]initWithURL:postUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    
    NSString * body =[NSString stringWithFormat:@"timeZone=%@",[[NSTimeZone localTimeZone]name]];
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
        
        [[NSUserDefaults standardUserDefaults]setObject:[[json objectForKey:@"data"] objectForKey:@"doctorId"] forKey:@"DoctorNowId"];
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        [[NSUserDefaults standardUserDefaults]setObject:[[json objectForKey:@"data"]objectForKey:@"appointmentStartTime"] forKey:@"DoctorNowStartTime"];
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        [[NSUserDefaults standardUserDefaults]setObject:[[json objectForKey:@"data"]objectForKey:@"appointmentEndTime"] forKey:@"DoctorNowEndTime"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        

        
        
    
        
    }
    else{
        
        
        
    }
    
    
    [self popUpSeeDoc];
    
}
#pragma mark-See Doctor Now PopUp
-(void)popUpSeeDoc{
    
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
    
    
    if([[json objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]])
        header.text=@"See Doctor";
    
    else
        
        header.text=@"SORRY";
    header.numberOfLines=2;
    header.font=[UIFont fontWithName:@"GothamRounded-Medium" size:30];
    header.textColor=[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1];
    header.textAlignment = NSTextAlignmentCenter;
    [letsGetStartedPopUp addSubview:header];
    
    UILabel *information=[[UILabel alloc]init];
    information.frame=  CGRectMake(20,50, letsGetStartedPopUp.frame.size.width-40, 300);
    if([[json objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]){
        information.text
        =[NSString stringWithFormat:@"Your Appointment on:\n\n%@\nto\n%@",[self changeFormat:[[NSUserDefaults standardUserDefaults]objectForKey:@"DoctorNowStartTime"]],[self changeFormat:[[NSUserDefaults standardUserDefaults]objectForKey:@"DoctorNowEndTime"]]];
       
       // NSLog(@"%@",[self changeFormat:[[NSUserDefaults standardUserDefaults]objectForKey:@"SeeDoctorStart"]]);
    }
    else
        information.text=@"All of our doctors are\ncurrently unavailable";
    information.numberOfLines=7;
    information.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
    information.textColor=[UIColor blackColor];
    information.textAlignment = NSTextAlignmentCenter;
    [letsGetStartedPopUp addSubview:information];
    
    
    
    
    letsGoButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    letsGoButton.frame=CGRectMake(0,letsGetStartedPopUp.frame.size.height-50,letsGetStartedPopUp.frame.size.width, 50);
    [letsGoButton setTitle:@"OK!" forState:UIControlStateNormal];
    letsGoButton.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    [letsGoButton setBackgroundColor:[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1]];
    [letsGoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    if([[json objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]])
    
    [letsGoButton addTarget:self action:@selector(networkOk) forControlEvents:UIControlEventTouchUpInside];
    
    else
   [letsGoButton addTarget:self action:@selector(okAction2) forControlEvents:UIControlEventTouchUpInside];
    
    letsGoButton.layer.cornerRadius=6.0f;
    
    [letsGetStartedPopUp addSubview:letsGoButton];
    
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        header.frame = CGRectMake(0,0,  letsGetStartedPopUp.frame.size.width, 150);
        header.textAlignment = NSTextAlignmentCenter;
        header.font = [UIFont fontWithName:@"GothamRounded-Medium" size:50];
        
       
        
        information.frame=  CGRectMake(40,150, letsGetStartedPopUp.frame.size.width-80, 300);
        information.font = [UIFont fontWithName:@"GothamRounded-Medium" size:30];
        information.textAlignment = NSTextAlignmentCenter;
              letsGoButton.frame=CGRectMake(0,letsGetStartedPopUp.frame.size.height-100,letsGetStartedPopUp.frame.size.width, 100);
        letsGoButton.titleLabel.font = [UIFont fontWithName:@"GothamRounded-Medium" size:30];
    }
    

    
    
}

#pragma mark-Convert UTC to local
-(NSString*)fetchdate:(NSString *)dateStr{
    
    
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormat setTimeZone:[NSTimeZone localTimeZone]];
    
    // [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    //
    NSDate *date=[dateFormat dateFromString:dateStr];
    
    
    
    NSDateFormatter *utc=[[NSDateFormatter alloc]init];
    //[utc setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    [utc setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    //  NSString *utcstr=[utc stringFromDate:date];
    
    [utc setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString * resultDate =[utc stringFromDate:date];
    
    
    return resultDate;
    
}
#pragma mark-Time format change
-(NSString *)changeFormat:(NSString*)time{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
   // [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    
    
    NSDate *date=[dateFormat dateFromString:time];
    
    
    NSDateFormatter *dataFormatter=[[NSDateFormatter alloc]init];
    [dataFormatter setDateFormat:@"HH:mm:ss"];
    NSString *date1=[dataFormatter stringFromDate:date];
    
    
    
    [dataFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *date2=[dataFormatter stringFromDate:date];
    return [NSString stringWithFormat:@"%@ on %@",date1,date2];
    

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
