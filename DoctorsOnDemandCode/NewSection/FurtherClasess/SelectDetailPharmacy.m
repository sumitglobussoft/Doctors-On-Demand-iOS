//
//  SelectDetailPharmacy.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 10/29/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "SelectDetailPharmacy.h"

@interface SelectDetailPharmacy (){
    CGSize screenRect;
    float height;
    int fontSize,headerBtnfont;
    CGSize windowSize;
    UITableView *pharmacyDetailTbl;
    UIButton *findNwPharmcy;
      UIActivityIndicatorView *activityIndicator;
    NSMutableArray *pharmacyDetailsAr;
    NSMutableArray * resultArr;
    UIView * headerView;
    UIView *backPopUp,*areUsePopUp;
    int pharmacyId;
    BOOL searchPh;
    
}

@end

@implementation SelectDetailPharmacy

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    
    screenRect = [[UIScreen mainScreen] bounds].size;
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    if (UIUserInterfaceIdiomPad ==  UI_USER_INTERFACE_IDIOM()) {
        height = 75;
        fontSize = 25;
        headerBtnfont = 20;
    }
    else{
        fontSize = 8;
        height = 55;
        headerBtnfont = 13;
    }
    resultArr=[[NSMutableArray alloc]init];

    
    windowSize = [UIScreen mainScreen].bounds.size;
    [self activityAction];
        dispatch_async(dispatch_get_global_queue(0, 0),^{
    
                      if([[[NSUserDefaults standardUserDefaults]objectForKey:@"ViewControllerState"] isEqual:@"favoritePhar"])
                      {
                          
                          
//                          [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"ViewControllerState"];
//                          [[NSUserDefaults standardUserDefaults]synchronize];
                          
                       
                          [self fetchFavPharmacy];
                
            }
            else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"ViewControllerState"] isEqual:@"fetchPharamcy"]){
                
                
                
//                [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"ViewControllerState"];
//                [[NSUserDefaults standardUserDefaults]synchronize];
//                

                
                [self searchPharmacy];
            }
            dispatch_async(dispatch_get_main_queue(),^{
    
                   [self createUi];
                [activityIndicator stopAnimating];
            });
            
        });
    
 headerView =[[UIView alloc]init];
    headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55);
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]init];
    titleLable.frame = CGRectMake(60, 25, screenRect.width-120, 25);
    titleLable.text =@"SELECT PHARMACY";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font =[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [headerView addSubview:titleLable];
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad) {
        
        headerView.frame=  CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 75);
        titleLable.frame= CGRectMake(60, 25, [UIScreen mainScreen].bounds.size.width-120, 30);
        titleLable.font =  [UIFont fontWithName:@"GothamRounded-Light" size:26];
       
    }
    

        // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark-createUI

-(void)createUi{
    
    
    
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
 [backButton setFrame:CGRectMake(15, 18, 55, 35)];
    [backButton addTarget:self action:@selector(findNwPharmacy) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
    if(![[[NSUserDefaults standardUserDefaults]objectForKey:@"MYHEALTH"]isEqual:@"yes"]){
        
        UIButton *nextButton =  [UIButton buttonWithType:UIButtonTypeCustom];
        [nextButton setImage:[UIImage imageNamed:@"skip_btn.png"] forState:UIControlStateNormal];
 [nextButton setFrame:CGRectMake(screenRect.width-60, 28, 45, 25)];
        [nextButton addTarget:self action:@selector(skipAction) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:nextButton];
        
        if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad) {
            
            
            [backButton setImage:[UIImage imageNamed:@"back_btn_ipad.png"] forState:UIControlStateNormal];
            [backButton setFrame:CGRectMake(15, 30, 80, 25)];
            
            [nextButton setImage:[UIImage imageNamed:@"next_btn-ipad.png"] forState:UIControlStateNormal];
            [nextButton setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-100, 30, 80, 25)];
        }

        
    }
    

    
    
    
    pharmacyDetailTbl = [[UITableView alloc]init];
    pharmacyDetailTbl.frame =  CGRectMake(0 , 55,screenRect.width,screenRect.height);
    pharmacyDetailTbl.delegate = self;
    pharmacyDetailTbl.dataSource = self;
    pharmacyDetailTbl.backgroundColor =[UIColor cyanColor];
    pharmacyDetailTbl.showsVerticalScrollIndicator = YES;
    pharmacyDetailTbl.backgroundColor=[UIColor clearColor];
    pharmacyDetailTbl.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:pharmacyDetailTbl];
    
    
    UIView *footerView=[[UIView alloc]init];
    footerView.frame=CGRectMake(0, 0, pharmacyDetailTbl.frame.size.width, 120);
    [self.view addSubview:footerView];
    
    findNwPharmcy =  [UIButton buttonWithType:UIButtonTypeRoundedRect];
    findNwPharmcy.frame=CGRectMake(10 ,20, footerView.frame.size.width-20, 40);
    findNwPharmcy.backgroundColor=[UIColor colorWithRed:(CGFloat)252/255 green:(CGFloat)76/255 blue:(CGFloat)117/255 alpha:1];
    findNwPharmcy.layer.cornerRadius=5;
    [findNwPharmcy setTitle:@"Find New Pharmacy" forState:UIControlStateNormal];
    [findNwPharmcy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [findNwPharmcy addTarget:self action:@selector(findNwPharmacy) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView addSubview:findNwPharmcy];

    pharmacyDetailTbl.tableFooterView=footerView;
    
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad) {
        
        
        [backButton setImage:[UIImage imageNamed:@"back_btn_ipad.png"] forState:UIControlStateNormal];
        [backButton setFrame:CGRectMake(15, 30, 80, 25)];
        
         pharmacyDetailTbl.frame =  CGRectMake(0 , 100,screenRect.width,screenRect.height);
        
         findNwPharmcy.frame=CGRectMake(10 ,20, footerView.frame.size.width-20, 80);
        findNwPharmcy.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:25];
        
           }

   
    
}

