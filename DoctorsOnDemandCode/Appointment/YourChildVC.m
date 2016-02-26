//
//  YourChildVC.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 9/18/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "YourChildVC.h"

@interface YourChildVC (){
    CGSize screenRect;
    UITableView *childTableView;
    int numberOfRows;
    UITableViewCell *cell;
    UIButton *addButton;
    BOOL isExpandclick;
    UISegmentedControl *gender;
    UIDatePicker *picker;
    NSArray *addTextField;
    UITextField *firstName,*lastName,*dob;
    NSDateFormatter *finalDateFormat;
    NSString *finalDob;
    UIActivityIndicatorView *activityIndicator;
    UILabel *label;
    UIView *popUpView,*backPopUp;
    UITextField *prefix, *middleName,*suffix;
}



@end

@implementation YourChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    screenRect=[[UIScreen mainScreen]bounds].size;
    
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
//    dispatch_async(dispatch_get_global_queue(0, 0),^{
//        
//        
//            
//        }
//        
//        dispatch_async(dispatch_get_main_queue(),^{
//            
//            
//        });
//        
//    });

    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    titleLable.text =@"Your Child";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font =[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
   [backButton setFrame:CGRectMake(15, 18, 55, 35)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
    
    
    
    UIButton *nextButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setImage:[UIImage imageNamed:@"next_btn.png"] forState:UIControlStateNormal];
     [nextButton setFrame:CGRectMake(screenRect.width-60, 28, 45, 25)];
    [nextButton addTarget:self action:@selector(nextButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:nextButton];
    
    
    if (UIUserInterfaceIdiomPad== UI_USER_INTERFACE_IDIOM()) {
        
        headerView.frame= CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80);
        
        [backButton setImage:[UIImage imageNamed:@"back_btn_ipad.png"] forState:UIControlStateNormal];
        [backButton setFrame:CGRectMake(15, 30, 80, 30)];
        
        //                titleLable.frame= CGRectMake(60, 25, screenRect.width-120, 35);
        //                titleLable.font =[UIFont boldSystemFontOfSize:25];
        titleLable.frame= CGRectMake(60, 25, screenRect.width-120, 35);
        titleLable.font=[UIFont fontWithName:@"GothamRounded-Light" size:30];
        [nextButton setImage:[UIImage imageNamed:@"next_btn-ipad.png"] forState:UIControlStateNormal];
        [nextButton setFrame:CGRectMake(screenRect.width-100, 28, 80, 25)];

    }

    
    isExpandclick=NO;
    
    [self createUi];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)createUi{
    
    numberOfRows=3;


    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(30, 80, screenRect.width, 40)];
    label1.numberOfLines=2;
    label1.text=@"Please tell us some basic info\nabout your child:";
    label1.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
    label1.textColor=[UIColor blackColor];
    
    [self.view addSubview:label1];
    
    
    
    
    
    
    
    
    
    childTableView=[[UITableView alloc]init];
    childTableView.frame=CGRectMake(10, 120 ,screenRect.width-20,screenRect.height-120);
    childTableView.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];

    //childTableView.scrollEnabled=NO;
    childTableView.showsVerticalScrollIndicator=NO;
    childTableView.separatorColor=[UIColor clearColor];
    childTableView.delegate=self;
    childTableView.dataSource=self;
    [self.view addSubview:childTableView];
    
    
    UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 10 ,childTableView.frame.size.width, 150)];
    footerView.backgroundColor=[UIColor clearColor];
     [self.view addSubview:footerView];
    
    
    
    
    gender = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Male", @"Female", @"Other", nil]];
    gender.frame = CGRectMake(5, 10,childTableView.frame.size.width-10 , 40);
    // segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    gender.selectedSegmentIndex = -1;
    gender.tintColor = [UIColor redColor];
  //  [gender addTarget:self action:@selector(valueChanged) forControlEvents: UIControlEventValueChanged];
    [footerView addSubview:gender];

    
    addButton =  [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addButton.frame=CGRectMake(childTableView.frame.size.width-100 , footerView.frame.size.height-50, 100, 40);
    [addButton addTarget:self action:@selector(expandActn) forControlEvents:UIControlEventTouchUpInside];
    [addButton setBackgroundImage:[UIImage imageNamed:@"expand_btn.png"] forState:UIControlStateNormal];
    
    [footerView addSubview:addButton];
    childTableView.tableFooterView=footerView;
    

    
if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
{
  
   label1.frame=CGRectMake(30, 100, screenRect.width, 60);

    label1.font=[UIFont fontWithName:@"GothamRounded-Medium" size:30];
    
     childTableView.frame=CGRectMake(10,190 ,screenRect.width-20,screenRect.height-120);
 gender.frame = CGRectMake(5, 10,childTableView.frame.size.width-10 , 50);
    UIFont *font = [UIFont fontWithName:@"GothamRounded-Light" size:25];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                           forKey:UITextAttributeFont];
    [gender setTitleTextAttributes:attributes
                                    forState:UIControlStateNormal];
    addButton.frame=CGRectMake(childTableView.frame.size.width-130 , footerView.frame.size.height-50, 140, 80);
}

}

