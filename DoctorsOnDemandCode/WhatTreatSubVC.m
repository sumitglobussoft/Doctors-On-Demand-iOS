//
//  WhatTreatSubVC.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 10/14/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "WhatTreatSubVC.h"

@interface WhatTreatSubVC (){
    CGSize screenRect;
    UIScrollView *myScroll;
     UILabel *mainLabel,*subLabel;
    CGFloat height1,height2,height3,height4,height5,height6,height7,height8;
}

@end

@implementation WhatTreatSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    screenRect=[[UIScreen mainScreen]bounds].size;
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
  
  
   // if([SingletonClass sharedSingleton].deptId==4){
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"sore"]){
        titleLable.text=@"Sore Throat";
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"UTI"]){
        titleLable.text=@"UTIs";
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"sports"]){
        titleLable.text=@"Sports";
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"rashes"]){
        titleLable.text=@"Rashes";
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"Cold"] && [SingletonClass sharedSingleton].deptId==4){
        titleLable.text=@"Cold & Flu";
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"Cold"] && [SingletonClass sharedSingleton].deptId==2){
        titleLable.text=@"Child Cold & Flu";
    }

    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"eye"]){
        titleLable.text=@"Eyes";
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"diarrhea"])
        titleLable.text=@"diarrhea";
else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"dont-trust"] && [SingletonClass sharedSingleton].deptId==4)
                titleLable.text=@"Don't Treat";
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"dont-trust"] && [SingletonClass sharedSingleton].deptId==2)
     titleLable.text=@"Ped Don't Treat";
        
    //}
//    else if ([SingletonClass sharedSingleton].deptId==2){
//    
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"PediacCare"] isEqual:@"pediaTriaghe"])
            titleLable.text=@"Pediactric Triage";
        
        else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"PediacCare"] isEqual:@"rashes"])
            titleLable.text=@"Rashes";
    
          else    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"lacatTreat"] isEqual:@"topMomIssues"] )            titleLable.text=@"Mom Issues";

           else    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"lacatTreat"] isEqual:@"topBabyIssues"] )            titleLable.text=@"Baby Issues";

   
    
//            }


    
    

    


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
    
    
    
    
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"sore"]){
        logoView.image=[UIImage imageNamed:@"medical_img_back.png"];
        [logoView setContentMode:UIViewContentModeScaleAspectFit];
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"UTI"]){
        logoView.image=[UIImage imageNamed:@"medical_img_back.png"];
        [logoView setContentMode:UIViewContentModeScaleAspectFit];

    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"sports"]){
        logoView.image=[UIImage imageNamed:@"medical_img_back.png"];
        [logoView setContentMode:UIViewContentModeScaleAspectFit];

    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"rashes"]){
        logoView.image=[UIImage imageNamed:@"medical_img_back.png"];
        [logoView setContentMode:UIViewContentModeScaleAspectFit];
    }
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"Cold"]){
        logoView.image=[UIImage imageNamed:@"medical_img_back.png"];
        [logoView setContentMode:UIViewContentModeScaleAspectFit];
    }
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"travel"]){
        logoView.image=[UIImage imageNamed:@"medical_img_back.png"];
        [logoView setContentMode:UIViewContentModeScaleAspectFit];

    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"eye"]){
        logoView.image=[UIImage imageNamed:@"medical_img_back.png"];
        [logoView setContentMode:UIViewContentModeScaleAspectFit];

    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"diarrhea"]){
        logoView.image=[UIImage imageNamed:@"medical_img_back.png"];
        [logoView setContentMode:UIViewContentModeScaleAspectFit];
    }
    
    
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"dont-trust"]){
      
    
    }

     else   if([[[NSUserDefaults standardUserDefaults]objectForKey:@"PediacCare"] isEqual:@"pediaTriaghe"]){
            logoView.image=[UIImage imageNamed:@"medical_img_back.png"];
        [logoView setContentMode:UIViewContentModeScaleAspectFit];
        }

        
        else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"PediacCare"] isEqual:@"rashes"]){
            logoView.image=[UIImage imageNamed:@"medical_img_back.png"];
        [logoView setContentMode:UIViewContentModeScaleAspectFit];
        }
        else    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"lacatTreat"] isEqual:@"topMomIssues"] ){
            logoView.image=[UIImage imageNamed:@"medical_img_back.png"];
    [logoView setContentMode:UIViewContentModeScaleAspectFit];
        }
        else    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"lacatTreat"] isEqual:@"topBabyIssues"] ){
            logoView.image=[UIImage imageNamed:@"medical_img_back.png"];
    [logoView setContentMode:UIViewContentModeScaleAspectFit];
        }
    
        else{
            
        }

    
            
        

        
           

    
    //[logoView sizeToFit];
    
    [myScroll addSubview:logoView];
    
   
    
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"sore"]){
       [self soreThroat];    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"UTI"]){
       [self soreThroat];
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"sports"]){
       [self soreThroat];
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"rashes"]){
       [self soreThroat];
    }
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"Cold"]){
        [self coldTravelEyesDia];
    }
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"travel"]){
        [self coldTravelEyesDia];
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"eye"]){
       [self coldTravelEyesDia];
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"diarrhea"]){
        [self coldTravelEyesDia];
    }
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"dont-trust"]) {
        [self dontTreat];
    }
   
      else    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"PediacCare"] isEqual:@"pediaTriaghe"] )
          [self coldTravelEyesDia];

       else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"PediacCare"] isEqual:@"rashes"] )
                [self coldTravelEyesDia];

       else    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"lacatTreat"] isEqual:@"topMomIssues"] )
           [self momIssues];
        
       else    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"lacatTreat"] isEqual:@"topBabyIssues"] )
           [self babyIssues];
    


    
    
        
    
    
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"commonVC"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"PediacCare"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"lacatTreat"];
    [[NSUserDefaults standardUserDefaults]synchronize];


    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-Top mom Issues
