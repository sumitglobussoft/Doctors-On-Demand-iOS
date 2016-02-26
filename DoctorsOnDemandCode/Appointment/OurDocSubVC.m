//
//  OurDocSubVC.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 10/15/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "OurDocSubVC.h"

@interface OurDocSubVC (){
    CGSize screenRect;
    UIScrollView *myScroll;
    UIView *topview;
    CGFloat height1;
    UILabel *header;
    UILabel *heading,*content;
  
  }


@end

@implementation OurDocSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    screenRect=[[UIScreen mainScreen]bounds].size;
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
        //adding to parent view!

    
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    
    if([SingletonClass sharedSingleton].deptId==4 ||[SingletonClass sharedSingleton].deptId==2){
    
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"OurDoctors"]isEqual:@"Intro"])
    titleLable.text=@"MD Intro";
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"OurDoctors"]isEqual:@"quality"])
        titleLable.text=@"MD Oversight";
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"OurDoctors"]isEqual:@"screening"])
        titleLable.text=@"MD Selection";
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"about"]isEqual:@"mission"])
        titleLable.text=@"Mission";
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"about"]isEqual:@"privacy"])
        titleLable.text=@"Privacy";
    }
    else if ([SingletonClass sharedSingleton].deptId==3){
        if([[[NSUserDefaults standardUserDefaults]objectForKey:@"pshy"]isEqual:@"Intro"])
            titleLable.text=@"Psych Intro";
        else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"pshy"]isEqual:@"screening"])
            titleLable.text=@"Psych Selection";
        else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"pshy"]isEqual:@"quality"])
            titleLable.text=@"Psych Oversight";
        else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"about"]isEqual:@"mission"])
            titleLable.text=@"Mission";
        else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"about"]isEqual:@"privacy"])
            titleLable.text=@"Privacy";

    }
    else if ([SingletonClass sharedSingleton].deptId==1){
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"about"]isEqual:@"mission"])
            titleLable.text=@"Mission";
        else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"about"]isEqual:@"privacy"])
            titleLable.text=@"Privacy";
        else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"consultant"]isEqual:@"screening"])
            titleLable.text=@"LC Selection";
        else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"consultant"]isEqual:@"quality"])
            titleLable.text=@"LC Oversight";

        
        


    }
    
    
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
     header=[UILabel new];
    
    if([SingletonClass sharedSingleton].deptId==4 || [SingletonClass sharedSingleton].deptId==2){
    
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"OurDoctors"]isEqual:@"Intro"])
        [self createUi];
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"OurDoctors"]isEqual:@"quality"])
        [self createUi];
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"about"]isEqual:@"mission"])
        [self createUi];
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"about"]isEqual:@"privacy"])
        [self createUi];
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"OurDoctors"]isEqual:@"screening"])
        [self screeningView];
    }
    else if ([SingletonClass sharedSingleton].deptId==3){
        if([[[NSUserDefaults standardUserDefaults]objectForKey:@"pshy"]isEqual:@"Intro"])
            [self createUi];
    
   else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"pshy"]isEqual:@"quality"])
        [self createUi];
        
        else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"pshy"]isEqual:@"screening"])
            [self screeningView];
        else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"about"]isEqual:@"mission"])
            [self createUi];
        else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"about"]isEqual:@"privacy"])
            [self createUi];
        


            
    }

    else if ([SingletonClass sharedSingleton].deptId==1){
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"about"]isEqual:@"mission"])
             [self createUi];
        else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"about"]isEqual:@"privacy"])
            [self createUi];
        else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"consultant"]isEqual:@"screening"])
            [self createUi];
        else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"consultant"]isEqual:@"quality"])
           [self lacationOversight];

        
    }


    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"pshy"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"about"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"consultant"];
    [[NSUserDefaults standardUserDefaults]synchronize];



    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-Lactation Oversight