-(void)expandActn{
    
    
    
    if(isExpandclick==NO){
    [addButton setBackgroundImage:[UIImage imageNamed:@"collapse_btn.png"] forState:UIControlStateNormal];
    numberOfRows=6;
    [childTableView reloadData];
    isExpandclick=YES;
        
        addTextField=[NSArray arrayWithObjects:firstName.text,lastName.text,dob.text, nil];
        
        
        
    }
    else{
        [addButton setBackgroundImage:[UIImage imageNamed:@"expand_btn.png"] forState:UIControlStateNormal];
        numberOfRows=3;
        [childTableView reloadData];
        isExpandclick=NO;

    }
    
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"SimpleTableItem";
    
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];

    
    if (cell == nil )
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    }
    
    
    if(isExpandclick==NO){
    if(indexPath.row==0 ){
        
        
        firstName=[[UITextField alloc]initWithFrame:CGRectMake(5, 10,childTableView.frame.size.width-10 , 40)];
        firstName.borderStyle=UITextBorderStyleRoundedRect;
        firstName.backgroundColor=[UIColor whiteColor];
        firstName.placeholder=@" First Name";
        firstName.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];
        firstName.delegate = self;
        [cell addSubview:firstName];
    }
    else if(indexPath.row==1){
    
        
        
        
        lastName=[[UITextField alloc]initWithFrame:CGRectMake(5, 10,childTableView.frame.size.width-10 , 40)];
        lastName.borderStyle=UITextBorderStyleRoundedRect;
        lastName.backgroundColor=[UIColor whiteColor];
        lastName.placeholder=@" Last Name";
        lastName.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];
        lastName.delegate = self;
        [cell addSubview:lastName];
        
        
    }
    else if(indexPath.row==2){
        
       dob=[[UITextField alloc]initWithFrame:CGRectMake(5, 10,childTableView.frame.size.width-10 , 40)];
        dob.borderStyle=UITextBorderStyleRoundedRect;
        dob.backgroundColor=[UIColor whiteColor];
        dob.placeholder=@" Date of Birth";
        dob.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];
        dob.delegate = self;
        [cell addSubview:dob];
        
        
                      picker = [[UIDatePicker alloc] init];
        picker.datePickerMode = UIDatePickerModeDate;
        [dob setInputView:picker];
        UIToolbar *toolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(100, 100, screenRect.width, 44)];
           UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
       
        UIBarButtonItem *done=[[UIBarButtonItem alloc]initWithTitle:@"DONE" style:UIBarButtonItemStyleDone target:self action:@selector(showDate)];
        [toolbar setItems:[NSArray arrayWithObjects:spaceItem,done, nil]];
        [dob setInputAccessoryView:toolbar];

        
        
    }
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            
            firstName.frame=CGRectMake(5, 10,childTableView.frame.size.width-10 , 80);
            
            firstName.placeholder=@" First Name";
            firstName.font=[UIFont fontWithName:@"GothamRounded-Light" size:25];
            
            lastName.frame=CGRectMake(5, 10,childTableView.frame.size.width-10 , 80);
            
            lastName.placeholder=@" Last Name";
            lastName.font=[UIFont fontWithName:@"GothamRounded-Light" size:25];
            
            
            dob.frame=CGRectMake(5, 10,childTableView.frame.size.width-10 , 80);
            
            dob.placeholder=@" Date of Birth";
            dob.font=[UIFont fontWithName:@"GothamRounded-Light" size:25];
            
            //        firstName.frame=CGRectMake(5, 10,childTableView.frame.size.width-10 , 40);
            //
            //        firstName.placeholder=@" First Name";
            //        firstName.font=[UIFont fontWithName:@"GothamRounded-Light" size:25];
            
        }

    }
    else{
        
        if(indexPath.row==0 ){
            
            
            prefix=[[UITextField alloc]initWithFrame:CGRectMake(5, 10,childTableView.frame.size.width-10 , 40)];
            prefix.borderStyle=UITextBorderStyleRoundedRect;
            prefix.backgroundColor=[UIColor whiteColor];
            prefix.placeholder=@" Prefix";
            prefix.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];
            prefix.delegate = self;
            [cell addSubview:prefix];
        }
        else if(indexPath.row==1){
            
            
            
            
            firstName=[[UITextField alloc]initWithFrame:CGRectMake(5, 10,childTableView.frame.size.width-10 , 40)];
            firstName.borderStyle=UITextBorderStyleRoundedRect;
            firstName.backgroundColor=[UIColor whiteColor];
            if([addTextField objectAtIndex:0]!=nil){
                firstName.text=[addTextField objectAtIndex:0];
            }
           
            firstName.placeholder=@" First Name";
            firstName.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];
         
            firstName.delegate = self;
            [cell addSubview:firstName];
            
            
        }
        else if(indexPath.row==2){
            
            middleName=[[UITextField alloc]initWithFrame:CGRectMake(5, 10,childTableView.frame.size.width-10 , 40)];
            middleName.borderStyle=UITextBorderStyleRoundedRect;
            middleName.backgroundColor=[UIColor whiteColor];
            middleName.placeholder=@" Middle Name";
            middleName.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];
            middleName.delegate = self;
            [cell addSubview:middleName];
            
            
            
        }
        else if(indexPath.row==3){
            
         lastName=[[UITextField alloc]initWithFrame:CGRectMake(5, 10,childTableView.frame.size.width-10 , 40)];
            lastName.borderStyle=UITextBorderStyleRoundedRect;
            lastName.backgroundColor=[UIColor whiteColor];
            lastName.placeholder=@" Last Name";
            lastName.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];
            if([addTextField objectAtIndex:1]!=nil){
                lastName.text=[addTextField objectAtIndex:1];
            }

            lastName.delegate = self;
            [cell addSubview:lastName];
            
        }
       else if(indexPath.row==4){
            
           suffix=[[UITextField alloc]initWithFrame:CGRectMake(5, 10,childTableView.frame.size.width-10 , 40)];
            suffix.borderStyle=UITextBorderStyleRoundedRect;
            suffix.backgroundColor=[UIColor whiteColor];
            suffix.placeholder=@" Suffix";
           suffix.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];
            suffix.delegate = self;
            [cell addSubview:suffix];
            
            
            
        }
       else if(indexPath.row==5){
           dob=[[UITextField alloc]initWithFrame:CGRectMake(5, 10,childTableView.frame.size.width-10 , 40)];
           dob.borderStyle=UITextBorderStyleRoundedRect;
           dob.backgroundColor=[UIColor whiteColor];
           dob.placeholder=@" Date of Birth";
           dob.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];
           dob.delegate = self;
           if([addTextField objectAtIndex:2]!=nil){
               dob.text=[addTextField objectAtIndex:2];
           }
           [cell addSubview:dob];
           
           
           picker = [[UIDatePicker alloc] init];
           picker.datePickerMode = UIDatePickerModeDate;
           [dob setInputView:picker];
           UIToolbar *toolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(100, 100, screenRect.width, 44)];
           UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
           
           UIBarButtonItem *done=[[UIBarButtonItem alloc]initWithTitle:@"DONE" style:UIBarButtonItemStyleDone target:self action:@selector(showDate)];
           [toolbar setItems:[NSArray arrayWithObjects:spaceItem,done, nil]];
           [dob setInputAccessoryView:toolbar];
       }

        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            
            firstName.frame=CGRectMake(5, 10,childTableView.frame.size.width-10 , 80);
            
            firstName.placeholder=@" First Name";
            firstName.font=[UIFont fontWithName:@"GothamRounded-Light" size:25];
            
            lastName.frame=CGRectMake(5, 10,childTableView.frame.size.width-10 , 80);
            
            lastName.placeholder=@" Last Name";
            lastName.font=[UIFont fontWithName:@"GothamRounded-Light" size:25];
            
            
            dob.frame=CGRectMake(5, 10,childTableView.frame.size.width-10 , 80);
            
            dob.placeholder=@" Date of Birth";
            dob.font=[UIFont fontWithName:@"GothamRounded-Light" size:25];
            
            prefix.frame=CGRectMake(5, 10,childTableView.frame.size.width-10 , 80);
            
            prefix.placeholder=@" Prefix";
            prefix.font=[UIFont fontWithName:@"GothamRounded-Light" size:25];

            
            middleName.frame=CGRectMake(5, 10,childTableView.frame.size.width-10 , 80);
            
            middleName.placeholder=@" Middle Name";
            middleName.font=[UIFont fontWithName:@"GothamRounded-Light" size:25];

            
            
            suffix.frame=CGRectMake(5, 10,childTableView.frame.size.width-10 , 80);
            
            suffix.placeholder=@" Suffix";
            suffix.font=[UIFont fontWithName:@"GothamRounded-Light" size:25];

            
         

            
            //        firstName.frame=CGRectMake(5, 10,childTableView.frame.size.width-10 , 40);
            //
            //        firstName.placeholder=@" First Name";
            //        firstName.font=[UIFont fontWithName:@"GothamRounded-Light" size:25];
            
        }

        cell.selectionStyle=UITableViewCellSelectionStyleNone;

        
    }

    
    
    
    
    
    
        return cell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return numberOfRows;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        return 100;
    }
    return 50;
    
}



