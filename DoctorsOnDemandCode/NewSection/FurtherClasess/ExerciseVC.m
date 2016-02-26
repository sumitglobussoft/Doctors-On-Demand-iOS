//
//  ExerciseVC.m
//  
//
//  Created by GLB-163 on 10/1/15.
//
//

#import "ExerciseVC.h"

@interface ExerciseVC (){
    
    
    UIScrollView *myScroll;
    CGSize screenRect;
    UIButton *notAtAllBtn,*severalBtn,*moreThanBtn,*nearlyBtn;
    ExcersicebVC *excersiceB;
    UIView * backPopUp;
    UIView * popUpView;
    Exercise2BVC *exercise2bvc;
    int option;

}

@end

@implementation ExerciseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
      [SingletonClass sharedSingleton].exercise=[SingletonClass sharedSingleton].exercise+1;
     NSLog(@"-->%d",[SingletonClass sharedSingleton].exercise);
    self.navigationController.navigationBar.hidden = YES;
    screenRect=[[UIScreen mainScreen]bounds].size;
    
    excersiceB=[[ExcersicebVC alloc]init];
    exercise2bvc=[[Exercise2BVC alloc]init];

    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    UIView * headerView =[[UIView alloc]init];
    headerView.frame=  CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55);
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]init];
    titleLable.frame= CGRectMake(60, 25, [UIScreen mainScreen].bounds.size.width-120, 25);
    if([SingletonClass sharedSingleton].exercise==1){
        titleLable.text=@"EXERCISE 1a";
    }
    else if([SingletonClass sharedSingleton].exercise==3){
          titleLable.text=@"EXERCISE 1c";
    }
    else if ([SingletonClass sharedSingleton].exercise==5){
        titleLable.text=@"EXERCISE 1e";
    }
    else if ([SingletonClass sharedSingleton].exercise==7){
          titleLable.text=@"EXERCISE 1g";    }

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
      //[SingletonClass sharedSingleton].exercise=[SingletonClass sharedSingleton].exercise-1;
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
    
    if([SingletonClass sharedSingleton].exercise==1){
    label.text=@"Feeling nervous anxious or on edge";
    }
    else if([SingletonClass sharedSingleton].exercise==3){
        label.text=@"Worrying too much about different\nthings";
    }
    else if ([SingletonClass sharedSingleton].exercise==5){
        label.text=@"Being so restless that it is hard to sit\nstill";
    }
    else if ([SingletonClass sharedSingleton].exercise==7){
        label.text=@"Feeling afraid as if something awful\nmight happen";
    }
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
    notAtAllBtn.titleLabel.font=[UIFont fontWithName:@"Gothamrounded-Light" size:14];
    [notAtAllBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [notAtAllBtn addTarget:self action:@selector(notAllBtnActn) forControlEvents:UIControlEventTouchUpInside];
    notAtAllBtn.layer.cornerRadius=2;
    notAtAllBtn.layer.borderWidth=0.2f;
    notAtAllBtn.layer.borderColor=[[UIColor blackColor] CGColor];
    [myScroll addSubview:notAtAllBtn];
    
    
    severalBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    severalBtn.frame=CGRectMake(10, 140, screenRect.width-20, 40);
    severalBtn.backgroundColor=[UIColor whiteColor];
    severalBtn.titleLabel.font=[UIFont fontWithName:@"Gothamrounded-Light" size:14];
    [severalBtn setTitle:@"Several days" forState:UIControlStateNormal];
    [severalBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
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
    moreThanBtn.titleLabel.font=[UIFont fontWithName:@"Gothamrounded-Light" size:14];
    moreThanBtn.layer.cornerRadius=2;
    moreThanBtn.layer.cornerRadius=2;
    moreThanBtn.layer.borderWidth=0.2f;
    
        [moreThanBtn addTarget:self action:@selector(moreBtnActn) forControlEvents:UIControlEventTouchUpInside];
    [myScroll addSubview:moreThanBtn];

    
    
    nearlyBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    nearlyBtn.frame=CGRectMake(10, 240, screenRect.width-20, 40);
    nearlyBtn.backgroundColor=[UIColor whiteColor];
    [nearlyBtn setTitle:@"Nearly every day" forState:UIControlStateNormal];
    [nearlyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    nearlyBtn.layer.cornerRadius=2;
    nearlyBtn.titleLabel.font=[UIFont fontWithName:@"Gothamrounded-Light" size:14];
    nearlyBtn.layer.cornerRadius=2;
    nearlyBtn.layer.borderWidth=0.2f;
        [nearlyBtn addTarget:self action:@selector(nearlyBtnActn) forControlEvents:UIControlEventTouchUpInside];
    [myScroll addSubview:nearlyBtn];

    
    
    
}
#pragma mark - Button Actions

-(void)nearlyBtnActn{
    option=4;
    [self addingToArray:option];
    if([SingletonClass sharedSingleton].exercise==7){
        [self createPopUp];
    }
    else{
       
    [self.navigationController pushViewController:excersiceB animated:YES];
    }
    
}
-(void)moreBtnActn{
    option=3;
    [self addingToArray:option];
    if([SingletonClass sharedSingleton].exercise==7){
        [self createPopUp];
    }
    else{
       
        [self.navigationController pushViewController:excersiceB animated:YES];
    }
}

-(void)notAllBtnActn{
    option=1;
    [self addingToArray:option];

    if([SingletonClass sharedSingleton].exercise==7){
        [self createPopUp];
    }
    else{
            [self.navigationController pushViewController:excersiceB animated:YES];
    }
}
-(void)severalBtnActn{
    option=2;
    [self addingToArray:option];
    if([SingletonClass sharedSingleton].exercise==7){
        [self createPopUp];
    }
    else{
    
    [self.navigationController pushViewController:excersiceB animated:YES];
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
    
    
    header.text=@"GETTING\nTHERE!";
    header.numberOfLines=2;
    header.font=[UIFont fontWithName:@"@GothamRounded-Medium" size:30];
    header.textAlignment = NSTextAlignmentCenter;
    header.textColor=[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1];
    [popUpView addSubview:header];
    
    
    UILabel *information=[[UILabel alloc]init];
    information.frame= CGRectMake(0,80,  popUpView.frame.size.width, 300);
 information.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    information.text=@"Just a few more questions\nto go.";
    information.numberOfLines=2;
    information.textColor=[UIColor blackColor];
    information.textAlignment = NSTextAlignmentCenter;
    [popUpView addSubview:information];
    UIButton *letsGoButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
           UIButton *skipBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        skipBtn.frame=CGRectMake(0, popUpView.frame.size.height-80,popUpView.frame.size.width/2, 50);
        [skipBtn setTitle:@"Skip" forState:UIControlStateNormal];
        
        [skipBtn setBackgroundColor:[UIColor grayColor]];
        [skipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [skipBtn addTarget:self action:@selector(skipActn) forControlEvents:UIControlEventTouchUpInside];
        //skipBtn.layer.cornerRadius=6.0f;
        [popUpView addSubview:skipBtn];
        
        
        UIButton *continueBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        continueBtn.frame=CGRectMake(popUpView.frame.size.width/2, popUpView.frame.size.height-80,popUpView.frame.size.width/2, 50);
        [continueBtn setTitle:@"Continue" forState:UIControlStateNormal];
         continueBtn.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
        [continueBtn setBackgroundColor:[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1]];
        [continueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [continueBtn addTarget:self action:@selector(continueActn) forControlEvents:UIControlEventTouchUpInside];
        //  continueBtn.layer.cornerRadius=6.0f;
        [popUpView addSubview:continueBtn];
        
        
    
    
    
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

#pragma mark-continue Action
-(void)continueActn{
    
     [SingletonClass sharedSingleton].exerciseB=0;
    [SingletonClass sharedSingleton].globalDictionry2=[[NSMutableDictionary alloc]init];
   
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        popUpView.frame=CGRectMake(30, 700, self.view.frame.size.width-60, self.view.frame.size.height-60);
        backPopUp.frame = CGRectMake(0,800, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }completion:^(BOOL finished){
        [self.navigationController pushViewController:exercise2bvc animated:YES];
        
        
    }];

    
   
}

#pragma mark-Adding to global array
-(void)addingToArray:(int)optn{
    
    
    [[SingletonClass sharedSingleton].globalDictionry1 setObject:[NSString stringWithFormat:@"%d",optn] forKey:[NSString stringWithFormat:@"%d",[SingletonClass sharedSingleton].exercise]];
    
    
//    [[SingletonClass sharedSingleton].globalArray  addObject:@{[NSString stringWithFormat:@"%d",[SingletonClass sharedSingleton].exercise]:[NSString stringWithFormat:@"%d",optn]}];
    
    
  
    NSLog(@"added array----->%@",[SingletonClass sharedSingleton].globalDictionry1);

}

#pragma mark-PopUp Skip Action
-(void)skipActn{
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        backPopUp.frame = CGRectMake(0,800, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }completion:^(BOOL finished){
        [self performSelector:@selector(goodGoingPopUp) withObject:nil afterDelay:.4];

    }];
    
    

    
    
}
   
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}

#pragma mark-Good Going backUp
-(void)goodGoingPopUp{
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
    
    header.font=[UIFont fontWithName:@"GothamRounded-Medium" size:30];
    header.text=@"GOOD\nGOING!";
    header.numberOfLines=2;
    header.textAlignment = NSTextAlignmentCenter;
    header.textColor=[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1];
    [popUpView addSubview:header];
    
    
    UILabel *information=[[UILabel alloc]init];
    information.frame= CGRectMake(0,70,  popUpView.frame.size.width, 300);
    information.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    information.text=@"Now we just need to set \n you up with an account. \n \n Don't worry it wont take \n long!.";
    information.numberOfLines=8;
    information.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
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
    
    [UIView animateWithDuration:0.5 animations:^{
        popUpView.frame = CGRectMake(20, 60, [UIScreen mainScreen].bounds.size.width-40, [UIScreen mainScreen].bounds.size.height-150);
        backPopUp.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }];
    
    
}

#pragma mark-Lets Go Button Action
-(void)letsGoFor{
    
    
    
    
    NSString *patientID=[[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"];

    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        popUpView.frame=CGRectMake(30, 700, self.view.frame.size.width-60, self.view.frame.size.height-60);
        backPopUp.frame = CGRectMake(0,800, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }completion:^(BOOL finished){
        
        if(patientID == nil){
            SignUpView *signUp=[[SignUpView alloc]init];
            [self.navigationController pushViewController:signUp animated:YES];
        }
        
                    PaymentViewController *payment=[PaymentViewController new];
            [self.navigationController pushViewController:payment animated:YES];
            
        
    }];

    
    
}

@end
