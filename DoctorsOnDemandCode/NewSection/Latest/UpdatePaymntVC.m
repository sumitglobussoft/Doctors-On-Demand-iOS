//
//  UpdatePaymntVC.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 9/15/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "UpdatePaymntVC.h"

@interface UpdatePaymntVC ()
    {
        CGSize screenRect;
        UIScrollView *scroll;
      

}

@end

@implementation UpdatePaymntVC

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
    briefDescp.text=@"Please update your payment\nmethod by scanning your card:";
    briefDescp.font=[UIFont systemFontOfSize:18];
    briefDescp.textColor=[UIColor blackColor];
    
    [scroll addSubview:briefDescp];

}
-(void)backAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
