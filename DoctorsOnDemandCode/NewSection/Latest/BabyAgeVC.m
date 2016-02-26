//
//  BabyAgeVC.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 9/15/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "BabyAgeVC.h"

@interface BabyAgeVC ()
{
    
    CGSize screenRect;
   
    UIButton *nextButton;
   
    NSArray *babyAgeViewCells;
    int selectedInx;
    UITableView *babyAgeTableView;
    UIScrollView *myScroll;
    
}

@end

@implementation BabyAgeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    screenRect = [[UIScreen mainScreen] bounds].size;
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    titleLable.text =@"BABY AGE";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font =[UIFont systemFontOfSize:15];
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
    [backButton setFrame:CGRectMake(15, 30, 45, 15)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
    nextButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setImage:[UIImage imageNamed:@"next_btn.png"] forState:UIControlStateNormal];
    [nextButton setFrame:CGRectMake(screenRect.width-60, 30, 45, 15)];
    [nextButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:nextButton];
    
    
    
    
    
    
    
    
    //  self.title=@"PURPOSE OF VISIT";
    
    [super viewDidLoad];
    [self createUi];
    

    // Do any additional setup after loading the view.
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)nextAction{
    
    }
-(void)createUi{
    
    
    
    
    myScroll = [[UIScrollView alloc] init];
    myScroll.frame = CGRectMake(0, 55, screenRect.width, screenRect.height);
    
    myScroll.contentSize = CGSizeMake(320, screenRect.height+350);
    myScroll.backgroundColor = [UIColor clearColor];
    
    myScroll.showsVerticalScrollIndicator = NO;    // to hide scroll indicators!
    
    
    
    myScroll.scrollEnabled = YES;                 //say "NO" to disable scroll
    
    
    [self.view addSubview:myScroll];
    
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(30, 20, screenRect.width, screenRect.height-480)];
   
    label.text=@"How old is your baby?";
    label.font=[UIFont boldSystemFontOfSize:15];
    label.textColor=[UIColor blackColor];
    
    [myScroll addSubview:label];
    
    
    
    
    
    
    babyAgeTableView=[[UITableView alloc]init];
    babyAgeTableView.frame=CGRectMake(10, 100 ,screenRect.width-20,screenRect.height+200);
    babyAgeTableView.backgroundColor=[UIColor clearColor];
    babyAgeTableView.scrollEnabled = NO;
    babyAgeTableView.layer.borderWidth = 2.0;
    babyAgeTableView.layer.borderColor = [UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1].CGColor;
    [babyAgeTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    babyAgeTableView.delegate=self;
    babyAgeTableView.dataSource=self;
    [myScroll addSubview:babyAgeTableView];
    babyAgeViewCells=[NSArray arrayWithObjects:@"Less than 1 week",@"1 week",@"2 weeks",@"3 weeks",@"1 month",@"2 months",@"3 months",@"4 months",@"5 months",@"6 months",@"7 months",@"8 months",@"9 months",@"10 months",@"11 months",@"12 months",@"More than 12 months", nil];
    
    
    
    
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
    cell.preservesSuperviewLayoutMargins=NO;
    
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
    
    cell.textLabel.text = [babyAgeViewCells objectAtIndex:indexPath.row];
    return cell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [babyAgeViewCells count];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedInx = (int)indexPath.row;
    [babyAgeTableView reloadData];
       
    
    
    
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
