//
//  SymptomsView.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 8/14/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "SymptomsView.h"

@interface SymptomsView (){
    
    CGSize screenRect;
    UIButton *skipButton;
    UIButton *nextButton;
    UIBarButtonItem *barButton;
    NSArray *timePeriodViewCells;
    UITableViewCell *cell;
    NSMutableArray *generalSympt,*head,*chest,*gastro,*genitourinary,*musculoskeletal,*skin,*sectionArr;
    
    UIView * backPopUp;UIView * popUpView;
    
     NSMutableArray *generalSymptSelected,*headSelected,*chestSelected,*gastroSelected,*genitourinarySelected,*musculoskeletalSelected,*skinSelected;
    NSMutableArray *jsonArr,*jsonArr1,*jsonArr2,*jsonArr3,*jsonArr4,*jsonArr5,*jsonArr6;
    UITableView *symptomsTableView;
    NSMutableDictionary *jsonSt;
    //NSString *generalSymptStr,*headNeckStr,*digestiveTrackStr;
}


@end

@implementation SymptomsView

- (void)viewDidLoad {
    [super viewDidLoad];
    
 //   jsonSt = [NSMutableDictionary dictionary];
    
    
    
    if([SingletonClass sharedSingleton].deptId==4|| [SingletonClass sharedSingleton].deptId==2){
    generalSympt=[[NSMutableArray alloc]initWithObjects:@"Fever",@"Weight loss/gain",@"Loss of Appetite",@"Mood changes",@"Fatigue/weakness",@"Foreign travel(past month)",@"Hospitalized(past six months)",nil];
    head=[[NSMutableArray alloc]initWithObjects:@"Headache",@"Dizzy/lightheaded",@"Vision changes",@"Hearing loss/ringing",@"Ear drainage",@"Nasal discharge",@"Congestion/sinus problems",@"Sore throat",@"Allergies",@"Numbness/tingling",@"History of fainting/seizure",@"Memory loss",@"History of stroke",@"History of falls",nil];
    chest=[[NSMutableArray alloc]initWithObjects:@"Chest pressure/pain",@"Palpitations",@"Cough",@"Sputum",@"Shortness of breath",@"Decreased exercise tolerance",@"History of smoking",nil];
    gastro=[[NSMutableArray alloc]initWithObjects:@"Sore throat",@"Nausea/vomiting",@"Difficulty/pain swallowing",@"Heartburn/reflux",@"Diarrhea",@"Constipation",@"Abdominal pain/discomfort" ,nil];
    genitourinary=[[NSMutableArray alloc]initWithObjects:@"Flank pain",@"Discomfort/burning with urination",@"Blood in urine",@"Frequent urination",@"History of Sexually Transmitted Infections",@"Irregular periods",@"Vaginal bleeding",@"Vaginal discharge",@"Penile Discharge",@"Testicular swelling",@"Testicular pain",nil];
    musculoskeletal=[[NSMutableArray alloc]initWithObjects:@"Muscle pain",@"limited motion/mobility",@"Muscle weakness",@"Back pain",@"Swelling",@"Joint replacement" ,nil];
    skin=[[NSMutableArray alloc]initWithObjects:@"Bleeding",@"Itching",@"Skin rashes/bumps",@"Bruising/discoloration",@"Sores",@"Bites" ,nil];
    }
    
    
   else  if([SingletonClass sharedSingleton].deptId==3){
        generalSympt=[[NSMutableArray alloc]initWithObjects:@"Anxiety/Stress/Worry",@"Feeling lonely/down/depressed",@"Life transition or Traumatic Event",@"Agitation or lack of focus",@"Grief,guilt,or loss",@"Trouble sleeping",@"Anger management",@"Improve mental/athletic/life performance",nil];
        head=[[NSMutableArray alloc]initWithObjects:@"Smoking",@"Alcohol",@"Diet",@"Body image",nil];
        chest=[[NSMutableArray alloc]initWithObjects:@"With partner",@"With family",@"With friends",@"Sexual issues",@"Other",nil];
        generalSymptSelected=[[NSMutableArray alloc]init];
        headSelected=[[NSMutableArray alloc]init];
        chestSelected=[[NSMutableArray alloc]init];
    }
   else if([SingletonClass sharedSingleton].deptId==1){
       generalSympt=[[NSMutableArray alloc]initWithObjects:@"Pain",@"Itching",@"Swelling",@"Lump",@"Redness",@"Too soft",@"Not enough milk",@"Too much milk",nil];
       head=[[NSMutableArray alloc]initWithObjects:@"Cracked",@"Bleeding",@"Constant pain",@"Pain with initial latch",@"Pain with entire latch",nil];
       chest=[[NSMutableArray alloc]initWithObjects:@"Refusing breast",@"Increased fussiness while feeding",@"Falls asleep at breast",@"Not stooling",@"Being supplemented",@"Clicking sound",@"Cries at breast",@"Cries at bottle",nil];
       generalSymptSelected=[[NSMutableArray alloc]init];
       headSelected=[[NSMutableArray alloc]init];
       chestSelected=[[NSMutableArray alloc]init];
   }
   else if([SingletonClass sharedSingleton].deptId==5){
       generalSympt=[[NSMutableArray alloc]initWithObjects:@"Fever",@"Weight loss/gain",@"Loss of Appetite",@"Mood changes",@"Fatigue/weakness",@"Foreign travel(past month)",@"Hospitalized(past six months)",nil];
       head=[[NSMutableArray alloc]initWithObjects:@"Headache",@"Dizzy/lightheaded",@"Vision changes",@"Hearing loss/ringing",@"Ear drainage",@"Nasal discharge",@"Congestion/sinus problems",@"Sore throat",@"Allergies",@"Numbness/tingling",@"History of fainting/seizure",@"Memory loss",@"History of stroke",@"History of falls",nil];
       chest=[[NSMutableArray alloc]initWithObjects:@"Sore throat",@"Nausea/vomiting",@"Difficulty/pain swallowing",@"Heartburn/reflux",@"Diarrhea",@"Constipation",@"Abdominal pain/discomfort" ,nil];
       
   }

    


    if([SingletonClass sharedSingleton].deptId==4 || [SingletonClass sharedSingleton].deptId==2){
    sectionArr=[[NSMutableArray alloc]initWithObjects:@"GENERAL SYMPTOMS",@"HEAD/NECK",@"CHEST",@"GASTROINTESTINAL",@"GENITOURINARY",@"MUSCULOSKELETAL",@"SKIN", nil];
    }
    else if ([SingletonClass sharedSingleton].deptId==3){
        sectionArr=[[NSMutableArray alloc]initWithObjects:@"GENERAL",@"HABIT CHANGE",@"RELATIONSHIP ISSUES", nil];

    }
    else if ([SingletonClass sharedSingleton].deptId==1){
        sectionArr=[[NSMutableArray alloc]initWithObjects:@"TO YOUR BREAST",@"TO YOUR NIPPLES",@"TO YOUR BABY", nil];

    }
    else if ([SingletonClass sharedSingleton].deptId==5){
        sectionArr=[[NSMutableArray alloc]initWithObjects:@"GENERAL",@"HEAD/NECK",@"DIGESTIVE TRACK", nil];
        
    }

    generalSymptSelected=[[NSMutableArray alloc]init];
    headSelected=[[NSMutableArray alloc]init];
    chestSelected=[[NSMutableArray alloc]init];
    gastroSelected=[[NSMutableArray alloc]init];
    genitourinarySelected=[[NSMutableArray alloc]init];
    musculoskeletalSelected=[[NSMutableArray alloc]init];
    skinSelected=[[NSMutableArray alloc]init];
    
    

    
    screenRect = [[UIScreen mainScreen] bounds].size;
    
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    UIView * headerView =[[UIView alloc]init];
    headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55);
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]init];
    titleLable.frame = CGRectMake(60, 25, [UIScreen mainScreen].bounds.size.width-120, 25);
    titleLable.text =@"SYMPTOMS";
    titleLable.font=  [UIFont fontWithName:@"GothamRounded-Light" size:12];
    titleLable.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
  [backButton setFrame:CGRectMake(15, 18, 55, 35)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
    skipButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [skipButton setImage:[UIImage imageNamed:@"skip_btn.png"] forState:UIControlStateNormal];
    
    [skipButton setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-60, 28, 50, 20)];
    [skipButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:skipButton];

    
    if (UI_USER_INTERFACE_IDIOM() ==  UIUserInterfaceIdiomPad) {
        
         headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 75);
         titleLable.frame = CGRectMake(60, 25, [UIScreen mainScreen].bounds.size.width-120, 35);
        titleLable.font =  [UIFont fontWithName:@"GothamRounded-Light" size:25];
        [backButton setImage:[UIImage imageNamed:@"back_btn_ipad.png"] forState:UIControlStateNormal];
        [backButton setFrame:CGRectMake(15, 30, 80, 25)];
        [skipButton setImage:[UIImage imageNamed:@"skip_btn_ipad.png"] forState:UIControlStateNormal];
        [skipButton setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-100, 30, 80, 25)];
        
    }
    
    
    [self createUi];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-Back Button Action
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-Create UI
-(void)createUi{
    
    
    UILabel *label=[[UILabel alloc]init];
    label.frame= CGRectMake(30, 80, screenRect.width, 80);
    label.numberOfLines=2;
    label.text=@"Do you have any of these\nsymptoms?";
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
    
    
    symptomsTableView=[[UITableView alloc]init];
    symptomsTableView.frame=CGRectMake(10, 200 ,screenRect.width-20,screenRect.height-200);
    symptomsTableView.backgroundColor=[UIColor clearColor];
    
    symptomsTableView.layer.borderWidth = 2.0;
    symptomsTableView.layer.borderColor = [UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1].CGColor;
    [symptomsTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    symptomsTableView.delegate=self;
    symptomsTableView.dataSource=self;
    [self.view addSubview:symptomsTableView];
    
    
    if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()) {
        label.font= [UIFont fontWithName:@"GothamRounded-Medium" size:30];
        label.frame= CGRectMake(30, 80, screenRect.width, 120);

         labelTap.frame = CGRectMake(30, 200, screenRect.width, 40);
        labelTap.font = [UIFont fontWithName:@"GothamRounded-Medium" size:24];
        symptomsTableView.frame=CGRectMake(10, 250 ,screenRect.width-20,screenRect.height-250);
    }
    
}


