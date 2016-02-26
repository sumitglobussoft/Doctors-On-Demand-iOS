//
//  ItWorksSubVC.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 10/17/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "ItWorksSubVC.h"

@interface ItWorksSubVC (){
    CGSize screenRect;
    UIScrollView *myScroll;
    UILabel*  header,*heading;
    UIView* topview;
    UILabel *content;
    CGFloat height1;
}

@end

@implementation ItWorksSubVC

- (void) didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Do any additional setup after loading the view.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    screenRect=[[UIScreen mainScreen]bounds].size;
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    //adding to parent view!
    
    
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    
  
        if([[[NSUserDefaults standardUserDefaults]objectForKey:@"subView"]isEqual:@"HowWeHelp"])
            titleLable.text=@"We Can Help";
        else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"subView"]isEqual:@"Effective"])
            titleLable.text=@"It's Effective";
    else
        titleLable.text=@"Video Therapy";
    

    
    
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font =[UIFont fontWithName:@"GothamRounded-Light" size:14];
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
[backButton setFrame:CGRectMake(15, 18, 55, 35)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
    myScroll = [[UIScrollView alloc] init];
    myScroll.frame = CGRectMake(0,55, screenRect.width, screenRect.height);
    
    //myScroll.contentSize = CGSizeMake(320, screenRect.height+100);
    myScroll.backgroundColor = [UIColor clearColor];
    
    myScroll.showsVerticalScrollIndicator = YES;    // to hide scroll indicators!
    
    myScroll.scrollEnabled = YES;                 //say "NO" to disable scroll
    
    
    [self.view addSubview:myScroll];
     topview=[UIView new];
    topview.frame=CGRectMake(0,0, screenRect.width, screenRect.height/2-135);
    topview.backgroundColor=[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:1];
    [myScroll addSubview:topview];
    header=[UILabel new];
    
    
    
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"subView"]isEqual:@"HowWeHelp"])
        [self createUi];
       else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"subView"]isEqual:@"Effective"])
        [self createUi];
    else
        [self createUi];
    

    

    // Dispose of any resources that can be recreated.
}

