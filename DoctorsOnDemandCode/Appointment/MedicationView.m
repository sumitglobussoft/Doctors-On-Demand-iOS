//
//  MedicationView.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 8/13/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "MedicationView.h"
#import "AllergiesView.h"

@interface MedicationView ()
{
    CGSize screenRect;
    UITableViewCell *cell;
    UIPickerView *myPickerView;
    NSArray *pickerArray;
    int numberOfRows;
    UITableView *medicationTableView;
    int count;
    UIButton *dataPick,*nextButton;
    UIToolbar *toolBar;
    NSString * selectedStr;
    NSMutableArray *textFieldDetails,*pickerDetails;
    UITextField *cellTextField;
    NSMutableArray *jsonText,*completeArry;
  
    
}



@end

@implementation MedicationView

- (void)viewDidLoad {
    [super viewDidLoad];
    numberOfRows=1;
    count=1;
    screenRect = [[UIScreen mainScreen] bounds].size;
 
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    textFieldDetails=[[NSMutableArray alloc]init];
    pickerDetails=[[NSMutableArray alloc]init];
   
   
    
    completeArry=[[NSMutableArray alloc]init];
    
    
    UIView * headerView =[[UIView alloc]init];
    headerView.frame= CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55);
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]init];
    titleLable.frame = CGRectMake(60, 25, screenRect.width-120, 25);
    titleLable.text =@"MEDICATION";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font =[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
  [backButton setFrame:CGRectMake(15, 18, 55, 35)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
   nextButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setImage:[UIImage imageNamed:@"skip_btn.png"] forState:UIControlStateNormal];
    [nextButton setFrame:CGRectMake(screenRect.width-60, 28, 45, 25)];
    [nextButton addTarget:self action:@selector(continueAction) forControlEvents:UIControlEventTouchUpInside];
     [headerView addSubview:nextButton];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
         headerView.frame= CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 75);
        
        titleLable.frame = CGRectMake(60, 25, screenRect.width-120, 25);
        titleLable.font = [UIFont fontWithName:@"GothamRounded-Light" size:26];
        
        [backButton setImage:[UIImage imageNamed:@"back_btn_ipad.png"] forState:UIControlStateNormal];
        [backButton setFrame:CGRectMake(15, 30, 80, 25)];
        
        [nextButton setImage:[UIImage imageNamed:@"skip_btn_ipad.png"] forState:UIControlStateNormal];
        [nextButton setFrame:CGRectMake(screenRect.width-100, 30, 80, 25)];
    }
    
    
    
    
        [self createUi];
    
    
    
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)createUi{
    
    UILabel *label=[[UILabel alloc]init];
    label.frame=CGRectMake(30,80, screenRect.width, 80);
    label.numberOfLines=3;
    label.text=@"Please tell us if you are currently\ntaking any medications,and if so,\nhow long?";
    label.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
    label.textColor=[UIColor blackColor];
    [self.view addSubview:label];

    
   medicationTableView=[[UITableView alloc]init];
    
    
    if(screenRect.height==480)
     medicationTableView.frame=CGRectMake(10, 150 ,screenRect.width-20,200+(numberOfRows*60));
    else if (screenRect.height==568)
        
        medicationTableView.frame=CGRectMake(10, 150 ,screenRect.width-20,250+(numberOfRows*60));
    
    else if (screenRect.height>=667)
        
        
        
        medicationTableView.frame=CGRectMake(10, 150 ,screenRect.width-20,350+(numberOfRows*60));
    
    medicationTableView.backgroundColor=[UIColor clearColor];
    
    
    medicationTableView.delegate=self;
    medicationTableView.dataSource=self;
  
    medicationTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:medicationTableView];
    
    
    
    UIButton *addButton =  [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addButton.frame=CGRectMake(5, medicationTableView.frame.size.height-100, 284, 60.0);
   
    [addButton addTarget:self action:@selector(addAnotherAction) forControlEvents:UIControlEventTouchUpInside];

    [addButton setBackgroundImage:[UIImage imageNamed:@"addmedication_btn.png"] forState:UIControlStateNormal];
    medicationTableView.tableFooterView=addButton;
    
    if (UIUserInterfaceIdiomPad ==  UI_USER_INTERFACE_IDIOM()) {
        
        
      
        

        
        label.frame=CGRectMake(30,100, screenRect.width-60, 150);
        label.font = [UIFont fontWithName:@"GothamRounded-Medium" size:30];
        //label.textAlignment = NSTextAlignmentCenter;
        medicationTableView.frame=CGRectMake(10, 300 ,screenRect.width-20,screenRect.height-300);
        addButton.frame=CGRectMake(5, medicationTableView.frame.size.height-100,medicationTableView.frame.size.width, 100);
        [addButton setBackgroundImage:[UIImage imageNamed:@"addmedication_btn_ipad.png"] forState:UIControlStateNormal];

    }
    
    
    }
