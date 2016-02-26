
//
//  SignInView.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 8/7/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "SignInView.h"
#import "SVProgressHUD.h"

@interface SignInView (){
    CGSize screenRect;
    int height;
    int width;
    UIActivityIndicatorView * AcitvityIndicatorView;
    UITextField *email,*password;UIButton *signIn,*forgotPassword;
    UILabel *label;
    UIActivityIndicatorView *activityIndicator;
    UIView *backPopUp,*letsGetStartedPopUp;

   

}


@end

@implementation SignInView

- (void)viewDidLoad {
    screenRect = [[UIScreen mainScreen] bounds].size;
       [super viewDidLoad];
    self.title=@"Sign In";
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    
    
    UIView * headerView =[[UIView alloc]init];
    headerView.frame= CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55);
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]init];
   titleLable.frame= CGRectMake(60, 25, screenRect.width-120, 25);
    titleLable.text =@"Sign In";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font =[UIFont fontWithName:@"GothamRounded-Light" size:15];
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
[backButton setFrame:CGRectMake(15, 18, 55, 35)];   [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        headerView.frame= CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80);
        titleLable.frame= CGRectMake(60, 25, screenRect.width-120, 35);
        titleLable.font=[UIFont fontWithName:@"GothamRounded-Light" size:30];
        //titleLable.font =[UIFont systemFontOfSize:30];
        [backButton setImage:[UIImage imageNamed:@"back_btn_ipad.png"] forState:UIControlStateNormal];
        [backButton setFrame:CGRectMake(15, 30, 80, 25)];

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
    logoView.frame=CGRectMake(40,80,260, 44);
    
    logoView.image=[UIImage imageNamed:@"logo.png"];
    [logoView setContentMode:UIViewContentModeScaleAspectFit];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        
        logoView.frame=CGRectMake([UIScreen mainScreen].bounds.size.width/4-70,120,500, 80);
        
        logoView.image=[UIImage imageNamed:@"logoIPad.png"];

    }
    
   // [logoView sizeToFit];
    
    [self.view addSubview:logoView];
    
    email=[[UITextField alloc]init];
    email.frame = CGRectMake(10, 180,screenRect.width-20 , 50);
    email.font = [UIFont fontWithName:@"GothamRounded-Light" size:15];
    
    
  
    //email.text=@"sudipkundu@globussoft.com";

   email.borderStyle=UITextBorderStyleRoundedRect;
    email.backgroundColor=[UIColor whiteColor];
   email.placeholder=@" Email Address";
        email.delegate = self;
    email.font=[UIFont fontWithName:@"GothamRounded-Light" size:15];
    [self.view addSubview:email];
    
    password=[[UITextField alloc]init];
    
        
     //   password.text=@"sudipkundu@globussoft.com";
    
    password.frame= CGRectMake(10, 235, screenRect.width-20, 50);
     password.font = [UIFont fontWithName:@"GothamRounded-Light" size:15];
   password.borderStyle=UITextBorderStyleRoundedRect;
    password.backgroundColor=[UIColor whiteColor];
    password.placeholder=@" Password";
   
     password.delegate = self;
    [password setSecureTextEntry:YES];
    [self.view addSubview:password];
    
    
    
    signIn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    signIn.frame=CGRectMake(10, 290,screenRect.width-20,60);
    signIn.backgroundColor=[UIColor clearColor];
    [signIn setBackgroundImage:[UIImage imageNamed:@"signin_btn.png"] forState:UIControlStateNormal];
    [signIn  addTarget:self action:@selector(signInAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signIn];

    forgotPassword=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    if(screenRect.width>=375){
        
        forgotPassword.frame=CGRectMake(screenRect.width/2-130, 375,screenRect.width-150,10);
    }
    else
    forgotPassword.frame=CGRectMake(screenRect.width/2-80, 375,screenRect.width-150,10);
    forgotPassword.titleLabel.font = [UIFont fontWithName:@"GothamRounded-Light" size:14];
    [forgotPassword setTitle:@"I forgot my password" forState:UIControlStateNormal];
    [forgotPassword addTarget:self action:@selector(forgotPassAction)  forControlEvents:UIControlEventTouchUpInside];

    

    if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()) {
        email.frame = CGRectMake(40, 250,screenRect.width-80 , 80);
         password.frame= CGRectMake(40, 335, screenRect.width-80, 80);
        signIn.frame=CGRectMake(40, 430,screenRect.width-80,100);
        email.font =[UIFont fontWithName:@"GothamRounded-Light" size:25];
        password.font =[UIFont fontWithName:@"GothamRounded-Light" size:25];
         [signIn setBackgroundImage:[UIImage imageNamed:@"signin_btn_ipad.png"] forState:UIControlStateNormal];
        forgotPassword.frame=CGRectMake(screenRect.width/3, 550,275,50);
             forgotPassword.titleLabel.font = [UIFont fontWithName:@"GothamRounded-Medium" size:25];
    }
    [self.view addSubview:forgotPassword];
}