#pragma mark-text Field delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
        [textField resignFirstResponder];
    return  YES;
}

#pragma mark-Back and Next Action
-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)nextButtonAction{
    
    label=[[UILabel alloc]init];
    label.text=@"";
    
   
    if([firstName.text isEqual:@""]){
        firstName.layer.borderColor=[[UIColor redColor]CGColor];
        firstName.layer.borderWidth= 1.0f;
        label.frame=CGRectMake(0, firstName.frame.size.height-20, firstName.frame.size.width, 20);
        label.textAlignment=NSTextAlignmentCenter;
        label.text=@"You must enter your child's first name";
        label.font=[UIFont fontWithName:@"GothamRounded-Medium" size:11];
        label.textColor=[UIColor redColor];
        [firstName addSubview:label];

    }
   else if ([lastName.text isEqual:@""]){
       lastName.layer.borderColor=[[UIColor redColor]CGColor];
       lastName.layer.borderWidth= 1.0f;
       label.frame=CGRectMake(0, lastName.frame.size.height-20, lastName.frame.size.width, 20);
       label.textAlignment=NSTextAlignmentCenter;
       label.font=[UIFont fontWithName:@"GothamRounded-Medium" size:11];
       label.textColor=[UIColor redColor];
       [lastName addSubview:label];

    }
    else  if([dob.text isEqual:@""]){
        dob.layer.borderColor=[[UIColor redColor]CGColor];
        dob.layer.borderWidth= 1.0f;
        label.frame=CGRectMake(0, dob.frame.size.height-20, dob.frame.size.width, 20);
        label.textAlignment=NSTextAlignmentCenter;
        label.text=@"You must enter your child's date of birth";
       label.font=[UIFont fontWithName:@"GothamRounded-Medium" size:11];
        label.textColor=[UIColor redColor];
        [dob addSubview:label];

        
    }
   else if(gender.selectedSegmentIndex==-1){
       [self createPopUp];
    }
    
    
    else{
    
    
    
    [self activityAction];
    dispatch_async(dispatch_get_global_queue(0, 0),^{
        
        
        [self createChild];
        dispatch_async(dispatch_get_main_queue(),^{
            SelectPharmacyVC *pharmacy=[[SelectPharmacyVC alloc]init];
            [self.navigationController pushViewController:pharmacy animated:YES];
             [activityIndicator stopAnimating];
        });
        
       
    });
    }
    
    
}

