//
//  GetFreeVisitVc.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 11/24/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "GetFreeVisitVc.h"

@interface GetFreeVisitVc ()
{
     CGSize screenRect;
    UIScrollView *myScroll;
    UIView *backPopUp,*letsGetStartedPopUp;
    UIButton *okButton;
    MFMessageComposeViewController *messageController;
}
@end

@implementation GetFreeVisitVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    screenRect=[[UIScreen mainScreen]bounds].size;
    
    
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    titleLable.text =@"Get a Free Visit";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font =[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
[backButton setFrame:CGRectMake(15, 18, 55, 35)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];

    [self createUi];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-Create UI
-(void)createUi{
    myScroll = [[UIScrollView alloc] init];
    myScroll.frame = CGRectMake(0, 55, screenRect.width, screenRect.height);
    
    //  myScroll.contentSize = CGSizeMake(320, screenRect.height+30);
    myScroll.backgroundColor = [UIColor clearColor];
    
    myScroll.showsVerticalScrollIndicator = NO;    // to hide scroll indicators!
    
    
    
    myScroll.scrollEnabled = YES;                 //say "NO" to disable scroll
    
    
    [self.view addSubview:myScroll];
    
    
    UIView  *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, screenRect.width, 130)];
    view.backgroundColor=[UIColor colorWithRed:(CGFloat)198/255 green:(CGFloat)240/255 blue:(CGFloat)70/255 alpha:1];
    [myScroll addSubview:view];
    
    
    
    
    UILabel *shareLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 20, screenRect.width-40, 40)];
    shareLabel.text=@"SHARE YOUR PROMOCODE &\nSAVE";
    shareLabel.textAlignment=NSTextAlignmentCenter;
    shareLabel.numberOfLines=2;
    shareLabel.textColor=[UIColor blackColor];
    shareLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:15];
    [myScroll addSubview:shareLabel];
    
    
    
    
    
    UILabel *promoCode=[[UILabel alloc]initWithFrame:CGRectMake(20, 70, screenRect.width-40, 50)];
    promoCode.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"PromoCode"];
    promoCode.textAlignment=NSTextAlignmentCenter;
    promoCode.textColor=[UIColor blackColor];
    promoCode.font=[UIFont fontWithName:@"GothamRounded-Bold" size:14];
    [myScroll addSubview:promoCode];
    

    
    
    UILabel *suggestion=[[UILabel alloc]initWithFrame:CGRectMake(10, 150, screenRect.width-20, 80)];
    suggestion.text=@"Your friends get their first visit\nFREE!!You get $10 off your next\nvisit for each friend that signs up.\nEarn up to $100 for future visits!";
    suggestion.numberOfLines=6;
    suggestion.textAlignment=NSTextAlignmentCenter;
    suggestion.textColor=[UIColor blackColor];
    suggestion.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];
    
    [myScroll addSubview:suggestion];
    
    
    UIButton *facebookShare=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    facebookShare.frame=CGRectMake(20, 240,50,68);
    
    [facebookShare setBackgroundImage:[UIImage imageNamed:@"share_btn.png"] forState:UIControlStateNormal];
    [facebookShare addTarget:self action:@selector(facebookShare) forControlEvents:UIControlEventTouchUpInside];
    [myScroll addSubview:facebookShare];
    
    
    UIButton *tweetBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    tweetBtn.frame=CGRectMake(screenRect.width/2-70, 240,50,68);
    
    [tweetBtn setBackgroundImage:[UIImage imageNamed:@"tweet_btn.png"] forState:UIControlStateNormal];
    [tweetBtn addTarget:self action:@selector(tweet) forControlEvents:UIControlEventTouchUpInside];
    [myScroll addSubview:tweetBtn];
    
    
    UIButton *email=[UIButton buttonWithType:UIButtonTypeCustom];
    email.frame=CGRectMake(screenRect.width/2+20, 240,50,68);
    
    [email setBackgroundImage:[UIImage imageNamed:@"email_btn.png"] forState:UIControlStateNormal];
    [email addTarget:self action:@selector(email) forControlEvents:UIControlEventTouchUpInside];
    [myScroll addSubview:email];

    
    UIButton *textMsg=[UIButton buttonWithType:UIButtonTypeCustom];
    textMsg.frame=CGRectMake(screenRect.width-70, 240,50,68);
    
    [textMsg setBackgroundImage:[UIImage imageNamed:@"text_btn.png"] forState:UIControlStateNormal];
    [textMsg addTarget:self action:@selector(textMsg) forControlEvents:UIControlEventTouchUpInside];
    [myScroll addSubview:textMsg];

    
  
    
    
    float sizeOfContent = 0;
    UIView *lLast = [myScroll.subviews lastObject];
    NSInteger wd = lLast.frame.origin.y;
    NSInteger ht = lLast.frame.size.height;
    NSInteger offset=30;
    sizeOfContent = wd+ht;
    myScroll.contentSize=CGSizeMake(screenRect.width,sizeOfContent+offset);
    

}
#pragma mark-back BUtton Action
-(void)backAction{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

-(void)facebookShare{
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:[NSString stringWithFormat:@"Try @Ready Doctor-see MDs and Psychologist on your phone or PC.Use my code %@ get 1st visit FREE",[[NSUserDefaults standardUserDefaults]objectForKey:@"PromoCode"]]];
        [self presentViewController:controller animated:YES completion:Nil];
    }
    else
        [self popUp];
       
    
}

