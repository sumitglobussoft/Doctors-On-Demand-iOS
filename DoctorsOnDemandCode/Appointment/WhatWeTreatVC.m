//
//  WhatWeTreatVC.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 10/14/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "WhatWeTreatVC.h"

@interface WhatWeTreatVC ()
{
          CGSize screenRect;
    UITableView *whatWeTreatTableVw;
    UITableViewCell *cell;
    NSArray *ar;
    UIScrollView *myScroll;
    WhatTreatSubVC *whatTreatSub;
}
@end

@implementation WhatWeTreatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
       screenRect = [[UIScreen mainScreen] bounds].size;
    self.tabBarController.tabBar.hidden=YES;
    
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    if([SingletonClass sharedSingleton].deptId==4 || [SingletonClass sharedSingleton].deptId==1){
    titleLable.text =@"What We Treat";
    }
    else if ([SingletonClass sharedSingleton].deptId==2){
        titleLable.text=@"Pediatric Care";
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-back Action
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-Create UI
-(void)createUi{
    
    myScroll = [[UIScrollView alloc] init];
    myScroll.frame = CGRectMake(0, 55, screenRect.width, screenRect.height);
    
    
    myScroll.backgroundColor = [UIColor clearColor];
    
    myScroll.showsVerticalScrollIndicator =YES;    // to hide scroll indicators!
   
    if([SingletonClass sharedSingleton].deptId==4){

    myScroll.scrollEnabled = YES;
    }
    else if ([SingletonClass sharedSingleton].deptId==2 || [SingletonClass sharedSingleton].deptId==1){
        myScroll.scrollEnabled=NO;
    }
    //say "NO" to disable scroll
    
    
    //adding to parent view!
    
    
    [self.view addSubview:myScroll];
    whatWeTreatTableVw=[[UITableView alloc]init];
    
    
    if([SingletonClass sharedSingleton].deptId==4){

    
        whatWeTreatTableVw.frame=CGRectMake(10,0,screenRect.width-20,screenRect.height-100);
    }
    else if ([SingletonClass sharedSingleton].deptId==2){
        
           whatWeTreatTableVw.frame=CGRectMake(10,0,screenRect.width-20,210);
    }
    else if ([SingletonClass sharedSingleton].deptId==1){
        whatWeTreatTableVw.frame=CGRectMake(10,0,screenRect.width-20,130);
        
    }
    
    
    
    
    whatWeTreatTableVw.backgroundColor=[UIColor clearColor];
   
    whatWeTreatTableVw.layer.borderWidth = 2.0;
    whatWeTreatTableVw.layer.borderColor = [UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1].CGColor;
    [whatWeTreatTableVw setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    whatWeTreatTableVw.delegate=self;
    whatWeTreatTableVw.dataSource=self;
    whatWeTreatTableVw.scrollEnabled=NO;
    
         [myScroll addSubview:whatWeTreatTableVw];
    
    
    
       if([SingletonClass sharedSingleton].deptId==4){
    ar=[NSArray arrayWithObjects:@"Cough/Cold/Flu/Allergies",@"Sore Throat",@"UTIs",@"Travel",@"Sports Injuries",@"Skin issues/Rushes",@"Diarrhea & Vomiting",@"Eye Conditions",@"What We Don't Treat", nil];
       }
    else    if([SingletonClass sharedSingleton].deptId==2){
         ar=[NSArray arrayWithObjects:@"Pediatric Triage",@"Cough/Cold/Flu/Allergies",@"Rashes",@"What We Don't Treat", nil];
        
        }
    else    if([SingletonClass sharedSingleton].deptId==1){
        ar=[NSArray arrayWithObjects:@"Top Mom Issues",@"Top Baby Issues", nil];
        
    }
    
    
    
    
    
    
    
    float sizeOfContent = 0;
    UIView *lLast = [myScroll.subviews lastObject];
    NSInteger wd = lLast.frame.origin.y;
    NSInteger ht = lLast.frame.size.height;
    NSInteger offset=100;
    sizeOfContent = wd+ht;
    myScroll.contentSize=CGSizeMake(screenRect.width,sizeOfContent+offset+10);
      [self.view addSubview:myScroll];
    

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell1 forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad){
        
        cell1.textLabel.font = [UIFont systemFontOfSize:30];
    }
    
    cell1.layer.cornerRadius = 6;
    cell1.clipsToBounds = YES;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"SimpleTableItem";
    
    cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.accessoryView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"forward_arrow.png"]];
    
    cell.textLabel.text=[ar objectAtIndex:indexPath.section];
    //cell.textLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    cell.textLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    cell.selectionStyle=UITableViewCellSelectionStyleGray;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
      whatTreatSub=[[WhatTreatSubVC alloc]init];
    
    NSLog(@"section-->%ld",(long)indexPath.section);
    
   
    if(indexPath.section==0){
        
         if([SingletonClass sharedSingleton].deptId==4){
        [[NSUserDefaults standardUserDefaults]setObject:@"Cold" forKey:@"commonVC"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.navigationController pushViewController:whatTreatSub animated:YES];
         }
         else if ([SingletonClass sharedSingleton].deptId==2){
             [[NSUserDefaults standardUserDefaults]setObject:@"pediaTriaghe" forKey:@"PediacCare"];
             [[NSUserDefaults standardUserDefaults]synchronize];
             [self.navigationController pushViewController:whatTreatSub animated:YES];
         }
        
         else if ([SingletonClass sharedSingleton].deptId==1){
             [[NSUserDefaults standardUserDefaults]setObject:@"topMomIssues" forKey:@"lacatTreat"];
             [[NSUserDefaults standardUserDefaults]synchronize];
             [self.navigationController pushViewController:whatTreatSub animated:YES];
         }

    }
    
    else if(indexPath.section==1){

           if([SingletonClass sharedSingleton].deptId==4){
        
        [[NSUserDefaults standardUserDefaults]setObject:@"sore" forKey:@"commonVC"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.navigationController pushViewController:whatTreatSub animated:YES];
           }
           else if ([SingletonClass sharedSingleton].deptId==2){
               [[NSUserDefaults standardUserDefaults]setObject:@"Cold" forKey:@"commonVC"];
               [[NSUserDefaults standardUserDefaults]synchronize];
               [self.navigationController pushViewController:whatTreatSub animated:YES];

           }
           else if ([SingletonClass sharedSingleton].deptId==1){
               [[NSUserDefaults standardUserDefaults]setObject:@"topBabyIssues" forKey:@"lacatTreat"];
               [[NSUserDefaults standardUserDefaults]synchronize];
               [self.navigationController pushViewController:whatTreatSub animated:YES];
           }

    }
    
    else if(indexPath.section==2){
        
          if([SingletonClass sharedSingleton].deptId==4){
       
        
        [[NSUserDefaults standardUserDefaults]setObject:@"UTI" forKey:@"commonVC"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.navigationController pushViewController:whatTreatSub animated:YES];
          }
          else if ([SingletonClass sharedSingleton].deptId==2){
              [[NSUserDefaults standardUserDefaults]setObject:@"rashes" forKey:@"PediacCare"];
              [[NSUserDefaults standardUserDefaults]synchronize];
              [self.navigationController pushViewController:whatTreatSub animated:YES];
          }

        

    }
    else if(indexPath.section==3){
        
        if([SingletonClass sharedSingleton].deptId==4){
        [[NSUserDefaults standardUserDefaults]setObject:@"travel" forKey:@"commonVC"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.navigationController pushViewController:whatTreatSub animated:YES];
        }
    
        else if([SingletonClass sharedSingleton].deptId==2){
            [[NSUserDefaults standardUserDefaults]setObject:@"dont-trust" forKey:@"commonVC"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [self.navigationController pushViewController:whatTreatSub animated:YES];
        }
        
    }
    else if (indexPath.section==4){
      
        
        [[NSUserDefaults standardUserDefaults]setObject:@"sports" forKey:@"commonVC"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.navigationController pushViewController:whatTreatSub animated:YES];
    }
    else if (indexPath.section==5){
        [[NSUserDefaults standardUserDefaults]setObject:@"rashes" forKey:@"commonVC"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.navigationController pushViewController:whatTreatSub animated:YES];
    }
    else if (indexPath.section==6){
        [[NSUserDefaults standardUserDefaults]setObject:@"diarrhea" forKey:@"commonVC"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.navigationController pushViewController:whatTreatSub animated:YES];
    }
    else if (indexPath.section==7){
        [[NSUserDefaults standardUserDefaults]setObject:@"eye" forKey:@"commonVC"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.navigationController pushViewController:whatTreatSub animated:YES];
    }
    else if (indexPath.section==8){
        [[NSUserDefaults standardUserDefaults]setObject:@"dont-trust" forKey:@"commonVC"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.navigationController pushViewController:whatTreatSub animated:YES];
    }



    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [ar count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  10;

 
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
               return 40;
   
    
}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 10)];
    headerView.backgroundColor=[UIColor clearColor];
   
    return headerView;
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
