//
//  PsychologyView.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 8/8/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "PsychologyView.h"
#import "SingletonClass.h"

@interface PsychologyView (){
    CGSize screenRect;
    NSArray *psychologyViewCells,*psychologyViewCellsImg;
    UIView *letsGetStartedPopUp;
    
    UIView * backPopUp;
    UIButton *couponButton;
     NSMutableArray *callCost;
    
    UIActivityIndicatorView *activityIndicator;
    
}


@end

@implementation PsychologyView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    screenRect=[[UIScreen mainScreen]bounds].size;
    
    [[NSUserDefaults standardUserDefaults]setObject:nil
                                             forKey:@"MYHEALTH"];
    [[NSUserDefaults standardUserDefaults]synchronize];

     [SingletonClass sharedSingleton].deptId=3;
    
    
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"OurDoctors"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"pop"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    titleLable.text =@"Pshychology";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];

    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
    [backButton setFrame:CGRectMake(15, 18, 55, 35)];    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
   
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"consultant"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"OurDoctors"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    if (UIUserInterfaceIdiomPad== UI_USER_INTERFACE_IDIOM()) {
        
        headerView.frame= CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80);
        
        [backButton setImage:[UIImage imageNamed:@"back_btn_ipad.png"] forState:UIControlStateNormal];
        [backButton setFrame:CGRectMake(15, 30, 80, 30)];
        
        //        titleLable.frame= CGRectMake(60, 25, screenRect.width-120, 35);
        //        titleLable.font =[UIFont boldSystemFontOfSize:25];
        titleLable.frame= CGRectMake(60, 25, screenRect.width-120, 35);
        titleLable.font=[UIFont fontWithName:@"GothamRounded-Light" size:30];
    }

    [self createUi];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)createUi{
    
    UIImageView *logoView = [[UIImageView alloc] init];
    
    if (UIUserInterfaceIdiomPad== UI_USER_INTERFACE_IDIOM()) {
        
        logoView.frame = CGRectMake(0, 80, screenRect.width,screenRect.height/2-50);
        logoView.image=[UIImage imageNamed:@"psychology_img_back.png"];
        
    }
    else{
    
    
    if(screenRect.height==667)
    {
        logoView.frame = CGRectMake(0, 70, screenRect.width, 190);
    }
    
    else if (screenRect.height>=736){
        logoView.frame = CGRectMake(0, 70, screenRect.width, 210);
    }
    else
        
        logoView.frame = CGRectMake(0, 70, screenRect.width, 160);
    
    
    logoView.image=[UIImage imageNamed:@"psychology_img_back.png"];
    }
    [logoView setContentMode:UIViewContentModeScaleAspectFit];
    
    
    [self.view addSubview:logoView];
    
    
    
    
    
    
    
    
    
    
    
    UITableView *tableView=[[UITableView alloc]init];
    
    if (UIUserInterfaceIdiomPad== UI_USER_INTERFACE_IDIOM())
        tableView.frame=CGRectMake(10, screenRect.height/2+20, screenRect.width-20, screenRect.height/2-30);
    
    else{
    if(screenRect.height==480){
        
        tableView.frame=CGRectMake(10, screenRect.height/2-10, screenRect.width-20, screenRect.height/2);
        
        
    }
    
else
    tableView.frame=CGRectMake(10, screenRect.height/2-50, screenRect.width-20, screenRect.height/2+40);
    }
    
    tableView.backgroundColor=[UIColor clearColor];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView setShowsVerticalScrollIndicator:NO];

    
    [self.view addSubview:tableView];
    
    
    psychologyViewCells=[NSArray arrayWithObjects:@"",@"Why Video Therapy?",@"How it Works",@"Our Psychologists",@"About Doctor On Demand", nil];
    
    psychologyViewCellsImg =[NSArray arrayWithObjects:@"",@"videoplay_icon",@"question_icon.png",@"user_icon.png",@"user_icon.png", nil];
    
    
}