-(void)addAnotherAction{
    
    
    [textFieldDetails addObject:cellTextField.text];
    if(selectedStr !=nil){
        [pickerDetails addObject:selectedStr];
    }
    
    NSLog(@"elemnt after +-->%@",textFieldDetails);
    
     NSLog(@"pick elemnt after +-->%@",pickerDetails);
    

    numberOfRows=1+count;
    [medicationTableView reloadData];
    count++;
    
    
}

#pragma  mark- tableView delegate methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"SimpleTableItem";
    
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
   
    
    
    if (cell == nil )
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone
    ;
    if(indexPath.row<=numberOfRows ){
        
        
       cellTextField = [[UITextField alloc] init];
        cellTextField.frame=CGRectMake(10, 10, 185, 50);
        cellTextField.adjustsFontSizeToFitWidth = YES;
        cellTextField.textColor = [UIColor blackColor];
        cellTextField.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];
        cellTextField.backgroundColor=[UIColor whiteColor];
        cellTextField.layer.cornerRadius=5.0f;

        cellTextField.delegate=self;
            cellTextField.placeholder = @" Medication";
            cellTextField.keyboardType = UIKeyboardTypeEmailAddress;
            cellTextField.returnKeyType = UIReturnKeyNext;
        [cell addSubview:cellTextField];
        
        
       
        
        
        if(textFieldDetails.count!=0 && indexPath.row<=textFieldDetails.count-1){
            cellTextField.text=[textFieldDetails  objectAtIndex:indexPath.row];
            //[textFieldDetails removeLastObject];
        }
        
            dataPick=[[UIButton alloc]init];
            dataPick.frame = CGRectMake(screenRect.width/2+20, 10, screenRect.width-(screenRect.width/2+40+20), 50);
        if(selectedStr==nil || indexPath.row>textFieldDetails.count-1){
        [dataPick setTitle:@"How\nLong?" forState:UIControlStateNormal];
        }
        else{
            [dataPick setTitle:[pickerDetails objectAtIndex:indexPath.row]  forState:UIControlStateNormal];

        }

        [dataPick setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        dataPick.titleLabel.numberOfLines=2;
        
        [dataPick setBackgroundImage:[UIImage imageNamed:@"dropdown_btn.png"] forState:UIControlStateNormal];
        [dataPick addTarget:self action:@selector(dataPickAction:) forControlEvents:UIControlEventTouchUpInside];

        dataPick.tag = indexPath.row;
        dataPick.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
        dataPick.layer.cornerRadius=5.0f;
        [cell addSubview:dataPick];
            
    
        if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()) {
            
            cellTextField.frame=CGRectMake(10, 10, medicationTableView.frame.size.width/2+30, 100);
            cellTextField.textAlignment = NSTextAlignmentCenter;
            cellTextField.font = [UIFont systemFontOfSize:25];
             dataPick.frame = CGRectMake(screenRect.width/2+40, 10, screenRect.width-(screenRect.width/2+40+20), 100);
            
             dataPick.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:25];
        }
        
    }
    return cell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return numberOfRows;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return 120;
    }
    return 60;
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //[cell setBackgroundColor:[UIColor colorWithPatternImage:pattern]];
   
    [cell setBackgroundColor:[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1]];
}

