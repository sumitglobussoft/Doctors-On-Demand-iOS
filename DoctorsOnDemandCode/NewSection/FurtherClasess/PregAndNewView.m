//
//  PregAndNewView.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 8/8/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "PregAndNewView.h"

@interface PregAndNewView (){
    CGSize screenRect;
    NSArray *pregnancyViewCells;
    
    
}


@end

@implementation PregAndNewView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    screenRect=[[UIScreen mainScreen]bounds].size;
    
    
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    titleLable.text =@"Pregnancy";
    titleLable.textAlignment = NSTextAlignmentCenter;
       titleLable.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
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
-(void)createUi{
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70, screenRect.width, 160)];
    
    
    logoView.image=[UIImage imageNamed:@"Pregnancy.jpg"];
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

//tableView.frame=CGRectMake(10, screenRect.height/2+10, screenRect.width-20, screenRect.height/2-10);
    tableView.backgroundColor=[UIColor clearColor];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  //  [tableView style:UITableViewStyleGrouped];
       [tableView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:tableView];
    
    
    
    
    
    
    
    
    
    

    
    
    pregnancyViewCells=[NSArray arrayWithObjects:@"See Medical Doctor",@"See Lactation Consultant",@"See Pediatrician",@"See Psychologist",nil];
    
    
    
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
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    
        // cell.imageView.frame = CGRectMake(10, 2, 22, 22);
        cell.textLabel.text = [pregnancyViewCells objectAtIndex:indexPath.section];
         cell.textLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];
        cell.imageView.image = [UIImage imageNamed:@"user_menu.png"];
        cell.accessoryView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"forward_arrow.png"]];
 
    
    
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"section>>>>>>%ld",(long)indexPath.section);
    
    
    switch (indexPath.section) {
        case 0:
        {
            MedicalView *medical=[[MedicalView alloc]init];
            [self.navigationController pushViewController:medical animated:YES];
            
            break;
        }
        case 1:
        {
            LactationVC *lactation=[[LactationVC alloc]init];
            [self.navigationController pushViewController:lactation animated:YES];
            
            break;
        }
        case 2:{
            PediatricsView *pediatrics=[[PediatricsView alloc]init];
            [self.navigationController pushViewController:pediatrics animated:YES];
            break;
        }
            
        case 3:{
          PsychologyView  *psychology=[[PsychologyView alloc]init];
            [self.navigationController pushViewController:psychology animated:YES];
            break;
           
        }
            
            
        default:
            break;
    }
    
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [pregnancyViewCells count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==2){
        return  10;
    }
    else
    return 25;
}

#pragma mark- See a doctor

-(void)backAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return 50;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc] init];
    /* Create custom view to display section header... */
      NSString *string ;

    if(section==0){
        view.frame = CGRectMake(0, 0, tableView.frame.size.width, 20);
        /* Create custom view to display section header... */
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
        [label setFont:[UIFont fontWithName:@"GothamRounded-Rounded" size:12]];
        [label setTextColor:[UIColor whiteColor]];
        string=@"PREGNANCY";
        [label setText:string];
        [view addSubview:label];
        [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]];
    }
    else if (section==1){
        view.frame = CGRectMake(0, 0, tableView.frame.size.width, 20);
        /* Create custom view to display section header... */
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
         [label setFont:[UIFont fontWithName:@"GothamRounded-Rounded" size:12]];
        [label setTextColor:[UIColor whiteColor]];
        string=@"NEWBORN";
        [label setText:string];
        [view addSubview:label];
        [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]];
    }
    else if (section==3){
        view.frame = CGRectMake(0, 0, tableView.frame.size.width, 20);
        /* Create custom view to display section header... */
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
         [label setFont:[UIFont fontWithName:@"GothamRounded-Rounded" size:12]];
        [label setTextColor:[UIColor whiteColor]];
        string=@"POSTPARTUM";
        [label setText:string];
        [view addSubview:label];
        [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]];
    }
    
        /* Section header is in 0th index... */
    //your background color...
    return view;
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
