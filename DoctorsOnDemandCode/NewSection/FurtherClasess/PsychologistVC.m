//
//  PsychologistVC.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 8/27/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "PsychologistVC.h"
#import "UIImageView+WebCache.h"

@interface PsychologistVC (){
    CGSize screenRect;
    UIScrollView *myScroll;
}

@end

@implementation PsychologistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    screenRect=[[UIScreen mainScreen]bounds].size;
    
    
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    
    if([SingletonClass sharedSingleton].deptId==3){
    titleLable.text =@"Psychologist Bio";
    }
    else if([SingletonClass sharedSingleton].deptId==4){
        titleLable.text=@"Doctor Bio";
    }
    else if ([SingletonClass sharedSingleton].deptId==2){
        titleLable.text=@"Padiactric Bio";
        
    }
    
    else if([SingletonClass sharedSingleton].item==2 ||[SingletonClass sharedSingleton].item==1 ||[SingletonClass sharedSingleton].deptId==1){
         titleLable.text =@"Consultant Bio";
    }
    else
        titleLable.text=@"Favorite";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font =[UIFont fontWithName:@"GothamRounded-Light" size:14];
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
    [backButton setFrame:CGRectMake(15, 18, 55, 35)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
       if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        headerView.frame= CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80);
        titleLable.frame= CGRectMake(60, 25, screenRect.width-120, 35);
        titleLable.font=[UIFont fontWithName:@"GothamRounded-Light" size:26];
        //titleLable.font =[UIFont systemFontOfSize:30];
        [backButton setImage:[UIImage imageNamed:@"back_btn_ipad.png"] forState:UIControlStateNormal];
        [backButton setFrame:CGRectMake(15, 30, 80, 25)];
        
        //        [nextButton setImage:[UIImage imageNamed:@"next_btn-ipad.png"] forState:UIControlStateNormal];
        //        [nextButton setFrame:CGRectMake(screenRect.width-100, 28, 80, 25)];
        //        
    }

    
    [ self createUI];
    

    // Do any additional setup after loading the view.
}
-(void)createUI{
    
    
    
    
    
    myScroll = [[UIScrollView alloc] init];
    myScroll.frame = CGRectMake(0, 55, screenRect.width, screenRect.height);
    

      if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
          myScroll.frame = CGRectMake(0, 80, screenRect.width, screenRect.height);
    

    
          
      myScroll.backgroundColor = [UIColor clearColor];
    
    myScroll.showsVerticalScrollIndicator = NO;    // to hide scroll indicators!
    
    
    
    myScroll.scrollEnabled = YES;
    
   
    
    [self.view addSubview:myScroll];
    


    UILabel *name=[[UILabel alloc]init];
    name.frame=CGRectMake(10, 100, screenRect.width, 40);
    name.textColor=[UIColor blackColor];
    name.font=[UIFont fontWithName:@"GothamRounded-Bold" size:12];
    
    
    int row=[[[NSUserDefaults standardUserDefaults]objectForKey:@"rowNo"]intValue];
    
    
    
    
    
    
    
    
    
    name.text=[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"bio%d",row]];
    [myScroll addSubview:name];
    
    UIImageView*  doctorsImg =[[UIImageView alloc]init];
    doctorsImg.frame = CGRectMake(screenRect.width/2-40, 60, 80, 80);
    doctorsImg.layer.cornerRadius = doctorsImg.frame.size.width/2;
    doctorsImg.clipsToBounds = YES;
    
    
    if([[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"DocPhoto%d",row]]==nil){
        doctorsImg.image = [UIImage imageNamed:@"doctor_img.png"];
    }
    else{
        NSURL *url = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"DocPhoto%d",row]];
        
        // doctorsImg.image = [UIImage imageNamed:@"doctor_img.png"];
        
