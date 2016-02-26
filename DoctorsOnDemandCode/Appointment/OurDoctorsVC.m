//
//  OurDoctorsVC.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 10/15/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "OurDoctorsVC.h"

@interface OurDoctorsVC (){
  
        CGSize screenRect;
    NSArray *doctorViewCells;
    
    OurDocSubVC *doctorSubVC;

}

@end

@implementation OurDoctorsVC

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
    
    if([SingletonClass sharedSingleton].deptId==4||[SingletonClass sharedSingleton].deptId==2){
    titleLable.text =@"Our Doctors";
    }
    else if ([SingletonClass sharedSingleton].deptId==3){
         titleLable.text =@"Psychologists";
    }
    else if ([SingletonClass sharedSingleton].deptId==1)
    {
        titleLable.text=@"Our Consultants";
    }
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font =[UIFont fontWithName:@"GothamRounded-Light" size:14];
    [headerView addSubview:titleLable];
    
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
 [backButton setFrame:CGRectMake(15, 18, 55, 35)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
    
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
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70, screenRect.width, 160)];
    
    
    logoView.image=[UIImage imageNamed:@"child_img"];
    [logoView setContentMode:UIViewContentModeScaleAspectFit];
    
    //[logoView sizeToFit];
    
    [self.view addSubview:logoView];
    
    
    
    
    
    
    
    
    
    UITableView *tableView=[[UITableView alloc]init];
    tableView.frame=CGRectMake(10, screenRect.height/2-50, screenRect.width-20, screenRect.height/2+40);
    tableView.backgroundColor=[UIColor clearColor];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:tableView];
    
    if([SingletonClass sharedSingleton].deptId==4||[SingletonClass sharedSingleton].deptId==2){
  doctorViewCells=[NSArray arrayWithObjects:@"Introduction",@"Meet our Physicians",@"Sreening & Training",@"Quality & Oversight",nil];
    }
    else if ([SingletonClass sharedSingleton].deptId==3){
        doctorViewCells=[NSArray arrayWithObjects:@"Introduction",@"Meet our Psychologists",@"Sreening & Training",@"Quality & Oversight",nil];
    }
    
    else if ([SingletonClass sharedSingleton].deptId==1){
        
       doctorViewCells=[NSArray arrayWithObjects:@"Meet our Consultants",@"Sreening & Training",@"Quality & Oversight",nil];
        
    }
    
    
}
#pragma mark-table Delegate
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
    cell.textLabel.text = [doctorViewCells objectAtIndex:indexPath.section];
    cell.textLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    cell.imageView.image = [UIImage imageNamed:[doctorViewCells  objectAtIndex:indexPath.section]];
    cell.accessoryView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"forward_arrow.png"]];
    
    
    
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    doctorSubVC=[OurDocSubVC new];
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"about"];
    [[NSUserDefaults standardUserDefaults]synchronize];

  
    NSLog(@"section>>>>>>%ld",(long)indexPath.section);
    switch (indexPath.section) {
        case 0:
        {
            

            if([SingletonClass sharedSingleton].deptId==4||[SingletonClass sharedSingleton].deptId==2){
            
            [[NSUserDefaults standardUserDefaults]setObject:@"Intro" forKey:@"OurDoctors"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [self.navigationController pushViewController:doctorSubVC animated:YES];
            }
            else if ([SingletonClass sharedSingleton].deptId==3){
                
                [[NSUserDefaults standardUserDefaults]setObject:@"Intro" forKey:@"pshy"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                [self.navigationController pushViewController:doctorSubVC animated:YES];
            }
            
            else if ([SingletonClass sharedSingleton].deptId==1){
                
                [[NSUserDefaults standardUserDefaults]setObject:@"meetCons" forKey:@"consultant"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                ChoosePsychologistVC *choose=[[ChoosePsychologistVC alloc]init];
                [self.navigationController pushViewController:choose animated:YES];
                
            }
                 
                 }

        
            
            break;
       
        case 1:{
             if([SingletonClass sharedSingleton].deptId==4||[SingletonClass sharedSingleton].deptId==2){
           [[NSUserDefaults standardUserDefaults]setObject:@"ourPhy" forKey:@"OurDoctors"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            ChoosePsychologistVC *choosePshyco=[ChoosePsychologistVC new];
            [self.navigationController pushViewController:choosePshyco animated:YES];
             }
             else if ([SingletonClass sharedSingleton].deptId==3){
                 
                 [[NSUserDefaults standardUserDefaults]setObject:@"ourPhy" forKey:@"pshy"];
                 [[NSUserDefaults standardUserDefaults]synchronize];
                 ChoosePsychologistVC *choosePshyco=[ChoosePsychologistVC new];
                 [self.navigationController pushViewController:choosePshyco animated:YES];
             }
             else if ([SingletonClass sharedSingleton].deptId==1){
                 
                 [[NSUserDefaults standardUserDefaults]setObject:@"screening" forKey:@"consultant"];
                 [[NSUserDefaults standardUserDefaults]synchronize];
                  [self.navigationController pushViewController:doctorSubVC animated:YES];
                 
             }

           
        }
            break;
            
        case 2:{
             if([SingletonClass sharedSingleton].deptId==4||[SingletonClass sharedSingleton].deptId==2){
            [[NSUserDefaults standardUserDefaults]setObject:@"screening" forKey:@"OurDoctors"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [self.navigationController pushViewController:doctorSubVC animated:YES];
             }
             else if ([SingletonClass sharedSingleton].deptId==3){
                 [[NSUserDefaults standardUserDefaults]setObject:@"screening" forKey:@"pshy"];
                 [[NSUserDefaults standardUserDefaults]synchronize];
                 [self.navigationController pushViewController:doctorSubVC animated:YES];
             }
             else if ([SingletonClass sharedSingleton].deptId==1){
                 
                 [[NSUserDefaults standardUserDefaults]setObject:@"quality" forKey:@"consultant"];
                 [[NSUserDefaults standardUserDefaults]synchronize];
                 [self.navigationController pushViewController:doctorSubVC animated:YES];
                 
             }

        }

            break;
            
        case 3:{
             if([SingletonClass sharedSingleton].deptId==4||[SingletonClass sharedSingleton].deptId==2){
            [[NSUserDefaults standardUserDefaults]setObject:@"quality" forKey:@"OurDoctors"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [self.navigationController pushViewController:doctorSubVC animated:YES];
             }
             else if ([SingletonClass sharedSingleton].deptId==3){
                 [[NSUserDefaults standardUserDefaults]setObject:@"quality" forKey:@"pshy"];
                 [[NSUserDefaults standardUserDefaults]synchronize];
                 [self.navigationController pushViewController:doctorSubVC animated:YES];
             }

        }

            break;
            
            
        default:
            break;
    }
    
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [doctorViewCells count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
    
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
