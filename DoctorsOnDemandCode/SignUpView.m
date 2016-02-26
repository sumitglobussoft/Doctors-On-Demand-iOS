//
//  SignUpView.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 8/7/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//


#import "SignUpView.h"
#import "SVProgressHUD.h"
#import "ConnectionManager.h"


@interface SignUpView (){
    CGSize screenRect;
    
    UIDatePicker *pickerView ;
    NSDateFormatter *dateFormatter;
    UIButton *createAccount, *checkBoxUnmarked;
    int firsttime;
    UIView *passwordValid;
    UILabel *label;
    UIButton * signIn;
    UITextField *dob;
    UIToolbar *toolbar;
    QBUUser *user;
    UIScrollView *myScroll;
        UIView *backPopUp,*letsGetStartedPopUp;
}

@end

@implementation SignUpView

-(void)hideSignIn{
    
    signIn.hidden=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideSignIn) name:@"hideSignIn" object:nil];
    
    firsttime=0;
    
    
    screenRect = [[UIScreen mainScreen] bounds].size;
    [super viewDidLoad];
    self.title=@"Create Account";
    
    
    
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    titleLable.text =@"Create Account";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font = [UIFont fontWithName:@"GothamRounded-Light" size:14];
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
  [backButton setFrame:CGRectMake(15, 18, 55, 35)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        headerView.frame= CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80);
        titleLable.frame= CGRectMake(60, 25, screenRect.width-120, 35);
        titleLable.font=[UIFont fontWithName:@"GothamRounded-Light" size:30];
        [backButton setImage:[UIImage imageNamed:@"back_btn_ipad.png"] forState:UIControlStateNormal];
        [backButton setFrame:CGRectMake(15, 30, 80, 25)];
    }
    
//     signIn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    signIn.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-60, 25,50,25);
//    signIn.backgroundColor =[UIColor clearColor];
//    [signIn setTitleColor:[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)30/255 blue:(CGFloat)49/255 alpha:(CGFloat)1] forState:UIControlStateNormal];
//    signIn.titleLabel.font =[UIFont systemFontOfSize:12];
//    [signIn setTitle:@"Sign In" forState:UIControlStateNormal];
//    [signIn addTarget:self action:@selector(signIn) forControlEvents:UIControlEventTouchUpInside];
//    [headerView addSubview:signIn];

    [self createUi];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma  mark-SignUp to Quick blox

