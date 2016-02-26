//
//  CalendarViewController.m
//  DoctorsOnDemandCode
//
//  Created by GBS-ios on 8/17/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "CalendarViewController.h"

#import "ApptWindowView.h"
#import "SVProgressHUD.h"

@interface CalendarViewController () < UITextFieldDelegate>{
    NSMutableDictionary *dayDateDict;
    NSMutableArray *dateAr1,*dateAr2;
    NSArray *jsonDate;
    UITableView *appointTableView;
    CGSize screenRect;
    NSString *dateAfterString;
    NSMutableArray *listValueAr;
    int fontSize,headerBtnfont,height;
    NSDateFormatter *dateFormat1 ;
    NSString*cmpDay;
    UIView *backPopUp,*letsGetStartedPopUp;
    

    int count;
    NSString * clickedDate;
    NSString *day ;
    
    UITableView *listTableView;
    
  
     NSMutableDictionary *_eventsByDate;
        
        NSDate *_todayDate;
        NSDate *_minDate;
        NSDate *_maxDate;
    NSArray *sortedArray;
        NSDate *_dateSelected;
    UISegmentedControl *segmentedControl;

    
  UIActivityIndicatorView *activityIndicator;
   // UIView *mainView;
}




@end

@implementation CalendarViewController



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
  
    [self activityAction];
    
    dayDateDict=[[NSMutableDictionary alloc]init];
    dateAr1=[[NSMutableArray alloc]init];
    dateAr2=[[NSMutableArray alloc]init];
    dispatch_async(dispatch_get_global_queue(0, 0),^{
        
        if([SingletonClass networkcheck]==YES){

        
        if([[[NSUserDefaults standardUserDefaults]objectForKey:@"scheduleMethod"]isEqual:@"byDoc"])
            
            
            
            [self fetchDocSchedule];
        else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"scheduleMethod"]isEqual:@"byTime"])
        [self fetchSchedule];
        }
        else
            [self networkWarning];

        
        dispatch_async(dispatch_get_main_queue(),^{
            // [self createUI];
            
            
            segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Calender", @"List", nil]];
            segmentedControl.frame = CGRectMake(10,60,screenRect.width-20, 30);
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
                 segmentedControl.frame = CGRectMake(10,100,screenRect.width-20, 50);
                
                UIFont *font = [UIFont fontWithName:@"GothamRounded-Light" size:25];
                NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                                       forKey:UITextAttributeFont];
                [segmentedControl setTitleTextAttributes:attributes
                                                forState:UIControlStateNormal];
//            segmentedControl setTitle:<#(nullable NSString *)#> forSegmentAtIndex:<#(NSUInteger)#>
//                segmentedControl.
//                
            }

            
            segmentedControl.selectedSegmentIndex = 0;
            segmentedControl.tintColor = [UIColor blueColor];
            [segmentedControl addTarget:self action:@selector(valueChanged) forControlEvents: UIControlEventValueChanged];
            [self.view addSubview:segmentedControl];
            
          

           
//            mainView=[UIView new];
//            mainView.frame=CGRectMake(0, 90, screenRect.width, screenRect.height);
//            [self.view addSubview:mainView];
//            
            
            _calendarManager = [JTCalendarManager new];
            _calendarManager.delegate = self;
            
            
            
            [self createMinAndMaxDate];
            
            
            
            
            _calendarContentView=[JTHorizontalCalendarView new];
            
            
            _calendarContentView.frame = CGRectMake(20,125,[UIScreen mainScreen].bounds.size.width-40 , [UIScreen mainScreen].bounds.size.width-40);
            _calendarContentView.backgroundColor=[UIColor whiteColor];
            
            
           
            
            [_calendarManager setContentView:_calendarContentView];
            [self.view addSubview:_calendarContentView];
            
            
            _calendarMenuView=[JTCalendarMenuView new];
            _calendarMenuView.frame=CGRectMake(20,80,[UIScreen mainScreen].bounds.size.width-40 ,40);
            _calendarMenuView.backgroundColor=[UIColor clearColor];
        
            [self.view addSubview:_calendarMenuView];
            
            
            
            [_calendarManager setMenuView:_calendarMenuView];
            
            [_calendarManager setDate:[NSDate date]];
            
            
            

            
            
            [activityIndicator stopAnimating];
            
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
                
                 _calendarContentView.frame = CGRectMake(40,segmentedControl.frame.origin.y+segmentedControl.frame.size.height+50,[UIScreen mainScreen].bounds.size.width-80 , [UIScreen mainScreen].bounds.size.width-80);
                  _calendarMenuView.frame=CGRectMake(20,segmentedControl.frame.origin.y+segmentedControl.frame.size.height+5,[UIScreen mainScreen].bounds.size.width-40 ,40);
                
                
                
            }
            
            
            [self createUI];
        });
        
        
    });
    
    
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:(BOOL)animated];    // Call the super class implementation.
    
    [appointTableView removeFromSuperview];
    [_calendarContentView removeFromSuperview];
    [_calendarMenuView removeFromSuperview];
    [listTableView removeFromSuperview];
    [segmentedControl removeFromSuperview];
    
