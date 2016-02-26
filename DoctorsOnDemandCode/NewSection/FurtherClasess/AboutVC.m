//
//  AboutVC.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 8/28/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "AboutVC.h"

@interface AboutVC (){
    CGSize screenRect;
    NSArray *aboutViewCells;
    OurDocSubVC *docSub;
}


@end

@implementation AboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    screenRect=[[UIScreen mainScreen]bounds].size;
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"OurDoctors"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    titleLable.text =@"About";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font =[UIFont fontWithName:@"GothamRounded-Light" size:14];
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
 [backButton setFrame:CGRectMake(15, 18, 55, 35)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
    
    
    [ self createUI];
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
-(void)createUI{
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70, screenRect.width, 180)];
    
    
    logoView.image=[UIImage imageNamed:@"psychology_img.png"];
    [logoView setContentMode:UIViewContentModeScaleAspectFit];
    
    
    [self.view addSubview:logoView];
    
    UITableView *tableView=[[UITableView alloc]init];
    tableView.frame=CGRectMake(10, screenRect.height/2-50, screenRect.width-20, screenRect.height/2+100);
    tableView.backgroundColor=[UIColor clearColor];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView setShowsVerticalScrollIndicator:NO];
    tableView.scrollEnabled=NO;
    
    
    [self.view addSubview:tableView];
    
    
//    aboutViewCells=[NSArray arrayWithObjects:@"Our Mission",@"Medical Board",@"Team",@"Privacy",nil];
//    
    aboutViewCells=[NSArray arrayWithObjects:@"Our Mission",@"Privacy",nil];

    
    
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil )
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    
    
    cell.textLabel.text = [aboutViewCells objectAtIndex:indexPath.section];
    cell.textLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    cell.accessoryView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"forward_arrow.png"]];
    
    
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    
    
    
    switch (indexPath.section) {
        case 0:
        {
            [[NSUserDefaults standardUserDefaults]setObject:@"mission" forKey:@"about"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            docSub=[[OurDocSubVC alloc]init];
            [self.navigationController pushViewController:docSub animated:YES];
            
        }
            
            
            break;
        case 1:{
            
            
        }
            
            break;
        case 2:{
            
            
        }
            
            break;
        case 3:{
            [[NSUserDefaults standardUserDefaults]setObject:@"privacy" forKey:@"about"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            docSub=[OurDocSubVC new];
            [self.navigationController pushViewController:docSub animated:YES];

            
        }
            
            break;
            

            

            
            
            
            
        default:
            break;
    }
    
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [aboutViewCells count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
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
