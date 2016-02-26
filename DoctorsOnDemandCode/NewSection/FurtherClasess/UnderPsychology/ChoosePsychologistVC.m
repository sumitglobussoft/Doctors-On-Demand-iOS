//
//  ChoosePsychologistVC.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 8/27/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "ChoosePsychologistVC.h"
#import "PsychologyView.h"

@interface ChoosePsychologistVC (){
    CGSize screenRect;
         UIView *backPopUp;
     UITableView *psychologistTableView;
    NSMutableArray *jsonArray;
UIActivityIndicatorView *activityIndicator;
}


@end

@implementation ChoosePsychologistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    screenRect=[[UIScreen mainScreen]bounds].size;
    jsonArray=[[NSMutableArray alloc]init];
    
   
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    [self activityAction];
    dispatch_async(dispatch_get_global_queue(0, 0),^{
        
        if([[[NSUserDefaults standardUserDefaults]objectForKey:@"scheduleMethod"]isEqual:@"byDoc"])
            
            
            
            [self fetchPshycology];
       
        else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"scheduleMethod"]isEqual:@"byTime"])
        
            [self fetchDocByTime];
        
        
        
        
        
        dispatch_async(dispatch_get_main_queue(),^{
            
            
            if(jsonArray.count==0){
                [self noDocLabel];
            }
            
            else
            [self createUI];
            
            [activityIndicator stopAnimating];
        });
        
    });

    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    
    
    
   if([SingletonClass sharedSingleton].deptId==3)
     titleLable.text =@"CHOOSE PSYCHOLOGIST";
     if([SingletonClass sharedSingleton].deptId==1)
            titleLable.text =@"SELECT CONSULTANT";
    if([SingletonClass sharedSingleton].deptId==2)
        titleLable.text=@"SELECT PAEDIATRICIAN";
    if([SingletonClass sharedSingleton].deptId==4)
        titleLable.text =@"SELECT MEDICAL DOCTOR";
  if([[[NSUserDefaults standardUserDefaults]objectForKey:@"OurDoctors"]isEqual:@"ourPhy"])
       titleLable.text =@"Our Doctors";
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"pshy"]isEqual:@"ourPhy"])
           titleLable.text =@"Featured Psychologists";
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"consultant"]isEqual:@"meetCons"])
        titleLable.text=@"Our Lactation Consultants";

    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font =[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
   [backButton setFrame:CGRectMake(15, 18, 55, 35)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        headerView.frame= CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80);
        titleLable.frame= CGRectMake(60, 25, screenRect.width-120, 35);
        titleLable.font=[UIFont fontWithName:@"GothamRounded-Light" size:26];
        //titleLable.font =[UIFont systemFontOfSize:30];
        [backButton setImage:[UIImage imageNamed:@"back_btn_ipad.png"] forState:UIControlStateNormal];
        [backButton setFrame:CGRectMake(15, 30, 80, 25)];
        
//        [nextButton setImage:[UIImage imageNamed:@"next_btn-ipad.png"] forState:UIControlStateNormal];
//        [nextButton setFrame:CGRectMake(screenRect.width-100, 28, 80, 25)];
//        
    }

    
    

    // Do any additional setup after loading the view.
}
-(void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)noDocLabel{
    
    UILabel* label=[[UILabel alloc]init];
     label.textAlignment=NSTextAlignmentCenter;
                label.frame= CGRectMake(0, 65, screenRect.width, 30);
    if([SingletonClass sharedSingleton].deptId==3)
        label.text =@"No psychologist available";
  else  if([SingletonClass sharedSingleton].deptId==1)
        label.text =@"No consultant available";
   else if([SingletonClass sharedSingleton].deptId==2)
        label.text=@"No paediatrician available";
   else if([SingletonClass sharedSingleton].deptId==4)
        label.text =@"No medical doctor available";
    else
        label.text=@"No Doctors available";
    
   
   
    label.textColor=[UIColor blackColor];
    label.font=[UIFont fontWithName:@"GothamRounded-Medium" size:15];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        
          label.frame= CGRectMake(0, 100, screenRect.width, 40);
         label.font=[UIFont fontWithName:@"GothamRounded-Medium" size:25];
        
    }
    [self.view addSubview:label];
  
    
}