#pragma mark-Table Delegates

-(UITableViewCell *)tableView:(UITableView * )tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"SimpleTableItem";
cell = [tableView dequeueReusableCellWithIdentifier:
                             cellIdentifier];
    
    
    
    
        if (cell == nil) {
           
            
        cell = [[UITableViewCell alloc]initWithStyle:
                UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
    
    
    
    
    NSString *stringForCell;
    switch (indexPath.section) {
        case 0:
           
            stringForCell= [generalSympt objectAtIndex:indexPath.row];
            if ([generalSymptSelected containsObject:[NSNumber numberWithInt:(int)indexPath.row]]) {
                cell.backgroundColor =[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1.0];
                cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"check_mark.png"]];
            }
            else{
                cell.backgroundColor =[UIColor whiteColor];
                cell.accessoryView =nil;
            }



            break;
        case 1:
            stringForCell=  [head objectAtIndex:indexPath.row];
            if([headSelected containsObject:[NSNumber numberWithInt:(int)indexPath.row]]){
                cell.backgroundColor =[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1.0];
                cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"check_mark.png"]];
            }
            else{
                cell.backgroundColor =[UIColor whiteColor];
                cell.accessoryView =nil;
            }



            break;
        case 2:
            stringForCell=  [chest objectAtIndex:indexPath.row];
            if([chestSelected containsObject:[NSNumber numberWithInt:(int)indexPath.row]]){
                cell.backgroundColor =[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1.0];
                cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"check_mark.png"]];
            }
            else{
                cell.backgroundColor =[UIColor whiteColor];
                cell.accessoryView =nil;
            }

            break;
        case 3:
            stringForCell=   [gastro objectAtIndex:indexPath.row];
            if([gastroSelected containsObject:[NSNumber numberWithInt:(int)indexPath.row]]){
                cell.backgroundColor =[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1.0];
                cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"check_mark.png"]];
            }
            else{
                cell.backgroundColor =[UIColor whiteColor];
                cell.accessoryView =nil;
            }

            break;
        case 4:
            stringForCell=   [genitourinary objectAtIndex:indexPath.row];
            if([genitourinarySelected containsObject:[NSNumber numberWithInt:(int)indexPath.row]]){
                cell.backgroundColor =[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1.0];
                cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"check_mark.png"]];
            }
            else{
                cell.backgroundColor =[UIColor whiteColor];
                cell.accessoryView =nil;
            }

            break;
        case 5:
            stringForCell=   [musculoskeletal objectAtIndex:indexPath.row];
            if([musculoskeletalSelected containsObject:[NSNumber numberWithInt:(int)indexPath.row]]){
                cell.backgroundColor =[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1.0];
                cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"check_mark.png"]];
            }
            else{
                cell.backgroundColor =[UIColor whiteColor];
                cell.accessoryView =nil;
            }


            break;
        case 6:
            stringForCell=   [skin objectAtIndex:indexPath.row];
            if([skinSelected containsObject:[NSNumber numberWithInt:(int)indexPath.row]]){
                cell.backgroundColor =[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1.0];
                cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"check_mark.png"]];
            }
            else{
                cell.backgroundColor =[UIColor whiteColor];
                cell.accessoryView =nil;
            }

            
            break;
        
            
        default:
             
            break;
    }
    cell.textLabel.font= [UIFont fontWithName:@"GothamRounded-Light" size:14];
    
    

   [cell.textLabel setText:stringForCell];
    
    
    if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()){
          cell.textLabel.font= [UIFont fontWithName:@"GothamRounded-Light" size:30];
                                                                }
    return cell;
    }


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
(NSInteger)section{
    switch (section) {
        case 0:
            return  generalSympt.count;
            break;
        case 1:
            return  head.count;
            break;
        case 2:
            return  chest.count;
            break;
        case 3:
            return  gastro.count;
            break;
        case 4:
            return  genitourinary.count;
            break;
        case 5:
            return  musculoskeletal.count;
            break;
        case 6:
            return  skin.count;
            break;
                default:
            return 0;
            break;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [skipButton setImage:[UIImage imageNamed:@"next_btn.png"] forState:UIControlStateNormal];
     if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM())
           [skipButton setImage:[UIImage imageNamed:@"next_btn-ipad.png"] forState:UIControlStateNormal];
    
    switch (indexPath.section) {
        case 0:
            
            
            
            if ([generalSymptSelected containsObject:[NSNumber numberWithInt:(int)indexPath.row]]) {
               
                [generalSymptSelected removeObject:[NSNumber numberWithInt:(int)indexPath.row]];
            }
            else{
                [generalSymptSelected addObject:[NSNumber numberWithInt:(int)indexPath.row]];
                
            }
            
            break;
        case 1:
            if([headSelected containsObject:[NSNumber numberWithInt:(int)indexPath.row]]){
          
                [headSelected removeObject:[NSNumber numberWithInt:(int)indexPath.row]];
            }
            else{
                [headSelected addObject:[NSNumber numberWithInt:(int)indexPath.row]];
                
            }
            
            break;
        case 2:
            if([chestSelected containsObject:[NSNumber numberWithInt:(int)indexPath.row]]){
                // [chestSelected removeObjectAtIndex:indexPath.row];
                [chestSelected removeObject:[NSNumber numberWithInt:(int)indexPath.row]];
            }
            else{
                [chestSelected addObject:[NSNumber numberWithInt:(int)indexPath.row]];
                
            }
            
            break;
        case 3:
            
            if([gastroSelected containsObject:[NSNumber numberWithInt:(int)indexPath.row]]){
                // [gastroSelected removeObjectAtIndex:indexPath.row];
                [gastroSelected removeObject:[NSNumber numberWithInt:(int)indexPath.row]];
            }
            else{
                [gastroSelected addObject:[NSNumber numberWithInt:(int)indexPath.row]];
                
            }
            
            break;
        case 4:
            
            if([genitourinarySelected containsObject:[NSNumber numberWithInt:(int)indexPath.row]]){
                //[genitourinarySelected removeObjectAtIndex:indexPath.row];
                [genitourinarySelected removeObject:[NSNumber numberWithInt:(int)indexPath.row]];
            }
            else{
                [genitourinarySelected addObject:[NSNumber numberWithInt:(int)indexPath.row]];
                
            }
            
            break;
        case 5:
            if([musculoskeletalSelected containsObject:[NSNumber numberWithInt:(int)indexPath.row]]){
                // [musculoskeletalSelected removeObjectAtIndex:indexPath.row];
                [musculoskeletalSelected   removeObject:[NSNumber numberWithInt:(int)indexPath.row]];
            }
            else{
                [musculoskeletalSelected addObject:[NSNumber numberWithInt:(int)indexPath.row]];
                
            }
            
            break;
        case 6:
            
            if([skinSelected containsObject:[NSNumber numberWithInt:(int)indexPath.row]]){
                // [skinSelected removeObjectAtIndex:indexPath.row];
                [skinSelected removeObject:[NSNumber numberWithInt:(int)indexPath.row]];
            }
            else{
                [skinSelected addObject:[NSNumber numberWithInt:(int)indexPath.row]];
                
            }
            
            
            break;
            
            
        default:
            
            break;
    }
    
    [symptomsTableView reloadData];
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return sectionArr.count;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    
    return [sectionArr objectAtIndex:section];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle == nil) {
        return nil;
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10,2, screenRect.width, 22);
    label.textColor = [UIColor whiteColor];
    
    
    
    label.font = [UIFont fontWithName:@"GothamRounded-Medium" size:14];
    label.text = sectionTitle;
    
    UIView *view = [[UIView alloc] init];
    view.frame=CGRectMake(0, 0, screenRect.width, 22);
     view.backgroundColor = [UIColor grayColor];
    [view addSubview:label];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
         label.frame = CGRectMake(10, 0, screenRect.width, 50);
        label.font = [UIFont fontWithName:@"GothamRounded-Medium" size:25];

        view.frame=CGRectMake(0, 0, screenRect.width, 50);
    }
    return view;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
     cell.textLabel.font = [UIFont fontWithName:@"GothamRounded-Light" size:15];
    if (UIUserInterfaceIdiomPad ==  UI_USER_INTERFACE_IDIOM()) {
        cell.textLabel.font = [UIFont fontWithName:@"GothamRounded-Light" size:30];

    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return  85.0f;
    }
    return  45.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()) {
        return  50.0f;
    }
    return 22.0f;
}