#pragma mark-TableView Delegates

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return resultArr.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad){
        return   150;
    }
    return 80;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell1 forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    cell1.layer.cornerRadius = 3;
    cell1.clipsToBounds = YES;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell * cell =(CustomTableViewCell*) [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[CustomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PharmacyDetails"];
        cell.backgroundColor = [UIColor clearColor];
        cell.containerView.frame = CGRectMake(10, 5, pharmacyDetailTbl.frame.size.width-20, 80);
        cell.containerView.backgroundColor = [UIColor whiteColor];
        
        cell.containerView.layer.cornerRadius=5;
        
        UILabel *pharmacyName=[UILabel new];
        pharmacyName.frame=CGRectMake(5, 5, cell.containerView.frame.size.width, 30);
        pharmacyName.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
        pharmacyName.textColor=[UIColor blackColor];
        pharmacyName.text=[[resultArr objectAtIndex:indexPath.row] objectForKey:@"pharmacyName"];
        [cell.containerView addSubview:pharmacyName];
        
        
        
        
        
        UILabel *pharmacyNo=[UILabel new];
        pharmacyNo.frame=CGRectMake(5, 20, cell.containerView.frame.size.width, 30);
        pharmacyNo.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
        pharmacyNo.textColor=[UIColor blackColor];
        pharmacyNo.text=[[resultArr objectAtIndex:indexPath.row] objectForKey:@"phoneNumber"];
        [cell.containerView addSubview:pharmacyNo];
        
        
        
        
        UILabel *pharmacyAdd=[UILabel new];
        pharmacyAdd.frame=CGRectMake(5, 35, cell.containerView.frame.size.width, 30);
        pharmacyAdd.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
        pharmacyAdd.textColor=[UIColor blackColor];
        pharmacyAdd.text=[NSString stringWithFormat:@"%@,%@", [[resultArr objectAtIndex:indexPath.row] objectForKey:@"city"],[[resultArr objectAtIndex:indexPath.row] objectForKey:@"country"]];
        [cell.containerView addSubview:pharmacyAdd];

        
        
        if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad){
            pharmacyName.frame=CGRectMake(5, 5, cell.containerView.frame.size.width, 30);
            pharmacyName.font=[UIFont fontWithName:@"GothamRounded-Medium" size:25];
            
            pharmacyNo.frame=CGRectMake(5,50, cell.containerView.frame.size.width, 30);
            pharmacyNo.font=[UIFont fontWithName:@"GothamRounded-Light" size:25];
            
            pharmacyAdd.frame=CGRectMake(5, 100, cell.containerView.frame.size.width, 30);
            pharmacyAdd.font=[UIFont fontWithName:@"GothamRounded-Light" size:25];

        }
        
        
        
           }
    cell.accessoryView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"forward_arrow.png"]];
    
    
    
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad){
        cell.containerView.frame = CGRectMake(10, 5, pharmacyDetailTbl.frame.size.width-20, 150);
    
        

    }

    
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"ViewControllerState"] isEqual:@"fetchPharamcy"]){
        
      
   pharmacyId =    [[[resultArr objectAtIndex:indexPath.row]objectForKey:@"pharmacyId"]intValue];
        
          [self addFavorite];
        
    }

    