#pragma mark-back button
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark-Create UI
-(void)createUi{
    header.frame=CGRectMake(10, topview.frame.size.height-100, topview.frame.size.width, 100);
    
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"subView"]isEqual:@"HowWeHelp"])
        header.text=@"How We Can Help-\nPsychology";
    
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"subView"]isEqual:@"Effective"])
         header.text=@"Why It's Effective-\nPsychology";
    else
        header.text=@"Why Video\nTherapy";
    header.numberOfLines=3;
    header.textColor=[UIColor whiteColor];
    header.font=[UIFont fontWithName:@"GothamRounded-Light" size:18];
    [topview addSubview:header];
    
    
    
    
    content=[UILabel new];

        
        if([[[NSUserDefaults standardUserDefaults]objectForKey:@"subView"]isEqual:@"HowWeHelp"])
            content.text=@"Doctor On Demand psychologists help those that are struggling, but our psychologists also work with people that generally feel okay and have a certain area or problem they would like help with.\n\nIt is important to note that Doctor On Demand is not meant for emergency situations. If someone feels like harming themselves or someone else, or if they are having any other emergency situation, they should go to their nearest emergency room or call 911.\n\nDoctor On Demand psychologists meet with patients who are looking for help with one or more of the following conditions or symptoms (this is not an exhaustive list):\n\n● Alcohol abuse\n● Anger management\n● Anxiety\n● Behavioral issues\n● Borderline personality disorder\n● Changes in mood\n● Chronic pain\n● Codependency\n● Depression\n● Divorce\n● Eating disorders\n● Family conflict\n● Feeling overwhelmed\n● Grief\n● Impulsivity\n● Life Stresses\n● Loss\n● Obsessions/Obsessive-Compulsive disorder\n● Panic\n● Post Traumatic Stress disorder\n● Relationship issues\n● Self-esteem";

        else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"subView"]isEqual:@"Effective"]){
             content.text=@"Can a Doctor on Demand Psychologist diagnose and treat me effectively through app technology? The answer is yes! Through our app technology our therapists see your face, sense your emotions and hear your voice. There are also many studies that show that telemental health is as effective as in-person treatment and patients are just as satisfied with their treatment.\n\nDoctor on Demand is using technology to change the landscape of mental healthcare. Here's how:";
        }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"subView"]isEqual:@"Video"])
    {
        content.text=@"Though there is no clinical difference between Video Therapy and in-office therapy, there are tremendous benefits in the access and convenience of Doctor On Demand Video Therapy.";

    }
    height1=[self calculateHeight:content.text];
    content.frame=CGRectMake(10, topview.frame.size.height+20, myScroll.frame.size.width-20, height1+10);
    content.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    content.numberOfLines=50;
    [myScroll addSubview:content];
    
    
    heading=[[UILabel alloc]init];
    heading.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"subView"]isEqual:@"HowWeHelp"])
    heading.text=@"Things Doctor On Demand Psychologists Will Not or Rarely Treat:";
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"subView"]isEqual:@"Effective"])
        heading.text=@"1) More Access To Providers";
     else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"subView"]isEqual:@"Video"])
         heading.text=@"Access";
    
    CGFloat height2=[self calculateHeight:heading.text];
    heading.numberOfLines=6;
    heading.frame=CGRectMake(10, topview.frame.size.height+20+height1+20, myScroll.frame.size.width-20, height2);
     [myScroll addSubview:heading];
    
    
    
    content=[UILabel new];
    
    
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"subView"]isEqual:@"HowWeHelp"])
        content.text=@"● Schizophrenia\n● Suicidal/Homicidal/Psychiatric emergency\n● Conditions requiring psychiatry and psychiatric medicine\n\nOur goal is to help you get better as quickly as possible so you can lead a healthy and productive life, not continue therapy for years. Are you ready to try or revisit therapy?";
    
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"subView"]isEqual:@"Effective"])
        content.text=@"No longer are you limited to the few or lack of providers in your immediate area; now you can choose a provider from anywhere in your state. Because of the increased availability there is often less of a wait time too. Rather than waiting 3 months to be seen, you can see a therapist within a few days.";
   
     else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"subView"]isEqual:@"Video"])
         content.text=@"Easy to find a \nprescreened,high quality provider that fits your needs.";
    
  CGFloat  height3=[self calculateHeight:content.text];
    content.frame=CGRectMake(10, topview.frame.size.height+20+height1+10+height2+20, myScroll.frame.size.width-20, height3);
    content.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    content.numberOfLines=50;
    [myScroll addSubview:content];
    
    
        
        
        heading=[[UILabel alloc]init];
        heading.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
        if([[[NSUserDefaults standardUserDefaults]objectForKey:@"subView"]isEqual:@"Effective"])
        heading.text=@"2) Increased Privacy";
        else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"subView"]isEqual:@"Video"])
            heading.text=@"Convenience";
        CGFloat height=[self calculateHeight:heading.text];
        heading.numberOfLines=6;
        heading.frame=CGRectMake(10,  topview.frame.size.height+20+height1+10+height2+20+height3+20, myScroll.frame.size.width-20, height);
        [myScroll addSubview:heading];
        
        
        content=[UILabel new];
         if([[[NSUserDefaults standardUserDefaults]objectForKey:@"subView"]isEqual:@"Effective"])
        content.text=@"Doctor on Demand allows you to be seen in the private space of your choosing. You don't have to go sit in a lobby or a clinic where you might run into a coworker or neighbor. Your visits can happen in the location that works best for you. In that way, we are hoping that Doctor on Demand can reduce some of the stigma and reach out to a wider population that could benefit from mental health services.";
         else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"subView"]isEqual:@"Video"])
             content.text=@" Schedule a time to meet with\n your psychologist that works for you - not the other way around.";
        CGFloat  height4=[self calculateHeight:content.text];
        content.frame=CGRectMake(10,  topview.frame.size.height+20+height1+10+height2+20+height3+height+40, myScroll.frame.size.width-20, height4);
        content.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
        content.numberOfLines=50;
        [myScroll addSubview:content];
        
        heading=[[UILabel alloc]init];
        heading.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
        if([[[NSUserDefaults standardUserDefaults]objectForKey:@"subView"]isEqual:@"Effective"])

        heading.text=@"3) Convenience";
        else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"subView"]isEqual:@"Video"])
        heading.text=@"Comfort";
            
        CGFloat height5=[self calculateHeight:heading.text];
        heading.numberOfLines=5;
        heading.frame=CGRectMake(10,   topview.frame.size.height+20+height1+10+height2+20+height3+height+height4+60, myScroll.frame.size.width-20, height5);
        [myScroll addSubview:heading];
       
        content=[UILabel new];
         if([[[NSUserDefaults standardUserDefaults]objectForKey:@"subView"]isEqual:@"Effective"])
        content.text=@"You can schedule a time to meet with your therapist that works best for you, not the other way around - whether that's early morning before the day starts, during a lunch break at work, when the kids have gone to bed or even when you're traveling. No longer do you have to slip out of work, drive across town or miss a session. You make your own schedule and meet when you want.";
         else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"subView"]isEqual:@"Video"])
             content.text=@"Schedule a time to meet with\nyour psychologist that works for you - not the other way around.";
        CGFloat  height6=[self calculateHeight:content.text];
        content.frame=CGRectMake(10,   topview.frame.size.height+20+height1+10+height2+20+height3+height+height4+height5+70, myScroll.frame.size.width-20, height6);
        content.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
        content.numberOfLines=50;
        [myScroll addSubview:content];
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"subView"]isEqual:@"Effective"]){
        
        heading=[[UILabel alloc]init];
        heading.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
        heading.text=@"4) General comfort";
        CGFloat height7=[self calculateHeight:heading.text];
        heading.numberOfLines=5;
        heading.frame=CGRectMake(10, topview.frame.size.height+20+height1+10+height2+20+height3+height+height4+height5+height6+90, myScroll.frame.size.width-20, height7);
        [myScroll addSubview:heading];
        
        content=[UILabel new];
        content.text=@"Going to a therapists office can be a scary thing. With Doctor on Demand you can be at the place you're most comfortable, to ease yourself into the process and reduce your fears.\n\nWe invite you to connect with a one of our Psychologists today, to learn how therapy can help you or a loved work through issues and concerns and get back to living a happy, productive and healthy life.";
        CGFloat  height8=[self calculateHeight:content.text];
        content.frame=CGRectMake(10,  topview.frame.size.height+20+height1+10+height2+20+height3+height+height4+height5+height6+height7+100, myScroll.frame.size.width-20, height8+10);
        content.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
        content.numberOfLines=50;
        [myScroll addSubview:content];







    }
        

    

    float sizeOfContent = 0;
    UIView *lLast = [myScroll.subviews lastObject];
    NSInteger wd = lLast.frame.origin.y;
    NSInteger ht = lLast.frame.size.height;
    NSInteger offset=50;
    sizeOfContent = wd+ht;
    myScroll.contentSize=CGSizeMake(screenRect.width,sizeOfContent+offset+10);


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
