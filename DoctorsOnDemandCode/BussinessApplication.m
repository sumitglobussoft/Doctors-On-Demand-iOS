//
//  BussinessApplication.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 12/17/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "BussinessApplication.h"

@interface BussinessApplication ()
{
    
        CGSize screenRect;
        NSArray *accountViewCells,*comment;
          UIScrollView *scroll;

    
     UIActivityIndicatorView *activityIndicator;
    UITextField *firstName,*lastName,*companyName,*noOFPeople,*compMail,*orgType;
    UITextView *info;
    UIToolbar *toolbar;
    NSArray *organisationType;
        
        
   
}
@end

@implementation BussinessApplication

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    screenRect=[[UIScreen mainScreen]bounds].size;
    
    
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    titleLable.text =@"Bussiness Requirements";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font =[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [headerView addSubview:titleLable];
    
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
   [backButton setFrame:CGRectMake(15, 18, 55, 35)];    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];

    
    
    
    
    [self createUi];

    // Do any additional setup after loading the view.
}


-(void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma  mark-Create UI

-(void)createUi{
    
    
    scroll = [[UIScrollView alloc] init];
    scroll.frame = CGRectMake(0, 55, screenRect.width, screenRect.height);
    
    //scroll.contentSize = CGSizeMake(screenRect.width, screenRect.height+50);
    scroll.backgroundColor = [UIColor clearColor];
    
    scroll.showsVerticalScrollIndicator = YES;
    
    
    
    scroll.scrollEnabled = YES;
    
    
    [self.view addSubview:scroll];
    

    
    
    
    UILabel *briefDescp=[[UILabel alloc]initWithFrame:CGRectMake(30, 10, screenRect.width-30, 50)];
    briefDescp.numberOfLines=2;
    briefDescp.text=@"Business Requirement Details";
    briefDescp.font= [UIFont fontWithName:@"GothamRounded-Medium" size:14];
    briefDescp.textColor=[UIColor blackColor];
    [scroll addSubview:briefDescp];
    
    
    
    
    firstName=[[UITextField alloc]initWithFrame:CGRectMake(10,70, screenRect.width-20, 40)];
    firstName.borderStyle=UITextBorderStyleRoundedRect;
    firstName.placeholder=@" First Name";
    firstName.font= [UIFont fontWithName:@"GothamRounded-Light" size:14];
    firstName.layer.cornerRadius=2;
    firstName.delegate=self;
    [scroll addSubview:firstName];
    
    
    
    lastName=[[UITextField alloc]initWithFrame:CGRectMake(10,120, screenRect.width-20, 40)];
    lastName.borderStyle=UITextBorderStyleRoundedRect;
    lastName.placeholder=@" Last Name";
    lastName.font= [UIFont fontWithName:@"GothamRounded-Light" size:14];
    lastName.layer.cornerRadius=2;
    lastName.delegate=self;
    [scroll addSubview:lastName];
    
    companyName=[[UITextField alloc]initWithFrame:CGRectMake(10,170, screenRect.width-20, 40)];
    companyName.borderStyle=UITextBorderStyleRoundedRect;
    companyName.placeholder=@"Company Name";
    companyName.font= [UIFont fontWithName:@"GothamRounded-Light" size:14];
    companyName.layer.cornerRadius=2;
    companyName.delegate=self;
    [scroll addSubview:companyName];
    

     
    
    noOFPeople=[[UITextField alloc]initWithFrame:CGRectMake(10,220, screenRect.width-20, 40)];
    noOFPeople.borderStyle=UITextBorderStyleRoundedRect;
    noOFPeople.placeholder=@"Number Of People";
    noOFPeople.font= [UIFont fontWithName:@"GothamRounded-Light" size:14];
    noOFPeople.layer.cornerRadius=2;
    noOFPeople.keyboardType=UIKeyboardTypeNumberPad;
    noOFPeople.delegate=self;
    [scroll addSubview:noOFPeople];
    

    compMail=[[UITextField alloc]initWithFrame:CGRectMake(10,270, screenRect.width-20, 40)];
    compMail.borderStyle=UITextBorderStyleRoundedRect;
    compMail.placeholder=@"Company Mail";
    compMail.font= [UIFont fontWithName:@"GothamRounded-Light" size:14];
    compMail.layer.cornerRadius=2;
    compMail.keyboardType=UIKeyboardTypeEmailAddress;
    compMail.delegate=self;
    [scroll addSubview:compMail];
    
    
    
    orgType=[[UITextField alloc]initWithFrame:CGRectMake(10,320, screenRect.width-20, 40)];
    orgType.borderStyle=UITextBorderStyleRoundedRect;
    orgType.placeholder=@"Organisation Type";
    orgType.font= [UIFont fontWithName:@"GothamRounded-Light" size:14];
    orgType.layer.cornerRadius=2;
    orgType.delegate=self;
    [scroll addSubview:orgType];
    toolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(100, 100, screenRect.width, 44)];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *done=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneActn)];
    [done setTintColor:[UIColor blueColor]];
    [toolbar setItems:[NSArray arrayWithObjects:spaceItem,done, nil]];
    [orgType setInputAccessoryView:toolbar];
   UIPickerView* dataPicker=[[UIPickerView alloc]init];
    orgType.inputView=dataPicker;
    dataPicker.delegate = self;
    dataPicker.dataSource = self;
    
    organisationType=[NSArray arrayWithObjects:@"Employeer",@"Health care Provider",@"Pharmacy",nil];
    

    
    
    
    
    UILabel *aboutLbl=[UILabel new];
    aboutLbl.frame=CGRectMake(10, 390, screenRect.width, 30);
    aboutLbl.textColor=[UIColor blackColor];
    aboutLbl.text=@"Required Info";
    aboutLbl.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];
    [scroll addSubview:aboutLbl];

    
    
    info=[[UITextView alloc]initWithFrame:CGRectMake(10, 420, screenRect.width-20, 100 )];
    info.delegate=self;
    [scroll addSubview:info];
    
    

    
    UIButton *saveBtn=[[UIButton alloc]initWithFrame:CGRectMake(10,555, screenRect.width-20, 40)];
    [saveBtn setTitle:@"Save" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn setBackgroundColor:[UIColor colorWithRed:(CGFloat)234/255 green:(CGFloat)30/255 blue:(CGFloat)99/255 alpha:(CGFloat)1.0]];
    saveBtn.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
    [saveBtn addTarget:self action:@selector(saveActn) forControlEvents:UIControlEventTouchUpInside];
    saveBtn.layer.cornerRadius=10.0f;
    [scroll addSubview:saveBtn];
    

    
    float sizeOfContent = 0;
    UIView *lLast = [scroll.subviews lastObject];
    NSInteger wd = lLast.frame.origin.y;
    NSInteger ht = lLast.frame.size.height;
    NSInteger offset=110;
    sizeOfContent = wd+ht;
    scroll.contentSize=CGSizeMake(screenRect.width,sizeOfContent+offset+10);
    

    
    
    
}


