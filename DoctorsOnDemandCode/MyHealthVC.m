//
//  MyHealthVC.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 9/11/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//
#import "FavoriteProvider.h"
#import "MyHealthVC.h"
#import "Visit History.h"

@interface MyHealthVC (){
    CGSize screenRect;
    NSArray *healthCells;
    
}


@end

@implementation MyHealthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    screenRect=[[UIScreen mainScreen]bounds].size;
    
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    titleLable.text =@"My Health";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [headerView addSubview:titleLable];
    if (UIUserInterfaceIdiomPad==UI_USER_INTERFACE_IDIOM()){
        
        headerView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80);
    
        titleLable.frame= CGRectMake(60, 25, screenRect.width-120, 35);
        titleLable.font=[UIFont fontWithName:@"GothamRounded-Light" size:30];
        
        
        
    }

    [self createUi];
    // Do any additional setup after loading the view.
}

#pragma mark-createUI
-(void)createUi{
    
    UIImageView *logoView = [[UIImageView alloc]init];
    
    if(screenRect.height<736)
    {
        logoView.frame=CGRectMake(0, 70, screenRect.width, 175);    }
    else if (screenRect.height>=736){
        logoView.frame = CGRectMake(0, 70, screenRect.width, 240);
    }
    

    
    
    logoView.image=[UIImage imageNamed:@"myhealth.jpg"];
    [logoView setContentMode:UIViewContentModeScaleAspectFit];
    
    //[logoView sizeToFit];
    
    [self.view addSubview:logoView];
    
    
    
    
    
    
    
    
    
    UITableView *tableView=[[UITableView alloc]init];
    if(screenRect.height==480){
        
        tableView.frame=CGRectMake(10, screenRect.height/2-5, screenRect.width-20, screenRect.height/2-5);
        
        
    }
    else{
        tableView.frame=CGRectMake(10, screenRect.height/2-50, screenRect.width-20, screenRect.height/2+40);
    }

    tableView.backgroundColor=[UIColor clearColor];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView setShowsVerticalScrollIndicator:NO];
    tableView.scrollEnabled=NO;
    [self.view addSubview:tableView];
    
    
    healthCells=[NSArray arrayWithObjects:@"My Visit History",@"My Favourite Providers",@"My Pharmacies",nil];
    
    if (UIUserInterfaceIdiomPad==UI_USER_INTERFACE_IDIOM()){
        
        logoView.frame = CGRectMake(0, 80, screenRect.width,screenRect.height/2-50);
        logoView.image=[UIImage imageNamed:@"my_account.jpg"];
        
        tableView.frame=CGRectMake(10, screenRect.height/2+20, screenRect.width-20, screenRect.height/2-30);
        
    }

    
}


#pragma mark-Table Delegates
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UIUserInterfaceIdiomPad==UI_USER_INTERFACE_IDIOM()) {
        return 80;
    }
    else{
        
        
        
        if(screenRect.height>=667){
            
            
            return 50;
        }
        else{
            return 40;
        }
    }
    
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
    cell.textLabel.text = [healthCells objectAtIndex:indexPath.section];
       cell.textLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];
    cell.accessoryView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"forward_arrow.png"]];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        cell.textLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:25];
    }
    
    return cell;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [healthCells count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"Roe --->%ld",indexPath.section);
    
    switch (indexPath.section) {
        case 0:
        {
            Visit_History *visitHistory=[[Visit_History alloc]init];
[self.navigationController pushViewController:visitHistory animated:YES];
        }
            break;
        case 1:{
            
            FavoriteProvider *favProvider=[[FavoriteProvider alloc]init];
            [self.navigationController pushViewController:favProvider animated:YES];
        }
            break;
        case  2:{
            
            [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"MYHEALTH"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            

            MyPharmacy *favPharmacy=[MyPharmacy new];
            [self.navigationController pushViewController:favPharmacy animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