//        NSData *data = [NSData dataWithContentsOfURL:url];
//        doctorsImg.image = [UIImage imageWithData:data];
        
        [doctorsImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@""]];
        
    }
    
    [self.view addSubview:doctorsImg];
    
    

    UILabel *about=[[UILabel alloc]init];
    int row1=[[[NSUserDefaults standardUserDefaults]objectForKey:@"rowNo"]intValue];

    about.text = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"about%d",row1]];
    
    float heightl=[self calculateHeight:about.text];
    

    
   about.frame=CGRectMake(10, screenRect.width/2, screenRect.width-20, heightl);
    about.numberOfLines=heightl;
    about.textColor=[UIColor blackColor];
 
   
   about.font=[UIFont fontWithName:@"GothamRounded-Light" size:10];
    
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        
        
           doctorsImg.frame = CGRectMake(screenRect.width/2-80, 100, 150, 150);
        name.frame=CGRectMake(10, 180, screenRect.width, 40);
        name.font=[UIFont fontWithName:@"GothamRounded-Bold" size:30];
         about.frame=CGRectMake(10, 240, screenRect.width-20, heightl);
        
        about.font=[UIFont fontWithName:@"GothamRounded-Light" size:25];
        
    }

    
    
    float sizeOfContent = 0;
    UIView *lLast = [myScroll.subviews lastObject];
    NSInteger wd = lLast.frame.origin.y;
    NSInteger ht = lLast.frame.size.height;
    NSInteger offset=50;
    sizeOfContent = wd+ht;
    myScroll.contentSize=CGSizeMake(screenRect.width,sizeOfContent+offset+10);
    
   
          
    
    
    [myScroll addSubview:about];

    
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"OurDoctors"]isEqual:@"ourPhy" ]) {
        
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"pshy"]isEqual:@"ourPhy" ]){
        
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"consultant"]isEqual:@"meetCons" ]){
        
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"Fav"]isEqual:@"yes"]){
        
        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"Fav"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        

    }
    
    
    else{
        
        
        
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(10, screenRect.height-70, screenRect.width-20, 60);
    
    [[button layer] setBorderWidth:0.4f];
    [[button layer] setBorderColor:[UIColor lightGrayColor].CGColor];
    button.layer.cornerRadius=5;
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        if([[[NSUserDefaults standardUserDefaults]objectForKey:@"scheduleMethod"]isEqual:@"byDoc"])
            
            
            
              [button setBackgroundImage:[UIImage imageNamed:@"view_btn.png"] forState:UIControlStateNormal];
        
        else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"scheduleMethod"]isEqual:@"byTime"])
            
        {
            
        [button setBackgroundColor: [UIColor lightGrayColor]];
            
            
            if([SingletonClass sharedSingleton].deptId==3){
               // titleLable.text =@" Bio";
                 [button setTitle:@"Select Psychologist" forState:UIControlStateNormal];
            }
            else if([SingletonClass sharedSingleton].deptId==4){
              //  titleLable.text=@"Doctor Bio";
                [button setTitle:@"Select Doctor" forState:UIControlStateNormal];
            }
            else if ([SingletonClass sharedSingleton].deptId==2){
                 [button setTitle:@"Select Padiactric" forState:UIControlStateNormal];
            }
            else if([SingletonClass sharedSingleton].item==2 ||[SingletonClass sharedSingleton].item==1 ||[SingletonClass sharedSingleton].deptId==1){
             //   titleLable.text =@" Bio";
                 [button setTitle:@"Select Consultant" forState:UIControlStateNormal];
            }

            
            
        
            button.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:15];
         }

        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            button.frame=CGRectMake(10, screenRect.height-100, screenRect.width-20, 90);
             button.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:25];

        }

    
    //[button setBackgroundImage:[UIImage imageNamed:@"view_btn.png"] forState:[UIControlStateNormal]];
    [self.view addSubview:button];
    }
}
-(void)buttonAction{
   
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"scheduleMethod"]isEqual:@"byDoc"])
        
        
    {  AppointmentDurationVC *appointmentDuration=[[AppointmentDurationVC alloc]init];
    [self.navigationController pushViewController:appointmentDuration animated:YES];
    }
    
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"scheduleMethod"]isEqual:@"byTime"])

    {
        PuposeOfVisitView *purposeOfVisitView=[[PuposeOfVisitView  alloc]init];
        [self.navigationController pushViewController:purposeOfVisitView animated:YES];
        
    }
 
    
    
    
}
-(void)backAction{
    
//    ChoosePsychologistVC *choosePVC=[[ChoosePsychologistVC alloc]init];
//    [self.navigationController popToViewController:choosePVC animated:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
   }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-height of string
-(CGFloat)calculateHeight:(NSString *)stringData
{
    UILabel * lblDescription=[[UILabel alloc]init];
   // lblDescription.font=[UIFont systemFontOfSize:10];
    lblDescription.font=[UIFont fontWithName:@"GothamRounded-Light" size:10];
      if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
           lblDescription.font=[UIFont fontWithName:@"GothamRounded-Light" size:25];
    // Create a paragraph style with the desired line break mode
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    // Create the attributes dictionary with the font and paragraph style
    NSDictionary *attributes = @{
                                 NSFontAttributeName:lblDescription.font,
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    
    // Call boundingRectWithSize:options:attributes:context for the string
    CGRect textRect = [stringData boundingRectWithSize:CGSizeMake(self.view.frame.size.width-170,6000)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:attributes
                                               context:nil];
    
    float height = textRect.size.height;
    // NSLog(@"height of row %f",height);
    return height;
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
