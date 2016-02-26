//
//  YourChildVC.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 9/18/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "YourChildVC.h"

@interface YourChildVC (){
    CGSize screenRect;
    UITableView *childTableView;
    int numberOfRows;
    UITableViewCell *cell;
    UIButton *addButton;
    BOOL isExpandclick;
    UISegmentedControl *gender;
    
}



@end

@implementation YourChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    screenRect=[[UIScreen mainScreen]bounds].size;
    
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    titleLable.text =@"Your Child";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font =[UIFont systemFontOfSize:12];
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
    [backButton setFrame:CGRectMake(15, 30, 45, 15)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
    
    
    
    UIButton *nextButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
    [nextButton setFrame:CGRectMake(15, 30, 45, 15)];
    [nextButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:nextButton];
    
    isExpandclick=NO;
    
    [self createUi];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)createUi{
    
    numberOfRows=3;


    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(30, 80, screenRect.width, 40)];
    label.numberOfLines=2;
    label.text=@"Please tell us some basic info\nabout your child:";
    label.font=[UIFont boldSystemFontOfSize:12];
    label.textColor=[UIColor blackColor];
    
    [self.view addSubview:label];
    
    
    
    
    
    
    
    
    
    childTableView=[[UITableView alloc]init];
    childTableView.frame=CGRectMake(10, 120 ,screenRect.width-20,screenRect.height);
    childTableView.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];

    childTableView.scrollEnabled=NO;
    
    
    childTableView.delegate=self;
    childTableView.dataSource=self;
    [self.view addSubview:childTableView];
    
    
    UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 10 ,childTableView.frame.size.width, 150)];
    footerView.backgroundColor=[UIColor clearColor];
     [self.view addSubview:footerView];
    
    
    
    
    gender = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"All", @"Female", @"Male", nil]];
    gender.frame = CGRectMake(5, 10,childTableView.frame.size.width-10 , 40);
    // segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    //gender.selectedSegmentIndex = 0;
    gender.tintColor = [UIColor redColor];
  //  [gender addTarget:self action:@selector(valueChanged) forControlEvents: UIControlEventValueChanged];
    [footerView addSubview:gender];

    
    addButton =  [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addButton.frame=CGRectMake(childTableView.frame.size.width-100 , footerView.frame.size.height-50, 100, 40);
    [addButton addTarget:self action:@selector(expandActn) forControlEvents:UIControlEventTouchUpInside];
    [addButton setBackgroundImage:[UIImage imageNamed:@"expand_btn.png"] forState:UIControlStateNormal];
    
    [footerView addSubview:addButton];
    childTableView.tableFooterView=footerView;
    

    


}