#pragma mark-Next Action
-(void)nextAction{
 
    NSLog(@"Dept No--->%d",[SingletonClass sharedSingleton].deptId);
    

    
   
    jsonArr=[[NSMutableArray alloc]init];

    
    for(int i=0;i<generalSymptSelected.count;i++){
        
        
        int j=[[generalSymptSelected objectAtIndex:i]intValue];
        
                [jsonArr addObject:[generalSympt objectAtIndex:j]];
        
    }
    jsonArr1=[[NSMutableArray alloc]init];
    for(int i=0;i<headSelected.count;i++){
        
        
        int j=[[headSelected objectAtIndex:i]intValue];
        
        [jsonArr1 addObject:[head objectAtIndex:j]];
    }
   
      jsonArr2=[[NSMutableArray alloc]init];
    for(int i=0;i<chestSelected.count;i++){
        
        
        int j=[[chestSelected objectAtIndex:i]intValue];
        
        [jsonArr2 addObject:[chest objectAtIndex:j]];

        
    }
    jsonArr3=[[NSMutableArray alloc]init];
    for(int i=0;i<gastroSelected.count;i++){
        
        
        int j=[[gastroSelected objectAtIndex:i]intValue];
        
        [jsonArr3 addObject:[gastro objectAtIndex:j]];
        
    }

    jsonArr4=[[NSMutableArray alloc]init];
    for(int i=0;i<genitourinarySelected.count;i++){
        
        
        int j=[[genitourinarySelected objectAtIndex:i]intValue];
        
        [jsonArr4 addObject:[genitourinary objectAtIndex:j]];
 }
    jsonArr5=[[NSMutableArray alloc]init];
    for(int i=0;i<musculoskeletalSelected.count;i++){
        
        
        int j=[[musculoskeletalSelected objectAtIndex:i]intValue];
        
        [jsonArr5 addObject:[musculoskeletal objectAtIndex:j]];
    }
    jsonArr6=[[NSMutableArray alloc]init];
    for(int i=0;i<skinSelected.count;i++){
        
        
        int j=[[skinSelected objectAtIndex:i]intValue];
        
        [jsonArr6 addObject:[skin objectAtIndex:j]];
    }




        NSLog(@"Dept No--->%d",[SingletonClass sharedSingleton].deptId);
    

    
    
//    if( [SingletonClass sharedSingleton].deptId==4){
//        
//        
//        if(jsonArr!=0){
//            
//                NSString *generalSym=[jsonArr componentsJoinedByString:@","];
//                
//            
//                NSLog(@"general JSON Output: %@", generalSym);
//            
//            [[NSUserDefaults standardUserDefaults]setObject:generalSym  forKey:@"generalSymp"];
//                [[NSUserDefaults standardUserDefaults]synchronize];
//            }
//            
//            
//            else{
//                [[NSUserDefaults standardUserDefaults]setObject:@""  forKey:@"generalSymp"];
//                [[NSUserDefaults standardUserDefaults]synchronize];
//                
//            }
//        
//        if(jsonArr1!=0){
//            
//            NSString *headSym=[jsonArr componentsJoinedByString:@","];
//            
//            
//           // NSLog(@"general JSON Output: %@", generalSym);
//            
//            [[NSUserDefaults standardUserDefaults]setObject:headSym  forKey:@"generalSymp"];
//            [[NSUserDefaults standardUserDefaults]synchronize];
//        }
//        
//        
//        else{
//            [[NSUserDefaults standardUserDefaults]setObject:@""  forKey:@"generalSymp"];
//            [[NSUserDefaults standardUserDefaults]synchronize];
//            
//        }
//
//        
//        
//        if(jsonArr3.count!=0){
//            
//            NSString *disectiveSym=[jsonArr3 componentsJoinedByString:@","];
//            
//            
//            NSLog(@"digestive JSON Output: %@", disectiveSym);
//            
//            [[NSUserDefaults standardUserDefaults]setObject:disectiveSym  forKey:@"digestiveSymp"];
//            [[NSUserDefaults standardUserDefaults]synchronize];
//
//        }
//        
//        else{
//            [[NSUserDefaults standardUserDefaults]setObject:@""  forKey:@"digestiveSymp"];
//            [[NSUserDefaults standardUserDefaults]synchronize];
//            
//        }
//        if(jsonArr5.count!=0){
//            
//            NSString *muscleSym=[jsonArr5 componentsJoinedByString:@","];
//            
//            
//            NSLog(@"muscle JSON Output: %@", muscleSym);
//            
//            [[NSUserDefaults standardUserDefaults]setObject:muscleSym  forKey:@"muscleSymp"];
//            [[NSUserDefaults standardUserDefaults]synchronize];
//            
//        }
//        
//        else{
//            [[NSUserDefaults standardUserDefaults]setObject:@""  forKey:@"muscleSymp"];
//            [[NSUserDefaults standardUserDefaults]synchronize];
//            
//        }
//        
//        
//        
//        
//        if(jsonArr1.count!=0){
//            
//            NSString *headneckSym=[jsonArr1 componentsJoinedByString:@","];
//            
//            
//            NSLog(@"habit JSON Output: %@", headneckSym);
//            
//            [[NSUserDefaults standardUserDefaults]setObject:headneckSym  forKey:@"habitSym"];
//            [[NSUserDefaults standardUserDefaults]synchronize];
//            
//        }
//        
//        else{
//            [[NSUserDefaults standardUserDefaults]setObject:@""  forKey:@"habitSym"];
//            [[NSUserDefaults standardUserDefaults]synchronize];
//            
//        }
//
//        
//        
//        
//        if(jsonArr4.count!=0){
//            
//            NSString *headneckSym=[jsonArr4 componentsJoinedByString:@","];
//            
//            
//            NSLog(@"genetourinary JSON Output: %@", headneckSym);
//            
//            [[NSUserDefaults standardUserDefaults]setObject:headneckSym  forKey:@"pelvicSymp"];
//            [[NSUserDefaults standardUserDefaults]synchronize];
//            
//        }
//        
//        else{
//            [[NSUserDefaults standardUserDefaults]setObject:@""  forKey:@"pelvicSymp"];
//            [[NSUserDefaults standardUserDefaults]synchronize];
//            
//        }
//
//        
//    }
    
    if([SingletonClass sharedSingleton].deptId==3){
        
        if(jsonArr!=0){
            
            NSString *generalSym=[jsonArr componentsJoinedByString:@","];
            
            
            NSLog(@"general JSON Output: %@", generalSym);
            
            [[NSUserDefaults standardUserDefaults]setObject:generalSym  forKey:@"generalSymp"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        
        
        else{
            [[NSUserDefaults standardUserDefaults]setObject:@""  forKey:@"generalSymp"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }

        if(jsonArr1.count!=0){
            
            NSString *headneckSym=[jsonArr1 componentsJoinedByString:@","];
            
            
            NSLog(@"habit JSON Output: %@", headneckSym);
            
            [[NSUserDefaults standardUserDefaults]setObject:headneckSym  forKey:@"habitSym"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }
        
        else{
            [[NSUserDefaults standardUserDefaults]setObject:@""  forKey:@"habitSym"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }

        if(jsonArr2.count!=0){
            
            NSString *rel=[jsonArr2 componentsJoinedByString:@","];
            
            
            NSLog(@"habit JSON Output: %@", rel);
            
            [[NSUserDefaults standardUserDefaults]setObject:rel  forKey:@"relationshipSymp"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }
        
        else{
            [[NSUserDefaults standardUserDefaults]setObject:@""  forKey:@"relationshipSymp"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }

    }
    
    
    if([SingletonClass sharedSingleton].deptId==2||[SingletonClass sharedSingleton].deptId==4){
        if(jsonArr!=0){
            
            NSString *generalSym=[jsonArr componentsJoinedByString:@","];
            
            
            NSLog(@"general JSON Output: %@", generalSym);
            
            [[NSUserDefaults standardUserDefaults]setObject:generalSym  forKey:@"generalSymp"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        
        
        else{
            [[NSUserDefaults standardUserDefaults]setObject:@""  forKey:@"generalSymp"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }
        
        if(jsonArr1.count!=0){
            
            NSString *headneckSym=[jsonArr1 componentsJoinedByString:@","];
            
            
          
            
            [[NSUserDefaults standardUserDefaults]setObject:headneckSym  forKey:@"headNeckStr"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }
        
        else{
            [[NSUserDefaults standardUserDefaults]setObject:@""  forKey:@"headNeckStr"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }
        
        if(jsonArr2.count!=0){
            
            NSString *chestSm=[jsonArr2 componentsJoinedByString:@","];
            
            
            NSLog(@"habit JSON Output: %@", chestSm);
            
            [[NSUserDefaults standardUserDefaults]setObject:chestSm  forKey:@"chesttSym"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }
        
        else{
            [[NSUserDefaults standardUserDefaults]setObject:@""  forKey:@"chesttSym"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }
        if(jsonArr3.count!=0){
            
            NSString *disestiveSym=[jsonArr3 componentsJoinedByString:@","];
            
            
            NSLog(@"habit JSON Output: %@", disestiveSym);
            
            [[NSUserDefaults standardUserDefaults]setObject:disestiveSym  forKey:@"digestiveSymp"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }
        
        else{
            [[NSUserDefaults standardUserDefaults]setObject:@""  forKey:@"digestiveSymp"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }
        
        
        if(jsonArr4.count!=0){
            
            NSString *pelvisSymp=[jsonArr4 componentsJoinedByString:@","];
            
            
            NSLog(@"habit JSON Output: %@", pelvisSymp);
            
            [[NSUserDefaults standardUserDefaults]setObject:pelvisSymp  forKey:@"pelvicSymp"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }
        
        else{
            [[NSUserDefaults standardUserDefaults]setObject:@""  forKey:@"pelvicSymp"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }
        
        
        if(jsonArr5.count!=0){
            
            NSString *muscleSymp=[jsonArr5 componentsJoinedByString:@","];
            
            
            NSLog(@"habit JSON Output: %@", muscleSymp);
            
            [[NSUserDefaults standardUserDefaults]setObject:muscleSymp  forKey:@"muscleSymp"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }
        
        else{
            [[NSUserDefaults standardUserDefaults]setObject:@""  forKey:@"muscleSymp"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }

        if(jsonArr6.count!=0){
            
            NSString *skinSymp=[jsonArr6 componentsJoinedByString:@","];
            
            
            NSLog(@"habit JSON Output: %@", skinSymp);
            
            [[NSUserDefaults standardUserDefaults]setObject:skinSymp  forKey:@"skinSymp"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }
        
        else{
            [[NSUserDefaults standardUserDefaults]setObject:@""  forKey:@"skinSymp"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }



    }
    
    
    if([SingletonClass sharedSingleton].deptId==1){
        if(jsonArr.count!=0){
            
            NSString *breastSym=[jsonArr componentsJoinedByString:@","];
            
            
            //NSLog(@"habit JSON Output: %@", skinSymp);
            
            [[NSUserDefaults standardUserDefaults]setObject:breastSym  forKey:@"breastSym"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }
        
        else{
            [[NSUserDefaults standardUserDefaults]setObject:@""  forKey:@"breastSym"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }

        
        if(jsonArr1.count!=0){
            
            NSString *nippleSym=[jsonArr1 componentsJoinedByString:@","];
            
            
            //NSLog(@"habit JSON Output: %@", skinSymp);
            
            [[NSUserDefaults standardUserDefaults]setObject:nippleSym  forKey:@"nippleSym"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }
        
        else{
            [[NSUserDefaults standardUserDefaults]setObject:@""  forKey:@"nippleSym"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }

        
        
        if(jsonArr2.count!=0){
            
            NSString *babySym=[jsonArr2 componentsJoinedByString:@","];
            
            
            //NSLog(@"habit JSON Output: %@", skinSymp);
            
            [[NSUserDefaults standardUserDefaults]setObject:babySym  forKey:@"babySym"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }
        
        else{
            [[NSUserDefaults standardUserDefaults]setObject:@""  forKey:@"babySym"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }

    }
    
     if ([SingletonClass sharedSingleton].deptId==5){
        
        
        
        
        
        
        
        if(jsonArr.count!=0){
           NSString* generalSymptStr=[jsonArr componentsJoinedByString:@","];

        [[NSUserDefaults standardUserDefaults]setObject:generalSymptStr  forKey:@"generalSympStr"];
        [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            NSLog(@"gen-->%@",generalSymptStr);
            
        }
        else{
            [[NSUserDefaults standardUserDefaults]setObject:@""  forKey:@"generalSympStr"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        }
        
        if(jsonArr1.count!=0){
            NSString* headNeckStr=[jsonArr1 componentsJoinedByString:@","];
            [[NSUserDefaults standardUserDefaults]setObject:headNeckStr  forKey:@"headNeckStr"];
            [[NSUserDefaults standardUserDefaults]synchronize];
             NSLog(@"headNeck-->%@",headNeckStr);
        }
        else{
            [[NSUserDefaults standardUserDefaults]setObject:@""  forKey:@"headNeckStr"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        }

        
        
        if(jsonArr3.count!=0){
        NSString*    digestiveTrackStr=[jsonArr3 componentsJoinedByString:@","];

            [[NSUserDefaults standardUserDefaults]setObject:digestiveTrackStr  forKey:@"digestivetrackStr"];
            [[NSUserDefaults standardUserDefaults]synchronize];
             NSLog(@"DigesTrack-->%@",digestiveTrackStr);
        }
        else{
            [[NSUserDefaults standardUserDefaults]setObject:@""  forKey:@"digestivetrackStr"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        }


    }
   
    
   
    

    
    if([SingletonClass sharedSingleton].deptId==4 ||[SingletonClass sharedSingleton].deptId==2||[SingletonClass sharedSingleton].deptId==5){
        
        MedicalConditionView *medicalConditionView=[[MedicalConditionView alloc]init];
        [self.navigationController pushViewController:medicalConditionView animated:YES];
    }
    else if ([SingletonClass sharedSingleton].deptId==3){
        MedicationView *medication=[[MedicationView  alloc]init];
        [self.navigationController pushViewController:medication animated:YES];
    }
    else if([SingletonClass sharedSingleton].deptId==1){
        [self createPopUp];
    }

    
    
        
   }



#pragma mark-Pop Up view
-(void)createPopUp{
    
   backPopUp =[[UIView alloc]initWithFrame:CGRectMake(0, 800, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    backPopUp.backgroundColor =[UIColor lightGrayColor];
    [self.view addSubview:backPopUp];
    
     popUpView=[[UIView alloc]initWithFrame:CGRectMake(10, 800, [UIScreen mainScreen].bounds.size.width-20, [UIScreen mainScreen].bounds.size.height-120)];
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
    
    UILabel *header=[[UILabel alloc]initWithFrame:CGRectMake(00,0,  popUpView.frame.size.width, 150)];
    header.text=@"GOOD\nGOING!";
    header.numberOfLines=2;
    header.font=[UIFont fontWithName:@"GothamRounded-Medium" size:30];
    header.textAlignment = NSTextAlignmentCenter;
    header.textColor=[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1];
    [popUpView addSubview:header];
    
    
    UILabel *information=[[UILabel alloc]initWithFrame:CGRectMake(0,70,  popUpView.frame.size.width, 300)];
    information.text=@"Now we just need to set \n you up with an account. \n \n Don't worry it wont take \n long!.";
    information.numberOfLines=7;
    information.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    information.textColor=[UIColor blackColor];
    information.textAlignment = NSTextAlignmentCenter;
    [popUpView addSubview:information];
    
    UIButton *letsGoButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    letsGoButton.frame=CGRectMake(0, popUpView.frame.size.height-80,popUpView.frame.size.width-20, 50);
    [letsGoButton setTitle:@"Let's Go!" forState:UIControlStateNormal];
     letsGoButton.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    [letsGoButton setBackgroundColor:[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1]];
    [letsGoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [letsGoButton addTarget:self action:@selector(letsGo) forControlEvents:UIControlEventTouchUpInside];
    letsGoButton.layer.cornerRadius=6.0f;
    
    [popUpView addSubview:letsGoButton];
    
    
    
    [UIView animateWithDuration:0.5 animations:^{
        popUpView.frame = CGRectMake(20, 60, [UIScreen mainScreen].bounds.size.width-40, [UIScreen mainScreen].bounds.size.height-150);
        backPopUp.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }];
}
-(void)letsGo{
    NSString *patientID=[[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"];
    
    
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        popUpView.frame=CGRectMake(30, 700, self.view.frame.size.width-60, self.view.frame.size.height-60);
        backPopUp.frame = CGRectMake(0,800, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }completion:^(BOOL finished){
        
        if(patientID == nil){
            SignUpView *signUp=[[SignUpView alloc]init];
            [self.navigationController pushViewController:signUp animated:YES];
        }
        
              else{
            
                  
                  SelectPharmacyVC *phar=[[SelectPharmacyVC alloc]init];
            [self.navigationController pushViewController:phar animated:YES];
            
          
        }
        
        
    }];
    

}






@end
