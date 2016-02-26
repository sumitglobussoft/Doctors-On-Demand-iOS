//
//  UpdateInfoVC.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 9/1/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "UpdateInfoVC.h"

@interface UpdateInfoVC (){
    CGSize screenRect;
    UIScrollView *scroll;
}

@end

@implementation UpdateInfoVC

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
    
    scroll.contentSize = CGSizeMake(screenRect.width, screenRect.height+60);
    scroll.backgroundColor = [UIColor clearColor];
    
    scroll.showsVerticalScrollIndicator = NO;
    
    
    
    scroll.scrollEnabled = YES;
    
    
    [self.view addSubview:scroll];

    UILabel *briefDescp=[[UILabel alloc]initWithFrame:CGRectMake(30, 50, screenRect.width-30, screenRect.height-480)];
    briefDescp.numberOfLines=2;
    briefDescp.text=@"Please update our email and\npassword:";
    briefDescp.font=[UIFont systemFontOfSize:18];
    briefDescp.textColor=[UIColor blackColor];
    [scroll addSubview:briefDescp];
    
    UITextField *emailTextField=[[UITextField alloc]initWithFrame:CGRectMake(10,135, screenRect.width-20, 40)];
    emailTextField.borderStyle=UITextBorderStyleRoundedRect;
    emailTextField.placeholder=@" Email Address";
    emailTextField.layer.cornerRadius=10.0f;
    emailTextField.delegate=self;
    [scroll addSubview:emailTextField];
    
    UITextField *currentPasswd=[[UITextField alloc]initWithFrame:CGRectMake(10,185, screenRect.width-20, 40)];
    currentPasswd.borderStyle=UITextBorderStyleRoundedRect;
    currentPasswd.placeholder=@" Current Password";
    currentPasswd.secureTextEntry=YES;
    currentPasswd.layer.cornerRadius=10.0f;
    currentPasswd.delegate=self;
    [scroll addSubview:currentPasswd];

    
    
    UITextField *newPassword=[[UITextField alloc]initWithFrame:CGRectMake(10,235, screenRect.width-20, 40)];
    newPassword.borderStyle=UITextBorderStyleRoundedRect;
    newPassword.placeholder=@" New Password(At least 8 character)";
    newPassword.secureTextEntry=YES;
    newPassword.layer.cornerRadius=10.0f;
    newPassword.delegate=self;
    [scroll addSubview:newPassword];

    
    
    
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
-(void)textFieldDidBeginEditing:(UITextField *)textFiel{
    scroll.contentSize = CGSizeMake(screenRect.width, screenRect.height+200);
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    scroll.contentSize = CGSizeMake(screenRect.width, screenRect.height+60);
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
