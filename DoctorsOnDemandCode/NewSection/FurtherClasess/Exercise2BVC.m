//
//  Exercise2BVC.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 10/1/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "Exercise2BVC.h"

@interface Exercise2BVC (){
    
    
    UIScrollView *myScroll;
    CGSize screenRect;
    UIButton *notAtAllBtn,*severalBtn,*moreThanBtn,*nearlyBtn;
    ExcerciseBVC *excerciseb;
    UIView * backPopUp;
    UIView * popUpView;
    int option;
    

}


@end

@implementation Exercise2BVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [SingletonClass sharedSingleton].exerciseB++;
    self.navigationController.navigationBar.hidden = YES;
    screenRect=[[UIScreen mainScreen]bounds].size;
    excerciseb=[[ExcerciseBVC alloc]init];
   
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    UIView * headerView =[[UIView alloc]init];
    headerView.frame=  CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55);
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]init];
    titleLable.frame= CGRectMake(60, 25, [UIScreen mainScreen].bounds.size.width-120, 25);
    if([SingletonClass sharedSingleton].exerciseB==1){
        titleLable.text=@"EXERCISE 2a";
    }
    else if([SingletonClass sharedSingleton].exerciseB==3){
        titleLable.text=@"EXERCISE 2c";
    }
    else if([SingletonClass sharedSingleton].exerciseB==5){
        titleLable.text=@"EXERCISE 2e";
    }
    else if([SingletonClass sharedSingleton].exerciseB==7){
        titleLable.text=@"EXERCISE 2g";
    }
    else if([SingletonClass sharedSingleton].exerciseB==9){
        titleLable.text=@"EXERCISE 2i";
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
    //[SingletonClass sharedSingleton].exerciseB--;
    
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
    
    if([SingletonClass sharedSingleton].exerciseB==1){
        label.text=@"Little interest or pleasure in doing\nthings";
    }
    else if([SingletonClass sharedSingleton].exerciseB==3){
        label.text=@"Trouble falling or staying asleep,or\nsleeping too much";
    }
    else if([SingletonClass sharedSingleton].exerciseB==5){
        label.text=@"Poop appetite or overeating";
    }
    else if([SingletonClass sharedSingleton].exerciseB==7){
        label.text=@"Trouble concentrating on things,\nsuch as reading the newspaper or\nwatching television";
    }
    else if([SingletonClass sharedSingleton].exerciseB==9){
        label.text=@"Thought that you would be better\noff dead or of hurting yourself in\nsome way";
    }
    
    label.numberOfLines=4;
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
    if(  [SingletonClass sharedSingleton].exerciseB==9){
        [self createPopUp];
    }
    else{
        
    [self.navigationController pushViewController:excerciseb animated:YES];
        }
    
}
-(void)moreBtnActn{
     option=3;
      [self addingToArray:option];
    if(  [SingletonClass sharedSingleton].exerciseB==9){
        [self createPopUp];
    }
    else{
        [self.navigationController pushViewController:excerciseb animated:YES];
    }
}

