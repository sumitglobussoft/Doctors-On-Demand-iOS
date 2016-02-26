//
//  AppointmentDetails.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 11/30/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "AppointmentDetails.h"
#import "CustomTableViewCell.h"
//#import "ios-ntp.h"

@interface AppointmentDetails (){

        CGSize screenRect;
        UIActivityIndicatorView *activityIndicator;
    
    UITableView *apptDetialTbl;
    NSMutableArray *appointmntDetails;
    UILabel *noneShedule;
    BOOL response;
    
}

@end

@implementation AppointmentDetails

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
    
    
    
    [self activityAction];
    
    dispatch_async(dispatch_get_global_queue(0, 0),^{
        
        [self getAppointment];
        
        
        dispatch_async(dispatch_get_main_queue(),^{
            
            
            if(response==YES)
                
                [self createUi];
            else
                [self noAppointment];
            
            [activityIndicator stopAnimating];
            
            
        });
        
        
    });
    
    
    

    
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:(BOOL)animated];
    
    [noneShedule removeFromSuperview];
    
    [apptDetialTbl removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
        screenRect=[[UIScreen mainScreen]bounds].size;
    
    
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    titleLable.text =@"My Appointments";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font =[UIFont fontWithName:@"GothamRounded-Light" size:14];
    [headerView addSubview:titleLable];
    
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
    [backButton setFrame:CGRectMake(15, 18, 55, 35)];
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];

    //[self createUi];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-Back button

-(void)backButtonAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark-create no appointment

-(void)noAppointment{
    
    
    noneShedule=[[UILabel alloc]initWithFrame:CGRectMake(0,70, screenRect.width, 30)];
    noneShedule.textAlignment=NSTextAlignmentCenter;
    noneShedule.text=@"None scheduled.";
    noneShedule.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
    noneShedule.textColor=[UIColor blackColor];
    [self.view addSubview:noneShedule];

    
}


#pragma mark-Create UI

-(void)createUi{
    
    apptDetialTbl=[[UITableView alloc]initWithFrame:CGRectMake(10, 60, screenRect.width-20, screenRect.height-60)];
    apptDetialTbl.delegate=self;
    apptDetialTbl.dataSource=self;
    
    apptDetialTbl.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    UIView* headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, apptDetialTbl.frame.size.width, 60)];
    headerView.backgroundColor=[UIColor colorWithRed:(CGFloat)234/255 green:(CGFloat)30/255 blue:(CGFloat)99/255 alpha:(CGFloat)1.0];
    //apptDetialTbl.tableHeaderView=headerView;

    
    [self.view addSubview:apptDetialTbl];
    
    UILabel * titleLbl=[[UILabel alloc]init];
    titleLbl.frame=CGRectMake(0, 14, apptDetialTbl.frame.size.width, 30);
    titleLbl.text=@"Appointment Lists";
    titleLbl.textAlignment=NSTextAlignmentCenter;
    titleLbl.textColor=[UIColor whiteColor];
    titleLbl.backgroundColor=[UIColor clearColor];
    titleLbl.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
    [headerView addSubview:titleLbl];
    
    
    
    
}