//    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"pop"]isEqual:@"fromhealth"]){
//        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"pop"];
//        [[NSUserDefaults standardUserDefaults]synchronize];
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"MYHEALTH"]isEqual:@"yes"]){
        NSArray *array = [self.navigationController viewControllers];
        NSLog(@"array--->%@",array);
        
        
        
        
//        [[NSUserDefaults standardUserDefaults]setObject:nil
//                                                 forKey:@"MYHEALTH"];
//        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.navigationController popToViewController:[array objectAtIndex:3] animated:YES];
        
        
    }
    else{
        [[NSUserDefaults standardUserDefaults]setObject:[[resultArr objectAtIndex:indexPath.row]objectForKey:@"pharmacyId"] forKey:@"pharmacyId"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    PaymentViewController *payment=[[PaymentViewController alloc]init];
    [self.navigationController pushViewController:payment animated:YES];
    }
    
}


#pragma mark-back Button Action/Find new Pharmacy
-(void)findNwPharmacy{
    
    [SingletonClass sharedSingleton].back=1;
  
    searchPh=YES;
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark-Fetch Pharmacy list

-(void)searchPharmacy
{
    
    
                NSError *error;
            NSURLResponse * urlResponse;
            
            NSString * urlStr =[NSString stringWithFormat:searchPharmacyService];
            NSURL * url =[NSURL URLWithString:urlStr];
            
            NSMutableURLRequest  * request =[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
            
            NSString * body =[NSString stringWithFormat:@"pinCode=%@&pharmacyName=%@&pharmacyContactNumber=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"PharmzipCode"],[[NSUserDefaults standardUserDefaults] objectForKey:@"Pharmname"],[[NSUserDefaults standardUserDefaults] objectForKey:@"PharmPh"]];
            
            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            
            
            NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
            if (!data) {
                
                NSLog(@"%@",error);
                [activityIndicator stopAnimating];
                return;
            }
            id jsonResponse =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            
            
            
            
            NSLog(@"Pharmacy update---->%@",jsonResponse);
            
            if ([[jsonResponse objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
                
               
                
                resultArr=[jsonResponse objectForKey:@"data"] ;

                
            }
    
    
    
}


-(void)pushViewCont{
    
    [self.navigationController pushViewController:self animated:YES];
    
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

#pragma mark-Skip Action
-(void)skipAction{

    
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"pharmacyId"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self createPopUp];
    
    
}

#pragma mark-Fetch Pharmacy
-(void)fetchFavPharmacy
{
    
    
    NSError *error;
    NSURLResponse * urlResponse;
    
    NSString * urlStr =[NSString stringWithFormat:fetchFavPharmacyService];
    NSURL * url =[NSURL URLWithString:urlStr];
    
    NSMutableURLRequest  * request =[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    
    NSString * body =[NSString stringWithFormat:@"userId=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"patientid"]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (!data) {
        
        NSLog(@"%@",error);
        [activityIndicator stopAnimating];
        return;
    }
    id jsonResponse =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    
    
    
  //  NSLog(@"Pharmacy favorite---->%@",jsonResponse);
    
    if ([[jsonResponse objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
        
        resultArr=[jsonResponse objectForKey:@"data"] ;

        
        
        
        
    }
    
    
    
    
}
-(void)addFavorite{
    
    NSError *error;
    NSURLResponse * urlResponse;
    
    NSString * urlStr =[NSString stringWithFormat:addPharmacyFavoriteService];
    NSURL * url =[NSURL URLWithString:urlStr];
    
    NSMutableURLRequest  * request =[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    
    NSString * body =[NSString stringWithFormat:@"pharmacyId=%@&userId=%@",[NSString stringWithFormat:@"%d",pharmacyId],[[NSUserDefaults standardUserDefaults] objectForKey:@"patientid"]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (!data) {
        
        NSLog(@"%@",error);
        [activityIndicator stopAnimating];
        return;
    }
    id jsonResponse =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    
    
    
 //   NSLog(@"added to favorite---->%@",jsonResponse);
    
    if ([[jsonResponse objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
        
        NSArray *array = [self.navigationController viewControllers];
        NSLog(@"array--->%@",array);
        
        
        
        
        //        [[NSUserDefaults standardUserDefaults]setObject:nil
        //                                                 forKey:@"MYHEALTH"];
        //        [[NSUserDefaults standardUserDefaults]synchronize];
        
         if([[[NSUserDefaults standardUserDefaults]objectForKey:@"MYHEALTH"]isEqual:@"yes"])
        [self.navigationController popToViewController:[array objectAtIndex:1] animated:YES];
        else
        {
            
        }
        
        
        
        
    }
    

    
    
}

#pragma mark-Create Pop UP

-(void)createPopUp{
    
    backPopUp = [[UIView alloc]initWithFrame:CGRectMake(0, 800, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height)];
    backPopUp.backgroundColor =[UIColor lightGrayColor];
    [self.view addSubview:backPopUp];
    
    areUsePopUp=[[UIView alloc]initWithFrame:CGRectMake(10, 800, self.view.frame.size.width-20, self.view.frame.size.height-20)];
    areUsePopUp.layer.cornerRadius=6.0f;
    areUsePopUp.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:1];
    areUsePopUp.clipsToBounds = YES;
    areUsePopUp.layer.shadowColor = [UIColor blackColor].CGColor;
    areUsePopUp.layer.shadowOffset = CGSizeMake(-2, 2);
    areUsePopUp.layer.shadowOpacity = 3;
    areUsePopUp.layer.shadowRadius = 15;
    areUsePopUp.layer.shadowPath = [UIBezierPath bezierPathWithRect:areUsePopUp.bounds].CGPath;
    
    [backPopUp addSubview:areUsePopUp];
    UILabel *header=[[UILabel alloc]initWithFrame:CGRectMake(0,0,  self.view.frame.size.width-60-5, 150)];
    header.text=@"ARE YOU\nSURE";
    header.numberOfLines=3;
    header.textAlignment=NSTextAlignmentCenter;
  header.font=[UIFont fontWithName:@"GothamRounded-Medium" size:30];
    header.textColor=[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1];
    [areUsePopUp addSubview:header];
    
    [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        areUsePopUp.frame=CGRectMake(30, 60, self.view.frame.size.width-60, self.view.frame.size.height-110);
        backPopUp.frame=CGRectMake(00, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
    }completion:nil];
    
    
    
    UILabel *information=[[UILabel alloc]initWithFrame:CGRectMake(0,70,  self.view.frame.size.width-60-5, 300)];
    information.text=@"If you're sure you don't\nneed a prescription,you\ncan skip.\n\nOtherwise you'll maximize\nyour call time by selecting a pharmacy now.";
    information.numberOfLines=12;
    information.textAlignment=NSTextAlignmentCenter;
  information.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];    information.textColor=[UIColor blackColor];
    [areUsePopUp addSubview:information];
    
    
    UIButton * skip=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    skip.frame=CGRectMake(0, areUsePopUp.frame.size.height-50,areUsePopUp.frame.size.width/2, 50);
    [skip setTitle:@"Skip" forState:UIControlStateNormal];
    [skip setBackgroundColor:[UIColor grayColor]];
    skip.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    [skip setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [skip addTarget:self action:@selector(skipAtn) forControlEvents:UIControlEventTouchUpInside];
    [areUsePopUp addSubview:skip];
    
    
    UIButton * goSelect=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    goSelect.frame=CGRectMake(areUsePopUp.frame.size.width/2, areUsePopUp.frame.size.height-50,areUsePopUp.frame.size.width/2, 50);
    [goSelect setTitle:@"Go Select" forState:UIControlStateNormal];
    [goSelect setBackgroundColor:[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1]];
    goSelect.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    [goSelect setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [goSelect addTarget:self action:@selector(goSelectActn) forControlEvents:UIControlEventTouchUpInside];
    [areUsePopUp addSubview:goSelect];
    if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()) {
        header.font=[UIFont  fontWithName:@"GothamRounded-Medium" size:50];
        header.frame= CGRectMake(00,0,  areUsePopUp.frame.size.width, 200);
        information.frame= CGRectMake(0,250,  areUsePopUp.frame.size.width, 300);
        information.font = [UIFont fontWithName:@"GothamRounded-Medium" size:30];
        
        
        goSelect.frame=CGRectMake(areUsePopUp.frame.size.width/2, areUsePopUp.frame.size.height-80,areUsePopUp.frame.size.width/2, 80);
        goSelect.titleLabel.font = [UIFont fontWithName:@"GothamRounded-Medium" size:25];
        
        skip.frame=CGRectMake(0, areUsePopUp.frame.size.height-80,areUsePopUp.frame.size.width/2, 80);
        skip.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:25];
        
    }

    
    
}

#pragma mark-popUp Button Skip/Go select Action
-(void)goSelectActn{
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        
        areUsePopUp.frame=CGRectMake(30, 2000, self.view.frame.size.width-60, self.view.frame.size.height-60);
        backPopUp.frame = CGRectMake(0,2000, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }completion:^(BOOL finished){
        
    }];
    
    
}
-(void)skipAtn{
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        
        areUsePopUp.frame=CGRectMake(30, 2000, self.view.frame.size.width-60, self.view.frame.size.height-60);
        backPopUp.frame = CGRectMake(0,2000, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }completion:^(BOOL finished){
        
    }];
    PaymentViewController *payment=[PaymentViewController new];
    [self.navigationController pushViewController:payment animated:YES];
    
    
}



@end
