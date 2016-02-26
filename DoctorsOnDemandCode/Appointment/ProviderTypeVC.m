//
//  ProviderTypeVC.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 9/14/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "ProviderTypeVC.h"

@interface ProviderTypeVC (){
    CGSize screenRect;
    NSArray *providerTableCells;
     UITableView *providerTableView;
     UITableViewCell *cell;

     int selectedIndex;
}


@end

@implementation ProviderTypeVC
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    screenRect = [[UIScreen mainScreen] bounds].size;
    self.tabBarController.tabBar.hidden=YES;
    
    // UIImage *headerImage = [UIImage imageNamed:@"head_logo"];
    
    //arr =[NSArray arrayWithObjects:@" Me",@" My Child",@" Someone Else", nil];
    //self.navigationItem.titleView = [[UIImageView alloc] initWithImage:headerImage] ;
    
    
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    titleLable.text =@"PROVIDER TYPE";
    titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
   [backButton setFrame:CGRectMake(15, 18, 55, 35)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
    UIButton *nextButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setImage:[UIImage imageNamed:@"next_btn.png"] forState:UIControlStateNormal];
    [nextButton setFrame:CGRectMake(screenRect.width-60, 28, 45, 25)];
    [nextButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:nextButton];
    
    
    [self createUi];


    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)createUi{
   
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 90, screenRect.width, 50)];
    label.textAlignment=NSTextAlignmentCenter;
    label.numberOfLines=2;
    label.text=@"Please select the provider\nyou'd like to schedule with:";
    label.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];

    label.textColor=[UIColor blackColor];
    [self.view addSubview:label];
    
    
    
    
    providerTableView=[[UITableView alloc]init];
    
          providerTableView.frame=CGRectMake(10, 175 ,screenRect.width-20,176);
   
    
    
    
    
    
    providerTableView.backgroundColor=[UIColor clearColor];
    providerTableView.scrollEnabled = NO;
    providerTableView.layer.borderWidth = 2.0;
    providerTableView.layer.borderColor = [UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1].CGColor;
    [providerTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    providerTableView.delegate=self;
    providerTableView.dataSource=self;
    
  
        [self.view addSubview:providerTableView];
    
    
    providerTableCells=[NSArray arrayWithObjects:@"Medical Doctor",@"Psychologist",@"Pediatrics",@"Lactation Consultant",nil];

    

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"SimpleTableItem";
    
    cell = [tableView cellForRowAtIndexPath:indexPath];
    // cell.preservesSuperviewLayoutMargins=NO;
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
        cell.textLabel.text=[providerTableCells objectAtIndex:indexPath.row];
        
        
        if (indexPath.row == selectedIndex) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
  
    
        
    cell.textLabel.font= [UIFont fontWithName:@"GothamRounded-Light" size:14];

    
    
    return cell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
        
        return [providerTableCells count];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSLog(@"clicked---->%ld",(long)indexPath.row);
    
    selectedIndex = (int)indexPath.row;
    [providerTableView reloadData];
    
    
    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(void)nextAction{
    
    switch (selectedIndex) {
        case 0:
        {
            MedicalView *medical=[MedicalView new];
            [self.navigationController pushViewController:medical animated:YES];
            
        }
            break;
        case 1:
        {
            PsychologyView *psychology=[PsychologyView new];
            [self.navigationController pushViewController:psychology animated:YES];
        }
            break;
        case 2:
        {
            PediatricsView *pediatric=[PediatricsView new];
            [self.navigationController pushViewController:pediatric animated:YES];
        }
            break;
        case 3:
        {
            
            LactationVC *lactation=[LactationVC new];
            [self.navigationController pushViewController:lactation animated:YES];
        
        
        }
            break;
            
        default:
            break;
    }
    
    
   
}



-(void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
