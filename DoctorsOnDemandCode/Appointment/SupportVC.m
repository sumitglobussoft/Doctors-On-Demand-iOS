//
//  SupportVC.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 11/24/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "SupportVC.h"

@interface SupportVC ()
{
    CGSize screenRect;
    UITextField *emailTfld;
    UITextView *messageTv;
    UILabel *label;
}
@end

@implementation SupportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    screenRect = [[UIScreen mainScreen] bounds].size;
    
    
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    titleLable.text =@"Contact Support";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font = [UIFont fontWithName:@"GothamRounded-Light" size:12];
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
    [backButton setFrame:CGRectMake(15, 18, 55, 35)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
    
    [self createUi];

    // Do any additional setup after loading the view.
}
-(void)createUi{
    
    
    UILabel *briefDescp=[[UILabel alloc]initWithFrame:CGRectMake(10, 60, screenRect.width-20, 60)];
    briefDescp.numberOfLines=2;
    briefDescp.text=@"Enter your message and we will get back\nto you as soon as possible";
    briefDescp.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
    briefDescp.textColor=[UIColor blackColor];
    briefDescp.textAlignment=NSTextAlignmentCenter;
    
    [self.view addSubview:briefDescp];
    
    
    emailTfld=[[UITextField alloc]initWithFrame:CGRectMake(10,135, screenRect.width-20, 40)];
    emailTfld.borderStyle=UITextBorderStyleRoundedRect;
    emailTfld.placeholder=@" Email";
    emailTfld.delegate=self;
    emailTfld.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];
    emailTfld.layer.cornerRadius=2.0f;
    [self.view addSubview:emailTfld];

   
    UILabel *messageLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 190, screenRect.width-20, 20)];
    messageLbl.text=@"Message:";
    messageTv.delegate=self;
    messageLbl.textColor=[UIColor blackColor];
    messageLbl.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    [self.view addSubview:messageLbl];
    
    
    
    
    
    messageTv=[[UITextView alloc]initWithFrame:CGRectMake(10,210, screenRect.width-20, 150)];
    messageTv.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];
    messageTv.layer.cornerRadius=10.0f;
    [self.view addSubview:messageTv];

    
    
    
    
    
    
    UIButton *submit=[[UIButton alloc]initWithFrame:CGRectMake(10,370, screenRect.width-20, 50)];
    [submit setTitle:@"Submit" forState:UIControlStateNormal];
    [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submit setBackgroundColor:[UIColor colorWithRed:(CGFloat)234/255 green:(CGFloat)30/255 blue:(CGFloat)99/255 alpha:(CGFloat)1.0]];
    submit.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
    [submit addTarget:self action:@selector(saveSupport) forControlEvents:UIControlEventTouchUpInside];
    submit.layer.cornerRadius=10.0f;
    [self.view addSubview:submit];
    
    
    
    
    
    
    
}
-(void)backAction{
    
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)saveSupport{
    NSError *error;   NSURLResponse * urlResponse;
    
   
    
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    

 if(([emailTfld.text isEqual:@""]))
        
    {
        [emailTfld becomeFirstResponder];
        emailTfld.layer.borderColor=[[UIColor redColor]CGColor];
        emailTfld.layer.borderWidth= 1.0f;
        [[UITextField appearance] setTintColor:[UIColor whiteColor]];
    }
    else  if([emailTest evaluateWithObject:emailTfld.text] == NO){
         [emailTfld resignFirstResponder];
             emailTfld.layer.borderColor=[[UIColor redColor]CGColor];
        emailTfld.layer.borderWidth= 1.0f;
        
        emailTfld.text=nil;
         [[UITextField appearance] setTintColor:[UIColor whiteColor]];
        
        
    }
    else if ([messageTv.text isEqual:@""]){
        
         [messageTv resignFirstResponder];
     
        messageTv.layer.borderColor=[[UIColor redColor]CGColor];
        messageTv.layer.borderWidth= 1.0f;
           }

    else{
   
    NSURL * url =[NSURL URLWithString:supportService];
    
    NSMutableURLRequest  * request =[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];

       NSString * body =[NSString stringWithFormat:@"email=%@&userid=%@&userquery=%@",emailTfld.text,[[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"],messageTv.text];
    
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
            
            
            
            messageTv.text=@"";
            emailTfld.text=@"";
            
            
        }
        else{
            
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            
        }
    }
    
    }
    

}
-(void)textFieldDidBeginEditing:(UITextField *)textField

{
    
          emailTfld .layer.borderColor=[[UIColor clearColor]CGColor];
        emailTfld.layer.borderWidth= 1.0f;

    
    
   
    
    
    
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
        messageTv .layer.borderColor=[[UIColor clearColor]CGColor];
        messageTv.layer.borderWidth= 1.0f;
        
        
        
 

}
- (BOOL)textView:(UITextView *)textView
shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
    }
    return YES;
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