-(void)quickBloxSignUp{
    
   
   
    

    
        
}
#pragma  mark- create ui
-(void)createUi{
    
    
    
    myScroll = [[UIScrollView alloc] init];
    myScroll.frame = CGRectMake(0, 55, screenRect.width, screenRect.height);
    
       myScroll.backgroundColor = [UIColor clearColor];
    
    myScroll.showsVerticalScrollIndicator = NO;    // to hide scroll indicators!
    
    [self.view addSubview:myScroll];
    
    
    UIImageView *logoView = [[UIImageView alloc] init];
    logoView.frame=CGRectMake(40, 20,260, 44);
    
    logoView.image=[UIImage imageNamed:@"logo.png"];
   // [logoView setContentMode:UIViewContentModeScaleAspectFit];
    
    //[logoView sizeToFit];
    
    [myScroll addSubview:logoView];
    
    
    
    
    nameTxt=[[UITextField alloc]init];
    nameTxt.frame=CGRectMake(10, 100,screenRect.width-20 , 50);
    nameTxt.font = [UIFont fontWithName:@"GothamRounded-Light" size:14];
    nameTxt.borderStyle=UITextBorderStyleRoundedRect;
    nameTxt.backgroundColor=[UIColor whiteColor];
    nameTxt.placeholder=@" Enter Name";
    
    nameTxt.delegate = self;
    [myScroll addSubview:nameTxt];
    
    
    
    
    
    
    email=[[UITextField alloc]init];
    email.frame=CGRectMake(10, 160,screenRect.width-20 , 50);
    email.borderStyle=UITextBorderStyleRoundedRect;
    email.backgroundColor=[UIColor whiteColor];
    email.placeholder=@" Email Address";
    email.font = [UIFont fontWithName:@"GothamRounded-Light" size:14];

    [myScroll addSubview:email];
    email.delegate =self;
    [email resignFirstResponder];
    
    
    //    dateOfBirth=[[UITextField alloc]initWithFrame:CGRectMake(10, 235,
    password=[[UITextField alloc]init];
    password.frame=CGRectMake(10, 220,screenRect.width-20 , 50);
    password.borderStyle=UITextBorderStyleRoundedRect;
    password.backgroundColor=[UIColor whiteColor];
    password.placeholder=@" Password";
    password.secureTextEntry=YES;
    password.font = [UIFont fontWithName:@"GothamRounded-Light" size:14];

    password.delegate = self;
    //    password.tag=1;
    [myScroll addSubview:password];
    
    
    passwordValid=[[UIView alloc]init];
    passwordValid.frame=CGRectMake(10, 330, screenRect.width-20 , 50);
    passwordValid.backgroundColor=[UIColor clearColor];
    [myScroll addSubview:passwordValid];
    
    UILabel *validation=[[UILabel alloc]init];
    validation.frame=CGRectMake(10, 15, 150, 10);
     validation.font=[UIFont fontWithName:@"GothamRounded-Medium" size:10];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
         validation.frame=CGRectMake(10, 15,[UIScreen mainScreen].bounds.size.width, 20);
         validation.font=[UIFont fontWithName:@"GothamRounded-Medium" size:15];
    }
    

    //validation.backgroundColor=[UIColor lightGrayColor];
    validation.text=@"8 or more characters";
    validation.textColor=[UIColor blackColor];
     [passwordValid addSubview:validation];
    
    
    validation=[[UILabel alloc]init];
    validation.frame=CGRectMake(180, 15, 150, 10);
       validation.font=[UIFont fontWithName:@"GothamRounded-Medium" size:10];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        validation.frame=CGRectMake(320, 15, [UIScreen mainScreen].bounds.size.width, 20);
        validation.font=[UIFont fontWithName:@"GothamRounded-Medium" size:15];
    }
    

    //validation.backgroundColor=[UIColor lightGrayColor];
    validation.text=@"At least 1 number";
    validation.textColor=[UIColor blackColor];
  
    [passwordValid addSubview:validation];
    
    
    validation=[[UILabel alloc]init];
    validation.frame=CGRectMake(10, 35, 150, 10);
      validation.font=[UIFont fontWithName:@"GothamRounded-Medium" size:10];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        validation.frame=CGRectMake(10, 45,[UIScreen mainScreen].bounds.size.width, 20);
         validation.font=[UIFont fontWithName:@"GothamRounded-Medium" size:15];
        
    }

  //  validation.backgroundColor=[UIColor lightGrayColor];
    validation.text=@"Upper and lower case letters";
    validation.textColor=[UIColor blackColor];
 
    [passwordValid addSubview:validation];
    
    passwordValid.hidden=YES;
    
    
    
    
    dob=[[UITextField alloc]init];
    
    dob.frame=CGRectMake(10,280, screenRect.width-20, 50);
    dob.borderStyle=UITextBorderStyleRoundedRect;
    dob.placeholder=@" Date Of Birth";
    
    
    dob.font= [UIFont fontWithName:@"GothamRounded-Light" size:14];
    
    dob.layer.cornerRadius=2;
    dob.delegate=self;
    [myScroll addSubview:dob];
    
    pickerView = [[UIDatePicker alloc] init];
    pickerView.datePickerMode = UIDatePickerModeDate;
    [dob setInputView:pickerView];
    toolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(100, 100, screenRect.width, 44)];
    UIBarButtonItem *done4=[[UIBarButtonItem alloc]initWithTitle:@"DONE" style:UIBarButtonItemStyleDone target:self action:@selector(showDatePicker)];
    [toolbar setItems:[NSArray arrayWithObjects:done4, nil]];
    [dob setInputAccessoryView:toolbar];
    
    
    
    
    UIView * separator = [[UIView alloc] init];
    separator.frame=CGRectMake(0,400, [UIScreen mainScreen].bounds.size.width, 1);
    separator.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
    [myScroll addSubview:separator];
    
    
    UILabel *iAgree=[[UILabel alloc]init];
    iAgree.frame=CGRectMake(0, 410, screenRect.width, 30);
    iAgree.text=@"I agree to Ready Doctors's\nTerms of Use & Informed Consent";
   [iAgree setFont:[UIFont fontWithName:@"GothamRounded-Medium" size:13]];
    //iAgree.font=[UIFont systemFontOfSize:13];
    iAgree.textAlignment=NSTextAlignmentCenter;
    iAgree.numberOfLines=2;
    iAgree.textColor=[UIColor redColor];
    iAgree.shadowColor=[UIColor clearColor];
    [myScroll addSubview:iAgree];
 
    createAccount=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    createAccount.frame=CGRectMake(10, 460,myScroll.frame.size.width-20,60);
    createAccount.backgroundColor=[UIColor clearColor];
    [createAccount setBackgroundImage:[UIImage imageNamed:@"signup_btn.png"] forState:UIControlStateNormal];
    createAccount.alpha=0.1;
    createAccount.enabled=NO;
    [createAccount addTarget:self action:@selector(createAccountAction) forControlEvents:UIControlEventTouchUpInside];
    [myScroll addSubview:createAccount];
    
    
    
    checkBoxUnmarked=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    checkBoxUnmarked.frame=CGRectMake(10, 410, 35, 33);
    checkBoxUnmarked.backgroundColor=[UIColor clearColor];
    [checkBoxUnmarked setBackgroundImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
    
    [checkBoxUnmarked addTarget:self action:@selector(checkboxFunctionality:) forControlEvents:UIControlEventTouchUpInside];
    [myScroll addSubview:checkBoxUnmarked];
    
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        
        logoView.frame=CGRectMake([UIScreen mainScreen].bounds.size.width/4-70,50,500, 80);
        
        logoView.image=[UIImage imageNamed:@"logoIPad.png"];
        
        nameTxt.frame=CGRectMake(10, 140,screenRect.width-20 ,80);
        nameTxt.font = [UIFont fontWithName:@"GothamRounded-Light" size:25];
        
        email.frame=CGRectMake(10, 230,screenRect.width-20 ,80);
        email.font = [UIFont fontWithName:@"GothamRounded-Light" size:25];
        
        password.frame=CGRectMake(10, 330,screenRect.width-20 ,80);
        password.font = [UIFont fontWithName:@"GothamRounded-Light" size:25];
     
        
        passwordValid.frame=CGRectMake(10, 440,screenRect.width-20 ,80);
        
        
         dob.frame=CGRectMake(10,420, screenRect.width-20, 80);
        dob.font= [UIFont fontWithName:@"GothamRounded-Light" size:25];
        
          separator.frame=CGRectMake(0,580, [UIScreen mainScreen].bounds.size.width, 1);
        iAgree.frame=CGRectMake(0, 590, screenRect.width, 80);
        [iAgree setFont:[UIFont fontWithName:@"GothamRounded-Medium" size:23]];
        [createAccount setBackgroundImage:[UIImage imageNamed:@"signupIPad.png"] forState:UIControlStateNormal];
           checkBoxUnmarked.frame=CGRectMake(10, 590, 50, 50);
        createAccount.frame=CGRectMake(10, 660,myScroll.frame.size.width-20,100);

        
    }
    

    
    float sizeOfContent = 0;
    UIView *lLast = [myScroll.subviews lastObject];
    NSInteger wd = lLast.frame.origin.y;
    NSInteger ht = lLast.frame.size.height;
    NSInteger offset=150;
    sizeOfContent = wd+ht;
    myScroll.contentSize=CGSizeMake(screenRect.width,sizeOfContent+offset);
    
    
    
    
    
    
    
}