-(void)createUI{
    
    
    
        // Do any additional setup after loading the view, typically from a nib.
    
    psychologistTableView=[[UITableView alloc]init];
    psychologistTableView.frame=CGRectMake(0, 50 ,screenRect.width,screenRect.height-70);
    psychologistTableView.backgroundColor=[UIColor clearColor];
    
    psychologistTableView.delegate=self;
    psychologistTableView.dataSource=self;
    psychologistTableView.showsVerticalScrollIndicator = NO;
    psychologistTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
     if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
         
         psychologistTableView.frame=CGRectMake(0, 90 ,screenRect.width,screenRect.height-90);
         
     }
    
    [self.view addSubview:psychologistTableView];
    

    
    
    
    
}
-(UITableViewCell *)tableView:(UITableView * )tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    CustomTableViewCell * cell =(CustomTableViewCell*) [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[CustomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"pshychologist"];
        cell.backgroundColor = [UIColor clearColor];
        
        //int stringHeight=[self calculateHeight:[[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"doctorAbout"]];
        
        cell.containerView.frame = CGRectMake(0, 5, psychologistTableView.frame.size.width, 95);
               cell.containerView.backgroundColor = [UIColor whiteColor];
        cell.containerView.layer.shadowColor = [UIColor blackColor].CGColor;
        cell.containerView.layer.shadowOffset = CGSizeMake(0, 0);
        cell.containerView.layer.shadowOpacity = 0.5;
        cell.containerView.layer.shadowRadius = 1;
        cell.containerView.layer.shadowPath = [UIBezierPath bezierPathWithRect:cell.containerView.bounds].CGPath;
       
        
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        
        
        
        
        
       // cell.pharmacyName.text
        NSString *fName=[[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"FirstName"];
        NSString *lName=[[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"LastName"];
        
        
        cell.pharmacyName.text=[NSString stringWithFormat:@"%@ %@",fName,lName];
        
        
        [[NSUserDefaults standardUserDefaults]setObject:cell.pharmacyName.text   forKey:[NSString stringWithFormat:@"bio%ld",(long)indexPath.row]];
        [[NSUserDefaults standardUserDefaults]synchronize];
    
        
        if([[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"doctorAbout"]!=[NSNull null]){
            cell.pharmacyPhNo.text=[[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"doctorAbout"];

        }
       
        
        
        
       
        
        [[NSUserDefaults standardUserDefaults]setObject:cell.pharmacyPhNo.text   forKey:[NSString stringWithFormat:@"about%ld",(long)indexPath.row]];
        [[NSUserDefaults standardUserDefaults]synchronize];

        
        if([[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"doctorProfilePicUrl"] !=[NSNull null]){
        [[NSUserDefaults standardUserDefaults]setObject:[[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"doctorProfilePicUrl"]   forKey:[NSString stringWithFormat:@"DocPhoto%ld",(long)indexPath.row]];
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        }
        else{
            [[NSUserDefaults standardUserDefaults]setObject:nil   forKey:[NSString stringWithFormat:@"DocPhoto%ld",(long)indexPath.row]];
            

        }
        cell.pharmacyName.font =[UIFont fontWithName:@"GothamRounded-Bold" size:15];

        cell.pharmacyPhNo.font =[UIFont fontWithName:@"GothamRounded-Light" size:12];
       
        
        cell.leftColorView.frame = CGRectMake(0, 1,5,cell.containerView.frame.size.height-1);
      if (UIUserInterfaceIdiomPad ==  UI_USER_INTERFACE_IDIOM()) {
            
            cell.containerView.frame = CGRectMake(0, 5, psychologistTableView.frame.size.width, 190);
            
            //cell.pharmacyName.frame=CGRectMake(7, 5, 150, cell.containerView.frame.size.height);
//            cell.pharmacyPhNo.frame=CGRectMake(pharmacyAppTbl.frame.size.width/2-150, 5, 120, cell.containerView.frame.size.height);
//            cell.pharmacyCity.frame=CGRectMake(pharmacyAppTbl.frame.size.width/2-10, 5, 120, cell.containerView.frame.size.height);
//            cell.pharmacyCountry.frame=CGRectMake(pharmacyAppTbl.frame.size.width/2+180, 5,pharmacyAppTbl.frame.size.width-(pharmacyAppTbl.frame.size.width/2+80), cell.containerView.frame.size.height);
         
          
            cell.pharmacyName.font =[UIFont fontWithName:@"GothamRounded-Medium" size:25];
            cell.pharmacyPhNo.font =[UIFont fontWithName:@"GothamRounded-Medium" size:20];
            cell.pharmacyCity.font =[UIFont fontWithName:@"GothamRounded-Medium" size:20];
            cell.pharmacyCountry.font =[UIFont fontWithName:@"GothamRounded-Medium" size:20];
            
            cell.leftColorView.frame = CGRectMake(0, 1,5,cell.containerView.frame.size.height-1);
        }    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"row no-->%ld",(long)indexPath.row);
    
    
    [[NSUserDefaults standardUserDefaults]setInteger:indexPath.row   forKey:@"rowNo"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    [[NSUserDefaults standardUserDefaults]setValue:[[jsonArray objectAtIndex:indexPath.row ]objectForKey:@"doctor_id"] forKey:@"doctorid" ];
    [[NSUserDefaults standardUserDefaults]synchronize];

    
    
    
    PsychologistVC *psychologist=[[PsychologistVC alloc]init];
    
    
    [self.navigationController pushViewController:psychologist animated:YES];
    
    
  
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return jsonArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     //float stringHeight=[self calculateHeight:[[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"doctorAbout"]];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        return 200;
    
    }
    return 100;
    
}

-(void)fetchPshycology{
    NSError * error ;
    NSURLResponse * urlResponse;
    
    NSURL * postUrl =[NSURL URLWithString:departmentDoctorsService];
    
    
    NSString * body;
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"OurDoctors"]isEqual:@"meetOurPhy" ])
      body  =[NSString stringWithFormat:@"departmentId=4&timeZone=%@",[NSTimeZone localTimeZone].name];
        
        else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"pshy"]isEqual:@"ourPhy" ])
            
            body  =[NSString stringWithFormat:@"departmentId=3&timeZone=%@",[NSTimeZone localTimeZone].name];
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"consultant"]isEqual:@"meetCons"])
      body  =[NSString stringWithFormat:@"departmentId=1&timeZone=%@",[NSTimeZone localTimeZone].name];
    else
            body =[NSString stringWithFormat:@"departmentId=%d&timeZone=%@",[SingletonClass sharedSingleton].deptId,[NSTimeZone localTimeZone].name];
    
    
    
    
    NSMutableURLRequest * request =[[NSMutableURLRequest alloc]initWithURL:postUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
    
    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (!data) {
        
        return;
    }
    
    id json =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
   // NSLog(@"json %@",json);
    if ([[json objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
        
        
            NSArray * arr =[json objectForKey:@"data"];
        for (int i=0; i<arr.count; i++) {
            [jsonArray addObject:[arr objectAtIndex:i]];
        }

        
        
        
    }
    
    
    

    
}



#pragma mark-fetch doctors from time interval
-(void)fetchDocByTime{
    NSError * error ;
    NSURLResponse * urlResponse;
    
    NSURL * postUrl =[NSURL URLWithString:fetchDoctorsByTimeService];
    
    
    NSString * body;
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"OurDoctors"]isEqual:@"meetOurPhy" ])
        body  =[NSString stringWithFormat:@"appointmentStartTime=%@&appointmentEndTime=%@&departmentId=4&timeZone=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"appointment_start_time"],[[NSUserDefaults standardUserDefaults]objectForKey:@"appointment_end_time"],[NSTimeZone localTimeZone].name];
    
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"pshy"]isEqual:@"ourPhy" ])
        
        body  =[NSString stringWithFormat:@"appointmentStartTime=%@&appointmentEndTime=%@&departmentId=3&timeZone=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"appointment_start_time"],[[NSUserDefaults standardUserDefaults]objectForKey:@"appointment_end_time"],[NSTimeZone localTimeZone].name];
    
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"consultant"]isEqual:@"meetCons"])
        body  =[NSString stringWithFormat:@"appointmentStartTime=%@&appointmentEndTime=%@&departmentId=1&timeZone=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"appointment_start_time"],[[NSUserDefaults standardUserDefaults]objectForKey:@"appointment_end_time"],[NSTimeZone localTimeZone].name];
    else
        body =[NSString stringWithFormat:@"appointmentStartTime=%@&appointmentEndTime=%@&departmentId=%d&timeZone=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"appointment_start_time"],[[NSUserDefaults standardUserDefaults]objectForKey:@"appointment_end_time"],[SingletonClass sharedSingleton].deptId,[NSTimeZone localTimeZone].name];
    
   
    
    
    NSMutableURLRequest * request =[[NSMutableURLRequest alloc]initWithURL:postUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
    
    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (!data) {
        
        return;
    }
    
    id json =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
  //  NSLog(@"json %@",json);
    if ([[json objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
        
        
        NSArray * arr =[json objectForKey:@"data"];
        for (int i=0; i<arr.count; i++) {
            [jsonArray addObject:[arr objectAtIndex:i]];
        }
        
        
        
        
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




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
