//
//  ApplyCouponVC.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 9/1/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "ApplyCouponVC.h"
#import "SingletonClass.h"

@interface ApplyCouponVC ()
{
    CGSize screenRect;
       UIView *headerView,*backPopUp,*letsGetStartedPopUp;
    UITextField *couponCode;
}


@end

@implementation ApplyCouponVC

- (void)viewDidLoad {
    [super viewDidLoad];
    screenRect = [[UIScreen mainScreen] bounds].size;
    
    // UIImage *headerImage = [UIImage imageNamed:@"head_logo"];
    
    //arr =[NSArray arrayWithObjects:@" Me",@" My Child",@" Someone Else", nil];
    //self.navigationItem.titleView = [[UIImageView alloc] initWithImage:headerImage] ;
    
    
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    titleLable.text =@"Apply Coupon";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font = [UIFont fontWithName:@"GothamRounded-Light" size:12];
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
   [backButton setFrame:CGRectMake(15, 18, 55, 35)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
    UIButton *cancelButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelButton.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-60, 25,50,25);
    cancelButton.backgroundColor =[UIColor clearColor];
    [cancelButton setTitleColor:[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)30/255 blue:(CGFloat)49/255 alpha:(CGFloat)1] forState:UIControlStateNormal];
    cancelButton.titleLabel.font =[UIFont systemFontOfSize:12];
    [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    
    [headerView addSubview:cancelButton];
    
    [self createUi];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)createUi{
    
    
    UILabel *briefDescp=[[UILabel alloc]initWithFrame:CGRectMake(0, 65, screenRect.width-30, 50)];
    briefDescp.numberOfLines=2;
    briefDescp.text=@"Do you have a coupon code to\n use with Doctor On Demand?";
    briefDescp.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
    briefDescp.textColor=[UIColor blackColor];
    briefDescp.textAlignment=NSTextAlignmentCenter;
    
    [self.view addSubview:briefDescp];
    
    
    
    
    
    
    
    couponCode=[[UITextField alloc]initWithFrame:CGRectMake(10,135, screenRect.width-20, 50)];\
    couponCode.borderStyle=UITextBorderStyleRoundedRect;
    couponCode.placeholder=@" Coupon Code";
    couponCode.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];
    couponCode.layer.cornerRadius=10.0f;
    couponCode.text=@"";
    [self.view addSubview:couponCode];
    //
    //
    
    
    UIButton *submitCouponBtn=[[UIButton alloc]initWithFrame:CGRectMake(10,190, screenRect.width-20, 50)];
    [submitCouponBtn setTitle:@"Submit Coupon" forState:UIControlStateNormal];
    [submitCouponBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitCouponBtn setBackgroundColor:[UIColor colorWithRed:(CGFloat)234/255 green:(CGFloat)30/255 blue:(CGFloat)99/255 alpha:(CGFloat)1.0]];
      submitCouponBtn.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
    [submitCouponBtn addTarget:self action:@selector(submitActn) forControlEvents:UIControlEventTouchUpInside];
    submitCouponBtn.layer.cornerRadius=10.0f;
    [self.view addSubview:submitCouponBtn];
    
    
    
    
    
    
    
}

#pragma submit Action
-(void)submitActn{
    
    
    if([SingletonClass networkcheck]==YES){

    
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"CouponType"]isEqual:@"BussinessType"])
        [self submitBussinessCoupon];
        else
            [self submitCouponAction];
    }
    else{
        [self networkWarning];
    }
    
}
-(void)backAction{
    
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeCallRate" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"changeCallRate" object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)cancelAction{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeCallRate" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"changeCallRate" object:nil];
         [self.navigationController popViewControllerAnimated:YES];
}

#pragma SubmitBussinessCoupon

-(void)submitBussinessCoupon{
    
    NSError *error;   NSURLResponse * urlResponse;
    
    
    NSURL * url =[NSURL URLWithString:bussinessReferalCoupon];
    
    NSMutableURLRequest  * request =[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    
    
    NSString * body =[NSString stringWithFormat:@"referralCode=%@&orgType=%@&userId=%@",couponCode.text,[[NSUserDefaults standardUserDefaults]objectForKey:@"referalNo"],[[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (!data) {
        return;
    }
    id jsonResponse =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    
    
    NSLog(@"schedule jason---->%@",jsonResponse);
    
    if(jsonResponse ==nil){
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Invalid Coupon" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        
        
    }
    else{
        NSString *msg=[jsonResponse objectForKey:@"message"];
        if ([[jsonResponse objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            
            
            couponCode.text=@"";
            
        }
        else{
            
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            
            
            [alert show];
            
        }
    }
    
    
    
}


    
#pragma SubmitCoupon

-(void)submitCouponAction{
    
    NSError *error;   NSURLResponse * urlResponse;
    
 
    NSURL * url =[NSURL URLWithString:applyCouponService];
    
    NSMutableURLRequest  * request =[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    
    // NSString * body =[NSString stringWithFormat:@"doctor_id=40"];
    
    NSString * body =[NSString stringWithFormat:@"couponCode=%@&userId=%@",couponCode.text,[[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (!data) {
        return;
    }
    id jsonResponse =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
   

    
    NSLog(@"schedule jason---->%@",jsonResponse);
    
    if(jsonResponse ==nil){
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Invalid Coupon" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        
        
    }
    else{
     NSString *msg=[jsonResponse objectForKey:@"message"];
    if ([[jsonResponse objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
        
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        
        
         couponCode.text=@"";
        
    }
    else{
        
       
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
       
        
        [alert show];
        
    }
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