#pragma  mark - textfield delegate methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}

#pragma  mark - sign in function

-(void)signInAction{
    
    
    
    label=[[UILabel alloc]init];
    label.text=@"";
    [password resignFirstResponder];
    [email resignFirstResponder];
    
    if([email.text isEqual:@""]){
        email.layer.borderColor=[[UIColor redColor]CGColor];
        email.layer.borderWidth= 1.0f;
        
        
        label.frame=CGRectMake(50, 30, 250, 20);
        label.text=@"You must enter an email address";
        label.font=[UIFont systemFontOfSize:12];
        label.textColor=[UIColor redColor];
        
        
        [email addSubview:label];
        
    }
    else if([password.text isEqual:@""]){
        password.layer.borderColor=[[UIColor redColor]CGColor];
        password.layer.borderWidth= 1.0f;
        
        
        label.frame=CGRectMake(60, 30, 250, 20);
        label.text=@"You must enter a password";
        label.font=[UIFont systemFontOfSize:12];
        label.textColor=[UIColor redColor];
        
        
        [password addSubview:label];
        
    }

    
    
    else{
        
        if([SingletonClass networkcheck]==YES){
            
  
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1]];
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Loading...", nil)];
    
    NSError * error;
    NSURLResponse *  urlResponse;
    
    
    NSURL * postUrl =[NSURL URLWithString:singInService];
    
    
    
    NSMutableURLRequest * request =[[NSMutableURLRequest alloc]initWithURL:postUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
      
        NSString * body =[NSString stringWithFormat:@"email=%@&password=%@",email.text,password.text];
    [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
      
    if (!data) {
          NSLog(@"error...%@",error.description);
        [SVProgressHUD dismiss];
        NSLog(@"rturned.........");

        return;
    }
    
    id json =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"json %@",json);
         [SVProgressHUD dismiss];
    if ([[json objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]&&[[[json objectForKey:@"data"]objectForKey:@"role"]isEqual:@"1"])
    {
        
        
        [[NSUserDefaults standardUserDefaults]setObject:password.text  forKey:@"patientPassword"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        

        
        email.text =@"";
        password.text =@"";
        
        [[NSUserDefaults standardUserDefaults]setObject:[[json objectForKey:@"data"] objectForKey:@"id"]  forKey:@"patientid"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        if(  [[json objectForKey:@"data"] objectForKey:@"promoCode"]!=[NSNull null]){
       
        [[NSUserDefaults standardUserDefaults]setObject:[[json objectForKey:@"data"] objectForKey:@"promoCode"]  forKey:@"PromoCode"];
        [[NSUserDefaults standardUserDefaults]synchronize];

        
        }
        
        [[NSUserDefaults standardUserDefaults]setObject:[[json objectForKey:@"data"] objectForKey:@"email"]  forKey:@"patientEmail"];
        [[NSUserDefaults standardUserDefaults]synchronize];

        [[NSUserDefaults standardUserDefaults]setObject:[[json objectForKey:@"data"] objectForKey:@"name"]  forKey:@"patientName"];
        [[NSUserDefaults standardUserDefaults]synchronize];

        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"changeSignInName" object:nil];
        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"changeSignInName" object:nil];
        
       
        

    if([[[json objectForKey:@"data"]objectForKey:@"info"] isEqualToNumber:[NSNumber numberWithInt:0]])
        
        
        
        
    {
        PatientMeta *patientMeta=[[PatientMeta alloc]init];
            [self.navigationController presentViewController:patientMeta animated:YES completion:nil];
    }

        
        
        
        
        
        
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"dismissViewController" object:nil];
//        
   //        [alert show];

      
           [self.navigationController popViewControllerAnimated:YES];


    }
    else{
//       // NSString *errMsg=[json objectForKey:@"message"];
//        if(errMsg!=nil)
//        {
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Signin Successful" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//            [alert show];
//
//        }
//        else
//        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@" Invalid Credentials" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
       // }
            }
        
    }
  
      else
          [self networkWarning];
        
    }
    
}