-(void)lacationOversight{
    
    header.frame=CGRectMake(10, topview.frame.size.height-100, topview.frame.size.width, 100);
    
           header.text=@"Quality & Oversight-\nLactation Consultants";
    header.numberOfLines=3;
    header.textColor=[UIColor whiteColor];
    header.font=[UIFont fontWithName:@"GothamRounded-Light" size:18];
    [topview addSubview:header];
    
    content=[[UILabel alloc]init];
           content.text=@"To help moms work through the issues and have the best possible experience breastfeeding, we have certified Lactation Consultants at the ready. Often, we're seeing moms just days into nursing, which is such a critical time in breastfeeding. We select highly-trained Lactation Consultants to make sure mom gets the professional guidance she needs.";
    
    CGFloat height=[self calculateHeight:content.text];
    content.frame=CGRectMake(10, topview.frame.size.height+20, myScroll.frame.size.width-20, height+10);
    content.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    content.numberOfLines=50;
    [myScroll addSubview:content];
    
    
    
    heading =[UILabel new];
    heading.frame=CGRectMake(10, topview.frame.size.height+20+height+10, myScroll.frame.size.width, 30);
    heading.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    
    heading.text=@"Selection Quality Consultants";
    [myScroll addSubview:heading];
    
    content=[[UILabel alloc]init];
    content.text=@"All of our Lactation Consultants are International Board Certified Lactation Consultants (IBCLCs). This means they have completed a number of prerequisite medical courses, passed the certification exam, worked along another IBCLC and spent hours working with nursing moms. IBCLCs are also required to practice according to a special Code of Professional Conduct. From this highly-trained group of professionals, we select and vet our LC's through background checks and references from well-respected industry professionals.";
    
    CGFloat height2=[self calculateHeight:content.text];
    content.frame=CGRectMake(10,topview.frame.size.height+20+height+10+30, myScroll.frame.size.width-20, height2);
    content.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    content.numberOfLines=50;
    [myScroll addSubview:content];
    
    heading =[UILabel new];
    heading.frame=CGRectMake(10, topview.frame.size.height+20+height+10+height2+30, myScroll.frame.size.width, 30);
    heading.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    
    heading.text=@"Treating By Video";
    [myScroll addSubview:heading];
    
    
    content=[[UILabel alloc]init];
    content.text=@"Each of our Lactation Consultants are interviewed via video to test their bedside manner and see how well they interact with mom and baby. The Lactation Consultant's bedside manner is critical to ensure mom feels comfortable receiving guidance from our professionals. Our Lactation Consultants also receiving training from peers who are leaders in the field on the clinical 'do's', 'dont's' and hallmarks of treating through video.";
    
    CGFloat height3=[self calculateHeight:content.text];
    content.frame=CGRectMake(10,topview.frame.size.height+20+height+10+height2+30+30, myScroll.frame.size.width-20, height3);
    content.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    content.numberOfLines=50;
    [myScroll addSubview:content];
    
    heading =[UILabel new];
    heading.frame=CGRectMake(10, topview.frame.size.height+20+height+10+height2+30+30+height3, myScroll.frame.size.width, 30);
    heading.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    
    heading.text=@"A continuous Quality Review";
    [myScroll addSubview:heading];

    content=[[UILabel alloc]init];
    content.text=@"After each call, moms can rate the care they received and leave comments. These comments reflect back to the LC their level of professionalism, service and the mom's view on the level of helpfulness. Within Doctor on Demand Professionals, LCs also undergo Quality Assurance reviews in order to identify areas for improvement and ensure that LCs are providing high quality care. Everything we do is done with the goal of assuring and helping mom as she undertakes breastfeeding, whether it's for the first or fifth time.";
    
    CGFloat height4=[self calculateHeight:content.text];
    content.frame=CGRectMake(10,topview.frame.size.height+20+height+10+height2+30+30+30+height3, myScroll.frame.size.width-20, height4);
    content.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    content.numberOfLines=50;
    [myScroll addSubview:content];
    
    heading =[UILabel new];
    heading.frame=CGRectMake(10,topview.frame.size.height+20+height+10+height2+30+30+30+height3+height4, myScroll.frame.size.width, 30);
    heading.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    
    heading.text=@"Mom-Focused Care";
    [myScroll addSubview:heading];
    
    content=[[UILabel alloc]init];
    content.text=@"Our Lactation Consultants are trained to help mom reach her own, individual breastfeeding goals. Whether it's 4 weeks, 4 months or 12 months our Lactation Consultant's will help mom create a care plan to fit her needs. We are a support system for mom and will help her achieve the goals that are best for her and her family.";
    
    CGFloat height5=[self calculateHeight:content.text];
    content.frame=CGRectMake(10,topview.frame.size.height+20+height+10+height2+30+30+30+height3+height4+30, myScroll.frame.size.width-20, height5);
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

    

  }