#pragma  mark- create prickerView here
-(void)dataPickAction:(UIButton *)sender{
 
    pickerArray = [[NSArray alloc]initWithObjects:
                   @"The past week",@"The past month",@"The past year",@"More than a year", nil];
   
    myPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0,screenRect.height-150
                                                            , screenRect.width, 150)];
    myPickerView.backgroundColor=[UIColor whiteColor];
    
    myPickerView.dataSource = self;
    myPickerView.delegate = self;
    myPickerView.showsSelectionIndicator = YES;
    
    
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                   target:self action:@selector(done)];
    toolBar = [[UIToolbar alloc]initWithFrame:
                          CGRectMake(0, self.view.frame.size.height-
                                     myPickerView.frame.size.height, screenRect.width, 40)];
    [toolBar setBarStyle:UIBarStyleDefault];
    NSArray *toolbarItems = [NSArray arrayWithObjects:spaceItem,
                             doneButton, nil];
    [toolBar setItems:toolbarItems];
    
    if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()){
        myPickerView .frame=CGRectMake(0,screenRect.height-300 , screenRect.width, 300);
        
        
        toolBar.frame=
                   CGRectMake(0, self.view.frame.size.height-
                              myPickerView.frame.size.height, screenRect.width, 40);
    }
    [self.view insertSubview:toolBar aboveSubview:medicationTableView];
  [self.view insertSubview:myPickerView aboveSubview:medicationTableView];

    
}
-(void)done
{
    
    
   
    
    
    [myPickerView removeFromSuperview];
    [toolBar removeFromSuperview];
   
}
- (CGFloat)tableView:(UITableView*)tableView
heightForFooterInSection:(NSInteger)section {
    return 5.0;
}




#pragma mark- Picker View Delegate


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [pickerArray count];
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    
    return [pickerArray objectAtIndex:row];
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    selectedStr=[pickerArray objectAtIndex:row];
 
    [dataPick setTitle:[pickerArray objectAtIndex:row] forState:UIControlStateNormal];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        dataPick.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:25];
        
    }
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)continueAction{
    
     NSLog(@"elemenst before continue--->%@",textFieldDetails);
    if(textFieldDetails.count!=0){
        [textFieldDetails addObject:cellTextField.text];
    }
    
    
    NSLog(@"elemenst after continue--->%@",textFieldDetails);
    
    if(selectedStr !=nil){
            [pickerDetails addObject:selectedStr];
    }
     NSLog(@"pickelemenst after continue--->%@",pickerDetails);
    
  
//    for(int i=0;i<textFieldDetails.count;i++){
//        
//        
//        [completeArry addObject:@{@"name":[textFieldDetails objectAtIndex:i],@"time":[pickerDetails objectAtIndex:i]}];
//        
//         
//        
//    }
    if(textFieldDetails.count!=0){
        NSString *str;
        
            str=[textFieldDetails componentsJoinedByString:@","];
            
       
        
        
        
//        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:str options:NSJSONReadingAllowFragments error:nil];
//        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"JSON Output: %@", str);
        [[NSUserDefaults standardUserDefaults]setObject:str  forKey:@"medications"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }
    else{
        [[NSUserDefaults standardUserDefaults]setObject:@""  forKey:@"medications"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    if(pickerDetails.count!=0){
        NSString *str1;
        
        str1=[pickerDetails componentsJoinedByString:@","];
        
        
        
        
        
//        NSData *jsonData1 = [NSJSONSerialization dataWithJSONObject:str1 options:NSJSONReadingAllowFragments error:nil];
//        NSString *jsonString1 = [[NSString alloc] initWithData:jsonData1 encoding:NSUTF8StringEncoding];
        NSLog(@"JSON Output: %@", str1);
        [[NSUserDefaults standardUserDefaults]setObject:str1  forKey:@"medicationsTimme"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }
    else{
        [[NSUserDefaults standardUserDefaults]setObject:@""  forKey:@"medicationsTimme"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    

   
   
  
    
    
    if([SingletonClass sharedSingleton].deptId==4 || [SingletonClass sharedSingleton].deptId==2){
        AllergiesView * allergyVC =[[AllergiesView alloc]init];
        [self.navigationController pushViewController:allergyVC animated:YES];
    }
    
    else  if([SingletonClass sharedSingleton].deptId==3){
        MedicalConditionView    * medicalcondition =[[MedicalConditionView alloc]init];
        [self.navigationController pushViewController:medicalcondition animated:YES];
    }
    else if ([SingletonClass sharedSingleton].deptId==1){
        PumpingVC *pumping=[[PumpingVC alloc]init];
        [self.navigationController pushViewController:pumping animated:YES];
    }
}


#pragma mark-text field delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
                               {
                                   
                                   [nextButton setImage:[UIImage imageNamed:@"next_btn.png"] forState:UIControlStateNormal];
    
                                   if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()){
                                  [nextButton setImage:[UIImage imageNamed:@"next_btn-ipad.png"] forState:UIControlStateNormal];
                                   }
                                   
    NSLog(@"Array lenth textfield--->%lu",(unsigned long)[textFieldDetails count]);
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}


@end
