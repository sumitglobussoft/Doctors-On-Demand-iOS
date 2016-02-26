//
//  LactationConsultVC.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 10/19/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "LactationConsultVC.h"

@interface LactationConsultVC (){
    CGSize screenRect;
    UIScrollView *myScroll;
    UIView *topview;
    UILabel *header;
    UILabel *heading,*content;

}

@end

@implementation LactationConsultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"OurDoctors"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"pshy"];
    [[NSUserDefaults standardUserDefaults]synchronize];
  
    
    screenRect=[[UIScreen mainScreen]bounds].size;
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
   
    
    
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"lactation"]isEqual:@"whatIsLactation"])
    titleLable.text=@"What's Lactation?";
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"lactation"]isEqual:@"lactationVideo"])
        titleLable.text=@"Lactation Video";
    
  



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
topview =[UIView new];
topview.frame=CGRectMake(0,0, screenRect.width, screenRect.height/2-135);
topview.backgroundColor=[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:1];
[myScroll addSubview:topview];

    
    
    
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"lactation"]isEqual:@"whatIsLactation"])
        [self lactationUi];
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"lactation"]isEqual:@"lactationVideo"])
        [self lactationVideoUi];
    


    //adding to parent view!


    
   
    

       // Do any additional setup after loading the view.
}

