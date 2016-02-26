//
//  UpdtNameAddressVC.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 9/14/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "UpdtNameAddressVC.h"

@interface UpdtNameAddressVC (){
    CGSize screenRect;
    UIScrollView *scroll;
    NSArray *bloodGrpAr,*gender;
    UITextField *bloodGrp,*dob,*genderTxtFld,*firstnameTextFld,*lastnameTextFld,*weight,*height,*address;
    UIPickerView *dataPicker1,*dataPicker;
    UIToolbar *toolbar;
    UIDatePicker *pickerView;
    UITextView *about;
    UIActivityIndicatorView *activityIndicator;
    NSMutableDictionary *profileDetails;
}


@end

@implementation UpdtNameAddressVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    profileDetails=[[NSMutableDictionary alloc]init];
    [self activityAction];
    dispatch_async(dispatch_get_global_queue(0, 0),^{
        
        [self fetchProfile];
        dispatch_async(dispatch_get_main_queue(),^{
            
            [self createUi];
            [activityIndicator stopAnimating];
        });
        
    });
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:(BOOL)animated];    // Call the super class implementation.
    profileDetails=nil;
    [scroll removeFromSuperview];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    screenRect = [[UIScreen mainScreen] bounds].size;
    
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    titleLable.text =@"UPDATE INFORMATION";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font =[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
    [backButton setFrame:CGRectMake(15, 18, 55, 35)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
    
    
    

    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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
    briefDescp.text=@"Please update our name and\naddress";
     briefDescp.font= [UIFont fontWithName:@"GothamRounded-Medium" size:14];
  
    briefDescp.textColor=[UIColor blackColor];
    
    [scroll addSubview:briefDescp];
    
   firstnameTextFld=[[UITextField alloc]initWithFrame:CGRectMake(10,70, screenRect.width-20, 40)];
    firstnameTextFld.borderStyle=UITextBorderStyleRoundedRect;
    firstnameTextFld.placeholder=@" First Name";
   
    if(!([[profileDetails objectForKey:@"patientFirstName"] isEqual:[NSNull null]]||[[profileDetails objectForKey:@"patientFirstName"] isEqual:@""]))
        firstnameTextFld.text=[profileDetails objectForKey:@"patientFirstName"];
    
    firstnameTextFld.font= [UIFont fontWithName:@"GothamRounded-Light" size:14];
    firstnameTextFld.layer.cornerRadius=2;
    firstnameTextFld.delegate=self;
    [scroll addSubview:firstnameTextFld];
    
    
    
   lastnameTextFld=[[UITextField alloc]initWithFrame:CGRectMake(10,120, screenRect.width-20, 40)];
    lastnameTextFld.borderStyle=UITextBorderStyleRoundedRect;
    lastnameTextFld.placeholder=@" Last Name";
    
    if(!([[profileDetails objectForKey:@"patientLastName"] isEqual:[NSNull null]]||[[profileDetails objectForKey:@"patientLastName"] isEqual:@""]))
        lastnameTextFld.text=[profileDetails objectForKey:@"patientLastName"];
    
    lastnameTextFld.font= [UIFont fontWithName:@"GothamRounded-Light" size:14];

    lastnameTextFld.layer.cornerRadius=2;
    lastnameTextFld.delegate=self;
    [scroll addSubview:lastnameTextFld];
    
   address=[[UITextField alloc]initWithFrame:CGRectMake(10,170, screenRect.width-20, 40)];
    address.borderStyle=UITextBorderStyleRoundedRect;
    address.placeholder=@"Address";
    
    if(!([[profileDetails objectForKey:@"patientAddress"] isEqual:[NSNull null]]||[[profileDetails objectForKey:@"patientAddress"] isEqual:@""]))
        address.text=[profileDetails objectForKey:@"patientAddress"];
    
    address.font= [UIFont fontWithName:@"GothamRounded-Light" size:14];

    address.layer.cornerRadius=2;
     address.delegate=self;
    [scroll addSubview:address];
    
    
    
 dob=[[UITextField alloc]initWithFrame:CGRectMake(10,220, screenRect.width-20, 40)];
    dob.borderStyle=UITextBorderStyleRoundedRect;
    dob.placeholder=@" Date Of Birth";
    
    if(!([[profileDetails objectForKey:@"patientDateOfBirth"] isEqual:[NSNull null]]||[[profileDetails objectForKey:@"patientDateOfBirth"] isEqual:@""]))
    {
    
        
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        
        [dateFormat setDateFormat:@"YYYY-MM-dd"];
        
        NSDate *date=[dateFormat dateFromString:[profileDetails objectForKey:@"patientDateOfBirth"]];
       
        NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
        
        [dateFormat1 setDateFormat:@"YYYY/MM/dd"];
        
        dob.text =[dateFormat1 stringFromDate:date];
        

    }
    
    dob.font= [UIFont fontWithName:@"GothamRounded-Light" size:14];

    dob.layer.cornerRadius=2;
     dob.delegate=self;
    [scroll addSubview:dob];
    
    pickerView = [[UIDatePicker alloc] init];
    pickerView.datePickerMode = UIDatePickerModeDate;
    [dob setInputView:pickerView];
   toolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(100, 100, screenRect.width, 44)];
    UIBarButtonItem *done4=[[UIBarButtonItem alloc]initWithTitle:@"DONE" style:UIBarButtonItemStyleDone target:self action:@selector(showDatePicker)];
    [toolbar setItems:[NSArray arrayWithObjects:done4, nil]];
    [dob setInputAccessoryView:toolbar];

    
    
    
    
    
    
    
    
    
   weight=[[UITextField alloc]initWithFrame:CGRectMake(10,270, screenRect.width/2-10, 40)];
    weight.borderStyle=UITextBorderStyleRoundedRect;
      weight.font= [UIFont fontWithName:@"GothamRounded-Light" size:14];
    weight.placeholder=@" Weight(in kg)";
    
    if(!([[profileDetails objectForKey:@"patientWeight"] isEqual:[NSNull null]]||[[profileDetails objectForKey:@"patientWeight"] isEqual:@""]))
        weight.text=[profileDetails objectForKey:@"patientWeight"];

    
    weight.layer.cornerRadius=2;
    weight.delegate=self;
    [scroll addSubview:weight];
    
    
height=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.width/2+10,270, screenRect.width/2-20, 40)];
    height.borderStyle=UITextBorderStyleRoundedRect;
    height.font= [UIFont fontWithName:@"GothamRounded-Light" size:14];
    height.placeholder=@" Height(in cm)";
    
    if(!([[profileDetails objectForKey:@"patientHeight"] isEqual:[NSNull null]]||[[profileDetails objectForKey:@"patientHeight"] isEqual:@""]))
        height.text=[profileDetails objectForKey:@"patientHeight"];
    
    height.layer.cornerRadius=2;
    height.delegate=self;
    [scroll addSubview:height];
    


    
    
    toolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(100, 100, screenRect.width, 44)];
   bloodGrp=[[UITextField alloc]initWithFrame:CGRectMake(10,320, screenRect.width/2-10, 40)];
    bloodGrp.borderStyle=UITextBorderStyleRoundedRect;
     bloodGrp.font= [UIFont fontWithName:@"GothamRounded-Light" size:14];
    bloodGrp.placeholder=@" Blood Group";
    
    if(!([[profileDetails objectForKey:@"patientBloodGroup"] isEqual:[NSNull null]]||[[profileDetails objectForKey:@"patientBloodGroup"] isEqual:@""]))
        bloodGrp.text=[profileDetails objectForKey:@"patientBloodGroup"];

    
    bloodGrp.delegate=self;
    bloodGrp.layer.cornerRadius=2;
    [scroll addSubview:bloodGrp];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *done=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneActn)];
    [done setTintColor:[UIColor blueColor]];
    [toolbar setItems:[NSArray arrayWithObjects:spaceItem,done, nil]];
    [bloodGrp setInputAccessoryView:toolbar];
    dataPicker=[[UIPickerView alloc]init];
    bloodGrp.inputView=dataPicker;
    dataPicker.delegate = self;
    dataPicker.dataSource = self;
    
    bloodGrpAr=[NSArray arrayWithObjects:@"O+",@"O-",@"A+",@"A-",@"B+",@"B-",@"AB +",@"AB-",nil];
   
    
    
    
    
    UIToolbar *toolbar1=[[UIToolbar alloc]initWithFrame:CGRectMake(100, 100, screenRect.width, 44)];
    genderTxtFld=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.width/2+10,320, screenRect.width/2-20, 40)];
    genderTxtFld.borderStyle=UITextBorderStyleRoundedRect;
    genderTxtFld.delegate=self;
    genderTxtFld.placeholder=@"Gender";
    
