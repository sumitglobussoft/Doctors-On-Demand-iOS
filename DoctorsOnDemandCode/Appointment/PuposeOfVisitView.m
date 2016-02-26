//
//  PuposeOfVisitView.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 8/12/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "PuposeOfVisitView.h"

@interface PuposeOfVisitView (){
    CGSize screenRect;
    UIButton *skipButton;
    UIButton *nextButton;
    UIBarButtonItem *barButton;
    UITextView *textField;
}

@end

@implementation PuposeOfVisitView

- (void)viewDidLoad {
    screenRect = [[UIScreen mainScreen] bounds].size;
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    UIView * headerView =[[UIView alloc]init];
    headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55);
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]init];
   titleLable.frame = CGRectMake(60, 25, screenRect.width-120, 25);
    titleLable.text =@"PURPOSE OF VISIT";
    titleLable.font =[UIFont fontWithName:@"GothamRounded-Light" size:12];
    titleLable.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
   [backButton setFrame:CGRectMake(15, 18, 55, 35)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
    skipButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [skipButton setImage:[UIImage imageNamed:@"skip_btn.png"] forState:UIControlStateNormal];
 [skipButton setFrame:CGRectMake(screenRect.width-60, 28, 50, 20)];
    [skipButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:skipButton];
    
    [super viewDidLoad];
    
    if (UIUserInterfaceIdiomPad ==  UI_USER_INTERFACE_IDIOM()) {
         headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 75);
        
        titleLable.frame = CGRectMake(60, 25, screenRect.width-120, 25);
   titleLable.font=[UIFont fontWithName:@"GothamRounded-Light" size:26];
        
        [backButton setImage:[UIImage imageNamed:@"back_btn_ipad.png"] forState:UIControlStateNormal];
        [backButton setFrame:CGRectMake(15, 30, 80, 25)];
        
        [skipButton setImage:[UIImage imageNamed:@"skip_btn_ipad.png"] forState:UIControlStateNormal];
        [skipButton setFrame:CGRectMake(screenRect.width-100, 28, 80, 25)];
        
        
    }
    
    [self createUi];
    // Do any additional setup after loading the view.
}
-(void)backAction{
    [textField resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)nextAction{
    
    
    if([textField.text isEqual: @""]){
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"purposeOfVisit"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    else{
    [[NSUserDefaults standardUserDefaults]setObject:textField.text forKey:@"purposeOfVisit"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    }
    
     [textField resignFirstResponder];
    if([SingletonClass sharedSingleton].deptId==4){
        TimePeriodView *timePeriodView=[[TimePeriodView alloc]init];
        [self.navigationController pushViewController:timePeriodView animated:YES];
    }
    
    else if([SingletonClass sharedSingleton].deptId==3){
        
        SymptomsView *symptom=[[SymptomsView alloc]init];
        [self.navigationController pushViewController:symptom animated:YES];
    }
    else if([SingletonClass sharedSingleton].deptId==2){
        
        TimePeriodView *timePeriodView=[[TimePeriodView alloc]init];
        [self.navigationController pushViewController:timePeriodView animated:YES];
    }
    
    else if([[SingletonClass sharedSingleton]init].deptId==1){
        BabyAgeVC *babyAge=[BabyAgeVC alloc];
        [self.navigationController pushViewController:babyAge animated:YES];
    }
    else if ([SingletonClass sharedSingleton].deptId==5){
        AllergiesView *allergies=[AllergiesView new];
        [self.navigationController pushViewController:allergies animated:YES];

    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)createUi{
    
    UILabel *briefDescp=[[UILabel alloc]init];
    briefDescp.frame= CGRectMake(30, 80, screenRect.width, 80);

    briefDescp.numberOfLines=2;
    briefDescp.text=@"Please briefly describe the\npurpose of your visit:";
    briefDescp.font =[UIFont fontWithName:@"GothamRounded-Medium" size:14];
    briefDescp.textColor=[UIColor blackColor];
    
    [self.view addSubview:briefDescp];
    
    textField=[[UITextView alloc]init];
    textField.frame= CGRectMake(30, 180, screenRect.width-60,200);
   //textField.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
   
    textField.backgroundColor=[UIColor whiteColor];
    textField.layer.cornerRadius=15.0f;
    textField.delegate=self;
    [self.view addSubview:textField];
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        
         briefDescp.frame= CGRectMake(60, 120, screenRect.width-120, 100);
         briefDescp.font =[UIFont fontWithName:@"GothamRounded-Medium" size:25];
         textField.frame= CGRectMake(60, 300, screenRect.width-120,400);
        textField.font = [UIFont fontWithName:@"GothamRounded-Medium" size:25];
    }
    
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    
    
 
    [skipButton setImage:[UIImage imageNamed:@"next_btn.png"] forState:UIControlStateNormal];
    
    if (UIUserInterfaceIdiomPad==UI_USER_INTERFACE_IDIOM()) {
        [skipButton setImage:[UIImage imageNamed:@"next_btn-ipad.png"] forState:UIControlStateNormal];
    }
  /*  nextButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setImage:[UIImage imageNamed:@"forward_arrow.png"] forState:UIControlStateNormal];
    [nextButton setFrame:CGRectMake(320, 0, 61, 21)];
    barButton = [[UIBarButtonItem alloc] initWithCustomView:nextButton];
    self.navigationItem.rightBarButtonItem = barButton;
    [nextButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];*/
}
- (BOOL)textView:(UITextView *)textView
shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
    }
    return YES;
}



@end