-(void)doneActn{
    
    [orgType resignFirstResponder];
}

#pragma mark-Picker view Delegates
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView1 numberOfRowsInComponent:(NSInteger)component {
    
            return organisationType.count  ;
    
}
-(NSString *)pickerView:(UIPickerView *)pickerView1 titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    
    
   
        return [organisationType objectAtIndex:row];
        
    
    
    
    
}
-(void)pickerView:(UIPickerView *)pickerView1 didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
            orgType.text=[organisationType objectAtIndex:row];
   
    
}


#pragma mark-Text Field Delegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    [textField resignFirstResponder];
    return  YES;
}

#pragma mark-Text View Delelgates
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

-(void)textFieldDidBeginEditing:(UITextField *)textField

{
    
    if(textField==firstName){
        firstName.layer.borderColor=[[UIColor clearColor]CGColor];
        firstName.layer.borderWidth= 1.0f;
        
    }
    else if(textField==lastName){
        lastName .layer.borderColor=[[UIColor clearColor]CGColor];
        lastName.layer.borderWidth= 1.0f;
       
    }else if(textField==companyName){
        companyName .layer.borderColor=[[UIColor clearColor]CGColor];
        companyName.layer.borderWidth= 1.0f;
       
    }
    else if(textField==noOFPeople){
        noOFPeople .layer.borderColor=[[UIColor clearColor]CGColor];
        noOFPeople.layer.borderWidth= 1.0f;
        
    }
    else if(textField==compMail){
        compMail .layer.borderColor=[[UIColor clearColor]CGColor];
        compMail.layer.borderWidth= 1.0f;
        
    }
    else if(textField==orgType){
        orgType .layer.borderColor=[[UIColor clearColor]CGColor];
        orgType.layer.borderWidth= 1.0f;
        
    }
            }

