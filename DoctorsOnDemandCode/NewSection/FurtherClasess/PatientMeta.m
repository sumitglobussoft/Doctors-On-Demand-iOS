//
//  PatientMeta.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 10/27/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "PatientMeta.h"
#import "SingletonClass.h"
@interface PatientMeta ()
{
    CGSize screenRect;
    UIScrollView *scroll;
    UITextField *bloodGrp,*dob,*genderTxtFld,*firstnameTextFld,*lastnameTextFld,*weight,*height,*address;
    UIToolbar *toolbar;
    NSArray *bloodGrpAr,*gender;
    UIDatePicker *pickerView;
    UIPickerView *dataPicker1,*dataPicker;
    UIActivityIndicatorView *activityIndicator;
    UIView *backPopUp,*letsGetStartedPopUp;



}
@end

@implementation PatientMeta

- (void)viewDidLoad {
    [super viewDidLoad];
    screenRect = [[UIScreen mainScreen] bounds].size;
    
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    titleLable.text =@"Registration";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font =[UIFont fontWithName:@"GothamRounded-Light" size:14];
    [headerView addSubview:titleLable];
    
    [self createUi];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-CreateUi
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
briefDescp.text=@"Please Register";
briefDescp.font= [UIFont fontWithName:@"GothamRounded-Medium" size:14];

briefDescp.textColor=[UIColor blackColor];

[scroll addSubview:briefDescp];

firstnameTextFld=[[UITextField alloc]initWithFrame:CGRectMake(10,70, screenRect.width-20, 40)];
firstnameTextFld.borderStyle=UITextBorderStyleRoundedRect;
firstnameTextFld.placeholder=@" First Name";


firstnameTextFld.font= [UIFont fontWithName:@"GothamRounded-Light" size:14];
firstnameTextFld.layer.cornerRadius=2;
firstnameTextFld.delegate=self;
[scroll addSubview:firstnameTextFld];



lastnameTextFld=[[UITextField alloc]initWithFrame:CGRectMake(10,120, screenRect.width-20, 40)];
lastnameTextFld.borderStyle=UITextBorderStyleRoundedRect;
lastnameTextFld.placeholder=@" Last Name";


lastnameTextFld.font= [UIFont fontWithName:@"GothamRounded-Light" size:14];

lastnameTextFld.layer.cornerRadius=2;
lastnameTextFld.delegate=self;
[scroll addSubview:lastnameTextFld];

address=[[UITextField alloc]initWithFrame:CGRectMake(10,170, screenRect.width-20, 40)];
address.borderStyle=UITextBorderStyleRoundedRect;
address.placeholder=@"Address";



address.font= [UIFont fontWithName:@"GothamRounded-Light" size:14];

address.layer.cornerRadius=2;
address.delegate=self;
[scroll addSubview:address];



dob=[[UITextField alloc]initWithFrame:CGRectMake(10,220, screenRect.width-20, 40)];
dob.borderStyle=UITextBorderStyleRoundedRect;
dob.placeholder=@" Date Of Birth";


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



weight.layer.cornerRadius=2;
weight.delegate=self;
[scroll addSubview:weight];


height=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.width/2+10,270, screenRect.width/2-20, 40)];
height.borderStyle=UITextBorderStyleRoundedRect;
height.font= [UIFont fontWithName:@"GothamRounded-Light" size:14];
height.placeholder=@" Height(in cm)";


height.layer.cornerRadius=2;
height.delegate=self;
[scroll addSubview:height];





toolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(100, 100, screenRect.width, 44)];
bloodGrp=[[UITextField alloc]initWithFrame:CGRectMake(10,320, screenRect.width/2-10, 40)];
bloodGrp.borderStyle=UITextBorderStyleRoundedRect;
bloodGrp.font= [UIFont fontWithName:@"GothamRounded-Light" size:14];
bloodGrp.placeholder=@" Blood Group";


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

bloodGrpAr=[NSArray arrayWithObjects:@"O+",@"O-",@"A+",@"A-",@"B+",@"B-",@"AB+",@"AB-",nil];