#pragma mark-Text Fiels delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField

{
    
    if(textField==firstName){
        firstName.layer.borderColor=[[UIColor clearColor]CGColor];
        firstName.layer.borderWidth= 1.0f;
        [label removeFromSuperview];
    }
    else if(textField==lastName){
        lastName .layer.borderColor=[[UIColor clearColor]CGColor];
        lastName.layer.borderWidth= 1.0f;
        [label removeFromSuperview];
    }
    
    
    if(textField==dob){
        
        
        dob .layer.borderColor=[[UIColor clearColor]CGColor];
        dob.layer.borderWidth= 1.0f;
        [label removeFromSuperview];
        
    }
    
    
}


#pragma mark-Date Picker
-(void)showDate{
 NSDateFormatter  * dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MMM dd,YYYY"];
    
    
    
    
     finalDateFormat=[[NSDateFormatter alloc]init];
    [finalDateFormat setDateFormat:@"YYYY-MM-dd"];
    finalDob= [NSString stringWithFormat:@"%@",[finalDateFormat stringFromDate:picker.date]];
    
    
   
    
    // [dateFormatter setDateFormat:@"HH:mm"];
   dob.text=[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:picker.date]];
    [dob resignFirstResponder];

}


#pragma mark-Create child Details srvice
-(void)createChild{
    NSError * error;
    NSURLResponse *  urlResponse;
    
    
    NSURL * postUrl =[NSURL URLWithString:createChildService];
    
    
    
    
    NSMutableURLRequest * request =[[NSMutableURLRequest alloc]initWithURL:postUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    
    NSString * body =[NSString stringWithFormat:@"patient_id=%@&firstName=%@&lastName=%@&dob=%@&sex=%ld",[[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"],firstName.text,lastName.text,finalDob,(long)gender.selectedSegmentIndex];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    if (!data) {
        NSLog(@"error...%@",error);
             NSLog(@"rturned.........");
        
        return;
    }
    
    id json =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"json %@",json);
       if ([[json objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
        
           
          
//           [[NSUserDefaults standardUserDefaults]setObject:[[json objectForKey:@"data"] objectForKey:@"id"]  forKey:@"patientNo"];
//           [[NSUserDefaults standardUserDefaults]synchronize];

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


#pragma mark-Pop up view
-(void)createPopUp{
    
    
    
    backPopUp =[[UIView alloc]init];
    backPopUp.frame= CGRectMake(0, 800, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    backPopUp.backgroundColor =[UIColor lightGrayColor];
    [self.view addSubview:backPopUp];
    
    popUpView =[[UIView alloc]init];
    popUpView.frame= CGRectMake(10, 800, [UIScreen mainScreen].bounds.size.width-20, [UIScreen mainScreen].bounds.size.height-120);
    popUpView.backgroundColor = [UIColor whiteColor];
    popUpView.layer.cornerRadius=6.0f;
    popUpView.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:1];
    popUpView.clipsToBounds = YES;
    popUpView.layer.shadowColor = [UIColor blackColor].CGColor;
    popUpView.layer.shadowOffset = CGSizeMake(-2, 2);
    popUpView.layer.shadowOpacity = 3;
    popUpView.layer.shadowRadius = 15;
    popUpView.layer.shadowPath = [UIBezierPath bezierPathWithRect:popUpView.bounds].CGPath;
    [backPopUp addSubview:popUpView];
    
    UILabel *header=[[UILabel alloc]init];
    header.frame= CGRectMake(00,0,  popUpView.frame.size.width, 150);
    header.text=@"OOPS!";
   header.font=[UIFont fontWithName:@"GothamRounded-Medium" size:30];
    header.textAlignment = NSTextAlignmentCenter;
    header.textColor=[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1];
    [popUpView addSubview:header];
    

    
    UILabel *information=[[UILabel alloc]init];
    information.frame= CGRectMake(0,70,  popUpView.frame.size.width, 300);
       information.text=@"Please select gender.";
    information.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    information.textColor=[UIColor blackColor];
    information.textAlignment = NSTextAlignmentCenter;
    [popUpView addSubview:information];
    UIButton *letsGoButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
   
        
        letsGoButton.frame=CGRectMake(0, popUpView.frame.size.height-80,popUpView.frame.size.width-20, 50);
        [letsGoButton setTitle:@"OK" forState:UIControlStateNormal];
        letsGoButton.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
        [letsGoButton setBackgroundColor:[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1]];
        [letsGoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [letsGoButton addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
        letsGoButton.layer.cornerRadius=6.0f;
        
        [popUpView addSubview:letsGoButton];
    
    if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()) {
      
        information.frame= CGRectMake(0,250,  popUpView.frame.size.width, 300);
        information.font = [UIFont systemFontOfSize:30];
        letsGoButton.frame=CGRectMake(0, popUpView.frame.size.height-130,popUpView.frame.size.width, 100);
        letsGoButton.titleLabel.font = [UIFont systemFontOfSize:30];
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        popUpView.frame = CGRectMake(20, 60, [UIScreen mainScreen].bounds.size.width-40, [UIScreen mainScreen].bounds.size.height-150);
        backPopUp.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }];
}

-(void)okAction{
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        popUpView.frame=CGRectMake(30, 700, self.view.frame.size.width-60, self.view.frame.size.height-60);
        backPopUp.frame = CGRectMake(0,800, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }completion:^(BOOL finished){
        
        
        
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