-(void)tweet{
  
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:[NSString stringWithFormat:@"Try @Ready Doctor-see MDs and Psychologist on your phone or PC.Use my code %@ get 1st visit FREE",[[NSUserDefaults standardUserDefaults]objectForKey:@"PromoCode"]]];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
        [self popUp];
    

    
}
-(void)email{
    
    if(![MFMailComposeViewController canSendMail]) {
        
        [self popUp];
        
    }
    else{
    
    NSString *emailTitle = @"Ready Doctor Support";
    // Email Content
    NSString *messageBody = [NSString stringWithFormat:@"I thought you would like Ready Doctor-a new app that let's you see a Doctor,Pshychologist and more from your smartphone or computer.I tried it-I loved it!Check out Ready Doctor-See a Doctor,Psychologist and more from your phone or PC.Try it for FREE.Use my Code %@ to get your first Video Visit!",[[NSUserDefaults standardUserDefaults]objectForKey:@"PromoCode"]];
    
    // To address
   // NSArray *toRecipents = [NSArray arrayWithObject:@"support@appcoda.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    //[mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    }
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)textMsg{
    
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    
    //NSArray *recipents = @[@"12345678", @"72345524"];
    NSString *message = [NSString stringWithFormat:@"Try @Ready Doctor-see MDs and Psychologist on your phone.Use my code %@ get 1st visit FREE",[[NSUserDefaults standardUserDefaults]objectForKey:@"PromoCode"]];
messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate=self;
  //  [messageController setRecipients:recipents];
    [messageController setBody:message];
    
    // Present message view controller on screen
    [self presentViewController:messageController animated:YES completion:nil];
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
      [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)popUp{
    
    
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
    header.text=@"OOPS";
    header.numberOfLines=2;
    header.font=[UIFont fontWithName:@"GothamRounded-Medium" size:30];
    header.textColor=[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1];
    header.textAlignment = NSTextAlignmentCenter;
    [letsGetStartedPopUp addSubview:header];
    
    UILabel *information=[[UILabel alloc]init];
    information.frame=  CGRectMake(20,50, letsGetStartedPopUp.frame.size.width-40, 300);
    information.text=@"Go to settings and configure your accounts";
    information.numberOfLines=7;
    information.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    information.textColor=[UIColor blackColor];
    information.textAlignment = NSTextAlignmentCenter;
    [letsGetStartedPopUp addSubview:information];
    
    
    
    
    okButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    okButton.frame=CGRectMake(0,letsGetStartedPopUp.frame.size.height-50,letsGetStartedPopUp.frame.size.width, 50);
    [okButton setTitle:@"OK!" forState:UIControlStateNormal];
    okButton.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    [okButton setBackgroundColor:[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1]];
    [okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okButton addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
    okButton.layer.cornerRadius=6.0f;
    
    [letsGetStartedPopUp addSubview:okButton];
    

}
#pragma mark-OK buttom Action

-(void)okAction{
    
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        letsGetStartedPopUp.frame=CGRectMake(30, 700, self.view.frame.size.width-60, self.view.frame.size.height-60);
        backPopUp.frame = CGRectMake(0,800, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }completion:^(BOOL finished){
        [backPopUp removeFromSuperview];
        
        
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