UIToolbar *toolbar1=[[UIToolbar alloc]initWithFrame:CGRectMake(100, 100, screenRect.width, 44)];
genderTxtFld=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.width/2+10,320, screenRect.width/2-20, 40)];
genderTxtFld.borderStyle=UITextBorderStyleRoundedRect;
genderTxtFld.delegate=self;
genderTxtFld.placeholder=@"Gender";


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
aboutLbl.textColor=[UIColor blackColor];
aboutLbl.text=@"About:";
    aboutLbl.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];

    UITextView *aboutView=[[UITextView alloc]initWithFrame:CGRectMake(10, 400, screenRect.width-20, 100 )];
    aboutView.delegate=self;
    [scroll addSubview:aboutView];


[scroll addSubview:aboutLbl];



UIButton *saveBtn=[[UIButton alloc]initWithFrame:CGRectMake(10,510, screenRect.width-20, 40)];
[saveBtn setTitle:@"Save" forState:UIControlStateNormal];
[saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
[saveBtn setBackgroundColor:[UIColor colorWithRed:(CGFloat)234/255 green:(CGFloat)30/255 blue:(CGFloat)99/255 alpha:(CGFloat)1.0]];
    saveBtn.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
[saveBtn addTarget:self action:@selector(savePatientMeta) forControlEvents:UIControlEventTouchUpInside];
saveBtn.layer.cornerRadius=10.0f;
[scroll addSubview:saveBtn];





float sizeOfContent = 0;
UIView *lLast = [scroll.subviews lastObject];
NSInteger wd = lLast.frame.origin.y;
NSInteger ht = lLast.frame.size.height;
NSInteger offset=50;
sizeOfContent = wd+ht;
scroll.contentSize=CGSizeMake(screenRect.width,sizeOfContent+offset+10);




}

#pragma mark-Date Picker Action
-(void)showDatePicker{
    
    
    NSDateFormatter *form=[[NSDateFormatter alloc]init];
    [form setDateFormat:@"YYYY-MM-dd"];
    dob.text=[NSString stringWithFormat:@"%@",[form stringFromDate:pickerView.date]];
    [dob resignFirstResponder];
    
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [self animateTextField:textView up:YES];
    
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    
      [self animateTextField:textView up:NO];
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


-(void)doneActn{
    [bloodGrp resignFirstResponder];
}
-(void)doneActn1{
    [genderTxtFld resignFirstResponder];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    scroll.contentSize = CGSizeMake(screenRect.width, screenRect.height+250);
    
    
}
//-(void)textFieldDidEndEditing:(UITextField *)textField{
//    scroll.contentSize = CGSizeMake(screenRect.width, screenRect.height+50);
//}
//
//

#pragma mark-Save Profile Action
-(void)savePatientMeta{
    
    if([firstnameTextFld isEqual:@""]||[lastnameTextFld isEqual:@""]||[address isEqual:@""]||[dob isEqual:@""]||[weight isEqual:@""]||[height isEqual:@""]||[bloodGrp isEqual:@""]||[genderTxtFld isEqual:@""])
    {
        UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"Error"
                                                      message:@"Fill all datas" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        
        [alert show];
        
    }
    else if([SingletonClass networkcheck]==YES){
        
        
        NSString *bloodG;
        
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
        
        
        
        

        
        
        [self activityAction];
        dispatch_async(dispatch_get_global_queue(0, 0),^{
            
            dispatch_async(dispatch_get_main_queue(),^{
                
                
                NSError *error;
                NSURLResponse * urlResponse;
                
                NSString * urlStr =[NSString stringWithFormat:patientMetaService];
                NSURL * url =[NSURL URLWithString:urlStr];
                
                NSMutableURLRequest  * request =[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
                
                NSString * body =[NSString stringWithFormat:@"patient_id=%@& patientFirstName=%@&patientLastName=%@&dateOfBirth=%@&patientWeight=%@&patientHeight=%@&patientBloodGroup=%@&patientAddress=%@&sex=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"],firstnameTextFld.text,lastnameTextFld.text,dob.text,weight.text,height.text,bloodG,address.text,genderTxtFld.text];
                
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
                    
                   
                    
                    
                    
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"dismissViewController" object:nil];
                    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"dismissViewController" object:nil];
                    

                    
                    
                }
                else{
                    UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"Message"
                                                                  message:@"Update Unsuccessful" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                    
                    [alert show];
                }
                
                
                
            });
            
        });
        
    }
    
    else
        [self networkWarning];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