-(void)momIssues{
    mainLabel=[[UILabel alloc]init ];
    
       mainLabel.text=@"Issues Affecting Mom";
    
   
    mainLabel.frame=CGRectMake(10,170,screenRect.width-20,30);
    mainLabel.textColor=[UIColor blackColor];
    mainLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:18];
    [myScroll addSubview:mainLabel];
    
    
    subLabel=[[UILabel alloc]init];
    subLabel.text=@"It is very common for new parents to experience challenges with breastfeeding and to have questions and concerns. Doctor On Demand works with International Board Certified Lactation Consultants (IBCLCs) to provide the guidance and support new moms need, so they can have the best possible experience breastfeeding. The first two weeks of breastfeeding is especially crucial. Mom is tired, but must adjust to her milk supply. Baby is learning to latch. If baby's latch is incorrect then this is when sore and cracked nipples can very quickly come into play. It's important to lay down good breastfeeding habits in the first two weeks and our Lactation Consultants at Doctor On Demand are ready to help. Doctor On Demand provides an alternative to visiting a doctor's office, giving moms the guidance they need, from the comfort of home. We understand the more confident moms feel breastfeeding, the more they feel encouraged to extend breastfeeding. In fact, 80%+ of issues can be treated in only 1-2 visits with a Lactation Consultant. If treated within the first 48 hours, that percentage of success increases to 85-90%. The most common issues for mothers include:";
   CGFloat h1=[self calculateHeight:subLabel.text];
    subLabel.frame=CGRectMake(10,210,screenRect.width-20,h1);
    subLabel.textColor=[UIColor blackColor];
    subLabel.numberOfLines=50;
    subLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [myScroll addSubview:subLabel];
    
    
    mainLabel=[[UILabel alloc]init ];
    
    mainLabel.text=@"1) Sore nipples";
    
    
    mainLabel.frame=CGRectMake(10,210+h1,screenRect.width-20,30);
    mainLabel.textColor=[UIColor blackColor];
    mainLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    [myScroll addSubview:mainLabel];
    
    
    
    subLabel=[[UILabel alloc]init];
    subLabel.text=@"Sore and tender nipples for the first couple of weeks is expected, but cracked, bleeding, scabbed and/or blistered nipples are usually signs of a problem. A Lactation Consultant (LC) may be able to determine the problem simply based on the appearance of the nipple injury and provide a plan of action. For example a linear scab or bruise means mom is having positional issues. The Lactation Consultant may walk her through what's called an asymmetrical latch, which a lot of moms don't naturally do, to line up the baby better for feeding. Seeking help from a Lactation Consultant at the onset of any of these symptoms could prevent further damage.";
    CGFloat h2=[self calculateHeight:subLabel.text];
    subLabel.frame=CGRectMake(10,210+h1+30,screenRect.width-20,h2);
    subLabel.textColor=[UIColor blackColor];
    subLabel.numberOfLines=50;
    subLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [myScroll addSubview:subLabel];
    
    
    mainLabel=[[UILabel alloc]init ];
    
    mainLabel.text=@"2) Milk production";
    
    
    mainLabel.frame=CGRectMake(10,210+h1+30+h2,screenRect.width-20,30);
    mainLabel.textColor=[UIColor blackColor];
    mainLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    [myScroll addSubview:mainLabel];
    
    
    subLabel=[[UILabel alloc]init];
    subLabel.text=@"Am I making enough milk? Am I feeding frequently enough? Every mom worries if her baby is getting enough breast milk because she can't measure how much is going to her baby. One visit with our Lactation Consultants provides peace of mind in many ways, and will help to ensure mom understands whether her baby is getting the breast milk she needs to thrive and be healthy. For example, mom can weigh the baby and count how many times her baby urinates. There are many simple ways our trained LCs can put mom's mind at ease.";
    CGFloat h3=[self calculateHeight:subLabel.text];
    subLabel.frame=CGRectMake(10,210+h1+30+h2+30,screenRect.width-20,h3);
    subLabel.textColor=[UIColor blackColor];
    subLabel.numberOfLines=50;
    subLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [myScroll addSubview:subLabel];



    mainLabel=[[UILabel alloc]init ];
    
    mainLabel.text=@"3) Plugged ducts and mastitis";
    
    
    mainLabel.frame=CGRectMake(10,210+h1+30+h2+30+h3,screenRect.width-20,30);
    mainLabel.textColor=[UIColor blackColor];
    mainLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    [myScroll addSubview:mainLabel];
    

    subLabel=[[UILabel alloc]init];
    subLabel.text=@"If a new mom finds a lump or a hardened area of the breast with or without flu-like symptoms it could be a plugged duct or mastitis. Lactation Consultants can work with mom to resolve the plugs before they become infected. Lactation Consultants will also recognize when an infection has begun and refer the mother to a physician for treatment.";
    CGFloat h4=[self calculateHeight:subLabel.text];
    subLabel.frame=CGRectMake(10,210+h1+30+h2+30+h3+30,screenRect.width-20,h4);
    subLabel.textColor=[UIColor blackColor];
    subLabel.numberOfLines=50;
    subLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [myScroll addSubview:subLabel];
    
    
    mainLabel=[[UILabel alloc]init ];
    
    mainLabel.text=@"4)Returning To Work, Bottles & Storage";
    
     CGFloat h5=[self calculateHeight:mainLabel.text];
    mainLabel.frame=CGRectMake(10,210+h1+30+h2+30+h3+30+h4,screenRect.width-20,h5);
    mainLabel.textColor=[UIColor blackColor];
    mainLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    [myScroll addSubview:mainLabel];
    
    
    subLabel=[[UILabel alloc]init];
    subLabel.text=@"Initially the majority of breastfeeding problems are soreness, tiredness and the newness of it all. But when babies are around 3 months old many moms in the US go back to work and new issues start - 'my baby won't take a bottle' or 'I'm not making enough to store, how do I increase my supply?' Our Lactation Consultants can advise on which bottles to use, how to sterilize them, and recommended pumps, how long to pump for, how to store the milk and more. Our Lactation Consultants are trained to give researched based answers, not just share what worked for them, to allow mom to make more informed decisions on what is best for her and her baby, and to breastfeed for as long as she would like.";
    CGFloat h6=[self calculateHeight:subLabel.text];
    subLabel.frame=CGRectMake(10,210+h1+30+h2+30+h3+30+h4+h5,screenRect.width-20,h6+10);
    subLabel.textColor=[UIColor blackColor];
    subLabel.numberOfLines=50;
    subLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [myScroll addSubview:subLabel];
    


    
  
    

    
    float sizeOfContent = 0;
    UIView *lLast = [myScroll.subviews lastObject];
    NSInteger wd = lLast.frame.origin.y;
    NSInteger ht = lLast.frame.size.height;
    NSInteger offset=50;
    sizeOfContent = wd+ht;
    myScroll.contentSize=CGSizeMake(screenRect.width,sizeOfContent+offset+10);

    
}