//    listValueAr=nil;
//    dayDateDict=nil;
    
    
}



#pragma maark-segment control chaged Value
-(void)valueChanged{
    
    if(segmentedControl.selectedSegmentIndex == 0) {
        
        [listTableView removeFromSuperview];
        
        _calendarManager = [JTCalendarManager new];
        _calendarManager.delegate = self;
        
        
        
        [self createMinAndMaxDate];
        
        
        
        
        _calendarContentView=[JTHorizontalCalendarView new];
        
        
        _calendarContentView.frame = CGRectMake(20,125,[UIScreen mainScreen].bounds.size.width-40 , [UIScreen mainScreen].bounds.size.width-40);
        _calendarContentView.backgroundColor=[UIColor whiteColor];
        
        [_calendarManager setContentView:_calendarContentView];
        [self.view addSubview:_calendarContentView];
        
        
        _calendarMenuView=[JTCalendarMenuView new];
        _calendarMenuView.frame=CGRectMake(20,80,[UIScreen mainScreen].bounds.size.width-40 ,40);
        _calendarMenuView.backgroundColor=[UIColor clearColor];
        [self.view addSubview:_calendarMenuView];
        
        
        
        [_calendarManager setMenuView:_calendarMenuView];
        [_calendarManager setDate:[NSDate date]];
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            
            _calendarContentView.frame = CGRectMake(40,segmentedControl.frame.origin.y+segmentedControl.frame.size.height+50,[UIScreen mainScreen].bounds.size.width-80 , [UIScreen mainScreen].bounds.size.width-80);
            _calendarMenuView.frame=CGRectMake(20,segmentedControl.frame.origin.y+segmentedControl.frame.size.height+5,[UIScreen mainScreen].bounds.size.width-40 ,40);
            
            
            
        }
        [self createUI];

        
        
        
        
    }else if(segmentedControl.selectedSegmentIndex == 1){
        
        listValueAr=[NSMutableArray new];

        // Get the keys
        NSArray *keys = [dayDateDict allKeys];
        
        // Sort the keys
        sortedArray = [NSArray arrayWithArray:[keys sortedArrayUsingComparator:^(NSString* a, NSString* b) {
            return [a compare:b];
        }]];
        
        // Iterate the dictionary
        for (NSUInteger n = 0 ;n < [sortedArray count]; n++) {
            id value = [dayDateDict objectForKey:[sortedArray objectAtIndex:n]];
            [listValueAr addObject:value];
            
        }
        
        NSLog(@"Sorted Array-->%@",sortedArray);
        
        
       
        
        
        
        [appointTableView removeFromSuperview];
        [_calendarContentView removeFromSuperview];
        [_calendarMenuView removeFromSuperview];

    
        [self createListUI];

        
        
        
    }
    
    
    
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    screenRect=[[UIScreen mainScreen]bounds].size;
    
   
    
    
    
    //Create header here
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, [UIScreen mainScreen].bounds.size.width-120, 25)];
    titleLable.text =@"CHOOSE APPOINTMENT";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font =[UIFont fontWithName:@"GothamRounded-Light" size:12];

    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
  [backButton setFrame:CGRectMake(15, 18, 55, 35)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
//
//        UIButton *nextButton =  [UIButton buttonWithType:UIButtonTypeCustom];
//    [nextButton setImage:[UIImage imageNamed:@"next_btn.png"] forState:UIControlStateNormal];
//    [nextButton setFrame:CGRectMake(screenRect.width-60, 30, 45, 15)];
//    [nextButton addTarget:self action:@selector(continueAction) forControlEvents:UIControlEventTouchUpInside];
//    [headerView addSubview:nextButton];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        headerView.frame= CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80);
        titleLable.frame= CGRectMake(60, 25, screenRect.width-120, 35);
        titleLable.font=[UIFont fontWithName:@"GothamRounded-Light" size:26];
        //titleLable.font =[UIFont systemFontOfSize:30];
        [backButton setImage:[UIImage imageNamed:@"back_btn_ipad.png"] forState:UIControlStateNormal];
        [backButton setFrame:CGRectMake(15, 30, 80, 25)];
        
//                [nextButton setImage:[UIImage imageNamed:@"next_btn-ipad.png"] forState:UIControlStateNormal];
//                [nextButton setFrame:CGRectMake(screenRect.width-100, 28, 80, 25)];
        
    }
    
}

    
-(void)continueAction{
    ApptWindowView *apptWindow=[[ApptWindowView alloc]init];
    [self.navigationController pushViewController:apptWindow animated:YES];
}
- (UIView<JTCalendarDay> *)calendarBuildDayView:(JTCalendarManager *)calendar
{
    JTCalendarDayView *view = [JTCalendarDayView new];
    
    
    
    view.textLabel.font = [UIFont fontWithName:@"Arial" size:13];
    view.textLabel.textColor = [UIColor redColor];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
          view.textLabel.font = [UIFont fontWithName:@"GothamRounded-Light" size:25];
    }
    
    return view;
}

    