#pragma mark-back action
-(void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark-Lactation ConsultationUI
-(void)lactationUi{
    
    header=[UILabel new];
    header.frame=CGRectMake(10, topview.frame.size.height-80, topview.frame.size.width, 100);
        header.text=@"Lacation Consulting";
    header.numberOfLines=2;
    header.textColor=[UIColor whiteColor];
    header.font=[UIFont fontWithName:@"GothamRounded-Light" size:18];
    [topview addSubview:header];
    
    
//    heading =[UILabel new];
//    heading.frame=CGRectMake(10, topview.frame.size.height+10, myScroll.frame.size.width, 30);
//    heading.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
//    
//    heading.text=@"Selection and Screening";
//    [myScroll addSubview:heading];
//    
    
    content=[UILabel new];
   
    content.text=@"Breast milk is nature's most powerful food and prescription, yet many moms struggle with one or more aspects of breastfeeding. To help moms work through the issues and have the best possible experience breastfeeding, we have certified Lactation Consultants at your fingertips.\n\nThe consultation will be just like a visit with a Doctor On Demand physician, allowing new moms to meet with a consultant from the privacy and comfort of home. We know the first two weeks are especially crucial in forming good habits and ensuring the body receives the message to start making enough milk. When there are issues, it can easily overwhelm a new mom - not only the idea of exposing her newborn to germs at the doctor's office, but also finding a qualified consultant to help her.\n\nThere are many specialists who take an 8-hour course and begin helping mothers. At Doctor on Demand we provide a higher level of care. All of our Lactation Consultants are International Board Certified Lactation Consultants (IBCLCs), meaning they have completed a number of prerequisite medical courses along with hours of field practice alongside another IBCLC. An IBCLC is highly qualified to troubleshoot and consider multiple avenues to solve the issues.\n\nOne of the things moms are most concerned with Is my baby getting enough to eat?With Lactation Consultants at the ready, when mom is jumping into this new experience, we can guide her through the process, explaining why breastfeeding is so important and helping her continue to provide for her baby.";
    
    CGFloat height=[self calculateHeight:content.text];
    content.frame=CGRectMake(10, topview.frame.size.height+10, myScroll.frame.size.width-20, height+20);
    content.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    content.numberOfLines=50;
    [myScroll addSubview:content];
    
    
    
        heading=[[UILabel alloc]init];
        heading.text=@"Lactation issues fall into two categories:";
    CGFloat height1=[self calculateHeight:heading.text];
        heading.frame=CGRectMake(10, topview.frame.size.height+30+height, myScroll.frame.size.width, height1);
        heading.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
        [myScroll addSubview:heading];
    
    heading=[[UILabel alloc]init];
    heading.text=@"Issues Affetcing Baby";
    CGFloat height2=[self calculateHeight:heading.text];
    heading.frame=CGRectMake(10, topview.frame.size.height+30+height+height1+20, myScroll.frame.size.width, height2);
    heading.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    [myScroll addSubview:heading];
    
    
    content=[UILabel new];
    content.text=@"Examples include not feeding, not feeding properly, not wanting to start feeding, excessively fussy during feeding and more.";
    CGFloat height3=[self calculateHeight:content.text];
    content.frame=CGRectMake(10, topview.frame.size.height+30+height+height1+30+height2, myScroll.frame.size.width-20, height3);
    content.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    content.numberOfLines=50;
    [myScroll addSubview:content];
    
    
    heading=[[UILabel alloc]init];
    heading.text=@"Issues Affetcing Mother";
    CGFloat height4=[self calculateHeight:heading.text];
    heading.frame=CGRectMake(10,topview.frame.size.height+30+height+height1+30+height2+10+height3, myScroll.frame.size.width, height4);
    heading.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    [myScroll addSubview:heading];
    
    content=[UILabel new];
    content.text=@"Examples include breast issues, nipple issues, not producing enough milk/too much/not at all, issues with pumping, medication questions, returning to work and more.";
    CGFloat height5=[self calculateHeight:content.text];
    content.frame=CGRectMake(10, topview.frame.size.height+30+height+height1+30+height2+height3+10+height4, myScroll.frame.size.width-20, height5+10);
    content.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    content.numberOfLines=50;
    [myScroll addSubview:content];





    
    
     float sizeOfContent = 0;
    UIView *lLast = [myScroll.subviews lastObject];
    NSInteger wd = lLast.frame.origin.y;
    NSInteger ht = lLast.frame.size.height;
    NSInteger offset=50;
    sizeOfContent = wd+ht;
    myScroll.contentSize=CGSizeMake(screenRect.width,sizeOfContent+offset+10);
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"lactation"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    

    
}
#pragma mark-Lactation video UI
-(void)lactationVideoUi{
    
    header=[UILabel new];
   
    header.text=@"Lacation Consulting\nThrough Video";
   // CGFloat height=[self calculateHeight:header.text];
    header.frame=CGRectMake(10, topview.frame.size.height-80, topview.frame.size.width-20,60);
    header.numberOfLines=2;
    header.textColor=[UIColor whiteColor];
    header.font=[UIFont fontWithName:@"GothamRounded-Light" size:18];
    [topview addSubview:header];
    
    heading=[UILabel new];
    heading.text=@"Here's what a mom can expect during a typical video visit with a Doctor On Demand Lactation Consultant:";
    CGFloat height=[self calculateHeight:heading.text];
    heading.frame=CGRectMake(10, topview.frame.size.height+20, myScroll.frame.size.width-20, height);
    heading.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    heading.numberOfLines=10;
    [myScroll addSubview:heading];
    
    
    content=[UILabel new];
    content.text=@"1) Mom enters her concerns and any breastfeeding issues into the Doctor on Demand app. The certified Lactation Consultant (LC) will review the information prior to connecting with her.\n\n2) Once the LC connects with mom, she will make sure mom is comfortable and the baby is taken care of, so they're able to focus the visit on addressing the main issues. Through a face-to-face consult, the LC will review mom's questions and concerns in more detail.\n\n3) Next is visualization; where video becomes very helpful. The LC can inspect the nipples for any wounds, which may indicate position issues. She may also want to inspect the baby's tongue to check for any abnormalities. Through the hi-resolution camera, the LC is able to see mom and baby just as if they were in the room together.\n\n4) The LC may then ask the mom to do a feeding, so she can look at for any trouble latching, for incorrect positioning and observe the baby's ability to feed.\n\n";
    CGFloat height1=[self calculateHeight:content.text];
    content.frame=CGRectMake(10, topview.frame.size.height+20+height, myScroll.frame.size.width-20, height1+10);
    content.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    content.numberOfLines=50;
    [myScroll addSubview:content];
    
    heading=[UILabel new];
    heading.text=@"Learning The Right Motions";
    CGFloat height2=[self calculateHeight:heading.text];
    heading.frame=CGRectMake(10,topview.frame.size.height+20+height+height1, myScroll.frame.size.width-20, height2);
    heading.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    heading.numberOfLines=2;
    [myScroll addSubview:heading];
    
    content=[UILabel new];
    content.text=@"In a hospital setting, the clinicians tend to put the baby on the breast for mom. These feedings usually go wonderfully. But once she's home, mom isn't always able to get the right positioning on her own. Doctor on Demand's lactation consulting can be particularly empowering for moms in that it essentially requires her to start doing the ""\"work\" and learning with their newborns. During a consult with Doctor on Demand, the LC is hands free, giving clear instructions/demonstrations for mom to replicate on her own. This also ensures mom is working to learn the motions herself, enabling success long after the visit is over.\n\nMore often than not, the Lactation Consultants are able to help mom resolve any issues within 1-3 visits, giving her the tools and the confidence she needs to continue with her breastfeeding goals.";
    CGFloat height3=[self calculateHeight:content.text];
    content.frame=CGRectMake(10, topview.frame.size.height+20+height+height1+20+height2, myScroll.frame.size.width-20, height3);
    content.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    content.numberOfLines=50;
    [myScroll addSubview:content];


    

    
    
    
    
    
    
    float sizeOfContent = 0;
    UIView *lLast = [myScroll.subviews lastObject];
    NSInteger wd = lLast.frame.origin.y;
    NSInteger ht = lLast.frame.size.height;
    NSInteger offset=50;
    sizeOfContent = wd+ht;
    myScroll.contentSize=CGSizeMake(screenRect.width,sizeOfContent+offset+10);
    
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"lactation"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