if(!([[profileDetails objectForKey:@"sex"] isEqual:[NSNull null]]||[[profileDetails objectForKey:@"sex"] isEqual:@""]))
        
    {
                if([[profileDetails objectForKey:@"sex"]isEqual:@"0"])
           genderTxtFld.text=@"Male";
        else if([[profileDetails objectForKey:@"sex"]isEqual:@"1"])
            genderTxtFld.text=@"Female";
    }
       
        
        
        
    

    
    genderTxtFld.layer.cornerRadius=2;
     genderTxtFld.font= [UIFont fontWithName:@"GothamRounded-Light" size:14];
    [scroll addSubview:genderTxtFld];
    
    UIBarButtonItem *done1=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneActn1)];
    [done1 setTintColor:[UIColor blueColor]];
    [toolbar1 setItems:[NSArray arrayWithObjects:spaceItem,done1, nil]];
    [genderTxtFld setInputAccessoryView:toolbar1];
   dataPicker1=[[UIPickerView alloc]init];
    genderTxtFld.inputView=dataPicker1;
    dataPicker1.delegate = self;
    dataPicker1.dataSource = self;
    
     gender=[NSArray arrayWithObjects:@"Male",@"Female", nil];
 


    UILabel *aboutLbl=[UILabel new];
    aboutLbl.frame=CGRectMake(10, 370, screenRect.width, 30);
    aboutLbl.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    aboutLbl.textColor=[UIColor blackColor];
    aboutLbl.text=@"About:";
    
    
    
    
    [scroll addSubview:aboutLbl];
    
    
    about =[[UITextView alloc]init];
    about.delegate=self;
    about.font = [UIFont fontWithName:@"GothamRounded-Light" size:12];
    
    if(!([[profileDetails objectForKey:@"patientPersonalNotes"] isEqual:[NSNull null]]|| [[profileDetails objectForKey:@"patientPersonalNotes"] isEqual:@""]))
        
    {
        about.text=[profileDetails objectForKey:@"patientPersonalNotes"];
    }
    

    
    
    about.frame  = CGRectMake(10, 400, screenRect.width-20, 100);
   // about.delegate = self;
    about.layer.cornerRadius=3;
    [scroll addSubview:about];

    
    UIButton *saveBtn=[[UIButton alloc]initWithFrame:CGRectMake(10,510, screenRect.width-20, 40)];
    [saveBtn setTitle:@"Save" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn setBackgroundColor:[UIColor colorWithRed:(CGFloat)234/255 green:(CGFloat)30/255 blue:(CGFloat)99/255 alpha:(CGFloat)1.0]];
    saveBtn.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
    [saveBtn addTarget:self action:@selector(saveProfile) forControlEvents:UIControlEventTouchUpInside];
    saveBtn.layer.cornerRadius=10.0f;
    [scroll addSubview:saveBtn];
    
    
    UIButton *cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(10,560, screenRect.width-20, 40)];
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
 cancelBtn.titleLabel.font=   [UIFont fontWithName:@"GothamRounded-Medium" size:14];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:[UIColor grayColor]];
    [cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.layer.cornerRadius=10.0f;
    [scroll addSubview:cancelBtn];
    
    
    
    float sizeOfContent = 0;
    UIView *lLast = [scroll.subviews lastObject];
    NSInteger wd = lLast.frame.origin.y;
    NSInteger ht = lLast.frame.size.height;
    NSInteger offset=50;
    sizeOfContent = wd+ht;
    scroll.contentSize=CGSizeMake(screenRect.width,sizeOfContent+offset+10);
    

    
    
    
    
    
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
-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    [self animateTextField:textView up:YES];
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    
    [self animateTextField:textView up:NO];
}


