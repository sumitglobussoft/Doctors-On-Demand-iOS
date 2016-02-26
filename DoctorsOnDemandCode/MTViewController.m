//
//  MTViewController.m
//  PDFViewer
//
//  Created by C. A. Beninati on 5/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MTViewController.h"
#define kPadding 50

@interface MTViewController ()
{
    CGSize _pageSize;
    CGSize screenRect;
    
    UIButton *nextButton;

}
@end

@implementation MTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [super viewDidLoad];screenRect = [[UIScreen mainScreen] bounds].size;
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    titleLable.text =@"PDF";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
    [backButton setFrame:CGRectMake(15, 18, 55, 35)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
//    nextButton =  [UIButton buttonWithType:UIButtonTypeCustom];
//    [nextButton setImage:[UIImage imageNamed:@"next_btn.png"] forState:UIControlStateNormal];
//    [nextButton setFrame:CGRectMake(screenRect.width-60, 28, 45, 25)];    [nextButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
//    [headerView addSubview:nextButton];
    
    
    
    
    
    

    
    [self didClickMakePDF];
     [self didClickOpenPDF];
    
//    NSData *myFile = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"your_url"]];
//    [myFile writeToFile:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"yourfilename.pdf"] atomically:YES];
	
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}
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
   [self setupPDFDocumentNamed:@"NewPDF" Width:850 Height:1100];
    [self beginPDFPage];
    
    
    NSLog(@"First Name-%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"PatientFNamePDF"]);
    
    
  CGRect headerLbl=  [self addTextHeader:[NSString stringWithFormat:@"Prescription:"]
        withFrame:CGRectMake(kPadding, kPadding, 400, 200) fontSize:40];
    
   CGRect line= [self addLineWithFrame:CGRectMake(kPadding, headerLbl.origin.y + headerLbl.size.height+20, _pageSize.width - kPadding*2, 4)
                                       withColor:[UIColor blueColor]];


    
   CGRect name= [self addText:[NSString stringWithFormat:@"Name: %@ %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"PatientFNamePDF"],[[NSUserDefaults standardUserDefaults] objectForKey:@"PatientLNamePDF"]]
                          withFrame:CGRectMake(kPadding, line.origin.y + line.size.height+20, 400, 200) fontSize:25];
    
CGRect add=   [self addText:[NSString stringWithFormat:@"Address: %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"PatientAddressPDF"]]
                           withFrame:CGRectMake(kPadding,name.origin.y + name.size.height+20,400, 200) fontSize:25];
    
  CGRect dateOfBirth= [self addText:[NSString stringWithFormat:@"Date Of Birth: %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"PatientDOBPDF"]]
                          withFrame:CGRectMake(kPadding,add.origin.y + add.size.height+20, 400,200) fontSize:25];
    
   CGRect apptId= [self addText:[NSString stringWithFormat:@"Appointment ID: %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"AppointmentID"]]
                          withFrame:CGRectMake(kPadding, dateOfBirth.origin.y + dateOfBirth.size.height+20 ,400, 200) fontSize:25];
    
  
    CGRect textRect = [self addText:[NSString stringWithFormat:@"Doctor Name:%@ %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"DoctorsFirstName"],[[NSUserDefaults standardUserDefaults] objectForKey:@"DoctorsLastName"]]
                          withFrame:CGRectMake(kPadding, apptId.origin.y + apptId.size.height+20, 400, 200) fontSize:25];
    
    CGRect blueLineRect = [self addLineWithFrame:CGRectMake(kPadding, textRect.origin.y + textRect.size.height +20, _pageSize.width - kPadding*2, 4)
                                       withColor:[UIColor blueColor]];
    
//    UIImage *anImage = [UIImage imageNamed:@"tree.jpg"];
//    CGRect imageRect = [self addImage:anImage 
//                              atPoint:CGPointMake((_pageSize.width/2)-(anImage.size.width/2), blueLineRect.origin.y + blueLineRect.size.height + kPadding)];
    
    
    
  CGRect medicalReport=  [self addText:[NSString stringWithFormat:@"Medical Report:"]
        withFrame:CGRectMake(kPadding, blueLineRect.origin.y + blueLineRect.size.height+30 , 400, 200) fontSize:35];
    
    
   CGRect  report=  [self addText:[[NSUserDefaults standardUserDefaults] objectForKey:@"PatientReport"]
        withFrame:CGRectMake(kPadding, medicalReport.origin.y + medicalReport.size.height+30 , 400, 200) fontSize:25];
    
    
   CGRect instruct= [self addText:[NSString stringWithFormat:@"Doctor's Instruction:"]
        withFrame:CGRectMake(kPadding, report.origin.y + report.size.height+30 , 400, 200) fontSize:35];
    
    
    [self addText:[[NSUserDefaults standardUserDefaults] objectForKey:@"DocInstruction"]
        withFrame:CGRectMake(kPadding, instruct.origin.y + instruct.size.height+30 , 400, 200) fontSize:25];

    
    
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
            withFont:font
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
           alignment:UITextAlignmentCenter];
    
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

@end