#pragma mark-Top Baby Issues
-(void)babyIssues{
    
    mainLabel=[[UILabel alloc]init ];
    
    mainLabel.text=@"Issues for baby";
    
    
    mainLabel.frame=CGRectMake(10,170,screenRect.width-20,30);
    mainLabel.textColor=[UIColor blackColor];
    mainLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:18];
    [myScroll addSubview:mainLabel];
    
    
    subLabel=[[UILabel alloc]init];
    subLabel.text=@"Breast milk has the ideal mix of vitamins, fats and proteins all specifically formulated for humans. it is human-to-human milk not cow to human, making it more easily digested and causing less stress on the baby's body.\n\nBut the benefits don't stop there. Infants who are breastfed are less likely to have allergies, respiratory problems, diarrhea (#1 issue with infants), ear infections and less likely to be hospitalized. While they may get colds, they tend to be upper respiratory, not lower respiratory like pneumonia, which can cause hospitalization. In fact, studies have shown a link between an exclusive diet of breast milk for the first six months of life and a higher IQ.\n\nFor all of these reasons, the Lactation Consultants with Doctor On Demand support and encourage moms to breastfeed. When a mom is having issues with breastfeeding, our International Board Certified Lactation Consultants (IBCLCs) want to help troubleshoot. There is so much that can be learned and easily taken care of with a short video chat.";
    CGFloat h1=[self calculateHeight:subLabel.text];
    subLabel.frame=CGRectMake(10,210,screenRect.width-20,h1);
    subLabel.textColor=[UIColor blackColor];
    subLabel.numberOfLines=50;
    subLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [myScroll addSubview:subLabel];
    
    
    subLabel=[[UILabel alloc]init];
    subLabel.text=@"Here are some of the issues affecting baby when breastfeeding:";
    CGFloat h2=[self calculateHeight:subLabel.text];
    subLabel.frame=CGRectMake(10,210+h1,screenRect.width-20,h2);
    subLabel.textColor=[UIColor blackColor];
    subLabel.numberOfLines=10;
    subLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    [myScroll addSubview:subLabel];
    
    
    mainLabel=[[UILabel alloc]init ];
    mainLabel.text=@"1) Weight Gain";
    mainLabel.frame=CGRectMake(10,210+h1+h2+10,screenRect.width-20,30);
    mainLabel.textColor=[UIColor blackColor];
    mainLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    [myScroll addSubview:mainLabel];
    
    
    subLabel=[[UILabel alloc]init];
    subLabel.text=@"Babies should gain approximately 5-7 ounces a week in the first months of life. If a mom calls concerned about the baby's weight we will evaluate the age of the baby and where she falls on the growth line. We'd also want to learn if the baby is satisfied after feeding, is she ok for a couple of hours or is she continually fussing and crying? Is she gassy or have colic or reflux? We would also consider the stool's appearance. We are trained to know what is normal and can help moms navigate through this confusing time.";
    CGFloat h3=[self calculateHeight:subLabel.text];
    subLabel.frame=CGRectMake(10,210+h1+h2+10+30,screenRect.width-20,h3+10);
    subLabel.textColor=[UIColor blackColor];
    subLabel.numberOfLines=50;
    subLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [myScroll addSubview:subLabel];

    mainLabel=[[UILabel alloc]init ];
    mainLabel.text=@"2) Feeding Issues";
    mainLabel.frame=CGRectMake(10,210+h1+h2+10+30+10+h3,screenRect.width-20,30);
    mainLabel.textColor=[UIColor blackColor];
    mainLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    [myScroll addSubview:mainLabel];
    
    
    subLabel=[[UILabel alloc]init];
    subLabel.text=@"Babies are not ""\"blank slates\" They are born with a personality, which often influences how they eat. There are those who always seem ravenous and have such a strong suck that they damage the nipple even with correct positioning. There are the ""\"snackers\"who want to eat for a couple minutes every 10-15 minutes. There are babies that don't seem to know how to suck as they are always pushing the nipple out of their mouth. Others, still, might have been born with mouth malformations which make sucking very difficult. Our LC's have the training and experience necessary to recognize these and know how to help moms work through them.";
    CGFloat h4=[self calculateHeight:subLabel.text];
    subLabel.frame=CGRectMake(10,210+h1+h2+10+30+10+h3+30,screenRect.width-20,h4);
    subLabel.textColor=[UIColor blackColor];
    subLabel.numberOfLines=50;
    subLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [myScroll addSubview:subLabel];
    
    
    mainLabel=[[UILabel alloc]init ];
    mainLabel.text=@"3) Teething / Biting";
    mainLabel.frame=CGRectMake(10,210+h1+h2+10+30+10+h3+30+h4,screenRect.width-20,30);
    mainLabel.textColor=[UIColor blackColor];
    mainLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    [myScroll addSubview:mainLabel];
    
    
    subLabel=[[UILabel alloc]init];
    subLabel.text=@"Teething and biting can be painful for mom, but just because the baby is developing teeth does not mean they need to be weaned. Our Lactation Consultants will provide moms with tips to make teething a ""\"non-event\".";
    CGFloat h5=[self calculateHeight:subLabel.text];
    subLabel.frame=CGRectMake(10,210+h1+h2+10+30+10+h3+30+h4+30,screenRect.width-20,h5);
    subLabel.textColor=[UIColor blackColor];
    subLabel.numberOfLines=50;
    subLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [myScroll addSubview:subLabel];
    
    
    mainLabel=[[UILabel alloc]init ];
    mainLabel.text=@"4) Weaning";
    mainLabel.frame=CGRectMake(10,210+h1+h2+10+30+10+h3+30+h4+30+h5,screenRect.width-20,30);
    mainLabel.textColor=[UIColor blackColor];
    mainLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    [myScroll addSubview:mainLabel];
    
    
    subLabel=[[UILabel alloc]init];
    subLabel.text=@"The Lactation Consultant will guide mom through weaning or other feeding issues so that breastfeeding either resumes or mom can wean without becoming engorged and infected. The LC will guide mom through the weaning process or other feeding issues that might present themselves like weaning. For example, babies less than a year of age do not usually stop nursing on their own accord. There is usually a trigger, like a cold, or a tooth, or a sharp decrease in mom's milk supply.";
    CGFloat h6=[self calculateHeight:subLabel.text];
    subLabel.frame=CGRectMake(10,210+h1+h2+10+30+10+h3+30+h4+30+h5+30,screenRect.width-20,h6+10);
    subLabel.textColor=[UIColor blackColor];
    subLabel.numberOfLines=50;
    subLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [myScroll addSubview:subLabel];
    



    


    
    
    float sizeOfContent = 0;
    UIView *lLast = [myScroll.subviews lastObject];
    NSInteger wd = lLast.frame.origin.y;
    NSInteger ht = lLast.frame.size.height;
    NSInteger offset=50;
    sizeOfContent = wd+ht;
    myScroll.contentSize=CGSizeMake(screenRect.width,sizeOfContent+offset+10);

}