-(void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)cancelBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
       [textField resignFirstResponder];
    return  YES;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView1 numberOfRowsInComponent:(NSInteger)component {
    
    if (pickerView1==dataPicker) {
        return [bloodGrpAr count];

    }
    else if (pickerView1==dataPicker1){
        return [gender count];
    }
    else
        return  0;
    
   }
-(NSString *)pickerView:(UIPickerView *)pickerView1 titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    
    
    if (pickerView1==dataPicker) {
        return [bloodGrpAr objectAtIndex:row];
        
    }
    else if (pickerView1==dataPicker1){
       return [gender objectAtIndex:row];
    }
    else
        return  nil;
    



}
-(void)pickerView:(UIPickerView *)pickerView1 didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
   
    if (pickerView1==dataPicker) {
         bloodGrp.text=[bloodGrpAr objectAtIndex:row];
    }
    else if (pickerView1==dataPicker1){
     genderTxtFld.text=[gender objectAtIndex:row];
    }
    
    
}
-(void)doneActn{
    [bloodGrp resignFirstResponder];
}
-(void)doneActn1{
    [genderTxtFld resignFirstResponder];
}


#pragma mark-Date Picker Action
-(void)showDatePicker{
    
    
    NSDateFormatter *form=[[NSDateFormatter alloc]init];
    [form setDateFormat:@"YYYY/MM/dd"];
    dob.text=[NSString stringWithFormat:@"%@",[form stringFromDate:pickerView.date]];
       [dob resignFirstResponder];
    
    
}


