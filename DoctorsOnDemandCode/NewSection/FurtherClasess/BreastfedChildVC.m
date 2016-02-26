//
//  BreastfedChildVC.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 9/16/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "BreastfedChildVC.h"

@interface BreastfedChildVC ()
{
    
    CGSize screenRect;
    
    UIButton *nextButton;
    
    NSArray *breastfedChildViewCells;
    int selectedInx;
    UITableView *breastfedTableView;
    UIScrollView *myScroll;
    
}


@end

@implementation BreastfedChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    screenRect = [[UIScreen mainScreen] bounds].size;
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    titleLable.text =@"BREASTFED CHILDREN";
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
     [nextButton setFrame:CGRectMake(screenRect.width-60, 28, 45, 25)];
    [nextButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:nextButton];
    
    
    
    
    
    
    
    
    //  self.title=@"PURPOSE OF VISIT";
    
    [self createUi];
    
    
    // Do any additional setup after loading the view.
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)nextAction{
    
    [[NSUserDefaults standardUserDefaults]setObject:[breastfedChildViewCells objectAtIndex:selectedInx] forKey:@"breastFeedNo"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    BreastFeedingVC *breastFeeding=[[BreastFeedingVC alloc]init];
    [self.navigationController pushViewController:breastFeeding animated:YES];
    
}
-(void)createUi{
    
    
    
    
    myScroll = [[UIScrollView alloc] init];
    myScroll.frame = CGRectMake(0, 55, screenRect.width, screenRect.height);
    
    myScroll.backgroundColor = [UIColor clearColor];
    
    myScroll.showsVerticalScrollIndicator = NO;    // to hide scroll indicators!
    
    
    
    myScroll.scrollEnabled = YES;                 //say "NO" to disable scroll
    
    
    [self.view addSubview:myScroll];
    
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(30, 20, screenRect.width, 40)];
    label.numberOfLines=2;
    label.text=@"How many childern have you\nbreast fed previously?";
    label.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
    label.textColor=[UIColor blackColor];
    
    [myScroll addSubview:label];
    
    
    
    
    
    
    breastfedTableView=[[UITableView alloc]init];
    breastfedTableView.frame=CGRectMake(10, 100 ,screenRect.width-20,200);
    breastfedTableView.backgroundColor=[UIColor clearColor];
    breastfedTableView.scrollEnabled = NO;
    breastfedTableView.layer.borderWidth = 2.0;
    breastfedTableView.layer.borderColor = [UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1].CGColor;
    [breastfedTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    breastfedTableView.delegate=self;
    breastfedTableView.dataSource=self;
    [myScroll addSubview:breastfedTableView];
    breastfedChildViewCells=[NSArray arrayWithObjects:@"0",@"1",@"2",@"3+", nil];
    
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
    //cell.preservesSuperviewLayoutMargins=NO;
    
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
    cell.textLabel.text = [breastfedChildViewCells objectAtIndex:indexPath.row];
    return cell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [breastfedChildViewCells count];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedInx = (int)indexPath.row;
    [breastfedTableView reloadData];
    
    
    
    
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




@end
