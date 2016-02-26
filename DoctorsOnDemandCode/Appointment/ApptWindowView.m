//
//  ApptWindowView.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 8/13/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "ApptWindowView.h"

@interface ApptWindowView ()
{
    CGSize screenRect;
}


@end

@implementation ApptWindowView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    screenRect = [[UIScreen mainScreen] bounds].size;
    
  //  UIImage *headerImage = [UIImage imageNamed:@"head_logo"];
    
    
   // self.navigationItem.titleView = [[UIImageView alloc] initWithImage:headerImage] ;
    
    
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    UIView * headerView =[[UIView alloc]init];
    headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55);
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]init];
   titleLable.frame= CGRectMake(60, 25, screenRect.width-120, 25);
    titleLable.text =@"APPOINTMENT WINDOW ";
      titleLable.font =[UIFont fontWithName:@"GothamRounded-Light" size:12];
    titleLable.textAlignment = NSTextAlignmentCenter;
   
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
   [backButton setFrame:CGRectMake(15, 18, 55, 35)];    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
    UIButton *nextButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setImage:[UIImage imageNamed:@"next_btn.png"] forState:UIControlStateNormal];
   [nextButton setFrame:CGRectMake(screenRect.width-60, 24, 45, 25)];
    [nextButton addTarget:self action:@selector(continueAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:nextButton];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        headerView.frame= CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80);
        titleLable.frame= CGRectMake(60, 25, screenRect.width-120, 35);
        titleLable.font=[UIFont fontWithName:@"GothamRounded-Light" size:26];
        [backButton setImage:[UIImage imageNamed:@"back_btn_ipad.png"] forState:UIControlStateNormal];
        [backButton setFrame:CGRectMake(15, 30, 80, 25)];
        
                        [nextButton setImage:[UIImage imageNamed:@"next_btn-ipad.png"] forState:UIControlStateNormal];
                        [nextButton setFrame:CGRectMake(screenRect.width-100, 28, 80, 25)];
        
    }
    
    [self createUi];
    
       // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)createUi{
    
    
    
    UILabel *label=[[UILabel alloc]init];
    
    
    if(screenRect.height>=667){
        
        label.frame=CGRectMake(0,0, screenRect.width, 50);
    }
    else
    
    label.frame=CGRectMake(0,0, screenRect.width, 50);
  
    label.numberOfLines=2;
    label.textAlignment=NSTextAlignmentCenter;
    label.text=@"Your appointment will\nbegin between";
    label.font =[UIFont fontWithName:@"GothamRounded-Medium" size:16];
    label.textColor=[UIColor whiteColor];
    
    UIView *views=[[UIView alloc]init];
    views.frame = CGRectMake(0, 55, screenRect.width, 150);
       views.backgroundColor=[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1];
    [self.view addSubview:views];
    [views addSubview:label];
    
    
    
    UILabel *timeLabel=[[UILabel alloc]init];
    if(screenRect.height==480){
        timeLabel.frame=CGRectMake(0,30, screenRect.width, 100);
    }
    else if(screenRect.height==568){
    timeLabel.frame=CGRectMake(0,100, screenRect.width, 50);
    }
    else if (screenRect.height>=667){
         timeLabel.frame=CGRectMake(0,60, screenRect.width, 50);
    }
    timeLabel.numberOfLines=2;
    timeLabel.textAlignment=NSTextAlignmentCenter;
    timeLabel.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"appointmentTime"];
       timeLabel.font =[UIFont fontWithName:@"GothamRounded-Bold" size:18];
    timeLabel.textColor=[UIColor whiteColor];
   [views addSubview:timeLabel];
    
    
    
    
    UILabel *informLabel=[[UILabel alloc]init];
    
    if (screenRect.height>=667){
        informLabel.frame=CGRectMake(0,250, screenRect.width, 50);
    }
    else
    
    informLabel.frame=CGRectMake(0,235, screenRect.width, screenRect.height-400);
    informLabel.numberOfLines=3;
    
    
    
    informLabel.text=@"We will hold your appointment\nrequest for 30 minutes while you\nanswer a few questions.";
       informLabel.font =[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    informLabel.textAlignment=NSTextAlignmentCenter;
    informLabel.textColor=[UIColor blackColor];
    [self.view addSubview:informLabel];
    
    
    UIButton *continueButton=[[UIButton alloc]init];
    if (screenRect.height>=667){
        continueButton.frame=CGRectMake(20,400, screenRect.width-40, 50);
    }
    
    else
    continueButton.frame= CGRectMake(20, 380, screenRect.width-40, 50);
    [continueButton setTitle:@"Continue" forState:UIControlStateNormal];
       continueButton.titleLabel.font =[UIFont fontWithName:@"GothamRounded-Medium" size:14];
    [continueButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [continueButton setBackgroundColor:[UIColor colorWithRed:(CGFloat)234/255 green:(CGFloat)30/255 blue:(CGFloat)99/255 alpha:(CGFloat)1.0]];
    [continueButton addTarget:self action:@selector(continueAction) forControlEvents:UIControlEventTouchUpInside];
    continueButton.layer.cornerRadius=10.0f;
    [self.view addSubview:continueButton];
    
    if (UI_USER_INTERFACE_IDIOM()==  UIUserInterfaceIdiomPad) {
        views.frame = CGRectMake(0, 80, screenRect.width, screenRect.height/3);

        label.frame=CGRectMake(0,0, screenRect.width, 100);
        label.font = [UIFont fontWithName:@"GothamRounded-Medium" size:25];
        label.textAlignment = NSTextAlignmentCenter;
        informLabel.frame=CGRectMake(0,views.frame.origin.y+views.frame.size.height, screenRect.width, 200);
         informLabel.font =[UIFont fontWithName:@"GothamRounded-Medium" size:25];
        informLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.frame=CGRectMake(0,label.frame.origin.y+label.frame.size.height+75, screenRect.width, 80);
        timeLabel.font =[UIFont fontWithName:@"GothamRounded-Bold" size:35];
         continueButton.frame= CGRectMake(60, screenRect.height-250, screenRect.width-120, 100);
        continueButton.titleLabel.font = [UIFont systemFontOfSize:30];
    }
    
    
}
-(void)continueAction{
    
    
    
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"scheduleMethod"]isEqual:@"byTime"])
        
    {
        ChoosePsychologistVC *choosePsychologist=[[ChoosePsychologistVC alloc]init];
        [self.navigationController pushViewController:choosePsychologist animated:YES];
    }
    else{
    PuposeOfVisitView *purposeOfVisitView=[[PuposeOfVisitView  alloc]init];
    [self.navigationController pushViewController:purposeOfVisitView animated:YES];
    }
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