#pragma mark-Donot treat
-(void)dontTreat{
    mainLabel=[[UILabel alloc]init ];
    
  //  if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"dont-trust"])
        mainLabel.text=@"Conditions We Don't Treat";
   // else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"PediacCare"] isEqual:@"pediaTriaghe"])
          // mainLabel.text=@"Pediatric Triage";
    
    
    height2=[self calculateHeight:mainLabel.text];
    mainLabel.frame=CGRectMake(10,5,screenRect.width,height2+6);
    mainLabel.textColor=[UIColor blackColor];
    mainLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:18];
    [myScroll addSubview:mainLabel];
    
    
    subLabel=[[UILabel alloc]init];
    subLabel.text=@"There are many conditions Doctor On Demand physicians can often treat effectively through a Video Visit - from a sudden rash, a mild muscle sprain, an upset stomach and many more. But for more serious or chronic conditions, a visit to a doctor or hospital is important and necessary.";
    height1=[self calculateHeight:subLabel.text];
    subLabel.frame=CGRectMake(10,20+height2,screenRect.width-20,height1);
    subLabel.textColor=[UIColor blackColor];
    subLabel.numberOfLines=50;
    subLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [myScroll addSubview:subLabel];
    
    mainLabel=[[UILabel alloc]init ];
    mainLabel.text=@"1) Cancer or Other Complex Conditions";
    height3=[self calculateHeight:mainLabel.text];
    mainLabel.frame=CGRectMake(10,30+height2+height1,screenRect.width,height3);
    mainLabel.textColor=[UIColor blackColor];
    mainLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    [myScroll addSubview:mainLabel];
    
    subLabel=[[UILabel alloc]init];
    subLabel.text=@"Patients who have complex, tertiary medical problems that they have been dealing with for years are not likely to have a short term resolution to their problem and more likely to have aspects of their medical history that would be important to their diagnosis and treatment. Furthermore, their symptoms are more likely to present in uncommon ways and in certain cases require advanced testing such as medical imaging to ascertain the diagnosis.";
    height4=[self calculateHeight:subLabel.text];
    subLabel.frame=CGRectMake(10,40+height2+height1+height3,screenRect.width-20,height4);
    subLabel.textColor=[UIColor blackColor];
    subLabel.numberOfLines=50;
    subLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [myScroll addSubview:subLabel];
    
    mainLabel=[[UILabel alloc]init ];
    mainLabel.text=@"2) Chronic Conditions";
    height5=[self calculateHeight:mainLabel.text];
    mainLabel.frame=CGRectMake(10,50+height2+height1+height3+height4,screenRect.width,height5);
    mainLabel.textColor=[UIColor blackColor];
    mainLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    [myScroll addSubview:mainLabel];

    
    subLabel=[[UILabel alloc]init];
    subLabel.text=@"Having a chronic condition means you're dealing with your condition and its symptoms on a constant basis. It can also mean regular and frequent visits with your doctor as well, which can be very time-consuming. For the most effective treatment of chronic conditions, it's important to see your primary care physician. Doctor On Demand is not intended to replace the care you receive from your primary care physician.";
    height6=[self calculateHeight:subLabel.text];
    subLabel.frame=CGRectMake(10,60+height2+height1+height3+height4+height5,screenRect.width-20,height6);
    subLabel.textColor=[UIColor blackColor];
    subLabel.numberOfLines=50;
    subLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [myScroll addSubview:subLabel];


    

    
    float sizeOfContent = 0;
    UIView *lLast = [myScroll.subviews lastObject];
    NSInteger wd = lLast.frame.origin.y;
    NSInteger ht = lLast.frame.size.height;
    NSInteger offset=50;
    sizeOfContent = wd+ht;
    myScroll.contentSize=CGSizeMake(screenRect.width,sizeOfContent+offset+10);

}

