//
//  HowItWorkView.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 8/8/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "HowItWorkView.h"

@interface HowItWorkView ()
{
    CGSize screenRect;
    
    NSArray *itWorksViewCells;
}
@end

@implementation HowItWorkView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    screenRect=[[UIScreen mainScreen]bounds].size;
    
    
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    titleLable.text =@"It Works";
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
-(void)createUi{
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70, screenRect.width, 160)];
    
    
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
    
    
    itWorksViewCells=[NSArray arrayWithObjects:@"How We Can Help",@"Why It's Effective", nil];
    


    

    
    
    
    
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
    
    
    
    
        cell.textLabel.text = [itWorksViewCells objectAtIndex:indexPath.section];
        cell.textLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];
                cell.accessoryView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"forward_arrow.png"]];
   
    
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@ "ROW-%ld Content-%@",(long)indexPath.row+1,[itWorksViewCells objectAtIndex:indexPath.row]);
    NSLog(@"section>>>>>>%ld",(long)indexPath.section);
     ItWorksSubVC *subView=[[ItWorksSubVC alloc]init];
    
    switch (indexPath.section) {
        case 0:
            
            [[NSUserDefaults standardUserDefaults]setObject:@"HowWeHelp" forKey:@"subView"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            [self.navigationController pushViewController:subView animated:YES];
           
            break;
        case 1:
            [[NSUserDefaults standardUserDefaults]setObject:@"Effective" forKey:@"subView"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
              [self.navigationController pushViewController:subView animated:YES];
            break;
            
            
            
            
        default:
            break;
    }
    
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [itWorksViewCells count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
