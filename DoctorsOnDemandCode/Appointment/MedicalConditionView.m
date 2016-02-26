//
//  MedicalConditionView.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 8/14/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "MedicalConditionView.h"
#import "PaymentViewController.h"

@interface MedicalConditionView ()
{
    
    CGSize screenRect;
    UIButton *skipButton;
    UIButton *nextButton;
    UIBarButtonItem *barButton;
    
   
    NSMutableArray *coditions,* contionsSelected;
    UITableView *conditonsTableView;
    NSString *str;
    NSDictionary *jsonSt;
  NSMutableArray *completeArry;
    UIView * backPopUp;
    UIView * popUpView;
    SelectPharmacyVC *pharmacy;
    
    
    
}


@end

@implementation MedicalConditionView


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [SingletonClass sharedSingleton].back=0;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //coditions=[[NSMutableArray alloc]initWithObjects:@"Cancer",@"Diabetes",@"Heart disease",@"Stroke",@"High blood pressure",@"High cholestrol",@"Asthma/COPD",@"Depression",@"Arthritis",@"Abnormal thyroid",@"Pregnant",@"Other",nil];
   
    
    
       if([SingletonClass sharedSingleton].deptId==1){
        coditions=[[NSMutableArray alloc]initWithObjects:@"Breast augmentation",@"Reduction",@"Biopsy",@"Chest trauma",@"Cesarean delivery",@"Vaginal delivery",@"Defficulty getting pregnant",@"Thyroid problems",@"Hypertension",@"Gestational diabetes",@"IDDM",@"PCOS",@"Breast growth during pregnancy",@"Inverted nipples",@"Flat nipples",nil];
           str=@"MEDICAL HISTORY";
        
    }
   else
    {
        coditions=[[NSMutableArray alloc]initWithObjects:@"Cancer",@"Diabetes",@"Heart disease",@"Stroke",@"High blood pressure",@"High cholestrol",@"Asthma/COPD",@"Depression",@"Arthritis",@"Abnormal thyroid",@"Pregnant",@"Other",nil];
        str=@"CONDITION";
    }


    
    
    pharmacy=[[SelectPharmacyVC alloc]init];
    
//    UINavigationController *naviController=[[UINavigationController alloc]init];
//    [naviController addChildViewController:pharmacy];
//    naviController.navigationBarHidden=YES;
    
    contionsSelected =[[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
   completeArry=[[NSMutableArray alloc]init];
    screenRect = [[UIScreen mainScreen] bounds].size;
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    UIView * headerView =[[UIView alloc]init];
   headerView.frame=  CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55);
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]init];
    titleLable.frame= CGRectMake(60, 25, [UIScreen mainScreen].bounds.size.width-120, 25);
    
    if([SingletonClass sharedSingleton].deptId==1){
        titleLable.text =@" MEDICAL HISTORY";
    }
    else
    titleLable.text =@" MEDICAL CONDITIONS";
    titleLable.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    titleLable.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