#pragma mark-back Action
-(void)backAction{
       [self.navigationController popViewControllerAnimated:YES];
 
}


#pragma mark-text field delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField

{
    
    if(textField==email){
        email.layer.borderColor=[[UIColor clearColor]CGColor];
        email.layer.borderWidth= 1.0f;
        [label removeFromSuperview];
    }
    else if(textField==password){
        [self animateTextField:textField up:YES];
        password .layer.borderColor=[[UIColor clearColor]CGColor];
        password.layer.borderWidth= 1.0f;
        [label removeFromSuperview];
    }
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField==password){
        [self animateTextField:textField up:NO];
    }
    
}
#pragma mark- forgot Password Action
-(void)forgotPassAction{
    
    
    
    
    label=[[UILabel alloc]init];
    label.text=@"";
    [password resignFirstResponder];
    [email resignFirstResponder];
    
    if([email.text isEqual:@""]){
        email.layer.borderColor=[[UIColor redColor]CGColor];
        email.layer.borderWidth= 1.0f;
        
        
        label.frame=CGRectMake(50, 30, 250, 20);
        label.text=@"You must enter an email address";
        label.font=[UIFont systemFontOfSize:12];
        label.textColor=[UIColor redColor];
        
        
        [email addSubview:label];

    }
    else{
        
       [self activityAction];
        dispatch_async(dispatch_get_global_queue(0, 0),^{
            
           

            dispatch_async(dispatch_get_main_queue(),^{
                
                             [self forgotPass];
                [activityIndicator stopAnimating];
            });
            
        });
        
       


       
}
}

#pragma mark-Activity Indicator
-(void)activityAction{
    CGSize windowSize =[UIScreen  mainScreen].bounds.size;
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.frame = CGRectMake(windowSize.width/2-20, windowSize.height/2-55,40 ,40);
    activityIndicator.color = [UIColor blackColor];
    activityIndicator.alpha = 1;
    [self.view addSubview:activityIndicator];
    //[self placeSearchbaseId];
    
    [activityIndicator startAnimating];
    
    
}
#pragma forgot passwrod service
-(void)forgotPass{
    
    NSError * error;
    NSURLResponse *  urlResponse;
    
    
    NSURL * postUrl =[NSURL URLWithString:forgotPasswordService];
    
    
    
    NSMutableURLRequest * request =[[NSMutableURLRequest alloc]initWithURL:postUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    
    NSString * body =[NSString stringWithFormat:@"userEmail=%@",email.text];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];

    
    if (!data) {
        
        [AcitvityIndicatorView stopAnimating];
        
        return;
    }
    
    id json =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@" %@",json);
    
    
    if ([[json objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
        NSString *errMsg=[json objectForKey:@"message"];
        if(errMsg!=nil){
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:errMsg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
        
        
    }
    else{
        NSString *errMsg=[json objectForKey:@"message"];
        if(errMsg!=nil){
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:errMsg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            
        }
        else{
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@" Invalid Credentials!!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
    }
    
    

}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    NSLog(@"connection error or network error");
    
}
-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    const int movementDistance = -80;
    const float movementDuration = 0.3f;
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
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
    [okButton addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
    okButton.layer.cornerRadius=6.0f;
    
    [letsGetStartedPopUp addSubview:okButton];
    
}

-(void)okAction{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        letsGetStartedPopUp.frame=CGRectMake(30, 700, self.view.frame.size.width-60, self.view.frame.size.height-60);
        backPopUp.frame = CGRectMake(0,800, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }completion:^(BOOL finished){
        [backPopUp removeFromSuperview];
        
    }];
    
    
}


@end