#
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}




#pragma mark-fetch department schedule on specified date
-(void)fetchSchedule
{
    
     NSError *error;   NSURLResponse * urlResponse;
    
    
    NSURL * url =[NSURL URLWithString:fetchScheduleService];
    
    NSMutableURLRequest  * request =[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    
  
    
    
    
    NSString * body =[NSString stringWithFormat:@"departmentId=%d&timeZone=%@",[SingletonClass sharedSingleton].deptId ,[NSTimeZone localTimeZone].name];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (!data) {
          [SVProgressHUD dismiss];
        return;
    }
    id jsonResponse =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
//    NSLog(@"schedule jason---->%@",jsonResponse);
    
    
   
    
    if ([[jsonResponse objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
        
        NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending: YES];
        
        jsonDate=[[jsonResponse objectForKey:@"data"] sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortOrder]];
        
        
        [self convertTimeStamp];
        
    }
    
}

#pragma mark-Fetch doctors available date
-(void)fetchDocSchedule{
    
    
    NSError *error;   NSURLResponse * urlResponse;
    
    
    NSURL * url =[NSURL URLWithString:doctorsSchedule];
    
    NSMutableURLRequest  * request =[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    
    
    
    
    
    NSString * body =[NSString stringWithFormat:@"doctorId=%@&timeZone=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"doctorid"],[NSTimeZone localTimeZone].name];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (!data) {
        [SVProgressHUD dismiss];
        return;
    }
    id jsonResponse =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
   // NSLog(@"schedule jason---->%@",jsonResponse);
    
    
    
    
    if ([[jsonResponse objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
        
        
        
        jsonDate=[jsonResponse objectForKey:@"data"];
        
        
        [self convertTimeStamp];
        
    }

    
}

#pragma mark-Create UI/Table View
-(void)createUI{
    
    
    
    
    
    
    appointTableView = [[UITableView alloc]init];
    appointTableView.frame =  CGRectMake(10, _calendarContentView.frame.origin.y+_calendarContentView.frame.size.height+10, screenRect.width-20, screenRect.height-( _calendarContentView.frame.origin.y+_calendarContentView.frame.size.height+10));
    appointTableView.delegate = self;
    appointTableView.dataSource = self;
    appointTableView.backgroundColor =[UIColor clearColor];
    appointTableView.showsVerticalScrollIndicator = NO;
    appointTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        
        
        appointTableView.frame=CGRectMake(10, _calendarContentView.frame.origin.y+_calendarContentView.frame.size.height+10, screenRect.width-20, screenRect.height-( _calendarContentView.frame.origin.y+_calendarContentView.frame.size.height+10));

        
        
    }

    [self.view addSubview:appointTableView];
}


#pragma mark-create List UI

-(void)createListUI{
    
    listTableView=[[UITableView alloc]init];
    listTableView.frame=CGRectMake(10, 90 ,screenRect.width-20,screenRect.height-90);
    listTableView.backgroundColor=[UIColor clearColor];
    
    listTableView.layer.borderWidth = 2.0;
    listTableView.layer.borderColor = [UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1].CGColor;
    listTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    listTableView.delegate=self;
    listTableView.dataSource=self;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        
       
         listTableView.frame=CGRectMake(10, segmentedControl.frame.origin.y+segmentedControl.frame.size.height+10,screenRect.width-20,screenRect.height-100);
        
        
    }
    
    [self.view addSubview:listTableView];
    

    
}

#pragma mark-Table delegates


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if(tableView==appointTableView)
    return [[dayDateDict objectForKey:clickedDate] count];
    
    else if (tableView==listTableView){
        
        return [[listValueAr objectAtIndex:section]count];
    }
    else
        return 1;
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(tableView==appointTableView)
    
    
    return 1;
    
    else if (tableView==listTableView)
        return sortedArray.count;
    
    else
        return 0;
}
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    switch (section) {
////        case 0:
////            return str;
////            break;
////            
////        default:
////            break;
//    }
//    return nil;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if(tableView==listTableView)
             return 50;
    }
    
    if(tableView==listTableView)
    return  25;
    else return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(tableView==listTableView){
    
        NSString *sectionTitle =[sortedArray objectAtIndex:section];
    
    
    
    if (sectionTitle == nil) {
        return nil;
    }
    
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 0, screenRect.width, 22);
    //label.backgroundColor = [UIColor lightGrayColor];
    label.textColor = [UIColor whiteColor];
    
    
        label.font = [UIFont fontWithName:@"GothamRounded-Medium" size:12];
    label.text = sectionTitle;
    
    UIView *view = [[UIView alloc] init];
    view.frame=CGRectMake(0, 0, screenRect.width, 22);
    view.backgroundColor = [UIColor lightGrayColor];
    
    [view addSubview:label];
    
    if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()) {
        label.frame = CGRectMake(10, 0, screenRect.width, 50);
        label.font =[UIFont systemFontOfSize:25];
        view.frame=CGRectMake(0, 0, screenRect.width, 50);
    }
    
    return view;
    }
    return nil;
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomTableViewCell * cell =(CustomTableViewCell*) [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[CustomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"calender"];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    UILabel *leftLabel=[UILabel new];
    leftLabel.text=@"Appt\nWindow";
    leftLabel.numberOfLines=2;
    leftLabel.textColor=[UIColor lightGrayColor];
    leftLabel.frame=CGRectMake(cell.containerView.frame.size.width-70, 10, 50, 30);
    leftLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [cell.containerView addSubview:leftLabel];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    
   [dateFormat1 setDateFormat:@"HH:mm:ss"];
    

    
    
    if(tableView==appointTableView){
        
    
    NSDate * aptTime =[dateFormat1 dateFromString:[[dayDateDict objectForKey:clickedDate]objectAtIndex:indexPath.row] ];
    
    NSDate *dateAfter=[aptTime dateByAddingTimeInterval:(1500) ];
    dateAfterString =[dateFormat1 stringFromDate:dateAfter];
    NSString *dis=[NSString stringWithFormat:@"%@-%@",[[dayDateDict objectForKey:clickedDate]objectAtIndex:indexPath.row],dateAfterString];
    cell.appointmentTime.text =dis;
    }
    else
        
    {
       
            
            NSArray *ar=[listValueAr objectAtIndex:indexPath.section];
        
        NSDate * aptTime =[dateFormat1 dateFromString:[ar objectAtIndex:indexPath.row]];

        
        NSDate *dateAfter=[aptTime dateByAddingTimeInterval:(1500) ];
        dateAfterString =[dateFormat1 stringFromDate:dateAfter];
      
        NSString *dis=[NSString stringWithFormat:@"%@-%@",[ar objectAtIndex:indexPath.row],dateAfterString];
       
        cell.appointmentTime.text =dis;

            
//            cell.appointmentTime.text=[ar objectAtIndex:indexPath.row];
        
       // }
            
            
       
    }
    

    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        
         leftLabel.text=@"Appt\nWindow";
        leftLabel.frame=CGRectMake(cell.containerView.frame.size.width-220, 10, 150, 80);
        leftLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:25];

        
        cell.textLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:25];
        
    }
    
    return  cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return  100;
    }
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ApptWindowView *apptWindow=[[ApptWindowView alloc]init];
    [self.navigationController pushViewController:apptWindow animated:YES];
    NSString *dis;
    
    
    
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@ %@",[self convertFormat:clickedDate],[[dayDateDict objectForKey:clickedDate]objectAtIndex:indexPath.row]]forKey:@"appointment_start_time"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
    
    
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@ %@",[self convertFormat:clickedDate],[self convertToUTC:[[dayDateDict objectForKey:clickedDate]objectAtIndex:indexPath.row]]]forKey:@"appointment_start"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
    
    NSDate * aptTime1 =[dateFormat1 dateFromString:[[dayDateDict objectForKey:clickedDate]objectAtIndex:indexPath.row] ];
    NSDate *dateAfter1=[aptTime1 dateByAddingTimeInterval:(1500) ];
    
    
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@ %@",[self convertFormat:clickedDate],[dateFormat1 stringFromDate:dateAfter1]]forKey:@"appointment_end_time"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@ %@",[self convertFormat:clickedDate],[self convertToUTC:[dateFormat1 stringFromDate:dateAfter1]]]forKey:@"appointment_end"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    
    
    
NSLog(@"Appointment End--->%@",[NSString stringWithFormat:@"%@ %@",[self convertFormat:clickedDate],[self convertToUTC:[dateFormat1 stringFromDate:dateAfter1]]]);
    

    
    
    if(tableView==appointTableView){
    
        NSDate * aptTime =[dateFormat1 dateFromString:[[dayDateDict objectForKey:clickedDate]objectAtIndex:indexPath.row] ];
    NSDate *dateAfter=[aptTime dateByAddingTimeInterval:(1500) ];
    dateAfterString =[dateFormat1 stringFromDate:dateAfter];

    
   dis =[NSString stringWithFormat:@"%@ to %@\non %@",[[dayDateDict objectForKey:clickedDate]objectAtIndex:indexPath.row],dateAfterString,day];
        
//        [[NSUserDefaults standardUserDefaults]setObject:[[dayDateDict objectForKey:clickedDate]objectAtIndex:indexPath.row] forKey:@"appointmentStart"];
//        [[NSUserDefaults standardUserDefaults]synchronize];
//        
//        
//        [[NSUserDefaults standardUserDefaults]setObject:dateAfterString forKey:@"appointmentEnd"];
//        [[NSUserDefaults standardUserDefaults]synchronize];

    }
    else{
       
        NSArray *ar=[listValueAr objectAtIndex:indexPath.section];
        
        NSDate * aptTime =[dateFormat1 dateFromString:[ar objectAtIndex:indexPath.row]];
        
        
        NSDate *dateAfter=[aptTime dateByAddingTimeInterval:(1500) ];
        dateAfterString =[dateFormat1 stringFromDate:dateAfter];
        
        
        NSString * resultTime =[sortedArray objectAtIndex:indexPath.section];
        NSLog(@"date is-->%@",resultTime);
        
        NSDateFormatter *dateFormatterForGettingDate = [[NSDateFormatter alloc] init];
        [dateFormatterForGettingDate setDateFormat:@"dd-MM-yyyy"];
        [dateFormatterForGettingDate setLocale:[NSLocale localeWithLocaleIdentifier:@"EN"]];
        dateFormatterForGettingDate.timeZone = [NSTimeZone localTimeZone];
        
        // Parse the string representation of the date i.e Monday 2,Dec 2013
        
        NSDate *dateFromStr = [dateFormatterForGettingDate dateFromString:resultTime];
        NSLog(@"date selected  : %@", [dateFromStr descriptionWithLocale:[NSLocale currentLocale]]);
        NSDateFormatter *tempFormatter=[[NSDateFormatter alloc]init];
        [tempFormatter setDateFormat:@"EEE, MMM dd"];
        
       NSString * finalDay=[tempFormatter stringFromDate:dateFromStr];
       NSLog(@"date Selected : %@",finalDay);
//
     
//
//        NSDateFormatter *dayform = [[NSDateFormatter alloc] init];
//        
//      [dayform setDateFormat:@"dd-MM-YYYY"];
//        
//        NSDate *apptDay=[dayform dateFromString:resultTime];
//    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
//        
//        [dateFormat2 setDateFormat:@"dd-MM-YYYY HH:mm:ss"];
//        
//        NSString * finalDay =[dayform stringFromDate:apptDay];
//        
//       
//
//
//        
       dis =[NSString stringWithFormat:@"%@ to %@\non %@",[ar objectAtIndex:indexPath.row],dateAfterString,finalDay];
        
        
//        [[NSUserDefaults standardUserDefaults]setObject:[ar objectAtIndex:indexPath.row] forKey:@"appointmentStart"];
//        [[NSUserDefaults standardUserDefaults]synchronize];
//        
//        
//        [[NSUserDefaults standardUserDefaults]setObject:dateAfterString forKey:@"appointmentEnd"];
//        [[NSUserDefaults standardUserDefaults]synchronize];
//

    }

    
    [[NSUserDefaults standardUserDefaults]setObject:dis forKey:@"appointmentTime"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
   

    
    
}
#pragma mark-convert timeStamp to date
-(void)convertTimeStamp{
 
 
 
    
    for( NSString*valueForDate in jsonDate){
        
    
 
 NSTimeInterval timeSec=[valueForDate doubleValue];
      NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeSec];
        
        
        NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
        [formatter setLocale:[NSLocale currentLocale]];
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSString *dateString = [formatter stringFromDate:date];
        
        NSDate *finalDate=[formatter dateFromString:dateString];
 
 
// NSLog(@"\ndate are-->%@",finalDate);
 
 [self separateDate:finalDate];
    }
 
 
 
 }
 

 #pragma mark-separate date and Time
 -(void)separateDate:(NSDate*)date1{
 
dateFormat1 = [[NSDateFormatter alloc] init];
 
 
 [dateFormat1 setDateFormat:@"HH:mm:ss"];
 
 NSString * resultTime =[dateFormat1 stringFromDate:date1];
// NSLog(@"date is-->%@",resultTime);
 
 [dateFormat1 setDateFormat:@"dd-MM-YYYY"];
 NSString *resultDay=[dateFormat1 stringFromDate:date1];
 //NSLog(@"day is-->%@",resultDay);
     
     
     
          if([cmpDay isEqual:resultDay] || cmpDay==nil)
            {
         
              if(count!=1){
               [dateAr1 addObject:resultTime];
              }
              if(count==1){
                  
                  [dateAr2 addObject:resultTime];
              }
              
              
              
          }
          else{
              
              count=1;
              
               dateAr2=[[NSMutableArray alloc]init];
               [dateAr2 addObject:resultTime];
          }
     
     cmpDay=resultDay;
 
     
     if(count!=1){
     [dayDateDict setObject:dateAr1 forKey:resultDay];
     }
     else{
     [dayDateDict setObject:dateAr2 forKey:resultDay];
     }
 
   
     
     //NSLog(@"dictionary--->%@",dayDateDict);
     
     
     
 }