[backButton setFrame:CGRectMake(15, 18, 55, 35)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
    skipButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [skipButton setImage:[UIImage imageNamed:@"skip_btn.png"] forState:UIControlStateNormal];
[skipButton setFrame:CGRectMake(screenRect.width-60, 28, 50, 20)];
    [skipButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:skipButton];
    
    //  self.title=@"PURPOSE OF VISIT";
    
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad) {
        
        headerView.frame=  CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 75);
        titleLable.frame= CGRectMake(60, 25, [UIScreen mainScreen].bounds.size.width-120, 30);
        titleLable.font =  [UIFont fontWithName:@"GothamRounded-Light" size:26];        [backButton setImage:[UIImage imageNamed:@"back_btn_ipad.png"] forState:UIControlStateNormal];
        [backButton setFrame:CGRectMake(15, 30, 80, 25)];
        
        [skipButton setImage:[UIImage imageNamed:@"skip_btn_ipad.png"] forState:UIControlStateNormal];
        [skipButton setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-100, 30, 80, 25)];
    }
    
    [self createUi];
    

    
}
-(void)createUi{
    
    
    UILabel *label=[[UILabel alloc]init];
    label.frame= CGRectMake(30, 80, screenRect.width, 50);
    label.numberOfLines=2;
    label.text=@"Please let us know if you have any\nmedical conditions.";
    label.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
    label.textColor=[UIColor blackColor];
    
    [self.view addSubview:label];
    
    
    UILabel *labelTap=[[UILabel alloc]init];
    labelTap.frame = CGRectMake(30, 140, screenRect.width, 50);
    labelTap.numberOfLines=1;
    labelTap.text=@"Tap all that apply.";
    labelTap.font=[UIFont fontWithName:@"GothamRounded-Medium" size:11];

    labelTap.textColor=[UIColor blackColor];
    [self.view addSubview:labelTap];
    
    
    conditonsTableView=[[UITableView alloc]init];
    conditonsTableView.frame=CGRectMake(10, 200 ,screenRect.width-20,screenRect.height-200);
    conditonsTableView.backgroundColor=[UIColor clearColor];
    
    conditonsTableView.layer.borderWidth = 2.0;
    conditonsTableView.layer.borderColor = [UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1].CGColor;
    [conditonsTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    conditonsTableView.delegate=self;
    conditonsTableView.dataSource=self;
    [self.view addSubview:conditonsTableView];
    
    if (UIUserInterfaceIdiomPad== UI_USER_INTERFACE_IDIOM())
    {
     label.frame= CGRectMake(30, 80, screenRect.width-60, 100);
        label.font = [UIFont fontWithName:@"GothamRounded-Medium" size:30];
                      labelTap.frame = CGRectMake(30, 200, screenRect.width-60, 50);
        labelTap.font =  [UIFont fontWithName:@"GothamRounded-Medium" size:24];

        
         conditonsTableView.frame=CGRectMake(10, 300 ,screenRect.width-20,screenRect.height-300);
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- tableView delagate methods
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
     cell.textLabel.font =[UIFont fontWithName:@"GothamRounded-Light" size:15];
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad) {
        cell.textLabel.font =[UIFont fontWithName:@"GothamRounded-Light" size:30];
    }
}

-(UITableViewCell *)tableView:(UITableView * )tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"SimpleTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
            cellIdentifier];
      if (cell == nil) {
        
        
        cell = [[UITableViewCell alloc]initWithStyle:
                UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
          
    }
    
    
    
    
    NSString *stringForCell;
//    switch (indexPath.section) {
//        case 0:
    
            stringForCell= [coditions objectAtIndex:indexPath.row];
            if ([contionsSelected containsObject:[NSNumber numberWithLong:indexPath.row]]) {
                 cell.backgroundColor =[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1.0];
                cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"check_mark.png"]];
            }
            else{
                 cell.backgroundColor =[UIColor whiteColor];
                cell.accessoryView =nil;
            }