#pragma mark-Save action
-(void)saveActn{
    
    
    [firstName resignFirstResponder];
      [lastName resignFirstResponder];
      [companyName resignFirstResponder];
      [noOFPeople resignFirstResponder];
      [compMail resignFirstResponder];
      [orgType resignFirstResponder];
    [info resignFirstResponder];
    
    
    if([firstName.text isEqual: @""]){
        
        firstName.layer.borderColor=[[UIColor redColor]CGColor];
        firstName.layer.borderWidth= 1.0f;
    }
    else if ([lastName.text isEqual:@""]){
        lastName.layer.borderColor=[[UIColor redColor]CGColor];
        lastName.layer.borderWidth= 1.0f;
        
    }
    else if ([companyName.text isEqual:@""])
    {
        companyName.layer.borderColor=[[UIColor redColor]CGColor];
        companyName.layer.borderWidth= 1.0f;
        
    }
    else if ([noOFPeople.text isEqual:@""])
    {
        noOFPeople.layer.borderColor=[[UIColor redColor]CGColor];
        noOFPeople.layer.borderWidth= 1.0f;
    }
    else if ([compMail.text isEqual:@""]){
        
        compMail.layer.borderColor=[[UIColor redColor]CGColor];
        compMail.layer.borderWidth= 1.0f;
    }
    else if ([orgType.text isEqual:@""]){
        
    orgType.layer.borderColor=[[UIColor redColor]CGColor];
    orgType.layer.borderWidth= 1.0f;
    }
    else if ([info.text isEqual:@""]){
        
    info.layer.borderColor=[[UIColor redColor]CGColor];
    info.layer.borderWidth= 1.0f;
   
    }
    else{
    
    [self activityAction];
    dispatch_async(dispatch_get_global_queue(0, 0),^{
        
        dispatch_async(dispatch_get_main_queue(),^{
            
            
            NSError *error;
            NSURLResponse * urlResponse;
            
            NSString * urlStr =[NSString stringWithFormat:businessService];
            NSURL * url =[NSURL URLWithString:urlStr];
            
            NSMutableURLRequest  * request =[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
            
            NSString *organisation;
   
            if([orgType.text isEqual:@"Employeer"]){
             
                organisation=@"0";
            }
            else if ([orgType.text isEqual:@"Health care Provider"]){
                
                organisation=@"1";
            }
            else if ([orgType.text  isEqual:@"Pharmacy"])
            {
                  organisation=@"2";
            }
            
            
           
            NSString * body =[NSString stringWithFormat:@"userFName=%@&userLName=%@&CompanyName=%@&peopleCount=%@&companyMail=%@&orgType=%@&requiredinfo=%@&userid=%@",firstName.text,lastName.text,companyName.text,noOFPeople.text,compMail.text,organisation,info.text,[[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"]];
            
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
            
            NSLog(@"Pztient update---->%@",jsonResponse);
            
            if ([[jsonResponse objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
                
                
                
                firstName.text=@"";
                lastName.text=@"";
                info.text=@"";
                companyName.text=@"";
                compMail.text=@"";
                orgType.text=@"";
                noOFPeople.text=@"";
                
                UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"Message"
                                                              message:[jsonResponse objectForKey:@"message"] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                
                [alert show];
                
                
            }
            else{
                UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"Message"
                                                              message:@"Update Unsuccessful" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                
                [alert show];
            }
            
            
            
        });
        
    });
    }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


-(void)textViewDidBeginEditing:(UITextView *)textView
{
    info .layer.borderColor=[[UIColor clearColor]CGColor];
    info.layer.borderWidth= 1.0f;

    [self animateTextField:textView up:YES];
    
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    
    [self animateTextField:textView up:NO];
}

-(void)animateTextField:(UITextView*)textView up:(BOOL)up
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