-(void)expandActn{
    
    if(isExpandclick==NO){
    [addButton setBackgroundImage:[UIImage imageNamed:@"collapse_btn-1.png"] forState:UIControlStateNormal];
    numberOfRows=6;
    [childTableView reloadData];
    isExpandclick=YES;
    }
    else{
        [addButton setBackgroundImage:[UIImage imageNamed:@"expand_btn.png"] forState:UIControlStateNormal];
        numberOfRows=3;
        [childTableView reloadData];
        isExpandclick=NO;

    }
    
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"SimpleTableItem";
    
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];

    
    if (cell == nil )
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    }
    
    
    if(isExpandclick==NO){
    if(indexPath.row==0 ){
        
        
        UITextField *firstName=[[UITextField alloc]initWithFrame:CGRectMake(5, 10,childTableView.frame.size.width-10 , 40)];
        firstName.borderStyle=UITextBorderStyleRoundedRect;
        firstName.backgroundColor=[UIColor whiteColor];
        firstName.placeholder=@" First Name";
        firstName.delegate = self;
        [cell addSubview:firstName];
    }
    else if(indexPath.row==1){
    
        
        
        
        UITextField *lastName=[[UITextField alloc]initWithFrame:CGRectMake(5, 10,childTableView.frame.size.width-10 , 40)];
        lastName.borderStyle=UITextBorderStyleRoundedRect;
        lastName.backgroundColor=[UIColor whiteColor];
        lastName.placeholder=@" Last Name";
        lastName.delegate = self;
        [cell addSubview:lastName];
        
        
    }
    else if(indexPath.row==2){
        
        UITextField *dob=[[UITextField alloc]initWithFrame:CGRectMake(5, 10,childTableView.frame.size.width-10 , 40)];
        dob.borderStyle=UITextBorderStyleRoundedRect;
        dob.backgroundColor=[UIColor whiteColor];
        dob.placeholder=@" Date of Birth";
        dob.delegate = self;
        [cell addSubview:dob];
        
        
        
    }
    }
    else{
        
        if(indexPath.row==0 ){
            
            
            UITextField *prefix=[[UITextField alloc]initWithFrame:CGRectMake(5, 10,childTableView.frame.size.width-10 , 40)];
            prefix.borderStyle=UITextBorderStyleRoundedRect;
            prefix.backgroundColor=[UIColor whiteColor];
            prefix.placeholder=@" Prefix";
            prefix.delegate = self;
            [cell addSubview:prefix];
        }
        else if(indexPath.row==1){
            
            
            
            
            UITextField *firstName=[[UITextField alloc]initWithFrame:CGRectMake(5, 10,childTableView.frame.size.width-10 , 40)];
            firstName.borderStyle=UITextBorderStyleRoundedRect;
            firstName.backgroundColor=[UIColor whiteColor];
            firstName.placeholder=@" First Name";
            firstName.delegate = self;
            [cell addSubview:firstName];
            
            
        }
        else if(indexPath.row==2){
            
            UITextField *middleName=[[UITextField alloc]initWithFrame:CGRectMake(5, 10,childTableView.frame.size.width-10 , 40)];
            middleName.borderStyle=UITextBorderStyleRoundedRect;
            middleName.backgroundColor=[UIColor whiteColor];
            middleName.placeholder=@" Middle Name";
            middleName.delegate = self;
            [cell addSubview:middleName];
            
            
            
        }
        else if(indexPath.row==3){
            
            UITextField *lastName=[[UITextField alloc]initWithFrame:CGRectMake(5, 10,childTableView.frame.size.width-10 , 40)];
            lastName.borderStyle=UITextBorderStyleRoundedRect;
            lastName.backgroundColor=[UIColor whiteColor];
            lastName.placeholder=@" Last Name";
            lastName.delegate = self;
            [cell addSubview:lastName];
            
        }
       else if(indexPath.row==4){
            
            UITextField *suffix=[[UITextField alloc]initWithFrame:CGRectMake(5, 10,childTableView.frame.size.width-10 , 40)];
            suffix.borderStyle=UITextBorderStyleRoundedRect;
            suffix.backgroundColor=[UIColor whiteColor];
            suffix.placeholder=@" Suffix";
            suffix.delegate = self;
            [cell addSubview:suffix];
            
            
            
        }
       else if(indexPath.row==5){
           UITextField *dob=[[UITextField alloc]initWithFrame:CGRectMake(5, 10,childTableView.frame.size.width-10 , 40)];
           dob.borderStyle=UITextBorderStyleRoundedRect;
           dob.backgroundColor=[UIColor whiteColor];
           dob.placeholder=@" Date of Birth";
           dob.delegate = self;
           [cell addSubview:dob];
       }



        
    }

    
    
    
    
    
    
    
        return cell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return numberOfRows;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//  
//    
//    [cell setBackgroundColor:[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1]];
//}
//- (CGFloat)tableView:(UITableView*)tableView
//heightForFooterInSection:(NSInteger)section {
//    return 5.0;
//}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
        [textField resignFirstResponder];
    return  YES;
}
-(void)backAction
{
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
