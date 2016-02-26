//
//  VideoVisitVC.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 10/14/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "VideoVisitVC.h"

@interface VideoVisitVC ()
{
    CGSize screenRect;
    UIScrollView *myScroll;
    UILabel *mainLabel,*subLabel;
}
@end

@implementation VideoVisitVC

- (void)viewDidLoad {
    [super viewDidLoad];

    screenRect=[[UIScreen mainScreen]bounds].size;
        self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    titleLable.text =@"Vedio Visit";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font =[UIFont fontWithName:@"GothamRounded-Light" size:14];
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
   [backButton setFrame:CGRectMake(15, 18, 55, 35)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
    
    myScroll = [[UIScrollView alloc] init];
    myScroll.frame = CGRectMake(0, 55, screenRect.width, screenRect.height);
    
    //myScroll.contentSize = CGSizeMake(320, screenRect.height+100);
    myScroll.backgroundColor = [UIColor clearColor];
    
    myScroll.showsVerticalScrollIndicator = YES;    // to hide scroll indicators!
    
    myScroll.scrollEnabled = YES;                 //say "NO" to disable scroll
    
    
    [self.view addSubview:myScroll];               //adding to parent view!
    
    
    UIImageView *logoView = [[UIImageView alloc]init];
    logoView.frame = CGRectMake(0, 0, screenRect.width, 160);
    
    
    logoView.image=[UIImage imageNamed:@"medical_img_back.png"];
    [logoView setContentMode:UIViewContentModeScaleAspectFit];
    
    //[logoView sizeToFit];
    
    [myScroll addSubview:logoView];

    
    [self createUi];
    
    
// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-Create UI
-(void)createUi{
    
    
    
    
    
    
   mainLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 170,screenRect.width, 30)];
    mainLabel.text=@"What is a Video Visit?";
    mainLabel.textColor=[UIColor blackColor];
    //mainLabel.textAlignment=NSTextAlignmentCenter;
    mainLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:16];
    [myScroll addSubview:mainLabel];
    
    subLabel=[[UILabel alloc]init];
    
    subLabel.text=@"Doctor On Demand Video Visits allow our physicians, psychologists and lactation consultants to provide focused care - without you having to leave your home. With Video,they can Look, Listen, Examine and Engage with you to diagnose your issues and provide an effective treatment plan.";
    CGFloat height1=[self calculateHeight:subLabel.text];
     subLabel.frame=CGRectMake(10,200,screenRect.width-20,height1);
    subLabel.textColor=[UIColor blackColor];
    subLabel.numberOfLines=9;
    subLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [myScroll addSubview:subLabel];
    
   
    mainLabel=[[UILabel alloc]init] ;
    
    mainLabel.text=@"How do your Medical Doctors make a diagnosis?";
    CGFloat height2=[self calculateHeight:mainLabel.text];