#pragma mark - Buttons callback

- (IBAction)didGoTodayTouch
{
    [_calendarManager setDate:_todayDate];
}

- (IBAction)didChangeModeTouch
{
    _calendarManager.settings.weekModeEnabled = !_calendarManager.settings.weekModeEnabled;
    [_calendarManager reload];
    
    CGFloat newHeight = 300;
    if(_calendarManager.settings.weekModeEnabled){
        newHeight = 85.;
    }
    
    self.calendarContentViewHeight.constant = newHeight;
    [self.view layoutIfNeeded];
}

#pragma mark - CalendarManager delegate

// Exemple of implementation of prepareDayView method
// Used to customize the appearance of dayView
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    // Today
    if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor blueColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Selected date
    else if(_dateSelected && [_calendarManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor redColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Other month
    else if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor lightGrayColor];
    }
    // Another day of the current month
    else{
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor blackColor];
    }
    
    if([self haveEventForDay:dayView.date]){
        dayView.dotView.hidden = NO;
    }
    else{
        dayView.dotView.hidden = YES;
    }
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    _dateSelected = dayView.date  ;
    
 //   NSLog(@"orginal Clicked day-->%@",dayView.date);
    
    
    
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
    
            [dateFormat2 setDateFormat:@"dd-MM-YYYY"];
    
            clickedDate =[dateFormat2 stringFromDate:_dateSelected];
    
          //  NSLog(@"Selected date===>%@",clickedDate);
    
    
            NSString* s= [dayDateDict objectForKey:clickedDate];
            //NSLog(@"time is===>%@",s);
    
          //  [dateFormat2 setDateFormat:@"EEE, MMM dd "];
    
           day =[dateFormat2 stringFromDate:_dateSelected];
    
            
          //  NSLog(@"Selected day===>%@",day);

    
    
    // Animation for the circleView
    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView transitionWithView:dayView
                      duration:.3
                       options:0
                    animations:^{
                        dayView.circleView.transform = CGAffineTransformIdentity;
                        [_calendarManager reload];
                    } completion:nil];
    
    
    // Load the previous or next page if touch a day from another month
    
    if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        if([_calendarContentView.date compare:dayView.date] == NSOrderedAscending){
            [_calendarContentView loadNextPageWithAnimation];
        }
        else{
            [_calendarContentView loadPreviousPageWithAnimation];
        }
    }
    
    [appointTableView reloadData];
}

