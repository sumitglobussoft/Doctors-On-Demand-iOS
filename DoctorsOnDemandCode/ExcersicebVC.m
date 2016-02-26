//
//  ExcersicebVC.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 10/1/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "ExcersicebVC.h"

@interface ExcersicebVC (){
    
    
    UIScrollView *myScroll;
    CGSize screenRect;
    UIButton *notAtAllBtn,*severalBtn,*moreThanBtn,*nearlyBtn;
    ExerciseVC *exercise;
    int option;
}


@end

@implementation ExcersicebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   
      [SingletonClass sharedSingleton].exercise=[SingletonClass sharedSingleton].exercise+1;
     NSLog(@"-->%d",[SingletonClass sharedSingleton].exercise);
    self.navigationController.navigationBar.hidden = YES;
    screenRect=[[UIScreen mainScreen]bounds].size;
    exercise=[[ExerciseVC alloc ]init];
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    UIView * headerView =[[UIView alloc]init];
    headerView.frame=  CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55);
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]init];
    titleLable.frame= CGRectMake(60, 25, [UIScreen mainScreen].bounds.size.width-120, 25);
    if([SingletonClass sharedSingleton].exercise==2){
        titleLable.text=@"EXERCISE 1b";
    }
    else if([SingletonClass sharedSingleton].exercise==4){
        titleLable.text=@"EXERCISE 1d";
    }
    else if([SingletonClass sharedSingleton].exercise==6){
        titleLable.text=@"EXERCISE 1f";
    }

    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font =[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
   [backButton setFrame:CGRectMake(15, 18, 55, 35)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
    
    //  self.title=@"PURPOSE OF VISIT";
    
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad) {
        
        headerView.frame=  CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 75);
        titleLable.frame= CGRectMake(60, 25, [UIScreen mainScreen].bounds.size.width-120, 30);
        titleLable.font = [UIFont systemFontOfSize:30];
        [backButton setImage:[UIImage imageNamed:@"back_btn_ipad.png"] forState:UIControlStateNormal];
        [backButton setFrame:CGRectMake(15, 30, 80, 25)];
        
        
    }
    
    
    [self createUi];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark-back Action