#pragma mark-Cold/travel/Eyes/Diarrhea UI
-(void)coldTravelEyesDia{
    
    mainLabel=[[UILabel alloc]init ];
    
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"Cold"])
    mainLabel.text=@"Cough/Cold/Flu/Allergies";
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"travel"])
        mainLabel.text=@"Travel";
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"eye"])
          mainLabel.text=@"Eye Conditions";
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"diarrhea"])
        mainLabel.text=@"Diarrhea & Vomiting";
    else    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"PediacCare"] isEqual:@"pediaTriaghe"] )
        mainLabel.text=@"Pediatrics Triage";
    
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"PediacCare"] isEqual:@"rashes"] )
       mainLabel.text=@"Conditions Affecting\nthe Skin-Pediatric";
    

    
    mainLabel.numberOfLines=3;
    height2=[self calculateHeight:mainLabel.text];
    mainLabel.frame=CGRectMake(10,170,screenRect.width,height2+15);
    mainLabel.textColor=[UIColor blackColor];
    mainLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:18];
    [myScroll addSubview:mainLabel];
    
    
    subLabel=[[UILabel alloc]init];
    
     if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"Cold"])
     subLabel.text=@"Upper respiratory infections are the broad category for flu, sinus infections, bronchitis, runny noses, coughs and colds. These common conditions can be diagnosed through Doctor on Demand, keeping you out of the Doctor's office and away from unnecessary germs.";
    
     else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"travel"])
        subLabel.text=@"Travel is exciting: new places, new foods, new experiences. Unfortunately, travel can also bring with it exposure to pathogens, germs and overall stress on your body. Doctor on Demand can assist in all stages of travel. Whether you are about to travel, are currently traveling or have just returned from a trip, Doctor on Demand Video Visits are available wherever you have internet access, which can be very assuring!";
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"eye"])
         subLabel.text=@"Having an issue with one or both eyes can significantly and severely impact a patient's lifestyle, causing not only pain but the inability to carry out necessary tasks. For the eyes, getting quick, accurate advice is very important. There are three basic categories: minor issues, moderate issues that require interim care followed by specialist care, and severe issues.\n\nDiagnosing the condition and severity often begins with questions about pain, discharge and previous eye damage, and the collection of a patient's medical history. Then on camera, the physician can have the patient do several eye maneuvers and ask for still photographs to better assess the eye. The high integrity of photographs through the app allows the physician to see even better than the naked eye.";
       else    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"PediacCare"] isEqual:@"pediaTriaghe"] )
           subLabel.text=@"We all know that infants and children get sick more frequently than adults. And parents are naturally concerned when their children aren't feeling like themselves.";
       else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"PediacCare"] isEqual:@"rashes"] )
            subLabel.text=@"Rashes, bites, scrapes, hives and sores are very common in children. Sometimes these incidents are very minor. Other cases can be much more severe, potentially related to immune system issues. It is critical to get your child's skin condition evaluated by a physician.";
    
    else
        subLabel.text=@"";
    height1=[self calculateHeight:subLabel.text];
    subLabel.frame=CGRectMake(10,186+height2,screenRect.width-20,height1+20);
    subLabel.textColor=[UIColor blackColor];
    subLabel.numberOfLines=50;
    subLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [myScroll addSubview:subLabel];
    
    
    
    mainLabel=[[UILabel alloc]init ];
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"Cold"])
    mainLabel.text=@"Diagnosis-Listening";
   
    else  if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"travel"])
        mainLabel.text=@"About to Travel";
   
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"eye"])
        mainLabel.text=@"Minor Conditions";
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"diarrhea"])
         mainLabel.text=@"Diarrhea";
     else    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"PediacCare"] isEqual:@"pediaTriaghe"] )
           mainLabel.text=@"Does it work?";
     else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"PediacCare"] isEqual:@"rashes"] )
          mainLabel.text=@"How We Diagnose";

    height3=[self calculateHeight:mainLabel.text];
    mainLabel.frame=CGRectMake(10,206+height1+height2,screenRect.width,height3+6);
    mainLabel.textColor=[UIColor blackColor];
    mainLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    [myScroll addSubview:mainLabel];
    
    
    subLabel=[[UILabel alloc]init];
        if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"Cold"])
    subLabel.text=@"In diagnosing an upper respiratory infection, listening to the patient's story is very important -- has the patient had this before? Medication changes? Recent travel? What exactly are the symptoms? Does anyone around them have the same symptoms? How long has this been happening?";
   
        else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"travel"])
         subLabel.text=@"If you are about to travel, we can provide you with advice on travel medicines, vaccines, prophylactic measures, foods and liquids to avoid, how to keep yourself safe, current and prevalent illnesses in the area, and signs and symptoms to look out for. For example, there is a clinical trial that showed Pepto Bismol, taken 7-14 days in advance of a trip to certain areas of the world, can vastly reduce the chances of gastro-intestinal flu and traveler's vomiting and diarrhea. Why learn about what could have helped after you return? Consult with one of our physicians so we can help you make the most of your trip and stay healthy.";
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"eye"])
        subLabel.text=@"Minor conditions like pink eye, colobomas and styes are very common and often treated with remedies like prescription eye drops, warm compresses, cold compresses, etc.";
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"diarrhea"])
        subLabel.text=@"Diagnosing the cause and determining appropriate treatment of diarrhea typically begins with very focused clinical questions such as: How long have you had it? What type is it? What is your travel history? Have you been exposed to other sick individuals? The physician may also check whether you are running a fever. To treat diarrhea there are many conservative measures like consuming large amounts of water, or even better Pedialyte or Gatorade, which are similar to the consistency of your blood and thus retained better. Your physician may also recommend a special diet, over the counter and/or prescription medications, or follow-up care.";
    else    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"PediacCare"] isEqual:@"pediaTriaghe"] )
        subLabel.text=@"With Doctor On Demand, physicians can evaluate your child's condition immediately. You'll know whether their injury or illness requires in-person medical attention or not. In most cases, the physicians are able to treat your child at home with a prescription or non-prescription therapy and/or resolve any specific medical questions you have.";
     else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"PediacCare"] isEqual:@"rashes"] )
         subLabel.text=@"Skin conditions are very often diagnosable by visual inspection. An important component of dermatological assessment is recognizing patterns, features, signs and symptoms. Questions about your child's recent activities and duration of symptoms also help in making a diagnosis.";


    
    
    height4=[self calculateHeight:subLabel.text];
    subLabel.frame=CGRectMake(10,216+height1+height2+height3,screenRect.width-20,height4+8);
    subLabel.textColor=[UIColor blackColor];
    subLabel.numberOfLines=50;
    subLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [myScroll addSubview:subLabel];

    
    
    
    mainLabel=[[UILabel alloc]init ];
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"Cold"])
    mainLabel.text=@"Diagnosis-Inspection and Exam";
    
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"travel"])
    mainLabel.text=@"During Travel";
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"eye"])
    mainLabel.text=@"Moderate Conditions";
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"diarrhea"])
    mainLabel.text=@"Vomiting";
      else    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"PediacCare"] isEqual:@"pediaTriaghe"] )
             mainLabel.text=@"Avoid the wait and germs of the waiting room";
      else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"PediacCare"] isEqual:@"rashes"] )
          mainLabel.text=@"Using the Camera";
        
        
    height5=[self calculateHeight:mainLabel.text];
    mainLabel.frame=CGRectMake(10,226+height1+height2+height3+height4,screenRect.width,height5+6);
    mainLabel.textColor=[UIColor blackColor];
    mainLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    [myScroll addSubview:mainLabel];
    
    
    subLabel=[[UILabel alloc]init];
    
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"Cold"])
    subLabel.text=@"Along with the patient story, doctors will typically ask patients to go through a series of physical examination techniques.These may include taking a high resolution image of the patient's throat so the physician can see any redness or puffiness, pressing on the sinuses and lymph nodes to identify areas of pain or pressure, and coughing so the physician can listen for signs of bronchitis.";
    
       else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"travel"])
    subLabel.text=@"Doctor On Demand is available everywhere domestically by smartphone, tablet or computer, and if traveling internationally, you can connect with a physician from anywhere you have internet access. Imagine you're away from home, you don't know local doctors and you aren't feeling well. Connect with a doctor for a Video Visit. Our doctor's can tell you whether your condition requires urgent care, if you can wait to be treated or if it's something that needs to run its course. While they cannot prescribe medications internationally, the physicians at Doctor On Demand Professionals can diagnose your condition, suggest medications that may be available where you are, share non-prescription remedies, inform you of medical treatments to avoid and determine if you should adjust your travel plans. Don't let an illness ruin your travel. We can help, at the very least in the short-term, and put your mind at ease.";
    
       else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"eye"])
        subLabel.text=@"This category includes more serious conditions like a severe eye infection or corneal abrasion, which do not require emergency care but should be treated within 48 hours to avoid further damage. Doctor On Demand can provide this immediate care. For example, if you have a severe abrasion, the physician can order medication and/or a salve to help with the pain until you can see a specialist. Another example is Amaurosis fugax - the initial onset of a stroke. It often presents without pain, and can be identified by physicians during the Video Visit. By diagnosing this early, our physicians can help prevent strokes.";
    
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"diarrhea"])
        subLabel.text=@"Physicians are often able to determine the cause and provide treatment for vomiting during a Video Visit by reviewing your medical history, asking questions, and performing an exam. If you can keep food and liquids down, your physician can also recommend a particular diet to help with recovery.\n\nStomach and bowel upsets and issues can be caused by many factors: bad food, a prescription drug reaction, an allergy, germs and more. By connecting with Doctor On Demand, you are able to stay in the comfort of home and get immediate care.\n\nBoth diarrhea and vomiting can often be evaluated and treated through Doctor On Demand. Your physician will frequently be able to determine the severity, recommend treatments and suggest additional medical care if necessary. They can also make recommendations to prevent future illnesses.";
    

          else    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"PediacCare"] isEqual:@"pediaTriaghe"] )
               subLabel.text=@"By using Doctor On Demand to meet with a physician, you can help keep your child away from unnecessary exposure to the more than 2 million Healthcare Associated Infections in the US each year and help prevent the spread of infectious diseases like the flu.";
          else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"PediacCare"] isEqual:@"rashes"] )
              subLabel.text=@"Thanks to advances in technology, images transmitted through the Doctor On Demand app are extremely high resolution. The images are even more detailed than what physicians can see with their naked eye.\n\nParents can upload multiple photos of the child's skin condition safely and directly to your physician. The photos are transmitted with lossless compression. The camera allows you to take several views of the condition. We also have the ability to store images in a patient's medical record to assess changes over time.";


    
    
    height6=[self calculateHeight:subLabel.text];
    subLabel.frame=CGRectMake(10,236+height1+height2+height3+height4+height5,screenRect.width-20,height6+6);
    subLabel.textColor=[UIColor blackColor];
    subLabel.numberOfLines=50;
    subLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [myScroll addSubview:subLabel];

    
    
    mainLabel=[[UILabel alloc]init ];
       if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"Cold"])
    mainLabel.text=@"Treatment Guidelines-Flu";
    else  if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"travel"])
        mainLabel.text=@"Returned from Travel";
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"eye"])
        mainLabel.text=@"Severe Conditions";
        else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"PediacCare"] isEqual:@"rashes"] )
             mainLabel.text=@"Common Treatments";

    height7=[self calculateHeight:mainLabel.text];
    mainLabel.frame=CGRectMake(10,246+height1+height2+height3+height4+height5+height6,screenRect.width,height7+6);
    mainLabel.textColor=[UIColor blackColor];
    mainLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    [myScroll addSubview:mainLabel];
    
    
    subLabel=[[UILabel alloc]init];
    
      if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"Cold"])
          subLabel.text=@"A new CDC guideline for flu suggests taking flu antiviral medications such as Tamiflu within 48 hours in order for these medications to be effective. By the time you start realizing you're sick, a day has already passed. Once the physician has gathered the facts and performed a comprehensive clinical assessment, he or she will determine if the patient requires treatment such as medication or at home remedies to quickly treat and help relieve their symptoms.";
    else  if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"travel"])
         subLabel.text=@"To effectively diagnose and treat post-travel conditions, the physicians at Doctor On Demand Professionals can ask about your travel history, review your history and perform an examination, combine that with accepted medical knowledge of triggers common to those regions, and help determine and coordinate any necessary follow-up care.";
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"eye"])
        subLabel.text=@"For the most severe injuries, like a metal shard in your eye, you will absolutely need urgent, in-person care.";
     else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"PediacCare"] isEqual:@"rashes"] )
           subLabel.text=@"Treatment may consist of a topical ointment or cream, or an oral medication. Physicians are only going to prescribe medication when necessary.";
    
    height8=[self calculateHeight:subLabel.text];
    subLabel.frame=CGRectMake(10,256+height1+height2+height3+height4+height5+height6+height7,screenRect.width-20,height8+6);
    subLabel.textColor=[UIColor blackColor];
    subLabel.numberOfLines=50;
    subLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [myScroll addSubview:subLabel];
    



    

    
    float sizeOfContent = 0;
    UIView *lLast = [myScroll.subviews lastObject];
    NSInteger wd = lLast.frame.origin.y;
    NSInteger ht = lLast.frame.size.height;
    NSInteger offset=50;
    sizeOfContent = wd+ht;
    myScroll.contentSize=CGSizeMake(screenRect.width,sizeOfContent+offset+10);
    


    
}