#pragma mark - CalendarManager delegate - Page mangement

// Used to limit the date for the calendar, optional
- (BOOL)calendar:(JTCalendarManager *)calendar canDisplayPageWithDate:(NSDate *)date
{
    return [_calendarManager.dateHelper date:date isEqualOrAfter:_minDate andEqualOrBefore:_maxDate];
}

- (void)calendarDidLoadNextPage:(JTCalendarManager *)calendar
{
    //    NSLog(@"Next page loaded");
}

- (void)calendarDidLoadPreviousPage:(JTCalendarManager *)calendar
{
    //    NSLog(@"Previous page loaded");
}

#pragma mark - Fake data

- (void)createMinAndMaxDate
{
    _todayDate = [NSDate date];
    
    // Min date will be 2 month before today
    _minDate = [_calendarManager.dateHelper addToDate:_todayDate months:-3];
    
    // Max date will be 2 month after today
    _maxDate = [_calendarManager.dateHelper addToDate:_todayDate months:3];
}

// Used only to have a key for _eventsByDate
//- (NSDateFormatter *)dateFormatter
//{
//    
//    return dateFormatter;
//}

- (BOOL)haveEventForDay:(NSDate *)date
{
//    if(i>=[dayDateDict allKeys].count){
//        i=0;
//    }
    NSDateFormatter *dateFormatter;
    
    dateFormatter = [[NSDateFormatter alloc]init];
     [dateFormatter setDateFormat:@"dd-MM-YYYY"];
   
    

    NSString *key = [dateFormatter stringFromDate:date];
    
 
   
//    while(i<[dayDateDict allKeys].count){
//    if([key isEqual:[[dayDateDict allKeys]objectAtIndex:i]]){
//            i++;
    if ([[dayDateDict allKeys]containsObject:key]) {
        return YES;
    }
    

  
    
        return NO;
   
    
        
    
    
    
}