-(void)backAction{
    // [SingletonClass sharedSingleton].exercise=[SingletonClass sharedSingleton].exercise-1;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-create Ui
-(void)createUi{
    
  
    myScroll = [[UIScrollView alloc] init];
    myScroll.frame = CGRectMake(0, 55, screenRect.width, screenRect.height);
    
    myScroll.contentSize = CGSizeMake(320, screenRect.height+30);
    myScroll.backgroundColor = [UIColor clearColor];
    
    myScroll.showsVerticalScrollIndicator = NO;    // to hide scroll indicators!
    
    
    
    myScroll.scrollEnabled = YES;                 //say "NO" to disable scroll
    
    
    [self.view addSubview:myScroll];               //adding to parent view!
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0,40, screenRect.width, 50)];
    
    if([SingletonClass sharedSingleton].exercise==2){
    label.text=@"Not being able to stop or control\nworrying";
    }
    else if([SingletonClass sharedSingleton].exercise==4){
        label.text=@"Trouble relaxing";
    }
    else if([SingletonClass sharedSingleton].exercise==6){
        label.text=@"Becoming easily annoyed or irritable";
    }
    label.numberOfLines=2;
    label.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor blackColor];
    
    [myScroll addSubview:label];
    
    
    
    label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, screenRect.width, 50)];
    
    label.text=@"Over the last 2 weeks or more,have you\nnoticed the following?";
    label.numberOfLines=2;
    label.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor blackColor];
    
    [myScroll addSubview:label];
    
    
    
    notAtAllBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    notAtAllBtn.frame=CGRectMake(10, 90, screenRect.width-20, 40);
    notAtAllBtn.backgroundColor=[UIColor whiteColor];
    [notAtAllBtn setTitle:@"Not at all" forState:UIControlStateNormal];
    [notAtAllBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     notAtAllBtn.titleLabel.font =[UIFont fontWithName:@"GothamRounded-Light" size:14];
    [notAtAllBtn addTarget:self action:@selector(notAllBtnActn) forControlEvents:UIControlEventTouchUpInside];
    notAtAllBtn.layer.cornerRadius=2;
    notAtAllBtn.layer.borderWidth=0.2f;
    notAtAllBtn.layer.borderColor=[[UIColor blackColor] CGColor];

    [myScroll addSubview:notAtAllBtn];
    
    
    severalBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    severalBtn.frame=CGRectMake(10, 140, screenRect.width-20, 40);
    severalBtn.backgroundColor=[UIColor whiteColor];
    [severalBtn setTitle:@"Several days" forState:UIControlStateNormal];
    [severalBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     severalBtn.titleLabel.font =[UIFont fontWithName:@"GothamRounded-Light" size:14];
    severalBtn.layer.cornerRadius=2;
    severalBtn.layer.borderWidth=0.2f;
    severalBtn.layer.borderColor=[[UIColor blackColor] CGColor];

    [severalBtn addTarget:self action:@selector(severalBtnActn) forControlEvents:UIControlEventTouchUpInside];
    [myScroll addSubview:severalBtn];
    
    
    
    moreThanBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    moreThanBtn.frame=CGRectMake(10, 190, screenRect.width-20, 40);
    moreThanBtn.backgroundColor=[UIColor whiteColor];
    [moreThanBtn setTitle:@"More than half the days" forState:UIControlStateNormal];
    [moreThanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     moreThanBtn.titleLabel.font =[UIFont fontWithName:@"GothamRounded-Light" size:14];
    moreThanBtn.layer.cornerRadius=2;
    moreThanBtn.layer.borderWidth=0.2f;
    moreThanBtn.layer.borderColor=[[UIColor blackColor] CGColor];

    [moreThanBtn addTarget:self action:@selector(moreBtnActn) forControlEvents:UIControlEventTouchUpInside];
    [myScroll addSubview:moreThanBtn];
    
    
    
    nearlyBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    nearlyBtn.frame=CGRectMake(10, 240, screenRect.width-20, 40);
    nearlyBtn.backgroundColor=[UIColor whiteColor];
    [nearlyBtn setTitle:@"Nearly every day" forState:UIControlStateNormal];
    [nearlyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     nearlyBtn.titleLabel.font =[UIFont fontWithName:@"GothamRounded-Light" size:14];
    nearlyBtn.layer.cornerRadius=2;
    nearlyBtn.layer.borderWidth=0.2f;
    nearlyBtn.layer.borderColor=[[UIColor blackColor] CGColor];

    [nearlyBtn addTarget:self action:@selector(nearlyBtnActn) forControlEvents:UIControlEventTouchUpInside];
    [myScroll addSubview:nearlyBtn];
    
    
    
    
}
#pragma mark - Button Actions

-(void)nearlyBtnActn{
    
    option=4;
    [self addingToArray:option];
    [self.navigationController pushViewController:exercise animated:YES];
    
}
-(void)moreBtnActn{
    option=3;
    [self addingToArray:option];
    [self.navigationController pushViewController:exercise animated:YES];
}

-(void)notAllBtnActn{
    option=1;
    [self addingToArray:option];
    [self.navigationController pushViewController:exercise animated:YES];
}
-(void)severalBtnActn{
    option=2;
    [self addingToArray:option];
    [self.navigationController pushViewController:exercise animated:YES];
    
}
#pragma mark-Adding to global array
-(void)addingToArray:(int)optn{
    
   
    [[SingletonClass sharedSingleton].globalDictionry1 setObject:[NSString stringWithFormat:@"%d",optn] forKey:[NSString stringWithFormat:@"%d",[SingletonClass sharedSingleton].exercise]];

    
        NSLog(@"added array----->%@",[SingletonClass sharedSingleton].globalDictionry1);
    
}


//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}

@end