#pragma mark-Table Delegate
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomTableViewCell * cell =(CustomTableViewCell*) [tableView cellForRowAtIndexPath:indexPath];

    
    if(!cell){
        
        cell=[[CustomTableViewCell alloc ]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AppointmentDetails"];
        cell.backgroundColor = [UIColor clearColor];
        
               }

    switch ([[[appointmntDetails objectAtIndex:indexPath.row]objectForKey:@"appointmentStatus"]intValue]) {
        case 0:
            cell.appointmentStatus.text=@"Rejected";
            cell.appointmentStatus.textColor=[UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)37/255 blue:(CGFloat)101/255 alpha:(CGFloat)1];
            break;
        case 1:
            cell.appointmentStatus.text=@"Accepted";
            cell.appointmentStatus.textColor=[UIColor blueColor];
            
            break;
        case 2:
            cell.appointmentStatus.text=@"Rejected";
            cell.appointmentStatus.textColor=[UIColor redColor];
            
            break;
        case 3:
            cell.appointmentStatus.text=@"Completed";
            cell.appointmentStatus.textColor=[UIColor blackColor];
            
            break;
            
        default:
            break;
    }

        cell.userName.text=[NSString stringWithFormat:@"Dr. %@ %@",[[appointmntDetails objectAtIndex:indexPath.row]objectForKey:@"FirstName" ],[[appointmntDetails objectAtIndex:indexPath.row]objectForKey:@"LastName" ]];
    
    
    
    //fetching local current time
    
   // NetworkClock *   netClock = [NetworkClock sharedNetworkClock];

   // NSDate *now1 = [NSDate networkDate];
    
   // NSLog(@"networkTime-%@",netClock.networkTime);
    
    NSDate *now = [NSDate date];
    NSLog(@"device-%@",now);

    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    
    //NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:now]);
    
    
    
    
    
     NSLog(@"The time is %@",[self fetchdate:[[appointmntDetails objectAtIndex:indexPath.row]objectForKey:@"appointment_start_time"]]);
    
     NSLog(@"The time is %@",[self fetchdate:[[appointmntDetails objectAtIndex:indexPath.row]objectForKey:@"appointment_end_time"]]);
    

    
    

    if([[dateFormatter stringFromDate:now] compare:[self fetchdate:[[appointmntDetails objectAtIndex:indexPath.row]objectForKey:@"appointment_start_time"]]]==NSOrderedDescending && [[dateFormatter stringFromDate:now] compare:[self fetchdate:[[appointmntDetails objectAtIndex:indexPath.row]objectForKey:@"appointment_end_time"]]]==NSOrderedAscending&&[[[appointmntDetails objectAtIndex:indexPath.row]objectForKey:@"appointmentStatus"]intValue]==1){
        
        cell.appointmentStatus.text=@"CALL";
        cell.appointmentStatus.textColor=[UIColor colorWithRed:(CGFloat)53/255 green:(CGFloat)183/255 blue:(CGFloat)243/255 alpha:1];
        cell.appointmentStatus.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];
        
    }
         cell.appointmentStatus.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
        
       cell.appointmentTime.text=[NSString stringWithFormat:@"%@ TO %@",[self fetchdate:[[appointmntDetails objectAtIndex:indexPath.row]objectForKey:@"appointment_start_time"]],[self fetchdate:[[appointmntDetails objectAtIndex:indexPath.row]objectForKey:@"appointment_end_time"]]];
    
    
    
    
    
    
    
    
    
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleDefault;
    
 
    return cell;
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return appointmntDetails.count;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    [[NSUserDefaults standardUserDefaults]setObject:[appointmntDetails objectAtIndex:indexPath.row]objectForKey:@""];
    
    NSLog(@"row selected is-->%ld,",indexPath.row);
    
    NSDate *now = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    
   // NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:now]);

    
    if([[dateFormatter stringFromDate:now] compare:[self fetchdate:[[appointmntDetails objectAtIndex:indexPath.row]objectForKey:@"appointment_start_time"]]]==NSOrderedDescending && [[dateFormatter stringFromDate:now] compare:[self fetchdate:[[appointmntDetails objectAtIndex:indexPath.row]objectForKey:@"appointment_end_time"]]]==NSOrderedAscending&&[[[appointmntDetails objectAtIndex:indexPath.row]objectForKey:@"appointmentStatus"]intValue]==1){
        
        [[NSUserDefaults standardUserDefaults]setObject:[[appointmntDetails objectAtIndex:indexPath.row]objectForKey:@"doctor_id"] forKey:@"DoctorNowId"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        
        [[NSUserDefaults standardUserDefaults]setObject:[self fetchdate:[[appointmntDetails objectAtIndex:indexPath.row]objectForKey:@"appointment_start_time"]] forKey:@"callStartTime"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        [[NSUserDefaults standardUserDefaults]setObject:[self fetchdate:[[appointmntDetails objectAtIndex:indexPath.row]objectForKey:@"appointment_end_time"]]forKey:@"callEndTime"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        

        
        
        
        [self videoCall];
        

        
    }
    
  
   
   }


#pragma mark-Video Call
-(void)videoCall{
    
    
    
    //        dispatch_async(dispatch_get_global_queue(0, 0),^{
    //
    //
    //            dispatch_async(dispatch_get_main_queue(),^{
    //
    
    
    
    NSError *error;   NSURLResponse * urlResponse;
    
    NSString * urlStr =[NSString stringWithFormat:fetchQuickBloxDetails];
    NSURL * url =[NSURL URLWithString:urlStr];
    
    NSMutableURLRequest  * request =[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    
    NSString * body =[NSString stringWithFormat:@"patientId=%@&doctorID=%@"
                      ,[[NSUserDefaults standardUserDefaults] objectForKey:@"patientid"],[[NSUserDefaults standardUserDefaults] objectForKey:@"DoctorNowId"]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (!data) {
        return;
    }
    id jsonResponse1 =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
   
    NSLog(@"Chat response-->%@",jsonResponse1);
    
    
    if ([[jsonResponse1 objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
        
        //Save Receiver(Doctors) Quick Blox Creds
        
        [[NSUserDefaults standardUserDefaults]setObject: [[[jsonResponse1 objectForKey:@"data"] objectForKey:@"receiverDetails"] objectForKey:@"qId"] forKey:@"doctorQuickBloxId"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        [[NSUserDefaults standardUserDefaults]setObject: [[[jsonResponse1 objectForKey:@"data"] objectForKey:@"receiverDetails"] objectForKey:@"email"] forKey:@"doctorQuickBloxUserName"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        [[NSUserDefaults standardUserDefaults]setObject: [[[jsonResponse1 objectForKey:@"data"] objectForKey:@"receiverDetails"] objectForKey:@"name"] forKey:@"doctorQuickBloxName"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        // Save Caller(Patient) Quick Blox Creds
        
        
        
        [[NSUserDefaults standardUserDefaults]setObject: [[[jsonResponse1 objectForKey:@"data"] objectForKey:@"callerDetails"] objectForKey:@"qId"] forKey:@"patientQuickBloxId"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults]setObject: [[[jsonResponse1 objectForKey:@"data"] objectForKey:@"callerDetails"] objectForKey:@"name"] forKey:@"patientQuickBloxName"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        
        [[NSUserDefaults standardUserDefaults]setObject: [[[jsonResponse1 objectForKey:@"data"] objectForKey:@"callerDetails"] objectForKey:@"email"] forKey:@"patientQuickBloxEmail"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        

        
        //                        QBUUser *user = ConnectionManager.instance.users[0];
        //
        //
        //                        [self logInChatWithUser:user];
        
        self.navigationController.navigationBar.hidden = YES;
        
        LoginViewController *chatLogin = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"startStoryBoard"];
        
        chatLogin.title=@"Video & Audio Chat";
        
        [self.navigationController pushViewController:chatLogin animated:YES];
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    //            });
    //
    //        });
    
    
    
    
    
    
    
    
    
    
    
    
}





-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
    
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
#pragma mark-Get Patients Appointment Detail
-(void)getAppointment{
    
    
    appointmntDetails=[[NSMutableArray alloc]init];
    
    
        NSError * error;
        NSURLResponse *  urlResponse;
    
    
        NSURL * postUrl =[NSURL URLWithString:getAppointmentDetails];
    
        
        
        NSMutableURLRequest * request =[[NSMutableURLRequest alloc]initWithURL:postUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
        
        NSString * body =[NSString stringWithFormat:@"userId=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"patientid"]];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
        [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        
        NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
        
        if (!data) {
            
            return;
        }
        
        id  json =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
      //  NSLog(@"json %@",json);
        if ([[json objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
            
            response=YES;
            
            NSArray *ar=[json objectForKey:@"data"];
            
            for (int i=0; i<ar.count; i++) {
                
                [appointmntDetails addObject:[ar objectAtIndex:i]];
                
            }
            
        }
        else{
          
            
            response=NO;
            
        }
        
        
    
    
    
    
}
-(NSString*)fetchdate:(NSString *)dateStr{
    
    
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    
    // [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    //
    NSDate *date=[dateFormat dateFromString:dateStr];
    
    
    
    NSDateFormatter *utc=[[NSDateFormatter alloc]init];
    //[utc setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    [utc setTimeZone:[NSTimeZone localTimeZone]];
    //  NSString *utcstr=[utc stringFromDate:date];
    
    [utc setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString * resultDate =[utc stringFromDate:date];
    
    
    return resultDate;
    
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