//- (void)createRandomEvents
//{
//    _eventsByDate = [NSMutableDictionary new];
//    
//    for(int i = 0; i < 30; ++i){
//        // Generate 30 random dates between now and 60 days later
//        NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];
//        
//        // Use the date as key for eventsByDate
//        NSString *key = [[self dateFormatter] stringFromDate:randomDate];
//        
//        if(!_eventsByDate[key]){
//            _eventsByDate[key] = [NSMutableArray new];
//        }
//        
//        [_eventsByDate[key] addObject:randomDate];
//    }
//}
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

-(NSString*)convertToUTC:(NSString *)timming{
    
    
    
    // Convert string to date object
    
    
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:@"HH:mm:ss"];
    [dateFormat setTimeZone:[NSTimeZone localTimeZone]];
    
    // [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    //
    NSDate *date=[dateFormat dateFromString:timming];
    
    
    
    NSDateFormatter *utc=[[NSDateFormatter alloc]init];
    //[utc setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    [utc setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    //  NSString *utcstr=[utc stringFromDate:date];
    
    [utc setDateFormat:@"HH:mm:ss"];
    
    NSString * resultDate =[utc stringFromDate:date];
    
    
    return resultDate;
    
}


-(NSString*)convertFormat:(NSString *)time{
    
    
    
    // Convert string to date object
    
    
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    //[dateFormat setTimeZone:[NSTimeZone localTimeZone]];
    
    // [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    //
    NSDate *date=[dateFormat dateFromString:time];
    
    
    
    NSDateFormatter *utc=[[NSDateFormatter alloc]init];
    //[utc setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
   // [utc setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    //  NSString *utcstr=[utc stringFromDate:date];
    
    [utc setDateFormat:@"yyyy-MM-dd"];
    
    NSString * resultDate =[utc stringFromDate:date];
    
    
    return resultDate;
    
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