#pragma mark-Screening view
-(void)screeningView{
    
    header.frame=CGRectMake(10, topview.frame.size.height-100, topview.frame.size.width, 100);
    
    if ([SingletonClass sharedSingleton].deptId==4 || [SingletonClass sharedSingleton].deptId==2) {
          header.text=@"How We Select,\nScreen & Train Our\nDoctors";
    }
    else if ([SingletonClass sharedSingleton].deptId==3){
         header.text=@"Screening &\nTraining";
    }
    
    
    
    header.numberOfLines=3;
    header.textColor=[UIColor whiteColor];
    header.font=[UIFont fontWithName:@"GothamRounded-Light" size:18];
    [topview addSubview:header];
    

   heading =[UILabel new];
    heading.frame=CGRectMake(10, topview.frame.size.height+10, myScroll.frame.size.width, 30);
    heading.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];

    heading.text=@"Selection and Screening";
      [myScroll addSubview:heading];
    
    
    content=[UILabel new];
    
    if([SingletonClass sharedSingleton].deptId==4||[SingletonClass sharedSingleton].deptId==2)
         content.text=@"Each doctor is interviewed and carefully screened through a comprehensive credentialing process that includes a verification of their educational background, board certifications, training and licensure. All of this information is then verified by the NPDB (National Practitioner Data Bank).";
    else if ([SingletonClass sharedSingleton].deptId==3)
         content.text=@"You may have heard about Doctor On Demand from a friend, or perhaps from Dr. Phil or The Doctors. Maybe you read an interesting article on us. The goal of Doctor On Demand is to bring you the medical care and treatment you need from a licensed psychologist, through app technology. Seeing a therapist from home seems like a convenient idea, but you may wonder 'how qualified are these therapists?' Learn more about our rigorous selection, screening and training process:\n\nOur therapists are licensed psychologists with doctorate degrees, and bring years of clinical training and experience to the care they provide to patients.\n\nEach psychologist is interviewed and carefully screened through a credentialing process that includes a verification of their educational background, board certifications, training and licensure.";
    
    
    CGFloat height2=[self calculateHeight:content.text];
    content.frame=CGRectMake(10, topview.frame.size.height+10+30, myScroll.frame.size.width-20, height2);
    content.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    content.numberOfLines=50;
    [myScroll addSubview:content];
    
    
    heading=[[UILabel alloc]init];
    heading.frame=CGRectMake(10, topview.frame.size.height+10+30+height2, myScroll.frame.size.width, 30);
    heading.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    heading.text=@"Training";
    [myScroll addSubview:heading];

    
    
    content=[[UILabel alloc]init];
    if([SingletonClass sharedSingleton].deptId==4||[SingletonClass sharedSingleton].deptId==2){
    content.text=@"Next, each candidate goes through training on how to safely and effectively care for patients using telemedicine technologies; they are also provided nearly 200 clinical protocols and other resource materials to assist them in their practice. For example, we have a clinical protocol around ankle injuries called the Ottawa Ankle Rules, which determines whether a patient needs x-rays or if they will heal on their own. During this training phase physicians also receive training on cultural competency, sensitivity and Doctor on Demand policies and procedures.";
    }
    else if ([SingletonClass sharedSingleton].deptId==3){
        content.text=@"Next, each psychologist goes through training on how to safely and effectively care for patients using telehealth technologies. During this training phase psychologists also receive training on cultural competency, sensitivity and Doctor on Demand policies and procedures.\n\nFinally, we measure each therapist's performance and quality of care. This takes place in multiple forms, one of which is patient ratings. Patients can rate every single session. That gives us a good lens into their level of professionalism, their level of service and the patient's view on the level of helpfulness.\n\nThe result of this lengthy and rigorous selection and training process ensures each time you call Doctor On Demand, you are speaking to and being treated by qualified, licensed psychologists who are providing quality care.";
 
    }
    CGFloat height3=[self calculateHeight:content.text];
    content.frame=CGRectMake(10, topview.frame.size.height+10+30+height2+30, myScroll.frame.size.width-20, height3);
    content.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    content.numberOfLines=50;
    [myScroll addSubview:content];
    
    
    
    heading=[[UILabel alloc]init];
    heading.frame=CGRectMake(10, topview.frame.size.height+10+30+height2+30+height3, myScroll.frame.size.width, 30);
    heading.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    if([SingletonClass sharedSingleton].deptId==4||[SingletonClass sharedSingleton].deptId==2)
    heading.text=@"Ongoing Quality Management";
    [myScroll addSubview:heading];
    
    
    
    content=[[UILabel alloc]init];
     if([SingletonClass sharedSingleton].deptId==4||[SingletonClass sharedSingleton].deptId==2)
    content.text=@"Finally, the physician leadership at Doctor on Demand Professionals monitors each doctor's performance and quality of care. This takes place in multiple forms, one of which is patient ratings. Patients can rate every single visit and leave comments. These comments reflect back to the provider their level of professionalism, service and the patient's view on the level of helpfulness. All physicians also participate in a peer review program. This means that physicians score and rate the quality of care provided by their physician peers based on medical record reviews and other criteria. The peer review process leads to constant improvements in quality and helps ensure compliance with protocols and best practices.";
    CGFloat height4=[self calculateHeight:content.text];
    content.frame=CGRectMake(10, topview.frame.size.height+60+height2+height3+20+10, myScroll.frame.size.width-20, height4+20);
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
    
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"OurDoctors"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    
}
#pragma mark-create UI
-(void)createUi{
  
   
    
  
    header.frame=CGRectMake(10, topview.frame.size.height-50, topview.frame.size.width, 50);
    
    if([SingletonClass sharedSingleton].deptId==4||[SingletonClass sharedSingleton].deptId==2){
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"OurDoctors"]isEqual:@"Intro"])
        header.text=@"Our Physicians-\nIntroduction";
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"OurDoctors"]isEqual:@"quality"])
        header.text=@"Quality &\nOversight";
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"about"]isEqual:@"mission"])
          header.text=@"Our Mission";
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"about"]isEqual:@"privacy"])
        header.text=@"Privacy";
    }
    else if ([SingletonClass sharedSingleton].deptId==3){
        if([[[NSUserDefaults standardUserDefaults]objectForKey:@"pshy"]isEqual:@"Intro"])
        header.text=@"Our Psychologists-\nIntroduction";
        else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"pshy"]isEqual:@"quality"])
            header.text=@"Psych Oversight";
        else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"about"]isEqual:@"mission"])
            header.text=@"Our Mission";
        else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"about"]isEqual:@"privacy"])
            header.text=@"Privacy";
    }
    else if ([SingletonClass sharedSingleton].deptId==1){
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"about"]isEqual:@"mission"])
                header.text=@"Our Mission";

        else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"about"]isEqual:@"privacy"])
                header.text=@"Privacy";

        else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"about"]isEqual:@"privacy"])
            header.text=@"Privacy";
        
        
        else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"consultant"]isEqual:@"screening"])
               header.text=@"How We Choose Our\nLactation Consultants";
        

    }

    

    
    header.numberOfLines=2;
    header.textColor=[UIColor whiteColor];
    header.font=[UIFont fontWithName:@"GothamRounded-Light" size:18];
    [topview addSubview:header];
    
    
  content=[UILabel new];
    if([SingletonClass sharedSingleton].deptId==4 ||[SingletonClass sharedSingleton].deptId==2 ){
    
        if([[[NSUserDefaults standardUserDefaults]objectForKey:@"OurDoctors"]isEqual:@"Intro"])
    content.text=@"At Doctor On Demand Professionals, we hand-picked some of the top board-certified physicians in the country to provide medical care through our platform. Our doctors go through rigorous screening, training and ongoing quality assurance. Patients rate every single visit to help ensure the highest quality of care. Our physicians are focused on your care. No distractions, no interruptions. We're proud of our medical team.";
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"OurDoctors"]isEqual:@"quality"])
         content.text=@"Imagine you could rate your medical provider after each visit in categories like on-time rate, helpfulness, quality and communication. It's a pretty unique concept, but at Doctor on Demand it's how we operate.\n\nAfter each visit we ask you to rate your experience. The ratings give us and our providers valuable feedback that allows us to increase the quality of service whenever possible. They also give us better insight on the level of professionalism, level of service and the patient's view on the helpfulness of their Physician, Psychologist, or Lactation Consultant.\n\nDoctor on Demand Professionals also do provider peer reviews, meaning each provider's consultations are scored by his or her colleagues. We combine the peer and patient scores along with other metrics like timeliness, professionalism, and adherence to evidence-based clinical guidelines. Clinical leadership at Doctor on Demand Professionals uses this information to provide each Doctor, Psychologist or Lactation Consultant with concrete feedback with the ultimate goal of providing the patient with the very best care and service possible.\n\nOur providers are committed to lifelong learning and continuous process improvement.";
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"about"]isEqual:@"mission"])
      content.text=@"Lack of access to health care providers in the United States is a massive, growing problem. The average wait time to see a physician is three weeks. Even if you can see a doctor, it takes 2-3 hours from the time you leave your home or office to the time you get back home. It takes an average of 25 days to see a psychiatrist or psychologist. Nearly half of patients with mental health issues go without treatment.\n\nWe're not getting the care that we need. We built Doctor On Demand to help address this problem.\n\nAt Doctor On Demand we provide fast, easy and cost-effective access to some of the best doctors, psychologists, and other healthcare providers in the country. Our patients can have Video Visits with these providers on their smartphone or computers at any time of day.\n\nWe do this without sacrificing quality. All providers are carefully screened and trained to conduct Video Visits.\n\nWe started with Board-Certified Physicians, who are confident in applying their experience and expertise to addressing your medical problem. We now offer access to Licensed Psychologists, who provide help for a tremendous range of mental and emotional health concerns. And, our Lactation Consultants provide invaluable support to moms as they navigate the critical first months of their babies' lives.\n\nTomorrow? We'll provide care from even more health-care providers. We won't stop until we can help you improve all aspects of your physical, emotional, and behavioral health.\n\nThis is the better way to feel better.";
    
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"about"]isEqual:@"privacy"])
        content.text=@"At Doctor On Demand, we take privacy very seriously since it is our responsibility to protect the privacy and security of your personal information. We store member personal information behind two layers of encryption in a secure digital environment that is continuously monitored and routinely tested by leading experts in health information security. We restrict access to this environment using multiple safeguards such as dual factor authentication to ensure that only authorized clinical professionals and administrative personnel can access member personal information, and only on an as-needed basis. Your privacy is protected under strict Company rules that prohibit the use or disclosure of member personal information in an improper manner or without proper authorization. These rules are set forth in our internal and Site privacy policies and actively monitored and enforced by our Chief Privacy Officer and Chief Security Officer.";
    }
    else if ([SingletonClass sharedSingleton].deptId==3){
        
        if([[[NSUserDefaults standardUserDefaults]objectForKey:@"pshy"]isEqual:@"Intro"])
            content.text=@"The Behavioral Health Providers at Doctor On Demand Professionals are doctoral-level psychologists. Though there are many kinds of therapists, we provide access to some of the highest trained professionals in the field.\n\n* The telehealth services made available through Doctor On Demand are provided by a network of U.S. licensed psychologists practicing within a group of independently owned professional practices collectively known as Doctor on Demand Professionals. These practices provide services via the Doctor on Demand telehealth platform. Doctor on Demand, Inc. does not itself provide any physician, mental health or other healthcare provider services.";
        else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"pshy"]isEqual:@"quality"])
            content.text=@"Imagine you could rate your psychologist after each visit. It's a pretty unique concept, but at Doctor On Demand it's how we operate. After each visit we ask you to rate your experience and provide comments. The ratings and comments give us and our providers valuable valuable feedback that allows us to increase the quality of service whenever possible. They also give us better insight on the level of professionalism, level of service and the patient's view on the helpfulness of their Psychologist.\n\nDoctor on Demand Professionals also performs quality reviews and combines this information with patient scores along with other metrics like timeliness, professionalism, and adherence to evidence-based clinical guidelines. Clinical leadership at Doctor on Demand Professionals uses this information to provide Psychologists with concrete feedback with the ultimate goal of providing the patient with the very best care and service possible. Our providers are committed to lifelong learning and continuous process improvement.\n\nWe combine the peer and patient scores along with other metrics like timeliness, professionalism, etc. We use this information to provide each psychologist with concrete feedback with the ultimate goal of providing the patient with the very best service possible. In healthcare, the fact that we are doing this review process at all is a big step. The fact that we are doing it for every single visit is even bigger. But the fact that we act on the results in both the near and long term to effect real change in our service is setting the bar to a higher standard for all healthcare providers.\n\n* The telehealth services made available through Doctor On Demand are provided by a network of U.S. licensed psychologists practicing within a group of independently owned professional practices collectively known as Doctor on Demand Professionals . These practices provide services via the Doctor on Demand telehealth platform. Doctor on Demand, Inc. does not itself provide any physician, mental health or other healthcare provider services.";
        else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"about"]isEqual:@"mission"])
            content.text=@"Lack of access to health care providers in the United States is a massive, growing problem. The average wait time to see a physician is three weeks. Even if you can see a doctor, it takes 2-3 hours from the time you leave your home or office to the time you get back home. It takes an average of 25 days to see a psychiatrist or psychologist. Nearly half of patients with mental health issues go without treatment.\n\nWe're not getting the care that we need. We built Doctor On Demand to help address this problem.\n\nAt Doctor On Demand we provide fast, easy and cost-effective access to some of the best doctors, psychologists, and other healthcare providers in the country. Our patients can have Video Visits with these providers on their smartphone or computers at any time of day.\n\nWe do this without sacrificing quality. All providers are carefully screened and trained to conduct Video Visits.\n\nWe started with Board-Certified Physicians, who are confident in applying their experience and expertise to addressing your medical problem. We now offer access to Licensed Psychologists, who provide help for a tremendous range of mental and emotional health concerns. And, our Lactation Consultants provide invaluable support to moms as they navigate the critical first months of their babies' lives.\n\nTomorrow? We'll provide care from even more health-care providers. We won't stop until we can help you improve all aspects of your physical, emotional, and behavioral health.\n\nThis is the better way to feel better.";
        
        else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"about"]isEqual:@"privacy"])
            content.text=@"At Doctor On Demand, we take privacy very seriously since it is our responsibility to protect the privacy and security of your personal information. We store member personal information behind two layers of encryption in a secure digital environment that is continuously monitored and routinely tested by leading experts in health information security. We restrict access to this environment using multiple safeguards such as dual factor authentication to ensure that only authorized clinical professionals and administrative personnel can access member personal information, and only on an as-needed basis. Your privacy is protected under strict Company rules that prohibit the use or disclosure of member personal information in an improper manner or without proper authorization. These rules are set forth in our internal and Site privacy policies and actively monitored and enforced by our Chief Privacy Officer and Chief Security Officer.";
    


            
    }
    
    else if ([SingletonClass sharedSingleton].deptId==1){
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"about"]isEqual:@"mission"])
            content.text=@"Lack of access to health care providers in the United States is a massive, growing problem. The average wait time to see a physician is three weeks. Even if you can see a doctor, it takes 2-3 hours from the time you leave your home or office to the time you get back home. It takes an average of 25 days to see a psychiatrist or psychologist. Nearly half of patients with mental health issues go without treatment.\n\nWe're not getting the care that we need. We built Doctor On Demand to help address this problem.\n\nAt Doctor On Demand we provide fast, easy and cost-effective access to some of the best doctors, psychologists, and other healthcare providers in the country. Our patients can have Video Visits with these providers on their smartphone or computers at any time of day.\n\nWe do this without sacrificing quality. All providers are carefully screened and trained to conduct Video Visits.\n\nWe started with Board-Certified Physicians, who are confident in applying their experience and expertise to addressing your medical problem. We now offer access to Licensed Psychologists, who provide help for a tremendous range of mental and emotional health concerns. And, our Lactation Consultants provide invaluable support to moms as they navigate the critical first months of their babies' lives.\n\nTomorrow? We'll provide care from even more health-care providers. We won't stop until we can help you improve all aspects of your physical, emotional, and behavioral health.\n\nThis is the better way to feel better.";

        
        else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"about"]isEqual:@"privacy"])
            content.text=@"At Doctor On Demand, we take privacy very seriously since it is our responsibility to protect the privacy and security of your personal information. We store member personal information behind two layers of encryption in a secure digital environment that is continuously monitored and routinely tested by leading experts in health information security. We restrict access to this environment using multiple safeguards such as dual factor authentication to ensure that only authorized clinical professionals and administrative personnel can access member personal information, and only on an as-needed basis. Your privacy is protected under strict Company rules that prohibit the use or disclosure of member personal information in an improper manner or without proper authorization. These rules are set forth in our internal and Site privacy policies and actively monitored and enforced by our Chief Privacy Officer and Chief Security Officer.";
        
        else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"consultant"]isEqual:@"screening"])
            content.text=@"Being a new mom brings up so many questions, worries and concerns. While breastfeeding is a common part of motherhood, it doesn't always come naturally and can be especially challenging. No matter what the question, when it comes to breastfeeding, the Lactation Consultants at Doctor On Demand are available to guide and support moms in their breastfeeding goals.\n\nAll of our Lactation Consultants are International Board Certified Lactation Consultants (IBCLCs), meaning they have completed a number of prerequisite medical courses along with hours of field practice alongside another IBCLC. Because of the extensive training and clinical background IBCLCs are highly qualified to identify and troubleshoot problems, both from the perspective of mom and baby. Our Lactation Consultants have worked with thousands of moms, helping them create the breastfeeding experience that fits both mom and baby.\n\nEach LC is carefully screened to ensure that they have:\n\n· Years of experience practicing and helping moms find success in breastfeeding\n\n· A focus on mom and extending the period of breastfeeding\n\n· Warm, accepting personalities to help mom meet her breastfeeding goals\n\n· Endorsements from Obstetricians, Family Doctors and other Lactation Consultants that are respected in the field\n\nWe also have several LCs who are bilingual, to assist mom in the language she feels most comfortable speaking. We want to ensure each mom is able to express her breastfeeding goals, concerns and worries, so we can help her at any stage on breastfeeding in a healthy, satisfying way. We seek to help moms resolve breastfeeding issues and extend the period of breastfeeding, all from the comfort of home.";
        

        
        
    }

    
    height1=[self calculateHeight:content.text];
    content.frame=CGRectMake(10, topview.frame.size.height+20, myScroll.frame.size.width-20, height1+10);
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
    
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"OurDoctors"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    

    
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
