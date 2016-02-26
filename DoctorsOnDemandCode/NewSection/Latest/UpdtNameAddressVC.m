//
//  UpdtNameAddressVC.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 9/14/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "UpdtNameAddressVC.h"

@interface UpdtNameAddressVC (){
    CGSize screenRect;
    UIScrollView *scroll;
    NSArray *stateNames,*abbStateName,*phNoType;
    UITextField *state;
    UITextField *whichPhNo;
    UIPickerView *dataPicker1,*dataPicker;
    UIToolbar *toolbar;
}


@end

@implementation UpdtNameAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    screenRect = [[UIScreen mainScreen] bounds].size;
    
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    titleLable.text =@"Update Information";
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
    
    
    
    scroll = [[UIScrollView alloc] init];
    scroll.frame = CGRectMake(0, 55, screenRect.width, screenRect.height);
    
    scroll.contentSize = CGSizeMake(screenRect.width, screenRect.height+50);
    scroll.backgroundColor = [UIColor clearColor];
    
    scroll.showsVerticalScrollIndicator = YES;
    
    
    
    scroll.scrollEnabled = YES;
    
    
    [self.view addSubview:scroll];
    
    UILabel *briefDescp=[[UILabel alloc]initWithFrame:CGRectMake(30, 10, screenRect.width-30, 50)];
    briefDescp.numberOfLines=2;
    briefDescp.text=@"Please update our name and\naddress";
    briefDescp.font=[UIFont systemFontOfSize:18];
    briefDescp.textColor=[UIColor blackColor];
    
    [scroll addSubview:briefDescp];
    
    UITextField *firstnameTextFld=[[UITextField alloc]initWithFrame:CGRectMake(10,70, screenRect.width-20, 40)];
    firstnameTextFld.borderStyle=UITextBorderStyleRoundedRect;
    firstnameTextFld.placeholder=@" First Name";
    firstnameTextFld.layer.cornerRadius=10.0f;
    firstnameTextFld.delegate=self;
    [scroll addSubview:firstnameTextFld];
    
    
    
    UITextField *lastnameTextFld=[[UITextField alloc]initWithFrame:CGRectMake(10,120, screenRect.width-20, 40)];
    lastnameTextFld.borderStyle=UITextBorderStyleRoundedRect;
    lastnameTextFld.placeholder=@" Last Name";
    lastnameTextFld.layer.cornerRadius=10.0f;
    lastnameTextFld.delegate=self;
    [scroll addSubview:lastnameTextFld];
    
    UITextField *streetAdd1=[[UITextField alloc]initWithFrame:CGRectMake(10,170, screenRect.width-20, 40)];
    streetAdd1.borderStyle=UITextBorderStyleRoundedRect;
    streetAdd1.placeholder=@" Street Address 1";
    streetAdd1.layer.cornerRadius=10.0f;
     streetAdd1.delegate=self;
    [scroll addSubview:streetAdd1];
    
    
    
    UITextField *streetAdd2=[[UITextField alloc]initWithFrame:CGRectMake(10,220, screenRect.width-20, 40)];
    streetAdd2.borderStyle=UITextBorderStyleRoundedRect;
    streetAdd2.placeholder=@" Street Address 2";
    streetAdd2.layer.cornerRadius=10.0f;
     streetAdd2.delegate=self;
    [scroll addSubview:streetAdd2];
    
    
    
    
    
    UITextField *city=[[UITextField alloc]initWithFrame:CGRectMake(10,270, screenRect.width/2+10, 40)];
    city.borderStyle=UITextBorderStyleRoundedRect;
    city.placeholder=@" City";
    city.layer.cornerRadius=10.0f;
    city.delegate=self;
    [scroll addSubview:city];

    
    
    toolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(100, 100, screenRect.width, 44)];
   state=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.width/2+20+10,270, screenRect.width/2-40, 40)];
    state.borderStyle=UITextBorderStyleRoundedRect;
    state.placeholder=@" State";
    state.delegate=self;
    state.layer.cornerRadius=10.0f;
    [scroll addSubview:state];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *done=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneActn)];
    [done setTintColor:[UIColor blueColor]];
    [toolbar setItems:[NSArray arrayWithObjects:spaceItem,done, nil]];
    [state setInputAccessoryView:toolbar];
    dataPicker=[[UIPickerView alloc]init];
    state.inputView=dataPicker;
    dataPicker.delegate = self;
    dataPicker.dataSource = self;
    
    stateNames=[NSArray arrayWithObjects:@"Alabama",@"Alaska",@"Arizona", nil];
    abbStateName=[NSArray arrayWithObjects:@"AL",@"AK",@"AZ", nil];
    
    
    
    UITextField *zipCode=[[UITextField alloc]initWithFrame:CGRectMake(10,320,screenRect.width-20, 40)];
    zipCode.keyboardType = UIKeyboardTypeNumberPad;
    zipCode.borderStyle=UITextBorderStyleRoundedRect;
    zipCode.placeholder=@" Zip code";
    zipCode.layer.cornerRadius=10.0f;
    zipCode.delegate=self;
    [scroll addSubview:zipCode];

    
    UITextField *phNumber=[[UITextField alloc]initWithFrame:CGRectMake(10,370,screenRect.width/2+10, 40)];
    phNumber.borderStyle=UITextBorderStyleRoundedRect;
    phNumber.placeholder=@" Phone Number";
    phNumber.layer.cornerRadius=10.0f;
    phNumber.delegate=self;
    [scroll addSubview:phNumber];
    
    
    
    
    UIToolbar *toolbar1=[[UIToolbar alloc]initWithFrame:CGRectMake(100, 100, screenRect.width, 44)];
    whichPhNo=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.width/2+20+10,370, screenRect.width/2-40, 40)];
    whichPhNo.borderStyle=UITextBorderStyleRoundedRect;
    whichPhNo.delegate=self;
    whichPhNo.layer.cornerRadius=10.0f;
    [scroll addSubview:whichPhNo];
    
    UIBarButtonItem *done1=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneActn1)];
    [done1 setTintColor:[UIColor blueColor]];
    [toolbar1 setItems:[NSArray arrayWithObjects:spaceItem,done1, nil]];
    [whichPhNo setInputAccessoryView:toolbar1];
   dataPicker1=[[UIPickerView alloc]init];
    whichPhNo.inputView=dataPicker1;
    dataPicker1.delegate = self;
    dataPicker1.dataSource = self;
    
    phNoType=[NSArray arrayWithObjects:@"Mobile",@"Daytime",@"Evening",@"Office",@"Fax",@"Reminder",@"Home", nil];
 


    
    
    UIButton *saveBtn=[[UIButton alloc]initWithFrame:CGRectMake(10,420, screenRect.width-20, 40)];
    [saveBtn setTitle:@"Save Update" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn setBackgroundColor:[UIColor colorWithRed:(CGFloat)234/255 green:(CGFloat)30/255 blue:(CGFloat)99/255 alpha:(CGFloat)1.0]];
    [saveBtn addTarget:self action:@selector(myHealthCrBtnAction) forControlEvents:UIControlEventTouchUpInside];
    saveBtn.layer.cornerRadius=10.0f;
    [scroll addSubview:saveBtn];
    
    
    UIButton *cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(10,470, screenRect.width-20, 40)];
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:[UIColor grayColor]];
    [cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.layer.cornerRadius=10.0f;
    [scroll addSubview:cancelBtn];
    
    
    
    
    
    
    
    
}
-(void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)cancelBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
       [textField resignFirstResponder];
    return  YES;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (pickerView==dataPicker) {
        return [stateNames count];

    }
    else if (pickerView==dataPicker1){
        return [phNoType count];
    }
    else
        return  0;
    
   }
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    
    
    if (pickerView==dataPicker) {
        return [stateNames objectAtIndex:row];
        
    }
    else if (pickerView==dataPicker1){
       return [phNoType objectAtIndex:row];
    }
    else
        return  nil;
    



}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
   
    if (pickerView==dataPicker) {
         state.text=[abbStateName objectAtIndex:row];
    }
    else if (pickerView==dataPicker1){
     whichPhNo.text=[phNoType objectAtIndex:row];
    }
    
    
}
-(void)doneActn{
    [state resignFirstResponder];
}
-(void)doneActn1{
    [whichPhNo resignFirstResponder];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    scroll.contentSize = CGSizeMake(screenRect.width, screenRect.height+250);

    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
 scroll.contentSize = CGSizeMake(screenRect.width, screenRect.height+50);
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
