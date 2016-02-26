 //
//  AllergiesView.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 8/14/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "AllergiesView.h"

@interface AllergiesView (){
    
        CGSize screenRect;
        UITableViewCell *cell;
   
        int numberOfRows;
        UITableView *tableView;
        int count;
    UIButton *nextButton;
    NSMutableArray *textFieldDetails,*completeArry;
    UIBarButtonItem *barButton;
    UITextField *textField;
}

@end

@implementation AllergiesView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    completeArry=[[NSMutableArray alloc]init];
    UIView * headerView =[[UIView alloc]init];
    headerView.frame= CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55);
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
     textFieldDetails=[[NSMutableArray alloc]init];
    UILabel * titleLable =[[UILabel alloc]init];
    titleLable.frame= CGRectMake(60, 25, [UIScreen mainScreen].bounds.size.width-120, 25);
    titleLable.text =@"ALLERGIES";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font =[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
   [backButton setFrame:CGRectMake(15, 22, 55, 35)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
     nextButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setImage:[UIImage imageNamed:@"skip_btn.png"] forState:UIControlStateNormal];
    [nextButton setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-60, 28, 50, 20)];
    [nextButton addTarget:self action:@selector(continueAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:nextButton];

    
    
    numberOfRows=1;
    count=1;
    screenRect = [[UIScreen mainScreen] bounds].size;
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        headerView.frame= CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 75);
        
        titleLable.frame = CGRectMake(60, 25, screenRect.width-120, 25);
        titleLable.font = [UIFont fontWithName:@"GothamRounded-Light" size:26];
        
        [backButton setImage:[UIImage imageNamed:@"back_btn_ipad.png"] forState:UIControlStateNormal];
        [backButton setFrame:CGRectMake(15, 30, 80, 25)];
        
        [nextButton setImage:[UIImage imageNamed:@"skip_btn_ipad.png"] forState:UIControlStateNormal];
        [nextButton setFrame:CGRectMake(screenRect.width-100, 30, 80, 25)];
    }
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    
    
    
    
    self.navigationController.navigationBar.hidden = YES;

        
    [self createUi];
    
    
    
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)continueAction{
    
    NSLog(@"elemenst before continue--->%@",textFieldDetails);
    if(textFieldDetails.count!=0){
        [textFieldDetails addObject:textField.text];
    }
    
    
    NSLog(@"elemenst after continue--->%@",textFieldDetails);
    
    
    
    for(int i=0;i<textFieldDetails.count;i++){
        
        
        [completeArry addObject:[textFieldDetails objectAtIndex:i]];
        
        
        
    }
    if(textFieldDetails.count!=0){
        
      //  if([SingletonClass sharedSingleton].deptId==5){
            
            NSString *allergyStr=[textFieldDetails componentsJoinedByString:@","];
            
//            [[NSUserDefaults standardUserDefaults]setObject:allergyStr  forKey:@"allergies"];
//            [[NSUserDefaults standardUserDefaults]synchronize];

            
       // }
        //else{
//        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:allergyStr options:NSJSONReadingAllowFragments error:nil];
//        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"JSON Output: %@", allergyStr);
        [[NSUserDefaults standardUserDefaults]setObject:allergyStr  forKey:@"allergies"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        }

   
    else{
        [[NSUserDefaults standardUserDefaults]setObject:@""  forKey:@"allergies"];
        [[NSUserDefaults standardUserDefaults]synchronize];

    }
    
    
    
    

    SymptomsView *symptompsView=[[SymptomsView alloc]init];
    [self.navigationController pushViewController:symptompsView animated:YES];
    
    
}
    
    

-(void)createUi{
    
    UILabel *label=[[UILabel alloc]init];
    label.frame=CGRectMake(30,80, screenRect.width, 80);
    label.numberOfLines=2;
    label.text=@"Please tell us any allergies you\nhave:";
    label.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
    label.textColor=[UIColor blackColor];
    [self.view addSubview:label];
    
    
    
    tableView=[[UITableView alloc]init];
    if(screenRect.height>=667){
         tableView.frame=CGRectMake(10, 150 ,screenRect.width-20,380+(numberOfRows*60));
    }
    
    else if (screenRect.height==568){
        tableView.frame=CGRectMake(10, 150 ,screenRect.width-20,250+(numberOfRows*60));
    }
    else{
         tableView.frame=CGRectMake(10, 150 ,screenRect.width-20,200+(numberOfRows*60));
    }
    
   
    tableView.backgroundColor=[UIColor clearColor];
    
    
    tableView.delegate=self;
    tableView.dataSource=self;
    [self.view addSubview:tableView];
    
    
    
    UIButton *addButton =  [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addButton.frame=CGRectMake(10, tableView.frame.size.height-100, screenRect.width-20, 60.0);
    
    [addButton addTarget:self action:@selector(addAnotherAction) forControlEvents:UIControlEventTouchUpInside];

    [addButton setBackgroundImage:[UIImage imageNamed:@"addallergy_btn.png"] forState:UIControlStateNormal];
    tableView.tableFooterView=addButton;
    
    
    if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()) {
        label.frame=CGRectMake(30,100, screenRect.width, 150);
        label.font = [UIFont fontWithName:@"GothamRounded-Medium" size:30];
        //label.textAlignment = NSTextAlignmentCenter;
         tableView.frame=CGRectMake(10, 300 ,screenRect.width-20,screenRect.height-300);
        addButton.frame=CGRectMake(0, tableView.frame.size.height-100, screenRect.width-20, 100);
        [addButton setBackgroundImage:[UIImage imageNamed:@"addallergy_btn_ipad.png"] forState:UIControlStateNormal];

    }


    

}
-(void)addAnotherAction{
   
    
    [textFieldDetails addObject:textField.text];
    numberOfRows=1+count;
    [tableView reloadData];
    count++;
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"SimpleTableItem";
    
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    
    
    if (cell == nil )
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    
    if(indexPath.row<=numberOfRows ){
        
        
         textField= [[UITextField alloc] init];
         textField.frame= CGRectMake(10, 10, screenRect.width-20, 50);
        textField.adjustsFontSizeToFitWidth = YES;
        textField.textColor = [UIColor blackColor];
        textField.backgroundColor=[UIColor whiteColor];
        textField.layer.cornerRadius=5.0f;
        textField.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];
        textField.delegate=self;
        
        
        if(textFieldDetails.count!=0 && indexPath.row<=textFieldDetails.count-1){
            textField.text=[textFieldDetails  objectAtIndex:indexPath.row];
            //[textFieldDetails removeLastObject];
        }

        
        textField.placeholder = @" Allergy";
        textField.keyboardType = UIKeyboardTypeEmailAddress;
        textField.returnKeyType = UIReturnKeyNext;
        [cell addSubview:textField];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            textField.frame= CGRectMake(10, 10, screenRect.width-20, 100);
            textField.font = [UIFont systemFontOfSize:25];
        }
        
        
    }
    
    //cell.textLabel.text = [timePeriodViewCells objectAtIndex:indexPath.row];
    return cell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return numberOfRows;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()) {
        return 120;
    }
    return 60;
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //[cell setBackgroundColor:[UIColor colorWithPatternImage:pattern]];
    
    [cell setBackgroundColor:[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1]];
}
- (CGFloat)tableView:(UITableView*)tableView
    heightForFooterInSection:(NSInteger)section {
    return 5.0;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
    
      [nextButton setImage:[UIImage imageNamed:@"next_btn.png"] forState:UIControlStateNormal];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        [nextButton setImage:[UIImage imageNamed:@"next_btn-ipad.png"] forState:UIControlStateNormal];
    }
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
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
