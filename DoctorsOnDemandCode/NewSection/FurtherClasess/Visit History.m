//
//  Visit History.m
//  DoctorsOnDemandCode
//
//  Created by Sumit Ghosh on 23/01/16.
//  Copyright © 2016 GLB-163. All rights reserved.
//

#import "Visit History.h"
#import "CustomTableViewCell.h"
#import "MTViewController.h"
#import "SingletonClass.h"

#import "MTViewController.h"
#define kPadding 50

@interface Visit_History ()  {
   CGSize _pageSize;
    CGSize screenRect;
      UIActivityIndicatorView *activityIndicator;
       UITableView *psychologistTableView;
       UIView *letsGetStartedPopUp,*backPopUp;
    UIButton *letsGoButton;
    UILabel* noneShedule;

    NSMutableArray *jsonArray;
}


@end

@implementation Visit_History- (void)viewDidLoad {
    [super viewDidLoad];
    
   

    
    self.navigationController.navigationBar.hidden = YES;
    
    screenRect=[[UIScreen mainScreen]bounds].size;
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    
    
    
    
    titleLable.text=@"Appt History";
    
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font =[UIFont fontWithName:@"GothamRounded-Light" size:15];
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
    [backButton setFrame:CGRectMake(15, 18, 55, 35)];    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];

  
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self activityAction];
     jsonArray=[[NSMutableArray alloc]init];
       dispatch_async(dispatch_get_global_queue(0, 0),^{
        
        
          if([SingletonClass networkcheck]==YES)
        [self myhistory];
           else
               [self networkWarning];
        dispatch_async(dispatch_get_main_queue(),^{
         
            if(jsonArray.count==0)
                [self noAppointment];
                else
                [self createUI];
            
            [activityIndicator stopAnimating];
        });
        
    });
    
    
    
}
- (void)viewDidDisappear:(BOOL)animated {
   [super viewDidAppear:YES];
    [psychologistTableView removeFromSuperview];
    [noneShedule removeFromSuperview];
    
    // Call the super class implementation.
}

-(void)noAppointment{
    
    
    noneShedule=[[UILabel alloc]initWithFrame:CGRectMake(0,70, screenRect.width, 30)];
    noneShedule.textAlignment=NSTextAlignmentCenter;
    noneShedule.text=@"No Reports";
    noneShedule.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
    noneShedule.textColor=[UIColor blackColor];
    [self.view addSubview:noneShedule];
    
    
}
-(void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
    [self.view addSubview:psychologistTableView];
    
    
    
    
    
    
}