mainLabel.frame= CGRectMake(10,210+height1,screenRect.width-20, height2);
    mainLabel.textColor=[UIColor blackColor];
    mainLabel.numberOfLines=2;
    mainLabel.font=[UIFont fontWithName:@"GothamRounded-Bold" size:12];
    [myScroll addSubview:mainLabel];
    
    
    subLabel=[[UILabel alloc]init];
    subLabel.text=@"Doctors use two main skills to diagnose most common medical conditions: looking and listening. Through Doctor on Demand, each provider will determine if a focused or more comprehensive medical history needs to be performed. The provider will also perform a remote physical examination to ensure that your visit achieves the same level of quality as an in-person visit. Many of the most common ER cases can actually be treated by Video Visit, but your provider may recommend that you see a physician in person if he or she feels that is in your best interest.";
    CGFloat height3=[self calculateHeight:subLabel.text];
    subLabel.frame=CGRectMake(10,220+height1+height2,screenRect.width-20,height3);
    subLabel.textColor=[UIColor blackColor];
    subLabel.numberOfLines=15;
    subLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [myScroll addSubview:subLabel];
    
    
    mainLabel=[[UILabel alloc]init] ;
    mainLabel.text=@"How does a Video Visit with a Psychologist\nwork?";
    CGFloat height4=[self calculateHeight:mainLabel.text];
    mainLabel.frame= CGRectMake(10,230+height1+height2+height3,screenRect.width-20, height4);
    mainLabel.textColor=[UIColor blackColor];
     mainLabel.numberOfLines=3;
    mainLabel.font=[UIFont fontWithName:@"GothamRounded-Bold" size:12];
    [myScroll addSubview:mainLabel];
    
    subLabel=[[UILabel alloc]init];
    subLabel.text=@"Doctor On Demand lets you meet with your therapist via Video Visit from the comfort of home; no traveling to an unfamiliar office or time lost getting there. It's the same face-to-face therapy, but on your terms, and at your comfort level.";
    CGFloat height5=[self calculateHeight:subLabel.text];
    subLabel.frame=CGRectMake(10,240+height1+height2+height3+height4,screenRect.width-20,height5);
    subLabel.textColor=[UIColor blackColor];
    subLabel.numberOfLines=10;
    subLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [myScroll addSubview:subLabel];
    

    
    mainLabel=[[UILabel alloc]init] ;
    mainLabel.text=@"How do Medical Doctors treat children through Doctor On Demand?";
    CGFloat height6=[self calculateHeight:mainLabel.text];
    mainLabel.frame= CGRectMake(10,250+height1+height2+height3+height4+height5,screenRect.width-20, height6);
    mainLabel.textColor=[UIColor blackColor];
    mainLabel.numberOfLines=3;
    mainLabel.font=[UIFont fontWithName:@"GothamRounded-Bold" size:12];
    [myScroll addSubview:mainLabel];
    
    
    subLabel=[[UILabel alloc]init];
    subLabel.text=@"Many parents use Doctor On Demand for themselves, but wonder how it would work for their child. Our Medical Doctors are trained to provide care through Video Visits employing many of the same practices and techniques that are used in a traditional doctor's office. Parents, please be sure to indicate that you are calling on behalf of your child during the patient intake.";
    CGFloat height7=[self calculateHeight:subLabel.text];
    subLabel.frame=CGRectMake(10,260+height1+height2+height3+height4+height5+height6,screenRect.width-20,height7+10);
    subLabel.textColor=[UIColor blackColor];
    subLabel.numberOfLines=10;
    subLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [myScroll addSubview:subLabel];
    
    mainLabel=[[UILabel alloc]init] ;
    mainLabel.text=@"How can a Lactation Consultant help a new mom via Video?";
    CGFloat height8=[self calculateHeight:mainLabel.text];
    mainLabel.frame= CGRectMake(10,270+height1+height2+height3+height4+height5+height6+height7,screenRect.width-20, height8);
    mainLabel.textColor=[UIColor blackColor];
    mainLabel.numberOfLines=3;
    mainLabel.font=[UIFont fontWithName:@"GothamRounded-Bold" size:12];
    [myScroll addSubview:mainLabel];
    
    
    subLabel=[[UILabel alloc]init];
    subLabel.text=@"The basic structure of a Video Visit with a Lactation Consultant is very similar to what you would experience in person. The Lactation Consultant would discuss mom's concerns and questions, then walk her through the solutions. Using the hi-resolution camera through video the Lactation Consultant can inspect any issues with her nipples, the baby's latch and more, just like in person. The added benefit with Doctor on Demand is knowing that you're visiting with an International Board Certified Lactation Consultant (IBCLC), the highest trained lactation consultants.";
    CGFloat height9=[self calculateHeight:subLabel.text];
    subLabel.frame=CGRectMake(10,280+height1+height2+height3+height4+height5+height6+height7+height8,screenRect.width-20,height9);
    subLabel.textColor=[UIColor blackColor];
    subLabel.numberOfLines=15;
    subLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [myScroll addSubview:subLabel];
    

    



    float sizeOfContent = 0;
    UIView *lLast = [myScroll.subviews lastObject];
    NSInteger wd = lLast.frame.origin.y;
    NSInteger ht = lLast.frame.size.height;
    NSInteger offset=50;
    sizeOfContent = wd+ht;
    myScroll.contentSize=CGSizeMake(screenRect.width,sizeOfContent+offset+10);
    
    
    
  //  [self test];
}

-(void)test{
   NSError * error ;
        NSURLResponse * urlResponse;
        
        NSURL * postUrl =[NSURL URLWithString:@"http://api.dod.globusapps.com/autoallocatedoctor"];
    
        NSString * body =[NSString stringWithFormat:@"appointmentStartTime=01:23:00&appointmentEndTime=10:34:00&patientId=59&departmentId=2"];
        
              
        NSMutableURLRequest * request =[[NSMutableURLRequest alloc]initWithURL:postUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
        
        NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
        if (!data) {
            
            return;
        }
        
        id json =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        NSLog(@"json %@",json);
        if ([[json objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
            
            
            
        }
        
  
    

}
#pragma mark-back Action
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark-height of string
-(CGFloat)calculateHeight:(NSString *)stringData
{
    UILabel * lblDescription=[[UILabel alloc]init];
    // lblDescription.font=[UIFont systemFontOfSize:10];
    lblDescription.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    // Create a paragraph style with the desired line break mode
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    // Create the attributes dictionary with the font and paragraph style
    NSDictionary *attributes = @{
                                 NSFontAttributeName:lblDescription.font,
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    
    // Call boundingRectWithSize:options:attributes:context for the string
    CGRect textRect = [stringData boundingRectWithSize:CGSizeMake(screenRect.width-20,6000)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:attributes
                                               context:nil];
    
    float height = textRect.size.height;
    // NSLog(@"height of row %f",height);
    return height;
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