#pragma mark-SoreThroat/UTI/Sports/Rashes UI
-(void)soreThroat{
    
    
    mainLabel=[[UILabel alloc]init ];
    if([SingletonClass sharedSingleton].deptId==4){
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"sore"]){
    mainLabel.text=@"Sore Throat";
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"UTI"]){
        mainLabel.text=@"Urinary Tract Infection";
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"sports"]){
        mainLabel.text=@"Minor Sports Injuries";
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"rashes"]){
        mainLabel.text=@"Conditions Affecting the Skin";
    }
    }
       height2=[self calculateHeight:mainLabel.text];
    mainLabel.frame=CGRectMake(10,170,screenRect.width,height2+6);
    mainLabel.textColor=[UIColor blackColor];
   
    mainLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:18];
    [myScroll addSubview:mainLabel];
    
    
    subLabel=[[UILabel alloc]init];
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"sore"]){
    subLabel.text=@"A sore throat is a very common symptom which could be an indicator of a series of ailments, including many that can often be treated via Video Visit. It can be difficult for a patient to know if they have a Cold, Allergies, Strep Throat, or Tonsillitis unless they visit with a doctor.\n\nThe doctors at Doctor On Demand Professionals are trained to evaluate your symptoms and, depending on the clinical circumstances, diagnose and treat the various causes of a sore throat specifically through a Video Visit. You can make your visit more efficient by having your thermometer ready.\n\nA sore throat can also be an early sign of the flu. A new CDC guideline for flu suggests that you need to take antiviral medications such as Tamiflu within 48 hours in order for these medications to be effective. However, by the time you start realizing you're sick, a day has already passed. Based on the clinical assessment performed through the Video Visit, your doctor is able to determine if you need antiviral medication such as Tamiflu, or over-the-counter medication, at home remedies, or other treatments to relieve your symptoms.\n\nDuring a Video Visit, doctors ask many questions - e.g. have you had this before? Have you traveled recently? Does anyone around you have the same symptoms? How long has this been happening? Your physician may also ask to review medication history and other medical information that is readily available\n\nDuring Video Visits, Doctor On Demand physicians also examine patients. For example, the physician can use the video and high resolution camera on your phone to look deep inside a patient's mouth. Depending on the clinical circumstances, doctors are able to look for inflammation as well as carefully monitor other symptoms you may be experiencing such as congestion, swollen eyes, difficulty swallowing or speaking, and more. Your doctor can often use this information to make a diagnosis and then treat your condition safely and effectively.";
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"UTI"]){
        subLabel.text=@"Urinary tract infections (UTIs) are a very common condition. In fact, more often than not, when patients call Doctor On Demand they have already experienced the symptoms and have been diagnosed with this condition before.\n\nIf you are experiencing painful urination or bladder pain, your physician will often begin the Video Visit by asking the following types of questions: Have you had these symptoms before? Have you ever been diagnosed with a urinary tract infection? Is there discomfort and burning with urination? Was there an inciting event? Physicians listen carefully to determine whether the patient is suffering from a UTI or a more complicated condition that might present with similar symptoms. Collection of the patient's history is critical in determining whether a patient has an uncomplicated UTI or something else that may require follow-up testing or a physician office visit. The physician will also examine the patient, which may include among other things determining whether the patient has a fever or is experiencing tenderness or back pain.\n\nIn cases of an uncomplicated UTI, the Infectious Disease Society of America (IDSA) does not recommend a urinalysis.\n\nMost urinary tract infections are treated with prescription antibiotics. Ask your physician for suggestions on ways to prevent future urinary tract infections.";

    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"sports"]){

        
        subLabel.text=@"Sports and exercise activities are an important part of any healthy lifestyle. But, with increased activity comes the increased risk of injury. In the absence of an obviously severe injury like a broken bone, most doctor's visits concerning sports injuries are patients looking for reassurance that the injury is not more severe.\n\nSports injuries often fall into either a minor category (ankle sprains, wrist sprains, shoulder or rib soreness) or a severe category (broken bone, severely torn ligament/tendon).\n\nThe experience of a diagnosis and evaluation of sports injuries with a Doctor On Demand Video Visit is exactly like being in a doctor's office. For example, if you injured your ankle playing basketball, the physician can determine the severity of your injuries through a few exercises, learning more about where it hurts and the degree of pain on a scale of 1-10. If the physician determines your injury is severe (e.g. a broken bone or tear) then the physician may recommend a follow-up with a specialist. And if it's a simple sprain, home care like icing or a brace may be all that you need. With chronic cases like tennis elbow or pitcher's arm, the same thing is true -- the physician can often determine severity and treat minor injuries through a Doctor On Demand Video Visit.";

        
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"commonVC"] isEqual:@"rashes"]){
        
        
        subLabel.text=@"Our skin is the biggest organ in the human body, so it makes sense that most of us experience skin issues at some point in our lives. Common conditions include rashes, STDs, poison ivy, insect bites, cold sores, psoriasis, shingles, contact dermatitis, scrapes, allergies, hives, sores and boils. These conditions are most often diagnosable by visual inspection (having the physician look at the condition) during a Doctor On Demand Video Visit.\n\nAn important component of dermatological assessment is recognizing patterns, features, signs and symptoms. Using the hi-resolution camera through the Doctor On Demand app, you can upload multiple photos safely and directly to your physician. The photos are transmitted with lossless compression - meaning the pixel fidelity is maintained during transmission and the photos are even better than the naked eye. The camera allows you to take several views of the condition. Physicians also have the ability to store images in a patient's medical records to assess changes over time.\n\nTreatment may consist of a topical ointment or cream, or an oral medication, either a prescription, over the counter or something in your own home. Physicians are only going to prescribe medications when necessary. For example, a patient could present with a horrible looking rash that can be significantly improved with a few rounds of ice application. If a condition is treatable with simpler medications or no medications at all, physicians will almost always go that route.";
        
        
    }

    
    height1=[self calculateHeight:subLabel.text];
    subLabel.frame=CGRectMake(10,180+height2,screenRect.width-20,height1+20);
    subLabel.textColor=[UIColor blackColor];
    subLabel.numberOfLines=50;
    subLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [myScroll addSubview:subLabel];

    
    
    
    
    float sizeOfContent = 0;
    UIView *lLast = [myScroll.subviews lastObject];
    NSInteger wd = lLast.frame.origin.y;
    NSInteger ht = lLast.frame.size.height;
    NSInteger offset=50;
    sizeOfContent = wd+ht;
    myScroll.contentSize=CGSizeMake(screenRect.width,sizeOfContent+offset+10);
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"commonVC"];
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