//            break;
//            
//        default:
//            
//            break;
//    }
    
  

      cell.textLabel.font= [UIFont fontWithName:@"GothamRounded-Medium" size:15];
    [cell.textLabel setText:stringForCell];
    if (UIUserInterfaceIdiomPad== UI_USER_INTERFACE_IDIOM()){
        
        cell.textLabel.font= [UIFont fontWithName:@"GothamRounded-Medium" size:30];

    }
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
(NSInteger)section{
    switch (section) {
        case 0:
            return  coditions.count;
            break;
            default:
                    return 0;
            break;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{  [skipButton setImage:[UIImage imageNamed:@"next_btn.png"] forState:UIControlStateNormal];
    
    if (UI_USER_INTERFACE_IDIOM() ==  UIUserInterfaceIdiomPad){
         [skipButton setImage:[UIImage imageNamed:@"next_btn-ipad.png"] forState:UIControlStateNormal];
    }
    
    if ([contionsSelected containsObject:[NSNumber numberWithLong:indexPath.row]]) {
        //[contionsSelected removeObjectAtIndex:indexPath.row];
        [contionsSelected removeObject:[NSNumber numberWithLong:indexPath.row]];
    }
    else{
        [contionsSelected addObject:[NSNumber numberWithLong:indexPath.row]];
    }
    [conditonsTableView reloadData];
    /* nextButton =  [UIButton buttonWithType:UIButtonTypeCustom];
     [nextButton setImage:[UIImage imageNamed:@"forward_arrow.png"] forState:UIControlStateNormal];
     [nextButton setFrame:CGRectMake(320, 0, 61, 21)];
     barButton = [[UIBarButtonItem alloc] initWithCustomView:nextButton];
     self.navigationItem.rightBarButtonItem = barButton;
     [nextButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];*/
    
    
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return str;
            break;
            
                default:
            break;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return 50;
    }
    return  25;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
      NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle == nil) {
        return nil;
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10,2, screenRect.width, 22);
   label.font = [UIFont fontWithName:@"GothamRounded-Medium" size:14];
    label.textColor = [UIColor whiteColor];
    label.text = sectionTitle;
    
    UIView *view = [[UIView alloc] init];
    view.frame=CGRectMake(0, 0, screenRect.width, 22);
    view.backgroundColor = [UIColor grayColor];

    [view addSubview:label];
    
    if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()) {
        label.frame = CGRectMake(10, 0, screenRect.width, 50);
        label.font =[UIFont fontWithName:@"GothamRounded-Light" size:25];
        view.frame=CGRectMake(0, 0, screenRect.width, 50);
    }
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return 85;
    }
    return  45;
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)nextAction{
    
    
    
    for(int i=0;i<contionsSelected.count;i++){
        
        
        int j=[[contionsSelected objectAtIndex:i]intValue];
        
        // NSString *cond =[coditions objectAtIndex:j];
        [completeArry addObject:[coditions objectAtIndex:j]];
        //  jsonSt=[NSString stringWithFormat:@"medical_condition:%@",cond];
        
        
    }
    
   
    
    
    
    
 if ([SingletonClass sharedSingleton].deptId==5||[SingletonClass sharedSingleton].deptId==4){
        
        if(completeArry.count!=0){
        [[NSUserDefaults standardUserDefaults]setObject:[completeArry componentsJoinedByString:@","]  forKey:@"medicalCondition"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        }
        else{
            [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"medicalCondition"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }

//
//        NSLog(@"medical-->%@",[completeArry componentsJoinedByString:@","]);
     
    }
    else{
        [[NSUserDefaults standardUserDefaults]setObject:@""  forKey:@"medicalCondition"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    

    
    if([SingletonClass sharedSingleton].deptId==1){
        SymptomsView *symptom=[[SymptomsView alloc]init];
        [self.navigationController pushViewController:symptom animated:YES];

    }
    else{
    
    
    [self createPopUp];
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
    
    header.font=[UIFont fontWithName:@"GothamRounded-Medium" size:30];
    if([SingletonClass sharedSingleton].deptId==4|| [SingletonClass sharedSingleton].deptId==2||[SingletonClass sharedSingleton].deptId==5){
    header.text=@"GOOD\nGOING!";
    }
    else if([SingletonClass sharedSingleton].deptId==3){
       header.text=@"MAXIMIZE\nYOUR TIME";
    }
    header.numberOfLines=2;
    header.textAlignment = NSTextAlignmentCenter;
    header.textColor=[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1];
    [popUpView addSubview:header];
    
    
    UILabel *information=[[UILabel alloc]init];
    information.frame= CGRectMake(0,70,  popUpView.frame.size.width, 300);
     information.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];
    if([SingletonClass sharedSingleton].deptId==4||[SingletonClass sharedSingleton].deptId==2||[SingletonClass sharedSingleton].deptId==5){
    information.text=@"We can proceed to\nSchedule Your Appointment.";
    }
    else if([SingletonClass sharedSingleton].deptId==3){
         information.text=@"Next,we recommend that\nyou take a few minutes to\ncomplete two quick\nexercises.\n\nAnswering these questions\nnow will maximize\nyourtime withthe psychologist.";
    }
    information.numberOfLines=8;
      information.textColor=[UIColor blackColor];
     information.textAlignment = NSTextAlignmentCenter;
    [popUpView addSubview:information];
    UIButton *letsGoButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];

    if([SingletonClass sharedSingleton].deptId==4||[SingletonClass sharedSingleton].deptId==2||[SingletonClass sharedSingleton].deptId==5){
      
    letsGoButton.frame=CGRectMake(0, popUpView.frame.size.height-80,popUpView.frame.size.width-20, 50);
    [letsGoButton setTitle:@"Let's Go!" forState:UIControlStateNormal];
     letsGoButton.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    [letsGoButton setBackgroundColor:[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1]];
    [letsGoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [letsGoButton addTarget:self action:@selector(letsGoFor) forControlEvents:UIControlEventTouchUpInside];
    letsGoButton.layer.cornerRadius=6.0f;
    
    [popUpView addSubview:letsGoButton];
    }
    else if([SingletonClass sharedSingleton].deptId==3){
        UIButton *skipBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        skipBtn.frame=CGRectMake(0, popUpView.frame.size.height-80,popUpView.frame.size.width/2, 50);
        [skipBtn setTitle:@"Skip" forState:UIControlStateNormal];
        skipBtn.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
        [skipBtn setBackgroundColor:[UIColor grayColor]];
        [skipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [skipBtn addTarget:self action:@selector(skipActn) forControlEvents:UIControlEventTouchUpInside];
        //skipBtn.layer.cornerRadius=6.0f;
        [popUpView addSubview:skipBtn];
        
        
        UIButton *continueBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        continueBtn.frame=CGRectMake(popUpView.frame.size.width/2, popUpView.frame.size.height-80,popUpView.frame.size.width/2, 50);
        [continueBtn setTitle:@"Continue" forState:UIControlStateNormal];
         continueBtn.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
        [continueBtn setBackgroundColor:[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1]];
         [continueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         [continueBtn addTarget:self action:@selector(continueActn) forControlEvents:UIControlEventTouchUpInside];
       //  continueBtn.layer.cornerRadius=6.0f;
         [popUpView addSubview:continueBtn];


    }

    
    if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()) {
        header.font=[UIFont  fontWithName:@"GothamRounded-Medium" size:50];
         header.frame= CGRectMake(00,0,  popUpView.frame.size.width, 200);
         information.frame= CGRectMake(0,250,  popUpView.frame.size.width, 300);
        information.font = [UIFont fontWithName:@"GothamRounded-Medium" size:30];
        
        
          letsGoButton.frame=CGRectMake(0, popUpView.frame.size.height-130,popUpView.frame.size.width, 100);
        letsGoButton.titleLabel.font = [UIFont fontWithName:@"GothamRounded-Medium" size:30];
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        popUpView.frame = CGRectMake(20, 60, [UIScreen mainScreen].bounds.size.width-40, [UIScreen mainScreen].bounds.size.height-150);
        backPopUp.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }];
}

#pragma mark- letsGoFor method here

-(void)letsGoFor{
    
    
    
    
    
    
    
    
    
    
   NSString *patientID=[[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"];
    
    
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        popUpView.frame=CGRectMake(30, 2000, self.view.frame.size.width-60, self.view.frame.size.height-60);
        backPopUp.frame = CGRectMake(0,2000, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }completion:^(BOOL finished){
        
        if(patientID == nil){
            SignUpView *signUp=[[SignUpView alloc]init];
            [self.navigationController pushViewController:signUp animated:YES];
        }
        
        else if ([SingletonClass sharedSingleton].deptId==2){
            
            
            
            
            
            SelectChildVC *selectChild=[[SelectChildVC alloc]init];
            [self.navigationController pushViewController:selectChild animated:YES];
            
        }
        
        else if ([SingletonClass sharedSingleton].deptId==3){
          
            SelectPharmacyVC *pharm=[[SelectPharmacyVC alloc]init];
            [self.navigationController pushViewController:pharm animated:YES];
            
          
            
        }
        
        else{
            
            [SingletonClass sharedSingleton].back=0;
            [self.navigationController pushViewController:pharmacy animated:YES];
            
           
        }

        
    }];

    
  }

#pragma  mark- schedule appointment Service here

-(void)scheduleAppointment{
    
    
    
  /*  NSError * error;
    NSURLResponse *  urlResponse;
    
    
    NSURL * postUrl =[NSURL URLWithString:makeAppointmentService];
    
    NSString * body =[NSString stringWithFormat:@"doctor_id=1 'patient_id', 'appointment_start_time', 'appointment_end_time','patient','referredBy','purposeOfVisit','timePeriod','medications','allergies','symptoms','medicalConditions','pharmacy'",email.text,password.text];
    
    NSMutableURLRequest * request =[[NSMutableURLRequest alloc]initWithURL:postUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
    
    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (!data) {
        return;
    }
    
    id json =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"json %@",json);
    if ([[json objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
        
       
        [[NSNotificationCenter defaultCenter]postNotificationName:@"changeSignInName" object:nil];
        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"changeSignInName" object:nil];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }*/
    
  

}

#pragma mark-Continue Action
-(void)continueActn{
    ExerciseVC *exercise=[[ExerciseVC alloc]init];
    [SingletonClass  sharedSingleton].exercise=0;
  
    [SingletonClass sharedSingleton].globalDictionry1=[[NSMutableDictionary alloc]init];
   
    [SingletonClass sharedSingleton].globalDictionry2=[[NSMutableDictionary alloc]init];
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
    
        backPopUp.frame = CGRectMake(0,800, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }completion:^(BOOL finished){
        [backPopUp removeFromSuperview];
        [self.navigationController pushViewController:exercise animated:YES];
        
        
    }];
    

    
}


#pragma mark-PopUP skip Action
-(void)skipActn{
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        backPopUp.frame = CGRectMake(0,800, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }completion:^(BOOL finished){
 [self performSelector:@selector(goodGoingPopUp) withObject:nil afterDelay:.4];

    }];

   
    

}

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
            information.text=@"Now we just need to set\nyou up with an account.\nDon't worry it wont take\nlong!.";
    information.numberOfLines=8;
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




@end
