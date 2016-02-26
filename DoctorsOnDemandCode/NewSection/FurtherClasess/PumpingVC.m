//
//  PumpingVC.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 9/16/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "PumpingVC.h"

@interface PumpingVC (){
    
        
        CGSize screenRect;
        
        UIButton *nextButton;
        
        NSArray *pumpingViewCells;
        int selectedInx;
        UITableView *pumpingTableView;
        UIScrollView *myScroll;
        
 

}

@end

@implementation PumpingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];screenRect = [[UIScreen mainScreen] bounds].size;
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    titleLable.text =@"PUMPING";
    titleLable.textAlignment = NSTextAlignmentCenter;
   titleLable.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
   [backButton setFrame:CGRectMake(15, 18, 55, 35)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
    nextButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setImage:[UIImage imageNamed:@"next_btn.png"] forState:UIControlStateNormal];
    [nextButton setFrame:CGRectMake(screenRect.width-60, 28, 45, 25)];    [nextButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:nextButton];
    
    
    
    
    
    
    
    
    //  self.title=@"PURPOSE OF VISIT";
    
    [self createUi];
    
    
    // Do any additional setup after loading the view.
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)nextAction{
    
    
    [[NSUserDefaults standardUserDefaults]setObject:[pumpingViewCells objectAtIndex:selectedInx] forKey:@"breastPump"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    MedicalConditionView *medicalConditions=[[MedicalConditionView alloc]init];
    [self.navigationController pushViewController:medicalConditions animated:YES];
}
-(void)createUi{
    
    
    
    
    myScroll = [[UIScrollView alloc] init];
    myScroll.frame = CGRectMake(0, 55, screenRect.width, screenRect.height);
    myScroll.backgroundColor = [UIColor clearColor];
    
    myScroll.showsVerticalScrollIndicator = NO;    // to hide scroll indicators!
    
    
    
    myScroll.scrollEnabled = YES;                 //say "NO" to disable scroll
    
    
    [self.view addSubview:myScroll];
    
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(30, 20, screenRect.width, 80)];
    label.text=@"Select your breast pump:";
    label.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
    label.textColor=[UIColor blackColor];
    
    [myScroll addSubview:label];
    
    
    
    
    
    
    pumpingTableView=[[UITableView alloc]init];
    pumpingTableView.frame=CGRectMake(10, 100 ,screenRect.width-20,250);
    pumpingTableView.backgroundColor=[UIColor clearColor];
    pumpingTableView.scrollEnabled = NO;
    pumpingTableView.layer.borderWidth = 2.0;
    pumpingTableView.layer.borderColor = [UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1].CGColor;
    [pumpingTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    pumpingTableView.delegate=self;
    pumpingTableView.dataSource=self;
    [myScroll addSubview:pumpingTableView];
    pumpingViewCells=[NSArray arrayWithObjects:@"Manual",@"Electric",@"Double Electric",@"I'm not pumping",@"I haven't tried  yet", nil];
    
    
    float sizeOfContent = 0;
    UIView *lLast = [myScroll.subviews lastObject];
    NSInteger wd = lLast.frame.origin.y;
    NSInteger ht = lLast.frame.size.height;
    NSInteger offset=20;
    sizeOfContent = wd+ht;
    myScroll.contentSize=CGSizeMake(screenRect.width,sizeOfContent+offset+10);

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark- tableView delegate methods
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"SimpleTableItem";
    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    //lcell.preservesSuperviewLayoutMargins=NO;
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    
    if (indexPath.row ==  selectedInx) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
        cell.textLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];
    cell.textLabel.text = [pumpingViewCells objectAtIndex:indexPath.row];
    return cell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [pumpingViewCells count];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedInx = (int)indexPath.row;
    [pumpingTableView reloadData];
    
    
    
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