-(UITableViewCell *)tableView:(UITableView * )tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    CustomTableViewCell * cell =(CustomTableViewCell*) [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        
        cell = [[CustomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AppointmentHistory"];
        cell.backgroundColor = [UIColor clearColor];
        
        //int stringHeight=[self calculateHeight:[[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"doctorAbout"]];
        
        cell.containerView.frame = CGRectMake(0, 5, psychologistTableView.frame.size.width, 95);
        cell.containerView.backgroundColor = [UIColor whiteColor];
        cell.containerView.layer.shadowColor = [UIColor blackColor].CGColor;
        cell.containerView.layer.shadowOffset = CGSizeMake(0, 0);
        cell.containerView.layer.shadowOpacity = 0.5;
        cell.containerView.layer.shadowRadius = 1;
        cell.containerView.layer.shadowPath = [UIBezierPath bezierPathWithRect:cell.containerView.bounds].CGPath;
        
        
        
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
        if (jsonArray.count != 0) {
          
                // cell.pharmacyName.text
                NSString *fName=[[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"FirstName"];
                NSString *lName=[[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"LastName"];
            
            
            NSString *appointmentStart=[[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"appointment_start_time"];
            NSString *appointmentEnd=[[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"appointment_end_time"];
                
                
            cell.pharmacyName.text=[NSString stringWithFormat:@"Dr.%@ %@",fName,lName];
            cell.pharmacyPhNo.text=[NSString stringWithFormat:@"%@-%@",appointmentStart,appointmentEnd];
            
            
                
            
               
                
                
        }
    }
    
      
    
    cell.leftColorView.frame = CGRectMake(0, 1,5,cell.containerView.frame.size.height-1);
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([ jsonArray count] ==0){
        return 0;
    }
    else {
        
        return [jsonArray count];
    }
    
    // return jsonArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return 100;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
  

    
    
    if([[[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"patientFirstName"]isEqual:[NSNull null]]||[[[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"patientFirstName"]isEqual:@""]||[[[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"patientFirstName"]isEqual:@"(null)"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"PatientFNameAppF"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    else{
        
        
        [[NSUserDefaults standardUserDefaults]setObject:[[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"patientFirstName"] forKey:@"PatientFNameAppF"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }
    
    
    if([[[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"patientLastName"]isEqual:[NSNull null]]||[[[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"patientLastName"]isEqual:@""]||[[[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"patientLastName"]isEqual:@"(null)"]){
        
        
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"PatientLNamePDF"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        
    }else{
        [[NSUserDefaults standardUserDefaults]setObject:[[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"patientLastName"] forKey:@"PatientLNamePDF"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }
    if([[[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"patientAddress"]isEqual:[NSNull null]]||[[[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"patientAddress"]isEqual:@""]||[[[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"patientAddress"]isEqual:@"(null)"]){
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"PatientAddressPDF"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }else{
        [[NSUserDefaults standardUserDefaults]setObject:[[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"patientAddress"] forKey:@"PatientAddressPDF"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    

    
    
    
    [[NSUserDefaults standardUserDefaults]setObject:[[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"patientDateOfBirth"]forKey:@"PatientDOBPDF" ];
       [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    [[NSUserDefaults standardUserDefaults]setObject:[[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"FirstName"]forKey:@"DoctorsFirstName" ];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    [[NSUserDefaults standardUserDefaults]setObject:[[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"LastName"]forKey:@"DoctorsLastName" ];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
    [[NSUserDefaults standardUserDefaults]setObject:[[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"appointmentId"]forKey:@"AppointmentID" ];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
    [[NSUserDefaults standardUserDefaults]setObject:[[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"instructions"]forKey:@"DocInstruction" ];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    [[NSUserDefaults standardUserDefaults]setObject:[[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"medicationsReport"]forKey:@"PatientReport" ];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
   
    
//    MTViewController *PDF=[[MTViewController alloc]init];
//    [self.navigationController pushViewController:PDF animated:YES];
    
    [self didClickMakePDF];
    [self didClickOpenPDF];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-PDF generation
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)didClickOpenPDF {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pdfPath = [documentsDirectory stringByAppendingPathComponent:@"NewPDF.pdf"];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:pdfPath]) {
        
        ReaderDocument *document = [ReaderDocument withDocumentFilePath:pdfPath password:nil];
        
        
        if (document != nil)
        {
            ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
            readerViewController.delegate = self;
            
            readerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
            
            [self presentViewController:readerViewController animated:YES completion:nil];
        }
    }
}

- (void)didClickMakePDF {
    [self setupPDFDocumentNamed:@"NewPDF" Width:595 Height:842];//595x842
    [self beginPDFPage];
    [self addImageWithRect:[UIImage imageNamed:@"logo.png"] inRect:CGRectMake([UIScreen mainScreen].bounds.size.width/4, kPadding, [UIScreen mainScreen].bounds.size.width, 80)];
    
    
    CGRect headerLbl=  [self addText:[NSString stringWithFormat:@""]
                           withFrame:CGRectMake(kPadding, kPadding+60, 400, 200) fontSize:40];
    
    CGRect line= [self addLineWithFrame:CGRectMake(kPadding, headerLbl.origin.y + headerLbl.size.height+20, _pageSize.width - kPadding*2, 4)
                              withColor:[UIColor blueColor]];
    
    
    
    CGRect name= [self addText:[NSString stringWithFormat:@"Name: %@ %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"PatientFNameAppF"],[[NSUserDefaults standardUserDefaults] objectForKey:@"PatientLNamePDF"]]
                     withFrame:CGRectMake(kPadding, line.origin.y + line.size.height+20, 400, 200) fontSize:23];
    
    CGRect add=   [self addText:[NSString stringWithFormat:@"Address: %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"PatientAddressPDF"]]
                      withFrame:CGRectMake(kPadding,name.origin.y + name.size.height+20,400, 200) fontSize:23];
    
    CGRect dateOfBirth= [self addText:[NSString stringWithFormat:@"Date Of Birth: %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"PatientDOBPDF"]]
                            withFrame:CGRectMake(kPadding,add.origin.y + add.size.height+20, 400,200) fontSize:23];
    
    CGRect docName=    [self addText:[NSString stringWithFormat:@"Appointment ID: %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"AppointmentID"]]
                           withFrame:CGRectMake(kPadding, dateOfBirth.origin.y + dateOfBirth.size.height+20 ,400, 200) fontSize:23];
    
    
    CGRect textRect = [self addText:[NSString stringWithFormat:@"Doctor Name:%@ %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"DoctorsFirstName"],[[NSUserDefaults standardUserDefaults] objectForKey:@"DoctorsLastName"]]
                          withFrame:CGRectMake(kPadding, docName.origin.y + docName.size.height+20, 400, 200) fontSize:23];
    
    CGRect blueLineRect = [self addLineWithFrame:CGRectMake(kPadding, textRect.origin.y + textRect.size.height +20, _pageSize.width - kPadding*2, 4)
                                       withColor:[UIColor blueColor]];
    
    //    UIImage *anImage = [UIImage imageNamed:@"tree.jpg"];
    //    CGRect imageRect = [self addImage:anImage
    //                              atPoint:CGPointMake((_pageSize.width/2)-(anImage.size.width/2), blueLineRect.origin.y + blueLineRect.size.height + kPadding)];
    
    
    
    CGRect medicalReport=  [self addText:[NSString stringWithFormat:@"Medical Report:"]
                               withFrame:CGRectMake(kPadding, blueLineRect.origin.y + blueLineRect.size.height+30 , 400, 200) fontSize:26];
    
    
    CGRect  report=  [self addText:[[NSUserDefaults standardUserDefaults] objectForKey:@"PatientReport"]
                         withFrame:CGRectMake(kPadding, medicalReport.origin.y + medicalReport.size.height , 400, 200) fontSize:20];
    
    
    CGRect instruct= [self addText:[NSString stringWithFormat:@"Doctor's Instruction:"]
                         withFrame:CGRectMake(kPadding, report.origin.y + report.size.height+30 , 400, 200) fontSize:26];
    
    
    [self addText:[[NSUserDefaults standardUserDefaults] objectForKey:@"DocInstruction"]
        withFrame:CGRectMake(kPadding, instruct.origin.y + instruct.size.height , 400, 200) fontSize:20];
    
    
    
    //    [self addLineWithFrame:CGRectMake(kPadding, imageRect.origin.y + imageRect.size.height + kPadding, _pageSize.width - kPadding*2, 4)
    //                 withColor:[UIColor redColor]];
    
    [self finishPDF];

    
}

- (void)setupPDFDocumentNamed:(NSString*)name Width:(float)width Height:(float)height {
    _pageSize = CGSizeMake(width, height);
    
    NSString *newPDFName = [NSString stringWithFormat:@"%@.pdf", name];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *pdfPath = [documentsDirectory stringByAppendingPathComponent:newPDFName];
    
    UIGraphicsBeginPDFContextToFile(pdfPath, CGRectZero, nil);
}

- (void)beginPDFPage {
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, _pageSize.width, _pageSize.height), nil);
}

- (void)finishPDF {
    UIGraphicsEndPDFContext();
}

- (CGRect)addText:(NSString*)text withFrame:(CGRect)frame fontSize:(float)fontSize {
   UIFont *font = [UIFont systemFontOfSize:fontSize];
    
    CGSize stringSize = [text sizeWithFont:font constrainedToSize:CGSizeMake(_pageSize.width - 2*20-2*20, _pageSize.height - 2*20 - 2*20) lineBreakMode:UILineBreakModeWordWrap];
    
    float textWidth = frame.size.width;
    
    if (textWidth < stringSize.width)
        textWidth = stringSize.width;
    if (textWidth > _pageSize.width)
        textWidth = _pageSize.width - frame.origin.x;
    
    CGRect renderingRect = CGRectMake(frame.origin.x, frame.origin.y, textWidth, stringSize.height);
    
    [text drawInRect:renderingRect
            withFont:[UIFont fontWithName:@"GothamRounded-Medium" size:fontSize]

       lineBreakMode:UILineBreakModeWordWrap
           alignment:UITextAlignmentLeft];
    
    frame = CGRectMake(frame.origin.x, frame.origin.y, textWidth, stringSize.height);
    
    return frame;
}
- (CGRect)addTextHeader:(NSString*)text withFrame:(CGRect)frame fontSize:(float)fontSize {
   UIFont *font = [UIFont systemFontOfSize:fontSize];
    
    CGSize stringSize = [text sizeWithFont:font constrainedToSize:CGSizeMake(_pageSize.width - 2*20-2*20, _pageSize.height - 2*20 - 2*20) lineBreakMode:UILineBreakModeWordWrap];
    
    float textWidth = frame.size.width;
    
    if (textWidth < stringSize.width)
        textWidth = stringSize.width;
    if (textWidth > _pageSize.width)
        textWidth = _pageSize.width - frame.origin.x;
    
    CGRect renderingRect = CGRectMake(frame.origin.x, frame.origin.y, textWidth, stringSize.height);
    
    [text drawInRect:renderingRect
            withFont:font
       lineBreakMode:UILineBreakModeWordWrap
           alignment:UITextAlignmentLeft];
    
    frame = CGRectMake(frame.origin.x, frame.origin.y, textWidth, stringSize.height);
    
    return frame;
}

- (CGRect)addLineWithFrame:(CGRect)frame withColor:(UIColor*)color {
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(currentContext, color.CGColor);
    
    // this is the thickness of the line
    CGContextSetLineWidth(currentContext, frame.size.height);
    
    CGPoint startPoint = frame.origin;
    CGPoint endPoint = CGPointMake(frame.origin.x + frame.size.width, frame.origin.y);
    
    CGContextBeginPath(currentContext);
    CGContextMoveToPoint(currentContext, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(currentContext, endPoint.x, endPoint.y);
    
    CGContextClosePath(currentContext);
    CGContextDrawPath(currentContext, kCGPathFillStroke);
    
    return frame;
}

- (CGRect)addImage:(UIImage*)image atPoint:(CGPoint)point {
    CGRect imageFrame = CGRectMake(point.x, point.y, image.size.width, image.size.height);
    [image drawInRect:imageFrame];
    
    return imageFrame;
}

- (void)dismissReaderViewController:(ReaderViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
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

#pragma MYVisit History Service
-(void)myhistory{
    NSError *error;
    NSURLResponse * urlResponse;
    
    NSString * urlStr =[NSString stringWithFormat:appointmentHistory];
    NSURL * url =[NSURL URLWithString:urlStr];
    
    NSMutableURLRequest  * request =[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
 
    NSString * body =[NSString stringWithFormat:@"userId=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"patientid"]];
    
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
    
    
  //  NSLog(@"Delete pharem--%@",jsonResponse);
    
    
    if ([[jsonResponse objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
        
        NSArray * arr =[jsonResponse objectForKey:@"data"];
        for (int i=0; i<arr.count; i++) {
            [jsonArray addObject:[arr objectAtIndex:i]];
            
        }

        
        
    }
    
    

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
    [okButton addTarget:self action:@selector(okAction1) forControlEvents:UIControlEventTouchUpInside];
    okButton.layer.cornerRadius=6.0f;
    
    [letsGetStartedPopUp addSubview:okButton];
    
}

-(void)okAction1{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        letsGetStartedPopUp.frame=CGRectMake(30, 700, self.view.frame.size.width-60, self.view.frame.size.height-60);
        backPopUp.frame = CGRectMake(0,800, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }completion:^(BOOL finished){
        [backPopUp removeFromSuperview];
        
    }];
    
    
}
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
-(void)addImageWithRect:(UIImage *)image inRect:(CGRect)rect{
    UIImage *newImage = [self imageWithImage:image scaledToSize:CGSizeMake(rect.size.width, rect.size.height)];
    
    [newImage drawInRect:rect];
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
