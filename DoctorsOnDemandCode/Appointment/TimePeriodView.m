//
//  TimePeriodView.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 8/12/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "TimePeriodView.h"

@interface TimePeriodView (){
    
        CGSize screenRect;
        UIButton *skipButton;
        UIButton *nextButton;
        UIBarButtonItem *barButton;
    NSArray *timePeriodViewCells;
    int selectedInx;
    UITableView *timeTableView;

}

@end

@implementation TimePeriodView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    screenRect = [[UIScreen mainScreen] bounds].size;
   // UIImage *headerImage = [UIImage imageNamed:@"head_logo"];
    
    
   // self.navigationItem.titleView = [[UIImageView alloc] initWithImage:headerImage] ;
    
    
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    UIView * headerView =[[UIView alloc]init];
    headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55);
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]init];
    titleLable.frame=  CGRectMake(60, 25, screenRect.width-120, 25);
    titleLable.text =@"TIME PERIOD";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font =[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
    [backButton setFrame:CGRectMake(15, 18, 55, 35)];   [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
    skipButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [skipButton setImage:[UIImage imageNamed:@"skip_btn.png"] forState:UIControlStateNormal];
[skipButton setFrame:CGRectMake(screenRect.width-60, 28, 50, 20)];
    [skipButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:skipButton];
    
    
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad) {
        
        
       
        
         headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 75);
        
         titleLable.frame=  CGRectMake(60, 25, screenRect.width-120, 25);
        titleLable.font = [UIFont fontWithName:@"GothamRounded-Light" size:26];
        
        [backButton setImage:[UIImage imageNamed:@"back_btn_ipad.png"] forState:UIControlStateNormal];
        [backButton setFrame:CGRectMake(15, 30, 80, 25)];
        
        [skipButton setImage:[UIImage imageNamed:@"skip_btn_ipad.png"] forState:UIControlStateNormal];
        [skipButton setFrame:CGRectMake(screenRect.width-100, 30, 80, 25)];
    }
    
    
    [super viewDidLoad];
    [self createUi];

    // Do any additional setup after loading the view.
}
-(void)nextAction{
    MedicationView *medicationView=[[MedicationView alloc]init];
    [self.navigationController pushViewController:medicationView animated:YES];
    
    [[NSUserDefaults standardUserDefaults]setObject:[timePeriodViewCells objectAtIndex:selectedInx] forKey:@"timePeriod"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    

    
//    SymptomsView *symptomsView=[[SymptomsView alloc]init];
//    [self.navigationController pushViewController:symptomsView animated:YES];
//    
    
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)createUi{
    
    
    UILabel *label=[[UILabel alloc]init];
    label.frame = CGRectMake(30, 80, screenRect.width, 80);
    label.numberOfLines=2;
    label.text=@"When did you start feeling\nthis way:";
    label.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
    label.textColor=[UIColor blackColor];
    
    [self.view addSubview:label];
    
    
    timeTableView=[[UITableView alloc]init];
    timeTableView.frame=CGRectMake(10, 150 ,screenRect.width-20,screenRect.height-300);
    timeTableView.backgroundColor=[UIColor clearColor];
    timeTableView.scrollEnabled = NO;
    timeTableView.layer.borderWidth = 2.0;
    timeTableView.layer.borderColor = [UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1].CGColor;
    [timeTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    timeTableView.delegate=self;
    timeTableView.dataSource=self;
    [self.view addSubview:timeTableView];
    timePeriodViewCells=[NSArray arrayWithObjects:@"Today",@"Yesterday",@"The past week",@"The past month",@"The past year",@"More than a year", nil];
    timeTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, timeTableView.frame.size.width, 30)];
    

    if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()) {
        
        label.frame = CGRectMake(30, 80, screenRect.width, 200);
        label.font=[UIFont fontWithName:@"GothamRounded-Medium" size:30];
        timeTableView.frame=CGRectMake(10, 350 ,screenRect.width-20,screenRect.height-350);
    }
    
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
   // cell.preservesSuperviewLayoutMargins=NO;
    
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
       
    cell.textLabel.text = [timePeriodViewCells objectAtIndex:indexPath.row];
    cell.textLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];
    
    
    
    if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()){
        cell.textLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:25];

    }
    return cell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [timePeriodViewCells count];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [skipButton setImage:[UIImage imageNamed:@"next_btn.png"] forState:UIControlStateNormal];
    if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()){
        [skipButton setImage:[UIImage imageNamed:@"next_btn-ipad.png"] forState:UIControlStateNormal];

    }
    selectedInx = (int)indexPath.row;
    [timeTableView reloadData];
    
    
    
    
    [[NSUserDefaults standardUserDefaults]setObject:[timePeriodViewCells objectAtIndex:selectedInx] forKey:@"timePeriod"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
    
//    nextButton =  [UIButton buttonWithType:UIButtonTypeCustom];
//    [nextButton setImage:[UIImage imageNamed:@"forward_arrow.png"] forState:UIControlStateNormal];
//    [nextButton setFrame:CGRectMake(320, 0, 61, 21)];
//    barButton = [[UIBarButtonItem alloc] initWithCustomView:nextButton];
//    self.navigationItem.rightBarButtonItem = barButton;
//    [nextButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (UIUserInterfaceIdiomPad ==  UI_USER_INTERFACE_IDIOM()) {
        return 85.0f;
    }
    return  45.0f;
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
    
    if (UI_USER_INTERFACE_IDIOM() ==  UIUserInterfaceIdiomPad) {
        cell.textLabel.font = [UIFont fontWithName:@"GothamRounded-Light" size:25];
    }
}





@end