#pragma mark-Save Profile Action
-(void)saveProfile{
    
    if([firstnameTextFld isEqual:@""]||[lastnameTextFld isEqual:@""]||[address isEqual:@""]||[dob isEqual:@""]||[weight isEqual:@""]||[height isEqual:@""]||[bloodGrp isEqual:@""]||[genderTxtFld isEqual:@""]){
        UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"Error"
                                                      message:@"Fill all datas" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        
        [alert show];

    }
    
    
    else if([self dobValidation:dob.text]==NO){
        UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"Error"
                                                      message:@"Date Of Birth Must be Less than Today's Date" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        
        [alert show];

    }
    else{
    
    
    [self activityAction];
   
        dispatch_async(dispatch_get_global_queue(0, 0),^{
        
        dispatch_async(dispatch_get_main_queue(),^{
            
            
            NSError *error;
            NSURLResponse * urlResponse;
            
            NSString * urlStr =[NSString stringWithFormat:updatePatientProfile];
            NSURL * url =[NSURL URLWithString:urlStr];
            
            NSMutableURLRequest  * request =[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
           
            
            NSString *gen;
            
            if([genderTxtFld.text isEqual:@"Male"])
                //genderTxtFld.text=@"0";
                gen=@"0";
                
            else if([genderTxtFld.text isEqual:@"Female"])
                gen=@"1";
            
            
            NSString *bloodG=bloodGrp.text;
            
            if([bloodGrp.text isEqual:@"O+"]){
            
                bloodG=[bloodGrp.text stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
                
            }
            else if([bloodGrp.text isEqual:@"A+"]){
                
               bloodG=[bloodGrp.text stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];

                
            }
            else if([bloodGrp.text isEqual:@"B+"]){
                
                bloodG=[bloodGrp.text stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];

                
            }
            

            else if([bloodGrp.text isEqual:@"AB+"]){
                
               bloodG=[bloodGrp.text stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];

                
            }
            

            
            



            
                       NSString * body =[NSString stringWithFormat:@"patientId=%@&firstName=%@&lastName=%@&dob=%@&weight=%@&height=%@&bloodGroup=%@&personalNote=%@&address=%@&gender=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"],firstnameTextFld.text,lastnameTextFld.text,dob.text,weight.text,height.text,bloodG,about.text,address.text,gen];
            
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
                
                UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"Message"
                                                              message:@"Saved successful!!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                
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


-(BOOL)dobValidation:(NSString*)date{
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY/MM/dd";
    NSString *todayDate = [formatter stringFromDate:[NSDate date]];
    
    NSDate *today=[formatter dateFromString:todayDate];
    
    NSDate *enteredDate=[formatter dateFromString:date];
    
    
  
    
    if([enteredDate compare:today]==NSOrderedAscending)

        
        return YES;
    else
        return NO;
    
   
    
    
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


#pragma mark-Fetch Patient Profile
-(void)fetchProfile
{
    
    
    NSError *error;
    NSURLResponse * urlResponse;
    
    NSString * urlStr =[NSString stringWithFormat:fetchPatientProfile];
    NSURL * url =[NSURL URLWithString:urlStr];
    
    NSMutableURLRequest  * request =[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    
    
    NSString * body =[NSString stringWithFormat:@"patient_id=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (!data) {
        
        NSLog(@"%@",error);
       
        return;
    }
    id jsonResponse =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    
    
    NSLog(@"Pztient Profile---->%@",jsonResponse);
    
    if ([[jsonResponse objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
        profileDetails=[jsonResponse objectForKey:@"data"];
               
    }
    
}
//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//    if(textField==passwordTextField){
//        [self animateTextField:textField up:NO];
//    }
//    
//}



-(void)animateTextField:(UITextView*)textField up:(BOOL)up
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
