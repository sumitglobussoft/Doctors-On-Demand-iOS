//
//  SelectConsultantVC.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 9/16/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "SelectConsultantVC.h"

@interface SelectConsultantVC (){
    CGSize screenRect;
    
    UITableView *consultantTableView;
    UITableViewCell *cell;
    int selectedInx;
   
}


@end

@implementation SelectConsultantVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    screenRect=[[UIScreen mainScreen]bounds].size;
    
    
       self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    titleLable.text =@"SELECT CONSULTANT";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font =[UIFont systemFontOfSize:12];
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
    [backButton setFrame:CGRectMake(15, 30, 45, 15)];
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
    consultantTableView=[[UITableView alloc]init];
    consultantTableView.frame=CGRectMake(0, 100 ,screenRect.width,screenRect.height-70);
    consultantTableView.backgroundColor=[UIColor clearColor];
    
    consultantTableView.delegate=self;
    consultantTableView.dataSource=self;
    [self.view addSubview:consultantTableView];

}
-(UITableViewCell *)tableView:(UITableView * )tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        NSString *cellIdentifier = @"SimpleTableItem";
    cell = [tableView dequeueReusableCellWithIdentifier:
            cellIdentifier];
    
    
    
    
    if (cell == nil) {
        
        
        cell = [[UITableViewCell alloc]initWithStyle:
                UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        
    }
//   if (indexPath.row ==  selectedInx) {
//       
//       
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//   }
//   else{
//      // cell.accessoryType = UITableViewCellAccessoryCheckmark;
//       
    cell.accessoryView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"forward_arrow.png"]];
      // cell.accessoryType=UITableViewCellAccessoryNone;
  //}
    
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
//    selectedInx = (int)indexPath.row;
//    [consultantTableView reloadData];
    
    PsychologistVC *psychologist=[[PsychologistVC alloc]init];
    [self.navigationController pushViewController:psychologist animated:YES];
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
    
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