-(void)notAllBtnActn{
     option=1;
      [self addingToArray:option];
    if(  [SingletonClass sharedSingleton].exerciseB==9){
        [self createPopUp];
    }
    else{
        [self.navigationController pushViewController:excerciseb animated:YES];
    }
}
-(void)severalBtnActn{
     option=2;
      [self addingToArray:option];
    if(  [SingletonClass sharedSingleton].exerciseB==9){
    [self createPopUp];
}
else{
    [self.navigationController pushViewController:excerciseb animated:YES];
}
  
}
#pragma mark- create popUp here
-(void)createPopUp{
    
    backPopUp =[[UIView alloc]init];
    backPopUp.frame= CGRectMake(0, 800, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    backPopUp.backgroundColor =[UIColor lightGrayColor];
    [self.view addSubview:backPopUp];
    
    popUpView =[[UIView alloc]init];
    popUpView.frame= CGRectMake(10, 800, [UIScreen mainScreen].bounds.size.width-20, [UIScreen mainScreen].bounds.size.height-120);
    popUpView.backgroundColor = [UIColor whiteColor];
    popUpView.layer.cornerRadius=6.0f;
    popUpView.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:1];
    popUpView.clipsToBounds = YES;
    popUpView.layer.shadowColor = [UIColor blackColor].CGColor;
    popUpView.layer.shadowOffset = CGSizeMake(-2, 2);
    popUpView.layer.shadowOpacity = 3;
    popUpView.layer.shadowRadius = 15;
    popUpView.layer.shadowPath = [UIBezierPath bezierPathWithRect:popUpView.bounds].CGPath;
    [backPopUp addSubview:popUpView];
    
    UILabel *header=[[UILabel alloc]init];
    header.frame= CGRectMake(00,0,  popUpView.frame.size.width, 150);
    
    
   
        header.text=@"GOOD\nGOING!";
       header.numberOfLines=2;
   header.font=[UIFont fontWithName:@"GothamRounded-Medium" size:30];
    header.textAlignment = NSTextAlignmentCenter;
    header.textColor=[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1];
    [popUpView addSubview:header];
    
    
    UILabel *information=[[UILabel alloc]init];
    information.frame= CGRectMake(0,70,  popUpView.frame.size.width, 300);
//    if([SingletonClass sharedSingleton].deptId==4){
        information.text=@"Now we just need to set \n you up with an account. \n \n Don't worry it wont take \n long!.";
   // }
//    else if([SingletonClass sharedSingleton].deptId==3){
//        information.text=@"Next,we recommend that\nyou take a few minutes to\ncomplete two quick\nexercises.\n\nAnswering these questions\nnow will maximize\nyourtime withthe psychologist.";
//    }
    information.numberOfLines=8;
   information.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];
    information.textColor=[UIColor blackColor];
    information.textAlignment = NSTextAlignmentCenter;
    [popUpView addSubview:information];
    UIButton *letsGoButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    
        letsGoButton.frame=CGRectMake(0, popUpView.frame.size.height-80,popUpView.frame.size.width-20, 50);
        [letsGoButton setTitle:@"Let's Go!" forState:UIControlStateNormal];
         letsGoButton.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
        [letsGoButton setBackgroundColor:[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1]];
        [letsGoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [letsGoButton addTarget:self action:@selector(letsGoFor) forControlEvents:UIControlEventTouchUpInside];
        letsGoButton.layer.cornerRadius=6.0f;
        
        [popUpView addSubview:letsGoButton];
    
    
    
    if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()) {
        header.font=[UIFont boldSystemFontOfSize:50];
        header.frame= CGRectMake(00,0,  popUpView.frame.size.width, 200);
        information.frame= CGRectMake(0,250,  popUpView.frame.size.width, 300);
        information.font = [UIFont systemFontOfSize:30];
        letsGoButton.frame=CGRectMake(0, popUpView.frame.size.height-130,popUpView.frame.size.width, 100);
        letsGoButton.titleLabel.font = [UIFont systemFontOfSize:30];
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        popUpView.frame = CGRectMake(20, 60, [UIScreen mainScreen].bounds.size.width-40, [UIScreen mainScreen].bounds.size.height-150);
        backPopUp.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }];
}
-(void)letsGoFor{
    
    
        
   
   
     
     
     
   
         NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@{@"type1":[SingletonClass sharedSingleton].globalDictionry1,@"type2":[SingletonClass sharedSingleton].globalDictionry2} options:NSJSONWritingPrettyPrinted error:nil];
         NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
         NSLog(@"Excersice Output: %@", jsonString);
    
    [[NSUserDefaults standardUserDefaults]setObject:jsonString  forKey:@"psyExercise"];
         [[NSUserDefaults standardUserDefaults]synchronize];
         
    
    
    
    
    
    
    
    
    NSString *patientID=[[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"];
    
    if(patientID == nil){
        SignUpView *signUp=[[SignUpView alloc]init];
        [self.navigationController pushViewController:signUp animated:YES];
    }
    else{
        
        
        SelectPharmacyVC *pharmacy=[[SelectPharmacyVC alloc]init];
        [self.navigationController pushViewController:pharmacy animated:YES];
        
       
    }
}
-(void)addingToArray:(int)optn{
    
    
    [[SingletonClass sharedSingleton].globalDictionry2 setObject:[NSString stringWithFormat:@"%d",optn] forKey:[NSString stringWithFormat:@"%d",[SingletonClass sharedSingleton].exerciseB]];
    
    
    //    [[SingletonClass sharedSingleton].globalArray  addObject:@{[NSString stringWithFormat:@"%d",[SingletonClass sharedSingleton].exercise]:[NSString stringWithFormat:@"%d",optn]}];
    
    
    
    NSLog(@"added array----->%@",[SingletonClass sharedSingleton].globalDictionry2);
    
}




//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}

@end