#pragma mark- table delgate methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad){
        cell.textLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:25];
        
    }

    
    cell.layer.cornerRadius = 3;
    cell.clipsToBounds = YES;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil )
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    if (indexPath.section == 0) {
        UIButton *cellButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        if(screenRect.height>=667){
            
            cellButton.frame = CGRectMake(0, 0, screenRect.width-20,75);
        }
        else
            cellButton.frame = CGRectMake(0, 0, screenRect.width-20,60);
        [cellButton setBackgroundImage: [UIImage imageNamed:@"schedule_appointment_btn.png"] forState:UIControlStateNormal];
        [cellButton addTarget:self action:@selector(seeADoctor) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:cellButton];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            [cellButton setBackgroundImage: [UIImage imageNamed:@"schedule_appointment6.png"] forState:UIControlStateNormal];
            cellButton.frame = CGRectMake(0, 0, screenRect.width-20,120);
        }

        
    }
    else{
        
        
        // cell.imageView.frame = CGRectMake(10, 2, 22, 22);
        cell.textLabel.text = [psychologyViewCells objectAtIndex:indexPath.section];
        cell.textLabel.font=[UIFont systemFontOfSize:15];
        cell.imageView.image = [UIImage imageNamed:[psychologyViewCellsImg objectAtIndex:indexPath.section]];
        cell.accessoryView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"forward_arrow.png"]];
    }
    cell.textLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];

    
          return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@ "ROW-%ld Content-%@",(long)indexPath.row+1,[psychologyViewCells objectAtIndex:indexPath.row]);
    NSLog(@"section>>>>>>%ld",(long)indexPath.section);
    HowItWorkView *howItWork=[[HowItWorkView alloc]init];

    
    
    
    switch (indexPath.section) {
        case 0:
            
            break;
        case 1:{
            
            ItWorksSubVC *subView=[ItWorksSubVC new];
           
            
            [[NSUserDefaults standardUserDefaults]setObject:@"Video" forKey:@"subView"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            [self.navigationController pushViewController:subView animated:YES];
        }

            
            break;
            
        case 2:
            
            [self.navigationController pushViewController:howItWork animated:YES];
            
            break;
            
        case 3:{
            OurDoctorsVC *doctor=[OurDoctorsVC new];
            [self.navigationController pushViewController:doctor animated:YES];
        }
        
            
            break;
            
        case 4:
                              break;
                   
            
        case 5:{
            AboutVC *about=[[AboutVC alloc]init];
            [self.navigationController pushViewController:about animated:YES];
            break;
            
        }
            
        default:
            break;
    }
    
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [psychologyViewCells count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (UIUserInterfaceIdiomPad==UI_USER_INTERFACE_IDIOM()) {
        if(indexPath.section==0 && indexPath.row==0){
            
            return 120;
        }
        else
            return 80;
    }
    else{
        if(indexPath.section==0 && indexPath.row==0){
            if(screenRect.height>=667){
                
                return 75;
            }
            else
                return 60;
        }
        else
            if(screenRect.height>=667){
                
                
                return 50;
            }
            else{
                return 40;
            }
    }

}


-(void)cellButtonAction{
    NSLog(@"pressed");
    
    
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)seeADoctor{
    
    
    if([[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"]!=nil){
    
        
        
        [self activityAction];
        
        dispatch_async(dispatch_get_global_queue(0, 0),^{
            
            [self doctorCallRate];
            
            dispatch_async(dispatch_get_main_queue(),^{
                
                backPopUp = [[UIView alloc]initWithFrame:CGRectMake(0, 800, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height)];
                backPopUp.backgroundColor =[UIColor lightGrayColor];
                [self.view addSubview:backPopUp];
                
                letsGetStartedPopUp=[[UIView alloc]initWithFrame:CGRectMake(10, 800, self.view.frame.size.width-20, self.view.frame.size.height-20)];
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
                    
                    letsGetStartedPopUp.frame=CGRectMake(30, 60, self.view.frame.size.width-60, self.view.frame.size.height-110);
                    backPopUp.frame=CGRectMake(00, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                    
                }completion:nil];
                
                
                
                
                UILabel *header=[[UILabel alloc]initWithFrame:CGRectMake(0,0,  self.view.frame.size.width-60-5, 150)];
                header.text=@"LET'S GET\nSTARTED!";
                header.numberOfLines=2;
                header.font=[UIFont fontWithName:@"GothamRounded-Medium" size:30];
                header.textColor=[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1];
                header.textAlignment=NSTextAlignmentCenter;
                [letsGetStartedPopUp addSubview:header];
                
               
                
                UILabel *information=[[UILabel alloc]init];
                
                
                if(screenRect.height>=667){
                    
                    information.frame=CGRectMake(0,150,  self.view.frame.size.width-60-5, 80);
                    
                    information.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];
                }
                else{
                    information.frame=CGRectMake(0,120,  self.view.frame.size.width-60-5, 60);
                    information.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
                }
                

                information.text=@"We need some info to get\nyou the best possible care.\nYour visit costs:";
                information.numberOfLines=5;
                information.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
                information.textAlignment=NSTextAlignmentCenter;
                information.textColor=[UIColor blackColor];
                [letsGetStartedPopUp addSubview:information];
                
                
                UILabel *costInfo=[[UILabel alloc]init];
                
                
                if(screenRect.height>=667){
                    
                    costInfo.frame=CGRectMake(0,235,  self.view.frame.size.width-60-5, 70);
                    costInfo.font=[UIFont fontWithName:@"GothamRounded-Medium" size:15];
                }
                
                
                else{
                    costInfo.frame=CGRectMake(0,175,  self.view.frame.size.width-60-5, 70);
                    costInfo.font=[UIFont fontWithName:@"GothamRounded-Medium" size:13];
                }
                
               costInfo.text=[NSString stringWithFormat:@"%@ minutes-$%@",[[callCost objectAtIndex:0]objectForKey:@"calltime"],[[callCost objectAtIndex:0]objectForKey:@"needtopay"]] ;
                costInfo.textAlignment=NSTextAlignmentCenter;
                // costInfo.text=@"25 minutes-$50\n50 minutes-$95";
                costInfo.numberOfLines=2;
                costInfo.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
                costInfo.textColor=[UIColor blackColor];
                [letsGetStartedPopUp addSubview:costInfo];
                
                
                
            
                
                couponButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
                couponButton.frame=CGRectMake(10, letsGetStartedPopUp.frame.size.height-100,self.view.frame.size.width-60-30,20);
                
                [couponButton setTitle:@"Apply Coupon" forState:UIControlStateNormal];
                [couponButton setTitleColor:[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1] forState:UIControlStateNormal];
                [couponButton addTarget:self action:@selector(ApplyCouponActn) forControlEvents:UIControlEventTouchUpInside];
                couponButton.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
                
                [letsGetStartedPopUp addSubview:couponButton];
                
                UIButton *letsGoButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
                letsGoButton.frame=CGRectMake(0, letsGetStartedPopUp.frame.size.height-50,self.view.frame.size.width-60, 50);
                [letsGoButton setTitle:@"Let's Go!" forState:UIControlStateNormal];
                letsGoButton.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
                [letsGoButton setBackgroundColor:[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1]];
                [letsGoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [letsGoButton addTarget:self action:@selector(letsGo) forControlEvents:UIControlEventTouchUpInside];
                letsGoButton.layer.cornerRadius=6.0f;
                
                [letsGetStartedPopUp addSubview:letsGoButton];
                
                
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    header.frame = CGRectMake(0,0,  letsGetStartedPopUp.frame.size.width, 150);
                    header.textAlignment = NSTextAlignmentCenter;
                    header.font = [UIFont fontWithName:@"GothamRounded-Medium" size:50];
                    
                    costInfo.frame=CGRectMake(0,400,  self.view.frame.size.width-60-5, 70);
                    costInfo.font=[UIFont fontWithName:@"GothamRounded-Medium" size:30];
                    
                    information.frame=  CGRectMake(40,150, letsGetStartedPopUp.frame.size.width-80, 300);
                    information.font = [UIFont fontWithName:@"GothamRounded-Medium" size:30];
                    information.textAlignment = NSTextAlignmentCenter;
                    couponButton.frame=CGRectMake(letsGetStartedPopUp.frame.size.width/2-100, letsGetStartedPopUp.frame.size.height-200,250,80);
                    couponButton.titleLabel.font = [UIFont fontWithName:@"GothamRounded-Medium" size:30];
                    letsGoButton.frame=CGRectMake(0,letsGetStartedPopUp.frame.size.height-100,letsGetStartedPopUp.frame.size.width, 100);
                    letsGoButton.titleLabel.font = [UIFont fontWithName:@"GothamRounded-Medium" size:30];
                }

                [activityIndicator stopAnimating];

            });
            
        });
    
        }
    else{
    
        SignInView *signIn=[[SignInView alloc]init];
        [self.navigationController pushViewController:signIn animated:YES];
        
        
    }
    
    
    
}

-(void)letsGo{
    SetUpView *setUpView=[[SetUpView alloc]init];
    [SingletonClass sharedSingleton].item=2;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        letsGetStartedPopUp.frame=CGRectMake(30, 2000, self.view.frame.size.width-60, self.view.frame.size.height-60);
        backPopUp.frame = CGRectMake(0,2000, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }completion:^(BOOL finished){
        [self.navigationController pushViewController:setUpView animated:YES];
        
        
    }];
}

