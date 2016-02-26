//
//  UpdatePasswordVC.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 12/14/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "UpdatePasswordVC.h"

@interface UpdatePasswordVC ()

{
    CGSize screenRect;
    
    UIActivityIndicatorView *activityIndicator;
    UITextField * oldPassTxtFld,*newPassTxtFld;
}

@end

@implementation UpdatePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    screenRect = [[UIScreen mainScreen] bounds].size;
    
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    titleLable.text =@"UPDATE PASSWORD";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font =[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
 [backButton setFrame:CGRectMake(15, 18, 55, 35)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
    [self createUi];
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
  
    // Dispose of any resources that can be recreated.
}

#pragma mark-Create UI
-(void)createUi{
    oldPassTxtFld=[[UITextField alloc]initWithFrame:CGRectMake(10,70, screenRect.width-20, 40)];
    oldPassTxtFld.borderStyle=UITextBorderStyleRoundedRect;
    oldPassTxtFld.placeholder=@" Old Password";
    oldPassTxtFld.secureTextEntry=YES;
    
    
    
    
    oldPassTxtFld.font= [UIFont fontWithName:@"GothamRounded-Light" size:14];
    oldPassTxtFld.layer.cornerRadius=2;
    oldPassTxtFld.delegate=self;
    [self.view addSubview:oldPassTxtFld];
    
    newPassTxtFld=[[UITextField alloc]initWithFrame:CGRectMake(10,120, screenRect.width-20, 40)];
    newPassTxtFld.borderStyle=UITextBorderStyleRoundedRect;
    newPassTxtFld.placeholder=@" New Password";
    newPassTxtFld.font= [UIFont fontWithName:@"GothamRounded-Light" size:14];
    newPassTxtFld.layer.cornerRadius=2;
    newPassTxtFld.secureTextEntry=YES;
    newPassTxtFld.delegate=self;
    [self.view addSubview:newPassTxtFld];
    
    
    UIButton *saveBtn=[[UIButton alloc]initWithFrame:CGRectMake(10,170, screenRect.width-20, 40)];
    [saveBtn setTitle:@"Save" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn setBackgroundColor:[UIColor colorWithRed:(CGFloat)234/255 green:(CGFloat)30/255 blue:(CGFloat)99/255 alpha:(CGFloat)1.0]];
    saveBtn.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
    [saveBtn addTarget:self action:@selector(savePassword) forControlEvents:UIControlEventTouchUpInside];
    saveBtn.layer.cornerRadius=10.0f;
    [self.view addSubview:saveBtn];
    

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    [textField resignFirstResponder];
    return  YES;
}

#pragma mark-Back Action
-(void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
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

-(void)savePassword{
    
    [newPassTxtFld resignFirstResponder];
    [oldPassTxtFld resignFirstResponder];
    
    
    
    
    NSRange rang = [newPassTxtFld.text rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]];
    NSRange lower=[newPassTxtFld.text rangeOfCharacterFromSet:[NSCharacterSet lowercaseLetterCharacterSet]];
    NSRange upper=[newPassTxtFld.text rangeOfCharacterFromSet:[NSCharacterSet uppercaseLetterCharacterSet]];
    

    if([oldPassTxtFld.text isEqual:@""]){
        oldPassTxtFld.layer.borderColor=[[UIColor redColor]CGColor];
        oldPassTxtFld.layer.borderWidth= 1.0f;
        
            }
        else if([newPassTxtFld.text isEqual:@""]){
        newPassTxtFld.layer.borderColor=[[UIColor redColor]CGColor];
        newPassTxtFld.layer.borderWidth= 1.0f;
            }
    
    
        else if ( rang.length==0 ){
            newPassTxtFld.layer.borderColor=[[UIColor redColor]CGColor];
            newPassTxtFld.layer.borderWidth= 1.0f;
            
         
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Password must contain at least one digit" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
           
            
            
            
        }
        else if ( lower.length==0 ){
            newPassTxtFld.layer.borderColor=[[UIColor redColor]CGColor];
            newPassTxtFld.layer.borderWidth= 1.0f;
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Password must contain at least one lowercase character" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            
            
            
            
        }
    
        else if ( upper.length==0 ){
            newPassTxtFld.layer.borderColor=[[UIColor redColor]CGColor];
            newPassTxtFld.layer.borderWidth= 1.0f;
                 
           
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Password must contain at least one uppercase character" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            
        }
    

    
    else{
        
        
        [self activityAction];
        dispatch_async(dispatch_get_global_queue(0, 0),^{
            
            dispatch_async(dispatch_get_main_queue(),^{
                
                
                NSError *error;
                NSURLResponse * urlResponse;
                
                NSString * urlStr =[NSString stringWithFormat:updatePassword];
                NSURL * url =[NSURL URLWithString:urlStr];
                
                NSMutableURLRequest  * request =[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
  
                NSString * body =[NSString stringWithFormat:@"patientId=%@&oldPassword=%@&newPassword=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"],oldPassTxtFld.text,newPassTxtFld.text];
                
                [request setHTTPMethod:@"POST"];
                [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
                [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
                
                
                NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
                if (!data) {
                    
                    NSLog(@"%@",error);
                    [activityIndicator stopAnimating];
                    return;
                }
                id jsonResponse =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                
                
                [activityIndicator stopAnimating];
                
                
                NSString *msg=[jsonResponse objectForKey:@"message"];
                
                if ([[jsonResponse objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
                    
                    UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"Message"
                                                                  message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                    
                    [alert show];
                    
                    
                    newPassTxtFld.text=@"";
                    
                    
                }
                else{
                    UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"Message"
                                                                  message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                    
                    [alert show];
                }
                
                
                
            });
            
        });
        
    }
    

}

-(void)textFieldDidBeginEditing:(UITextField *)textField

{
    
    if(textField==oldPassTxtFld){
        
        oldPassTxtFld.layer.borderColor=[[UIColor clearColor]CGColor];
        oldPassTxtFld.layer.borderWidth= 1.0f;
       // oldPassTxtFld.placeholder=@" Email Address";
        //  [label removeFromSuperview];
        
    }
    else if(textField==newPassTxtFld){
       // [self animateTextField:textField up:YES];
        newPassTxtFld .layer.borderColor=[[UIColor clearColor]CGColor];
        newPassTxtFld.layer.borderWidth= 1.0f;
       // newPassTxtFld.placeholder=@" Password";
        // [label removeFromSuperview];
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
