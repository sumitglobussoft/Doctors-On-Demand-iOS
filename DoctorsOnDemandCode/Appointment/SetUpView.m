

//
//  SetUpView.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 8/10/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "SetUpView.h"
#import "CalendarViewController.h"

@interface SetUpView ()
{
    CGSize screenRect;
    NSArray *setupViewCells,*psychologySetupViewCells;
    UITableViewCell *cell;
    int selectedIndex;
    UIScrollView *scrollView;
    UITableView *setupTableView;
     UIView *headerView,*backPopUp,*letsGetStartedPopUp;
    CalendarViewController *calenderView;
    UIScrollView *myScroll;
}


@end

@implementation SetUpView

- (void)viewDidLoad {
    [super viewDidLoad];
    screenRect = [[UIScreen mainScreen] bounds].size;
    self.tabBarController.tabBar.hidden=YES;
    
    // UIImage *headerImage = [UIImage imageNamed:@"head_logo"];
    
    //arr =[NSArray arrayWithObjects:@" Me",@" My Child",@" Someone Else", nil];
    //self.navigationItem.titleView = [[UIImageView alloc] initWithImage:headerImage] ;
    
    
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    titleLable.text =@"SETUP";
    titleLable.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];
    titleLable.textAlignment = NSTextAlignmentCenter;
    //titleLable.font =[UIFont systemFontOfSize:12];
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
[backButton setFrame:CGRectMake(15, 18, 55, 35)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
    UIButton *nextButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setImage:[UIImage imageNamed:@"next_btn.png"] forState:UIControlStateNormal];
    [nextButton setFrame:CGRectMake(screenRect.width-60, 28, 45, 25)];    [nextButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:nextButton];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        headerView.frame= CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80);
        titleLable.frame= CGRectMake(60, 25, screenRect.width-120, 35);
        titleLable.font=[UIFont fontWithName:@"GothamRounded-Light" size:30];
        //titleLable.font =[UIFont systemFontOfSize:30];
        [backButton setImage:[UIImage imageNamed:@"back_btn_ipad.png"] forState:UIControlStateNormal];
        [backButton setFrame:CGRectMake(15, 30, 80, 25)];
        
        [nextButton setImage:[UIImage imageNamed:@"next_btn-ipad.png"] forState:UIControlStateNormal];
        [nextButton setFrame:CGRectMake(screenRect.width-100, 28, 80, 25)];
        
    }

    
    [self createUi];
    
    
    
    // Do any additional setup after loading the view.
}
-(void)nextAction{
    
    
    
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",selectedIndex] forKey:@"patientNo"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
 //   NSString *patientID=[[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"];

    
    //if([SingletonClass sharedSingleton].deptId==4) {
//        AddReferralSourceVC *referal=[[AddReferralSourceVC alloc]init];
//        [self.navigationController pushViewController:referal animated:YES];
//
//        CalendarViewController* calenderView1=[[CalendarViewController alloc]init];
//       [self.navigationController pushViewController:calenderView1 animated:YES];

        
   // }
    if(selectedIndex==2||selectedIndex==3)
    {
    
        [self popup];
        
    

    }
    
    else
    {
        
        if([SingletonClass sharedSingleton].deptId==3||[SingletonClass sharedSingleton].deptId==4||[SingletonClass sharedSingleton].deptId==2){
            HowToScheduleVC *howToSchedule=[[HowToScheduleVC alloc]init];
            [self.navigationController pushViewController:howToSchedule animated:YES];
        
    }
    }
}
-(void)backAction{
    
    self.tabBarController.tabBar.hidden=NO;
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)createUi{
    
    
    if([SingletonClass sharedSingleton].deptId==3){
        
        
        
        
        myScroll = [[UIScrollView alloc] init];
        myScroll.frame = CGRectMake(0, 55, screenRect.width, screenRect.height);
        
      //  myScroll.contentSize = CGSizeMake(320, screenRect.height+30);
        myScroll.backgroundColor = [UIColor clearColor];
        
        myScroll.showsVerticalScrollIndicator = NO;    // to hide scroll indicators!
        
        
        
        myScroll.scrollEnabled = YES;                 //say "NO" to disable scroll
        
        
        [self.view addSubview:myScroll];               //adding to parent view!
        
        
        
           }
    
    
    
    
//    if([SingletonClass sharedSingleton].deptId==4||[SingletonClass sharedSingleton].deptId==2){
//        UIButton *noThanks=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//        noThanks.frame= CGRectMake(screenRect.width-300,screenRect.height-90, screenRect.width-2*(screenRect.width-300), 20);
//        [noThanks setTitle:@"No Thanks,I'm Just Browsing..." forState:UIControlStateNormal];
//        noThanks.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
//        [noThanks setTitleColor:[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1] forState:UIControlStateNormal];
//        [noThanks addTarget:self action:@selector(noThanksAction) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:noThanks];
//    }
//    
    
    UILabel *whoIsPatient=[[UILabel alloc]init];
    whoIsPatient.numberOfLines=2;
    whoIsPatient.text=@"Who is the\nPatient?";
    whoIsPatient.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
    whoIsPatient.textColor=[UIColor blackColor];
   
    if([SingletonClass sharedSingleton].deptId==4||[SingletonClass sharedSingleton].deptId==2)
    {
       
        
        whoIsPatient.frame=CGRectMake(30, 80, screenRect.width, 40);
    }
    else if([SingletonClass sharedSingleton].deptId==3)
    {
        whoIsPatient.frame=CGRectMake(30, 30, myScroll.frame.size.width, 40);
    }
    
    

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        
        whoIsPatient.text=@"Who is the Patient?";
        
        whoIsPatient.font=[UIFont fontWithName:@"GothamRounded-Medium" size:30];
        
        
        
        if([SingletonClass sharedSingleton].deptId==4||[SingletonClass sharedSingleton].deptId==2)
        {
            
            whoIsPatient.frame=CGRectMake(30, 100, screenRect.width, 100);
            //[self.view addSubview:whoIsPatient];
        }
        
        else if([SingletonClass sharedSingleton].deptId==3)
        {
            
            whoIsPatient.frame=CGRectMake(30, 50, screenRect.width, 100);
            //[myScroll addSubview:whoIsPatient];
        }
        
       // [self.view addSubview:whoIsPatient];
    }
    
    
    
    
    
    if([SingletonClass sharedSingleton].deptId==4||[SingletonClass sharedSingleton].deptId==2)
    {
        [self.view addSubview:whoIsPatient];
    }
    else if([SingletonClass sharedSingleton].deptId==3)
    {
        [myScroll addSubview:whoIsPatient];
    }
    
    
    
    
    
    setupTableView=[[UITableView alloc]init];
    
    
    
    if([SingletonClass sharedSingleton].deptId==4||[SingletonClass sharedSingleton].deptId==2)
    {
        setupTableView.frame=CGRectMake(10,150 ,screenRect.width-20,150);
    }
    else if([SingletonClass sharedSingleton].deptId==3)
    {
        setupTableView.frame=CGRectMake(10, 80 ,screenRect.width-20,200);
    }
    
    
    
    
    
    setupTableView.backgroundColor=[UIColor clearColor];
    setupTableView.scrollEnabled = NO;
    setupTableView.layer.borderWidth = 2.0;
    setupTableView.layer.borderColor = [UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1].CGColor;
    [setupTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    setupTableView.delegate=self;
    setupTableView.dataSource=self;
    
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
  
      
        if([SingletonClass sharedSingleton].deptId==4||[SingletonClass sharedSingleton].deptId==2){
            
           setupTableView.frame=CGRectMake(10,180 ,screenRect.width-20,240);
        }
        else if([SingletonClass sharedSingleton].deptId==3){
            setupTableView.frame=CGRectMake(10,150 ,screenRect.width-20,360);
        
        }

    }
    if([SingletonClass sharedSingleton].deptId==4||[SingletonClass sharedSingleton].deptId==2){
        [self.view addSubview:setupTableView];
    }
    else if([SingletonClass sharedSingleton].deptId==3){
        [myScroll addSubview:setupTableView];
    }

    
    setupViewCells=[NSArray arrayWithObjects:@"Me",@"My Child",@"Someone Else", nil];
    psychologySetupViewCells=[NSArray arrayWithObjects:@"Me",@"My Child:",@"My Child:",@"Someone Else", nil];
    
    
    UILabel *pshycoSetUplabel=[[UILabel alloc]init];
    pshycoSetUplabel.frame=CGRectMake(0,setupTableView.frame.origin.y +setupTableView.frame.size.height-70,  myScroll.frame.size.width, 300);
    pshycoSetUplabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    pshycoSetUplabel.text=@"CRISIS/EMERGENCY?If you are\n experiencing a crisis or an emergency,\nplease dial 911.You may also access the\nfree,24-hour National Suicide\nPrevention Lifeline\nat 1-800-273-8255(1-800-273-TALK).";
    pshycoSetUplabel.numberOfLines=9;
    pshycoSetUplabel.textAlignment=NSTextAlignmentCenter;
    pshycoSetUplabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    pshycoSetUplabel.textColor=[UIColor redColor];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        
        
        
         pshycoSetUplabel.frame=CGRectMake(0,setupTableView.frame.origin.y +setupTableView.frame.size.height-70,  myScroll.frame.size.width, 300);
        
        pshycoSetUplabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:22];
    
    
    
    }

    [myScroll addSubview:pshycoSetUplabel];

    
    
    
    
    float sizeOfContent = 0;
    UIView *lLast = [myScroll.subviews lastObject];
    NSInteger wd = lLast.frame.origin.y;
    NSInteger ht = lLast.frame.size.height;
    NSInteger offset=30;
    sizeOfContent = wd+ht;
    myScroll.contentSize=CGSizeMake(screenRect.width,sizeOfContent+offset);

    
    
    
}
-(void)noThanksAction{
    MeetUsView *meetUsView=[[MeetUsView alloc]init];
    
    
    
    
    
    // [self presentViewController:meetUsView animated:NO completion:nil];
    [self.navigationController pushViewController:meetUsView animated:NO];
    
    
    
    
}

