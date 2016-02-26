//
//  MeetUsView.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 8/8/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "MeetUsView.h"
#import "MedicalView.h"
#import "FavoriteProvider.h"
#import "OurDoctorsVC.h"
#import "AboutVC.h"
#import "VideoVisitVC.h"
#import "WhatWeTreatVC.h"
@interface MeetUsView (){
    CGSize screenRect;
    NSArray *meetUsViewCells,*meetUsViewCellImg;
    
}

@end

@implementation MeetUsView

- (void)viewDidLoad {
    [super viewDidLoad];
   screenRect = [[UIScreen mainScreen] bounds].size;
    
    // UIImage *headerImage = [UIImage imageNamed:@"head_logo"];
    
    //arr =[NSArray arrayWithObjects:@" Me",@" My Child",@" Someone Else", nil];
    //self.navigationItem.titleView = [[UIImageView alloc] initWithImage:headerImage] ;
    
    
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    titleLable.text =@"Meet Us";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [headerView addSubview:titleLable];
    
    
    if([[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"]==nil)
    {
           UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
[backButton setFrame:CGRectMake(15, 18, 55, 35)];
        [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
        
    }
       UIButton *nextButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setImage:[UIImage imageNamed:@"help_btn.png"] forState:UIControlStateNormal];
   [nextButton setFrame:CGRectMake(screenRect.width-60, 28, 45, 25)];
    [nextButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:nextButton];
    
    
    
    [self createUi];
    

    // Do any additional setup after loading the view.
}
-(void)nextAction{
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)createUi{
    UIImageView *logoView = [[UIImageView alloc]init];
    
    if(screenRect.height<736)
    {
        logoView.frame=CGRectMake(0, 70, screenRect.width, 180);    }
    else if (screenRect.height>=736){
        logoView.frame = CGRectMake(0, 70, screenRect.width, 250);
    }
    
    

    
    
    logoView.image=[UIImage imageNamed:@"meet_bg.png"];
    [logoView setContentMode:UIViewContentModeScaleAspectFit];
    
    //[logoView sizeToFit];
    
    [self.view addSubview:logoView];
    
    
    
    
    
    
    
    
    
    UITableView *tableView=[[UITableView alloc]init];
    
    
    if(screenRect.height==480){
        if([[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"]==nil)
        {
            
            tableView.frame=CGRectMake(10, screenRect.height/2-5, screenRect.width-20, screenRect.height/2-5);
            

        }
        else
        
        tableView.frame=CGRectMake(10, screenRect.height/2-5, screenRect.width-20, screenRect.height/2-40);
        
        
    }
    else{
        
        if([[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"]==nil)
        {
            
//            tableView.frame=CGRectMake(10, screenRect.height/2-5, screenRect.width-20, screenRect.height/2-5);
            
             tableView.frame=CGRectMake(10, screenRect.height/2-50, screenRect.width-20, screenRect.height/2+40);
            
            
        }
        else
            
            tableView.frame=CGRectMake(10, screenRect.height/2-5, screenRect.width-20, screenRect.height/2-50);
       
    }

       tableView.backgroundColor=[UIColor clearColor];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:tableView];
    
    
    meetUsViewCells=[NSArray arrayWithObjects:@"Meet the Provider",@"How It Works",@"Press & Media",@"About Doctor On Demand",@"Our Blog",@"FAQ",nil];
    meetUsViewCellImg =[NSArray arrayWithObjects:@"schedule_icon.png",@"question_icon.png",@"question_icon.png",@"user_icon.png",@"dollar_icon.png",@"user_icon.png", nil];
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    cell.layer.cornerRadius = 3;
    cell.clipsToBounds = YES;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    
        
        // cell.imageView.frame = CGRectMake(10, 2, 22, 22);
        cell.textLabel.text = [meetUsViewCells objectAtIndex:indexPath.section];
    cell.textLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];

        cell.imageView.image = [UIImage imageNamed:[meetUsViewCellImg  objectAtIndex:indexPath.section]];
        cell.accessoryView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"forward_arrow.png"]];
   
    
    
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@ "ROW-%ld Content-%@",(long)indexPath.row+1,[meetUsViewCells objectAtIndex:indexPath.row]);
    NSLog(@"section>>>>>>%ld",(long)indexPath.section);
      switch (indexPath.section) {
        case 0:
          {
              NSLog(@">>>>>>%ld",(long)indexPath.section);
             
              [SingletonClass sharedSingleton].deptId=4;
              OurDoctorsVC *doctor=[[OurDoctorsVC alloc]init];
              [self.navigationController pushViewController:doctor animated:YES];
            
            break;
          }
          case 1:{
              [SingletonClass sharedSingleton].deptId=4;
              VideoVisitVC *videoVisit=[[VideoVisitVC alloc]init];
              [self.navigationController pushViewController:videoVisit animated:YES];
          }
            
            break;
            
          case 2:{
              [SingletonClass sharedSingleton].deptId=4;
              AboutVC *about=[AboutVC new];
              [self.navigationController pushViewController:about animated:YES];
          }
            
            break;
            
          case 3:{
              [SingletonClass sharedSingleton].deptId=4;
              AboutVC *about=[AboutVC new];
              [self.navigationController pushViewController:about animated:YES];

              
          }
            
            break;
            
          case 4:{
              [SingletonClass sharedSingleton].deptId=4;
              AboutVC *about=[AboutVC new];
              [self.navigationController pushViewController:about animated:YES];
          }
            break;
          case 5:{
              [SingletonClass sharedSingleton].deptId=4;
              WhatWeTreatVC *whatWetreat=[WhatWeTreatVC new];
              [self.navigationController pushViewController:whatWetreat animated:YES];
          }
            
            break;
          case 6:{
            
          }
            
            break;
            
            
            
            
        default:
            break;
    }
    
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [meetUsViewCells count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

#pragma mark- See a doctor
/*-(void)seeADoctor{
 
 backPopUp = [[UIView alloc]initWithFrame:CGRectMake(0, 800, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height)];
 backPopUp.backgroundColor =[UIColor lightGrayColor];
 [self.view addSubview:backPopUp];
 
 letsGetStartedPopUp=[[UIView alloc]initWithFrame:CGRectMake(10, 800, self.view.frame.size.width-20, self.view.frame.size.height-20)];
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
 
 letsGetStartedPopUp.frame=CGRectMake(30, 60, self.view.frame.size.width-60, self.view.frame.size.height-60);
 backPopUp.frame=CGRectMake(00, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
 
 }completion:nil];
 
 
 
 
 UILabel *header=[[UILabel alloc]initWithFrame:CGRectMake(60,0,  self.view.frame.size.width-60-5, 150)];
 header.text=@"LET'S GET\nSTARTED!";
 header.numberOfLines=2;
 header.font=[UIFont systemFontOfSize:30];
 header.textColor=[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1];
 [letsGetStartedPopUp addSubview:header];
 
 UILabel *information=[[UILabel alloc]initWithFrame:CGRectMake(40,70,  self.view.frame.size.width-60-5, 300)];
 information.text=@"We need some info to get\nyou the best possible care.\n\nYour visit with a Doctor On\n  Demand physician only\n       \tcosts $40.";
 information.numberOfLines=7;
 information.font=[UIFont systemFontOfSize:15];
 information.textColor=[UIColor blackColor];
 [letsGetStartedPopUp addSubview:information];
 
 
 
 couponButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
 couponButton.frame=CGRectMake(10, 380,self.view.frame.size.width-60-30,50);
 
 [couponButton setTitle:@"Apply Coupon" forState:UIControlStateNormal];
 [couponButton setTitleColor:[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1] forState:UIControlStateNormal];
 
 [letsGetStartedPopUp addSubview:couponButton];
 
 UIButton *letsGoButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
 letsGoButton.frame=CGRectMake(0, self.view.frame.size.height-105,self.view.frame.size.width-60, 50);
 [letsGoButton setTitle:@"Let's Go!" forState:UIControlStateNormal];
 
 [letsGoButton setBackgroundColor:[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1]];
 [letsGoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
 [letsGoButton addTarget:self action:@selector(letsGo) forControlEvents:UIControlEventTouchUpInside];
 letsGoButton.layer.cornerRadius=6.0f;
 
 [letsGetStartedPopUp addSubview:letsGoButton];
 
 
 
 
 
 }*/
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(screenRect.height>=667){
        
        
        return 50;
    }
    else{
        return 40;
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
