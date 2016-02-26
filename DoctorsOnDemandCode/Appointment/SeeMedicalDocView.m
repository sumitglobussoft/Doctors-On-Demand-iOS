//
//  SeeMedicalDocView.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 8/8/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "SeeMedicalDocView.h"

@interface SeeMedicalDocView (){
    CGRect screenRect;
    UIView *letsGetStarted;
    UIButton *couponButton;
}

@end

@implementation SeeMedicalDocView

- (void)viewDidLoad {
    [super viewDidLoad];
    screenRect = [[UIScreen mainScreen] bounds];
    
    letsGetStarted=[[UIView alloc]initWithFrame:CGRectMake(-300, 10, self.view.frame.size.width-20, self.view.frame.size.height-20)];
    letsGetStarted.layer.cornerRadius=6.0f;
      letsGetStarted.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:letsGetStarted];
    
    
    
    [self.view insertSubview:letsGetStarted atIndex:0];
    
    [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        letsGetStarted.frame=CGRectMake(30, 30, self.view.frame.size.width-60, self.view.frame.size.height-60);
    }completion:nil];
    
    
    
    
    
    self.view.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:0.8];
    [self createUi];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)createUi{
    UILabel *header=[[UILabel alloc]initWithFrame:CGRectMake(60,0,  self.view.frame.size.width-60-5, 150)];
    header.text=@"LET'S GET\nSTARTED!";
    header.numberOfLines=2;
    header.font=[UIFont systemFontOfSize:30];
    header.textColor=[UIColor cyanColor];
    [letsGetStarted addSubview:header];
    
    UILabel *information=[[UILabel alloc]initWithFrame:CGRectMake(40,70,  self.view.frame.size.width-60-5, 300)];
    information.text=@"We need some info to get\nyou the best possible care.\n\nYour visit with a Doctor On\n  Demand physician only\n       \tcosts $40.";
    information.numberOfLines=7;
    information.font=[UIFont systemFontOfSize:15];
    information.textColor=[UIColor blackColor];
    [letsGetStarted addSubview:information];
    
    
                     
    couponButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    couponButton.frame=CGRectMake(10, 380,self.view.frame.size.width-60-30,50);
    
    [couponButton setTitle:@"Apply Coupon" forState:UIControlStateNormal];
    [couponButton setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    
    [letsGetStarted addSubview:couponButton];
    
    UIButton *letsGoButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    letsGoButton.frame=CGRectMake(0, self.view.frame.size.height-105,self.view.frame.size.width-60, 50);
    [letsGoButton setTitle:@"Let's Go!" forState:UIControlStateNormal];
    
    [letsGoButton setBackgroundColor:[UIColor cyanColor]];
    [letsGoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [letsGoButton addTarget:self action:@selector(letsGo) forControlEvents:UIControlEventTouchUpInside];
    letsGoButton.layer.cornerRadius=6.0f;
    
    [letsGetStarted addSubview:letsGoButton];

    
}
-(void)letsGo{
    
    SetUpView *setupview=[[SetUpView alloc]init];
    NSLog(@"NOW PRESSED");  
    [self.navigationController pushViewController:setupview animated:YES];
    
    
    
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