#pragma mark-TableView delegate methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return 80;
    return 50;
        


}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"SimpleTableItem";
    
    cell = [tableView cellForRowAtIndexPath:indexPath];
    // cell.preservesSuperviewLayoutMargins=NO;
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if([SingletonClass sharedSingleton].deptId==4||[SingletonClass sharedSingleton].deptId==2)
    {
        cell.textLabel.text=[setupViewCells objectAtIndex:indexPath.row];
       cell.textLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];
        
        if (indexPath.row == selectedIndex) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    else if([SingletonClass sharedSingleton].deptId==3){
        
        cell.textLabel.text=[psychologySetupViewCells objectAtIndex:indexPath.row];
        cell.textLabel.font= [UIFont fontWithName:@"GothamRounded-Light" size:14];
        
        UILabel *age=[[UILabel alloc]init];
        if(indexPath.row==1){
            age.frame=CGRectMake(cell.frame.size.width-230, cell.frame.size.height-62, 150, 80);
            age.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];;
            age.text=@" 8-17 years old";
            age.textColor=[UIColor lightGrayColor];
            [cell addSubview:age];
            
            
        }
        else  if(indexPath.row==2){
            age.frame=CGRectMake(cell.frame.size.width-50, cell.frame.size.height-63, 150, 80);
            age.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];;
            age.text=@" under age 8";
            age.textColor=[UIColor lightGrayColor];
            [cell addSubview:age];
            
            
        }
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            age.frame=CGRectMake(cell.frame.size.width/3+50, cell.frame.size.height-40, 200, 80);
            age.font=[UIFont fontWithName:@"GothamRounded-Light" size:25];
           


            
        }
        
        if (indexPath.row == selectedIndex) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
              }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        cell.textLabel.font= [UIFont fontWithName:@"GothamRounded-Light" size:25];
    

    
    return cell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([SingletonClass sharedSingleton].deptId==4||[SingletonClass sharedSingleton].deptId==2)
    {
        
        return [setupViewCells count];
    }
    else if([SingletonClass sharedSingleton].deptId==3)
    {
        return [psychologySetupViewCells count];
    }
    else{
        return 0;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    selectedIndex = (int)indexPath.row;
    [setupTableView reloadData];
    
    
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",selectedIndex] forKey:@"patientNo"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    
    
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark-popUp
-(void)popup{
    
    
    
    
    
    
    backPopUp = [[UIView alloc]initWithFrame:CGRectMake(0, 800, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height)];
    backPopUp.backgroundColor =[UIColor lightGrayColor];
    [self.view addSubview:backPopUp];
    
    letsGetStartedPopUp=[[UIView alloc]init];
    letsGetStartedPopUp.frame = CGRectMake(10, 800, self.view.frame.size.width-20, self.view.frame.size.height-20);
    letsGetStartedPopUp.layer.cornerRadius=6.0f;
    letsGetStartedPopUp.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:1];
    letsGetStartedPopUp.clipsToBounds = YES;
    letsGetStartedPopUp.layer.shadowColor = [UIColor blackColor].CGColor;
    letsGetStartedPopUp.layer.shadowOffset = CGSizeMake(-2, 2);
    letsGetStartedPopUp.layer.shadowOpacity = 3;
    letsGetStartedPopUp.layer.shadowRadius = 15;
    letsGetStartedPopUp.layer.shadowPath = [UIBezierPath bezierPathWithRect:letsGetStartedPopUp.bounds].CGPath;
    
    [backPopUp addSubview:letsGetStartedPopUp];
    
    
    
    //[self.view insertSubview:letsGetStartedPopUp atIndex:2];
    
    [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        letsGetStartedPopUp.frame=CGRectMake(30, 60, self.view.frame.size.width-60, self.view.frame.size.height-100);
        backPopUp.frame=CGRectMake(00, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
    }completion:nil];
    
    
    
    
    UILabel *header=[[UILabel alloc]init];
    header.frame = CGRectMake(00,0,  letsGetStartedPopUp.frame.size.width, 150);
    
    
    header.text=@"CREATE NEW\nACCOUNT";
    header.numberOfLines=2;
    header.font=[UIFont fontWithName:@"GothamRounded-Medium" size:30];
    header.textColor=[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1];
    header.textAlignment = NSTextAlignmentCenter;
    [letsGetStartedPopUp addSubview:header];
    
    UILabel *information=[[UILabel alloc]init];
    
    
    if(screenRect.height>=667){
        
        information.frame=CGRectMake(0,150,  self.view.frame.size.width-60-5, 80);
        
        information.font=[UIFont fontWithName:@"GothamRounded-Light" size:16];
    }
    else{
        information.frame=CGRectMake(0,120,  self.view.frame.size.width-60-5, 60);
        information.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    }
    
    

    
    
    
    information.text=@"So sorry for the trouble\nbut you need to create a new\naccount in the name of the\nperson visiting the doctor.";
    
    information.numberOfLines=8;
    information.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    information.textColor=[UIColor blackColor];
    information.textAlignment = NSTextAlignmentCenter;
    [letsGetStartedPopUp addSubview:information];
    
    
    UIButton*  okButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    okButton.frame=CGRectMake(0,letsGetStartedPopUp.frame.size.height-50,letsGetStartedPopUp.frame.size.width, 50);
    [okButton setTitle:@"OK!" forState:UIControlStateNormal];
    okButton.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    [okButton setBackgroundColor:[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1]];
    [okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okButton addTarget:self action:@selector(okActn) forControlEvents:UIControlEventTouchUpInside];
    okButton.layer.cornerRadius=6.0f;
    
    [letsGetStartedPopUp addSubview:okButton];
    
}

-(void)okActn{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        letsGetStartedPopUp.frame=CGRectMake(30, 2000, self.view.frame.size.width-60, self.view.frame.size.height-60);
        backPopUp.frame = CGRectMake(0,2000, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }completion:^(BOOL finished){
        [backPopUp removeFromSuperview];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }];
    
    
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