-(void)dismissPicker{
    
    [dateOfBirth resignFirstResponder];
}


-(void)checkboxFunctionality:(id)sender{
    if(firsttime==0){
        firsttime=1;
        
        createAccount.enabled=YES;
        [checkBoxUnmarked setBackgroundImage:[UIImage imageNamed:@"checkbox - checked.png"] forState:UIControlStateNormal];

        createAccount.alpha=1;
    }
    else if(firsttime==1){
        [checkBoxUnmarked setBackgroundImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];

        firsttime=0;
        createAccount.enabled=NO;
        createAccount.alpha=0.1;
        
    }
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)dob{
    dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MMM dd,YYYY"];
    
    // [dateFormatter setDateFormat:@"HH:mm"];
    dateOfBirth.text=[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:pickerView.date]];
    [dateOfBirth resignFirstResponder];
}


#pragma mark- sign up action

-(void)createAccountAction{
    
    [nameTxt resignFirstResponder];
    [password resignFirstResponder];
    [email resignFirstResponder];
    
    
  
    
    
    NSRange rang = [password.text rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]];
    NSRange lower=[password.text rangeOfCharacterFromSet:[NSCharacterSet lowercaseLetterCharacterSet]];
    NSRange upper=[password.text rangeOfCharacterFromSet:[NSCharacterSet uppercaseLetterCharacterSet]];
    
    

    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
   
    label=[[UILabel alloc]init];
    label.text=@"";
    
    
    
    
    if(([nameTxt.text isEqual:@""])){
        
        
        nameTxt.layer.borderColor=[[UIColor redColor]CGColor];
        nameTxt.layer.borderWidth= 1.0f;
        label.frame=CGRectMake(0, nameTxt.frame.size.height-20, nameTxt.frame.size.width, 20);
        label.textAlignment=NSTextAlignmentCenter;
        label.text=@"You must enter a name";
        label.font=[UIFont systemFontOfSize:12];
        label.textColor=[UIColor redColor];
        [nameTxt addSubview:label];
        
        
    }
          else if(([email.text isEqual:@""]))
        
    {
        email.layer.borderColor=[[UIColor redColor]CGColor];
        email.layer.borderWidth= 1.0f;
        label.frame=CGRectMake(0, nameTxt.frame.size.height-20, nameTxt.frame.size.width, 20);
        label.textAlignment=NSTextAlignmentCenter;
        label.font=[UIFont systemFontOfSize:12];
        label.textColor=[UIColor redColor];
        
        label.text=@"You must enter a valid email address";
        [email addSubview:label];
    }
          else  if([emailTest evaluateWithObject:email.text] == NO){
              NSLog(@"%@",email.text);
              email.layer.borderColor=[[UIColor redColor]CGColor];
              email.layer.borderWidth= 1.0f;
              
              
              label.frame=CGRectMake(0, nameTxt.frame.size.height-20, nameTxt.frame.size.width, 20);
              label.textAlignment=NSTextAlignmentCenter;
              label.text=@"You must enter a valid email address";
              label.font=[UIFont systemFontOfSize:12];
              label.textColor=[UIColor redColor];
              
              
              [email addSubview:label];
              
              
              
              
          }

    else if (([password.text isEqual:@""])||[password.text length]<8)
    {
        password.layer.borderColor=[[UIColor redColor]CGColor];
        password.layer.borderWidth= 1.0f;
        label.frame=CGRectMake(0,nameTxt.frame.size.height-20, nameTxt.frame.size.width, 20);
        label.textAlignment=NSTextAlignmentCenter;
        label.font=[UIFont systemFontOfSize:12];
        label.textColor=[UIColor redColor];
        
        label.text=@"must be at least 8 characters";
        [password addSubview:label];
    }
    else if ( rang.length==0 ){
        password.layer.borderColor=[[UIColor redColor]CGColor];
        password.layer.borderWidth= 1.0f;
        label.frame=CGRectMake(0, nameTxt.frame.size.height-20, nameTxt.frame.size.width, 20);
        label.textAlignment=NSTextAlignmentCenter;
        label.font=[UIFont systemFontOfSize:12];
        label.textColor=[UIColor redColor];
        
        label.text=@"must contain at least one digit";
        [password addSubview:label];
        
        
        
    }
    else if ( lower.length==0 ){
        password.layer.borderColor=[[UIColor redColor]CGColor];
        password.layer.borderWidth= 1.0f;
        label.frame=CGRectMake(0, nameTxt.frame.size.height-20, nameTxt.frame.size.width, 20);
        label.textAlignment=NSTextAlignmentCenter;
        label.font=[UIFont systemFontOfSize:12];
        label.textColor=[UIColor redColor];
        
        label.text=@"must contain at least one lowercase character";
        [password addSubview:label];
        
        
        
    }
    
    else if ( upper.length==0 ){
        password.layer.borderColor=[[UIColor redColor]CGColor];
        password.layer.borderWidth= 1.0f;
        label.frame=CGRectMake(0, nameTxt.frame.size.height-20, nameTxt.frame.size.width, 20);
        label.textAlignment=NSTextAlignmentCenter;
        label.font=[UIFont systemFontOfSize:12];
        label.textColor=[UIColor redColor];
        
        label.text=@"must contain at least one uppercase character";
        [password addSubview:label];
        
        
        
    }
    
    else{
        
          if([SingletonClass networkcheck]==YES){
              
              
              [[NSUserDefaults standardUserDefaults]setObject:nameTxt.text forKey:@"SignUpname"];
              [[NSUserDefaults standardUserDefaults]synchronize];
              
              
              
              [[NSUserDefaults standardUserDefaults]setObject:email.text forKey:@"SignUpemail"];
              [[NSUserDefaults standardUserDefaults]synchronize];
              
              [[NSUserDefaults standardUserDefaults]setObject:password.text forKey:@"SignUppassword"];
              [[NSUserDefaults standardUserDefaults]synchronize];
              

              
              [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0.984 green:0.000 blue:0.498 alpha:1.000]];
              [SVProgressHUD showWithStatus:NSLocalizedString(@"Loading...", nil)];
              
  
              
              
              ConnectionManager *connection=[[ConnectionManager alloc]init];
              
              user = [QBUUser user];
              user.login = email.text;
              
              user.password = @"12345678";
              
              user.email=email.text;
              user.fullName=nameTxt.text;
              
              //[self logInChatWithUser:user];
              
              [connection signUp:user];
              
              
              

                  }
        else
            [self networkWarning ];
    }
    
    
       
    

    
}


