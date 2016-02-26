//
//  SettingsCallViewController.m
//  QBRTCChatSemple
//
//  Created by Andrey Ivanov on 11.12.14.
//  Copyright (c) 2014 QuickBlox Team. All rights reserved.
//

#import "SettingsCallViewController.h"
#import "CheckUserTableViewCell.h"
#import "ConnectionManager.h"
#import "CallManager.h"

#import "SVProgressHUD.h"

NSString *const kCheckUserTableViewCellIdentifier = @"CheckUserTableViewCellIdentifier";
NSString *const kStunViewControllerIdentifier = @"StunViewController";

const CGFloat kSettingsInfoHeaderHeight = 25;

@interface SettingsCallViewController ()<UITableViewDataSource, UITableViewDelegate>{
    QBUUser *testUser ;
    
    UIImageView *firstRate,*secRate,*thirdRate,*fourthRate,*fifthRate;
    
    int ratings;
    UITextView *reviewTextView;
    UIButton *starBtn;
    
}



@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *selectedUsers;

@end

@implementation SettingsCallViewController

- (void)dealloc {
    NSLog(@"%@ - %@",  NSStringFromSelector(_cmd), self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=NO;

    
    ratings=0;

    // Do any additional setup after loading the view.
    
    [QBRTCClient.instance addDelegate:CallManager.instance];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.rowHeight = 44;
    self.tableView.scrollEnabled=NO;
    self.selectedUsers = [NSMutableArray array];
  self.users = ConnectionManager.instance.usersWithoutMe;
    
    __weak __typeof(self)weakSelf = self;
    [self setDefaultBackBarButtonItem:^{
        
        [ConnectionManager.instance logOut];
        weakSelf.navigationController.navigationBar.hidden=YES;
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    self.title = [NSString stringWithFormat:@"Logged in as %@", ConnectionManager.instance.me.fullName];
   
//    UIBarButtonItem *anotherButton =
//    [[UIBarButtonItem alloc] initWithTitle:@"STUN"
//                                     style:UIBarButtonItemStylePlain
//                                    target:self action:@selector(pressSelectStun:)];
//    
//   testUser =[[QBUUser alloc]init];
//    testUser.login=@"Dharasis";
//    testUser.fullName=@"Dharasis Behera";
//    testUser.ID=6254135;
//    testUser.password=@"DHbe_7946";
////    [self userWithID:[NSNumber numberWithInt:6254135]
////               login:@"Dharasis"
////            fullName:@"Dharasis Behera"
////            passowrd:@"x6Bt0VDy5"];
    
   // self.navigationItem.rightBarButtonItem = anotherButton;
    
    
    
    [self reviewView];
    
}


#pragma mark-Review

-(void)reviewView{
    
    
    
starBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    starBtn.frame=CGRectMake([[UIScreen mainScreen]bounds].size.width/2-20, 140, 45, 45);
    [starBtn setBackgroundImage:[UIImage imageNamed:@"favorite.png"] forState:UIControlStateNormal];
    [starBtn addTarget:self action:@selector(addToFavActn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:starBtn];
    
    
//    UIImageView *star=[[UIImageView alloc]initWithFrame:CGRectMake(140, [[UIScreen mainScreen]bounds].size.width/4, 50, 50)];
//    star.image=[UIImage imageNamed:@"favorite.png"];
//    [self.view addSubview:star];
//    
    
    
    
    
    
    
    
      UILabel * reviewrating=[[UILabel alloc]initWithFrame:CGRectMake(10, 180, [UIScreen mainScreen].bounds.size.width-20, 35)];
    reviewrating.textAlignment=NSTextAlignmentCenter;
    reviewrating.text=@"Review & Rating";
    reviewrating.textColor=[UIColor redColor];
    reviewrating.font=[UIFont fontWithName:@"GothamRounded-Medium" size:15];
    [self.view addSubview:reviewrating];
    
    
   reviewTextView=[[UITextView alloc]initWithFrame:CGRectMake(10, 210, [UIScreen mainScreen].bounds.size.width-20, 80)];
    reviewTextView.delegate=self;
    reviewTextView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:reviewTextView];
    
    
    

firstRate=[[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4-20, 315,40,40)];
        firstRate.image=[UIImage imageNamed:@"star_rating_empty.png"];
        [self.view addSubview:firstRate];
  
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        firstRate.tag=0;
        
        [firstRate setUserInteractionEnabled:YES];
         [firstRate addGestureRecognizer:tap];
    
    
    secRate=[[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4-20+40, 315,40,40)];
        secRate.image=[UIImage imageNamed:@"star_rating_empty.png"];
        [self.view addSubview:secRate];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        secRate.tag=1;
        
        [secRate setUserInteractionEnabled:YES];
        [secRate addGestureRecognizer:tap1];
    
    
    
thirdRate=[[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4-20+80, 315,40,40)];
    thirdRate.image=[UIImage imageNamed:@"star_rating_empty.png"];
    [self.view addSubview:thirdRate];
 
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    thirdRate.tag=2;
    
    [thirdRate setUserInteractionEnabled:YES];
    [thirdRate addGestureRecognizer:tap2];
    
    
    
    
    fourthRate=[[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4-20+80+40, 315,40,40)];
    fourthRate.image=[UIImage imageNamed:@"star_rating_empty.png"];
    [self.view addSubview:fourthRate];
  
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    fourthRate.tag=3;
    
    [fourthRate setUserInteractionEnabled:YES];
    [fourthRate addGestureRecognizer:tap3];
    
    
    
    
fifthRate=[[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4-20+80+80, 315,40,40)];
    fifthRate.image=[UIImage imageNamed:@"star_rating_empty.png"];
    [self.view addSubview:fifthRate];

    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    fifthRate.tag=4;
    
    [fifthRate setUserInteractionEnabled:YES];
    [fifthRate addGestureRecognizer:tap4];
    
    
    
    
    UIButton *reviewBtn=[[UIButton alloc]initWithFrame:CGRectMake(10,380,[UIScreen mainScreen].bounds.size.width-20, 50)];
    [reviewBtn setTitle:@"Submit" forState:UIControlStateNormal];
    [reviewBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [reviewBtn setBackgroundColor:[UIColor colorWithRed:(CGFloat)234/255 green:(CGFloat)30/255 blue:(CGFloat)99/255 alpha:(CGFloat)1.0]];
    reviewBtn.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
    [reviewBtn addTarget:self action:@selector(ratingBtnActn) forControlEvents:UIControlEventTouchUpInside];
    reviewBtn.layer.cornerRadius=10.0f;
    [self.view addSubview:reviewBtn];

   
    
    
    
}


#pragma mark-Add to favorite Action
-(void)addToFavActn{
    
    dispatch_async(dispatch_get_global_queue(0, 0),^{
        
        
        dispatch_async(dispatch_get_main_queue(),^{

            [self addFavoriteProvider];
            
        });
    });
    
    
}


#pragma mark-Tap action
-(void)tapAction:(UITapGestureRecognizer*)recognizer{

    int tag=(int)recognizer.view.tag;
    if(tag==0){
    firstRate.image=[UIImage imageNamed:@"star_rating.png"];
    secRate.image=[UIImage imageNamed:@"star_rating_empty.png"];
    thirdRate.image=[UIImage imageNamed:@"star_rating_empty.png"];
    fourthRate.image=[UIImage imageNamed:@"star_rating_empty.png"];
    fifthRate.image=[UIImage imageNamed:@"star_rating_empty.png"];
        ratings=1;
    }

    
 if (tag==1){
           firstRate.image=[UIImage imageNamed:@"star_rating.png"];
        secRate.image=[UIImage imageNamed:@"star_rating.png"];
     thirdRate.image=[UIImage imageNamed:@"star_rating_empty.png"];
     fourthRate.image=[UIImage imageNamed:@"star_rating_empty.png"];
     fifthRate.image=[UIImage imageNamed:@"star_rating_empty.png"];
     ratings=2;
 }
    
    
    
 if(tag==2){
        
    firstRate.image=[UIImage imageNamed:@"star_rating.png"];
    secRate.image=[UIImage imageNamed:@"star_rating.png"];
    thirdRate.image=[UIImage imageNamed:@"star_rating.png"];
     fourthRate.image=[UIImage imageNamed:@"star_rating_empty.png"];
     fifthRate.image=[UIImage imageNamed:@"star_rating_empty.png"];
     ratings=3;

    }
    
    
     if(tag==3){
        
        firstRate.image=[UIImage imageNamed:@"star_rating.png"];
        secRate.image=[UIImage imageNamed:@"star_rating.png"];
        thirdRate.image=[UIImage imageNamed:@"star_rating.png"];
        fourthRate.image=[UIImage imageNamed:@"star_rating.png"];
          fifthRate.image=[UIImage imageNamed:@"star_rating_empty.png"];
         ratings=4;
        
    }
     if(tag==4){
        
        firstRate.image=[UIImage imageNamed:@"star_rating.png"];
        secRate.image=[UIImage imageNamed:@"star_rating.png"];
        thirdRate.image=[UIImage imageNamed:@"star_rating.png"];
        fourthRate.image=[UIImage imageNamed:@"star_rating.png"];
         fifthRate.image=[UIImage imageNamed:@"star_rating.png"];
         ratings=5;
        
    }

    
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.users.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CheckUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCheckUserTableViewCellIdentifier];
    
    QBUUser *user = self.users[indexPath.row];
    NSString *text = [NSString stringWithFormat:@"%lu", (unsigned long)user.index];
    [cell setColorMarkerText:text
                    andColor:user.color];
    
    cell.userDescription = [NSString stringWithFormat:@"%@", user.fullName];
    
    BOOL checkMark = [self.selectedUsers containsObject:user];
    [cell setCheckmark:checkMark];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
   

    
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    
    
    
    QBUUser *user = self.users[indexPath.row];
    [self procUser:user];
    
    [tableView reloadRowsAtIndexPaths:@[indexPath]
                     withRowAnimation:UITableViewRowAnimationNone];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    if([view isKindOfClass:[UITableViewHeaderFooterView class]]){
        
        UITableViewHeaderFooterView *tableViewHeaderFooterView = (UITableViewHeaderFooterView *) view;
        tableViewHeaderFooterView.textLabel.text = NSLocalizedString(@"Select doctor you want to call", nil);
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return @"header";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return kSettingsInfoHeaderHeight;
}

#pragma mark Actions

- (void)pressSelectStun:(id)sender {
    
    UINavigationController *navVC = [self.storyboard instantiateViewControllerWithIdentifier:kStunViewControllerIdentifier];
    [self presentViewController:navVC animated:YES completion:^{
        
    }];
}

- (IBAction)pressAudioCallBtn:(id)sender {
    
    [self callWithConferenceType:QBConferenceTypeAudio];
}

- (IBAction)pressVideoCallBtn:(id)sender {
    
    [self callWithConferenceType:QBConferenceTypeVideo];
}

- (void)callWithConferenceType:(QBConferenceType)conferenceType {
    
    
    
    NSDate *now = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    
    
    NSLog(@"%@",[dateFormatter stringFromDate:now]);
    NSLog(@"upto%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"callStartTime"]);
    
    if([[dateFormatter stringFromDate:now] compare:[[NSUserDefaults standardUserDefaults]objectForKey:@"callStartTime"]]==NSOrderedDescending && [[dateFormatter stringFromDate:now] compare:[[NSUserDefaults standardUserDefaults]objectForKey:@"callEndTime"]]==NSOrderedAscending){
        
        if ([self usersToCall]) {
            
            [CallManager.instance callToUsers:self.selectedUsers
                           withConferenceType:conferenceType];
        }

        
    }
    else{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    

    
   }

#pragma mark - Selected users

- (BOOL)usersToCall {
    
    BOOL isOK = (self.selectedUsers.count > 0);
    
    if (!isOK) {
        
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Please select one or more users", nil)];
    }
    
    return isOK;
}

- (void)procUser:(QBUUser *)user {
    
    if (![self.selectedUsers containsObject:user]) {
        
        [self.selectedUsers addObject:user];
    }
    else {
        
        [self.selectedUsers removeObject:user];
    }
}
- (BOOL)textView:(UITextView *)textView
shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
    }
    return YES;
}


-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    reviewTextView.layer.borderColor=[[UIColor clearColor]CGColor];
    reviewTextView.layer.borderWidth= 1.0f;
    
    
}

#pragma mark-Rating Action

-(void)ratingBtnActn{
    
    
    
    if([reviewTextView.text isEqual:@""]){
        
        [reviewTextView resignFirstResponder];
        
        reviewTextView.layer.borderColor=[[UIColor redColor]CGColor];
         reviewTextView.layer.borderWidth= 1.0f;
    }
    
    else{    dispatch_async(dispatch_get_global_queue(0, 0),^{
    
    
            dispatch_async(dispatch_get_main_queue(),^{
                NSError * error ;
                NSURLResponse * urlResponse;
                
                NSURL * postUrl =[NSURL URLWithString:reviewRatingService];
                
                
                NSString * body =[NSString stringWithFormat:@"appointmentId=%@&ratings=%d&review=%@&doctorId=%@&patientId=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"appointmentId" ],ratings,reviewTextView.text,[[NSUserDefaults standardUserDefaults] objectForKey:@"DoctorNowId"],[[NSUserDefaults standardUserDefaults] objectForKey:@"patientid"]];
                
                NSMutableURLRequest * request =[[NSMutableURLRequest alloc]initWithURL:postUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
                [request setHTTPMethod:@"POST"];
                [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
                
                NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
                if (!data) {
                    [SVProgressHUD dismiss];
                    
                    return;
                }
                
                id json =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                
                NSLog(@"json %@",json);
                
                if ([[json objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
                    
                    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Review Submitted" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                    [alertView show];
                    firstRate.image=[UIImage imageNamed:@"star_rating_empty.png"];
                    secRate.image=[UIImage imageNamed:@"star_rating_empty.png"];
                    thirdRate.image=[UIImage imageNamed:@"star_rating_empty.png"];
                    fourthRate.image=[UIImage imageNamed:@"star_rating_empty.png"];
                    fifthRate.image=[UIImage imageNamed:@"star_rating_empty.png"];
                    
                    
                    reviewTextView.text=@"";
                    
                    
                }
                else{
                    
                }
                

    
            });
            
        });
    
   
    }
    
}

-(void)addFavoriteProvider{
    
    NSError *error;
    NSURLResponse * urlResponse;
    
    NSString * urlStr =[NSString stringWithFormat:addFavProviderService];
    NSURL * url =[NSURL URLWithString:urlStr];
    
    NSMutableURLRequest  * request =[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    
    NSString * body =[NSString stringWithFormat:@"userId=%@&doctorId=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"patientid"],[[NSUserDefaults standardUserDefaults] objectForKey:@"DoctorNowId"]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (!data) {
        
        NSLog(@"%@",error);
        //[activityIndicator stopAnimating];
        return;
    }
    id jsonResponse =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    
    
    
    NSLog(@"added to favorite---->%@",jsonResponse);
    
    if ([[jsonResponse objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
        
        
        [starBtn setBackgroundImage:[UIImage imageNamed:@"favorite_selected.png"] forState:UIControlStateNormal];

        
        
        
    
        }
    
    
    
    
    
}

//-(NSString*)fetchdate:(NSString *)dateStr{
//    
//    
//    
//    
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//    
//    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
//    
//    // [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
//    //
//    NSDate *date=[dateFormat dateFromString:dateStr];
//    
//    
//    
//    NSDateFormatter *utc=[[NSDateFormatter alloc]init];
//    //[utc setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
//    [utc setTimeZone:[NSTimeZone localTimeZone]];
//    //  NSString *utcstr=[utc stringFromDate:date];
//    
//    [utc setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    
//    NSString * resultDate =[utc stringFromDate:date];
//    
//    
//    return resultDate;
//    
//}
//
//


@end