#pragma mark-Apply Coupon Buttom action


-(void)ApplyCouponActn{
    
    self.tabBarController.tabBar.hidden=NO;
    [[NSUserDefaults standardUserDefaults]setObject:@"FreeCoupon" forKey:@"CouponType"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    ApplyCouponVC *applyCoupon=[[ApplyCouponVC alloc]init];
    
    
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        letsGetStartedPopUp.frame=CGRectMake(30, 700, self.view.frame.size.width-60, self.view.frame.size.height-60);
        backPopUp.frame = CGRectMake(0,800, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }completion:^(BOOL finished){
        applyCoupon.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:applyCoupon animated:YES];
        
        
    }];
    
    
}

#pragma mark-Doctor Call Rate Services

-(void)doctorCallRate{
     callCost=[[NSMutableArray alloc]init];
    NSError * error ;
    NSURLResponse * urlResponse;
    
    NSURL * postUrl =[NSURL URLWithString:doctorCallCostService];
    
    
    NSLog(@"------->%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"symptomps"]);
    
    NSString * body;
    
    if([SingletonClass sharedSingleton].deptId==5)
        
        body =[NSString stringWithFormat:@"did=4&id=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"]];
    
    else
        
        body =[NSString stringWithFormat:@"did=%@&id=%@",[NSString stringWithFormat:@"%d",[SingletonClass sharedSingleton].deptId],[[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"]];
    
    NSMutableURLRequest * request =[[NSMutableURLRequest alloc]initWithURL:postUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
    
    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (!data) {
        
        return;
    }
    
    id json =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    NSLog(@"json %@",json);
    if ([[json objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
        
        NSArray *ar=[json objectForKey:@"data"];
        for (int i=0; i<ar.count; i++) {
            
            
            [callCost addObject:[ar objectAtIndex:i]];
        }
    }
    else{
        
    }
    
    
    
    
    
}
#pragma mark-Activity Indicator
-(void)activityAction{
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.frame = CGRectMake(screenRect.width/2-20, screenRect.height/2-55,40 ,40);
    activityIndicator.color = [UIColor blackColor];
    activityIndicator.alpha = 1;
    [self.view addSubview:activityIndicator];
    //[self placeSearchbaseId];
    
    [activityIndicator startAnimating];
    
    
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