#pragma mark-Sign Up

-(void)signUp{
    
    NSTimeZone * timeZone =[NSTimeZone localTimeZone];
    NSString * timezoneStr =[timeZone name];
    
    NSError * error ;
    NSURLResponse * urlResponse;
    
    NSURL * postUrl =[NSURL URLWithString:signUpservice];
    
    
    NSLog(@"emil===%@",email.text);
    
    NSString * body =[NSString stringWithFormat:@"name=%@&email=%@&role=1&password=%@&timeZone=%@&qId=%@&dateofbirth=%@&owner_id=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"SignUpname" ],[[NSUserDefaults standardUserDefaults]objectForKey:@"SignUpemail" ],[[NSUserDefaults standardUserDefaults]objectForKey:@"SignUppassword"],timezoneStr,[[NSUserDefaults standardUserDefaults] objectForKey:@"QuickBloxID"],dob.text,[[NSUserDefaults standardUserDefaults]objectForKey:@"QBOwnerID"]];
    
    NSMutableURLRequest * request =[[NSMutableURLRequest alloc]initWithURL:postUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
    
    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (!data) {
        [SVProgressHUD dismiss];
        
        return;
    }
    
    id json =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    [SVProgressHUD dismiss];
    NSLog(@"json %@",json);
    
    
   
    
    
    
    
    
    if ([[json objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
      
        nameTxt.text =@"";
        email.text =@"";
        password.text =@"";
        dateOfBirth.text =@"";
        
        
        
        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"SignUpname"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        
        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"SignUpemail"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"SignUppassword"];
        [[NSUserDefaults standardUserDefaults]synchronize];

        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"SignUp Successfull" message:@"Check your mail for confirmation mail" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    else{
       
      //Deleting User from Quick blox If signUp not successful
        
        NSLog(@"Email %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"SignUpemail"]);
        
        [QBRequest logInWithUserLogin:[[NSUserDefaults standardUserDefaults] objectForKey:@"SignUpemail"] password:@"12345678" successBlock:^(QBResponse *response, QBUUser *user1) {
            
            NSLog(@"login %@",response);
            
            
            
            
            [QBRequest deleteUserWithID:user1.ID successBlock:^(QBResponse *response) {
                
                
                NSLog(@"Successfully deleted from QuickBlox Server %@",response);
                
                
                
            } errorBlock:^(QBResponse *response) {
                NSLog(@"Error While detetion %@",response.error);
            }];
            
            
            
            
        } errorBlock:^(QBResponse *response) {
            
            NSLog(@"Failed to login %@",[response error]);
            
            // Handle error
        }];
        
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error!!" message:@"Unsuccessfull, Email already exists" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        
    }

}

#pragma mark-Date Picker Action
-(void)showDatePicker{
    
    
    NSDateFormatter *form=[[NSDateFormatter alloc]init];
    [form setDateFormat:@"YYYY-MM-dd"];
    dob.text=[NSString stringWithFormat:@"%@",[form stringFromDate:pickerView.date]];
    [dob resignFirstResponder];
    
    
}




#pragma mark - textFiled Delegate methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    if(textField==password) {
        passwordValid.hidden=YES;
    }
    [textField resignFirstResponder];
    return  YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField

{
    
    if(textField==nameTxt){
        passwordValid.hidden=YES;
        nameTxt.layer.borderColor=[[UIColor clearColor]CGColor];
        nameTxt.layer.borderWidth= 1.0f;
        [label removeFromSuperview];
    }
    else if(textField==email){
        [self animateTextField:textField up:YES];
        passwordValid.hidden=YES;
        email .layer.borderColor=[[UIColor clearColor]CGColor];
        email.layer.borderWidth= 1.0f;
        [label removeFromSuperview];
    }else if(textField==password){
        [self animateTextField:textField up:YES];
 passwordValid.hidden=NO;
        password .layer.borderColor=[[UIColor clearColor]CGColor];
        password.layer.borderWidth= 1.0f;
        [label removeFromSuperview];
    }
    else if (textField==dob){
        passwordValid.hidden=YES;
        
    }

    
    
//    if(textField==password||textField==email){
//       
//        
//        
//        password .layer.borderColor=[[UIColor clearColor]CGColor];
//        password.layer.borderWidth= 1.0f;
//        [label removeFromSuperview];
//        
//    }
//    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField==password||textField==email){
        [self animateTextField:textField up:NO];
    }
    
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

#pragma mark-Sign in action
-(void)signIn
{
    
    // [self callUserForVideoChat];
    SignInView *signInView=[[SignInView alloc]init];
    
    [self.navigationController pushViewController:signInView animated:YES];
    
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
