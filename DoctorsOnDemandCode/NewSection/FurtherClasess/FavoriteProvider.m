//
//  FavoriteProvider.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 12/17/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "FavoriteProvider.h"
#import "Visit History.h"
#import "CustomTableViewCell.h"
#import "PsychologistVC.h"

@interface FavoriteProvider (){
  UIActivityIndicatorView *spinner;
        CGSize screenRect;
     //   UIView *backPopUp;
        UITableView *psychologistTableView;
        NSMutableArray *jsonArray,*duplicateAr;
        UIActivityIndicatorView *activityIndicator;
    int ofset;
    UIButton *editBtn;
    BOOL response;
    BOOL editPress;
   

}
@property (nonatomic) BOOL noMoreResultsAvail;
 @property (nonatomic) BOOL loading;
@end

@implementation FavoriteProvider
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self activityAction];
    editPress=NO;
    jsonArray=[[NSMutableArray alloc]init];
    duplicateAr=[[NSMutableArray alloc]init];

    editPress=NO;
    ofset=0;
    dispatch_async(dispatch_get_global_queue(0, 0),^{
        
        
        
        [self fetchPshycology];
        dispatch_async(dispatch_get_main_queue(),^{
            if (response==YES)
            [self createUI];
            else
                [self noProvider];
            [activityIndicator stopAnimating];
        });
        
    });
    
    
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:(BOOL)animated];
    jsonArray=nil;
    duplicateAr=nil;
    [psychologistTableView removeFromSuperview];
    
    // Call the super class implementation.
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    screenRect=[[UIScreen mainScreen]bounds].size;
       self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    
    
    
   
        titleLable.text=@"Favorite Provider";
    
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font =[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
   [backButton setFrame:CGRectMake(15, 18, 55, 35)];    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
    
    editBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    editBtn.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-60, 25,50,25);
    editBtn.backgroundColor =[UIColor clearColor];
    [editBtn setTitleColor:[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)30/255 blue:(CGFloat)49/255 alpha:(CGFloat)1] forState:UIControlStateNormal];
    editBtn.titleLabel.font =[UIFont systemFontOfSize:12];
    [editBtn setTitle:@"Edit" forState:UIControlStateNormal];
    
    
    [editBtn addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:editBtn];
    


    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


/**@desc creating UI
 */
-(void)createUI{
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
    psychologistTableView=[[UITableView alloc]init];
    psychologistTableView.frame=CGRectMake(0, 50 ,screenRect.width,screenRect.height-70);
    psychologistTableView.backgroundColor=[UIColor clearColor];
    
    psychologistTableView.delegate=self;
    psychologistTableView.dataSource=self;
    psychologistTableView.showsVerticalScrollIndicator = NO;
    psychologistTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:psychologistTableView];
    
    
    
    
    
    
}

-(void)editAction{
    
    if(editPress==NO){
        editPress=YES;
        
        
        [psychologistTableView setEditing:YES animated:YES];
        
        [editBtn setTitle:@"Done" forState:UIControlStateNormal];
    }
    else{
        editPress=NO;
        
        [psychologistTableView setEditing:NO animated:YES];
        [editBtn setTitle:@"Edit" forState:UIControlStateNormal];
    }
    
    
    
    
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  UITableViewCellEditingStyleDelete;
}



-(void)tableView: (UITableView *)tableView commitEditingStyle: (UITableViewCellEditingStyle)editingStyle forRowAtIndexPath: (NSIndexPath *)indexPath

{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
[self deleteFavProvider:indexPath.row];
//        
//        
//        
//        
       [jsonArray removeObjectAtIndex:indexPath.row];
        
        [psychologistTableView reloadData];
        
    }
    
    
}
#pragma UIScrollView Method::
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
     CGSize windowSize =[UIScreen  mainScreen].bounds.size;
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    //spinner.backgroundColor=[UIColor grayColor];
    spinner.frame = CGRectMake(windowSize.width/2-20, windowSize.height/2-55,40 ,40);
    spinner.color=[UIColor blackColor];
    [psychologistTableView addSubview:spinner];
   
        //[activityIndicator startAnimating];
    [spinner startAnimating];

    
    if (!self.loading) {
        float endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (endScrolling >= scrollView.contentSize.height)
        {
            
            [self performSelector:@selector(loadDataDelayed) withObject:nil afterDelay:1];
            
        }
    }
}

#pragma UserDefined Method for generating data which are show in Table :::
-(void)loadDataDelayed{
    
    
    [activityIndicator startAnimating];
    //NSMutableArray *array = [[NSMutableArray alloc]init];
    
    ofset=ofset+1;
    [self fetchPshycology];
    
    
    [activityIndicator stopAnimating];
    
    //[self.tableView reloadData];
    // [self performSelector:nil withObject:nil afterDelay:2];
    
}


-(UITableViewCell *)tableView:(UITableView * )tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    CustomTableViewCell * cell =(CustomTableViewCell*) [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        
        cell = [[CustomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"pshychologist"];
        cell.backgroundColor = [UIColor clearColor];
        
        //int stringHeight=[self calculateHeight:[[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"doctorAbout"]];
        
        cell.containerView.frame = CGRectMake(0, 5, psychologistTableView.frame.size.width, 100);
        cell.containerView.backgroundColor = [UIColor whiteColor];
        cell.containerView.layer.shadowColor = [UIColor blackColor].CGColor;
        cell.containerView.layer.shadowOffset = CGSizeMake(0, 0);
        cell.containerView.layer.shadowOpacity = 0.5;
        cell.containerView.layer.shadowRadius = 1;
        cell.containerView.layer.shadowPath = [UIBezierPath bezierPathWithRect:cell.containerView.bounds].CGPath;
        
        
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
        if (jsonArray.count != 0) {
            if(indexPath.row <[jsonArray count]){
                // cell.pharmacyName.text
                NSString *fName=[[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"FirstName"];
                NSString *lName=[[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"LastName"];
                
                
                cell.pharmacyName.text=[NSString stringWithFormat:@"%@ %@",fName,lName];
                
                
                [[NSUserDefaults standardUserDefaults]setObject:cell.pharmacyName.text   forKey:[NSString stringWithFormat:@"bio%ld",(long)indexPath.row]];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                
                if([[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"doctorAbout"]!=[NSNull null]){
                    cell.pharmacyPhNo.text=[[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"doctorAbout"];
                    
                }
                
                
                
                
                
                
                [[NSUserDefaults standardUserDefaults]setObject:cell.pharmacyPhNo.text   forKey:[NSString stringWithFormat:@"about%ld",(long)indexPath.row]];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                
                if([[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"doctorProfilePicUrl"] !=[NSNull null]){
                    [[NSUserDefaults standardUserDefaults]setObject:[[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"doctorProfilePicUrl"]   forKey:[NSString stringWithFormat:@"DocPhoto%ld",(long)indexPath.row]];
                    
                    [[NSUserDefaults standardUserDefaults]synchronize];
                }
                else{
                    [[NSUserDefaults standardUserDefaults]setObject:nil   forKey:[NSString stringWithFormat:@"DocPhoto%ld",(long)indexPath.row]];
                    
                    
                }
                
                
//                cell.pharmacyName.font =[UIFont fontWithName:@"GothamRounded-Bold" size:12];
//                
//                cell.pharmacyPhNo.font =[UIFont fontWithName:@"GothamRounded-Light" size:10];
                
                
                [spinner stopAnimating];

            }
            else{
                if (!self.noMoreResultsAvail) {
                    //spinner.hidden =NO;
                   // cell..textLabel.text=nil;
                                  }
                else{
                    [spinner stopAnimating];
                    spinner.hidden=YES;
                    
                    //cell.textLabel.text=nil;
                    
//                    UILabel* loadingLabel = [[UILabel alloc]init];
//                    loadingLabel.font=[UIFont boldSystemFontOfSize:14.0f];
//                    loadingLabel.textAlignment = UITextAlignmentLeft;
//                    loadingLabel.textColor = [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0];
//                    loadingLabel.numberOfLines = 0;
//                    loadingLabel.text=@"No More Providers";
//                    loadingLabel.frame=CGRectMake(85,20, 302,25);
//                    [cell addSubview:loadingLabel];
                }
                
            }

        
        
               //-----------comment---------------------------------------------------
        /*  if (UIUserInterfaceIdiomPad ==  UI_USER_INTERFACE_IDIOM()) {
         
         cell.containerView.frame = CGRectMake(0, 5, psychologistTableView.frame.size.width, 90);
         
         cell.pharmacyName.frame=CGRectMake(7, 5, 150, cell.containerView.frame.size.height);
         cell.pharmacyPhNo.frame=CGRectMake(pharmacyAppTbl.frame.size.width/2-150, 5, 120, cell.containerView.frame.size.height);
         cell.pharmacyCity.frame=CGRectMake(pharmacyAppTbl.frame.size.width/2-10, 5, 120, cell.containerView.frame.size.height);
         cell.pharmacyCountry.frame=CGRectMake(pharmacyAppTbl.frame.size.width/2+180, 5,pharmacyAppTbl.frame.size.width-(pharmacyAppTbl.frame.size.width/2+80), cell.containerView.frame.size.height);
         
         cell.pharmacyName.font =[UIFont fontWithName:@"GothamRounded-Medium" size:20];
         cell.pharmacyPhNo.font =[UIFont fontWithName:@"GothamRounded-Medium" size:20];
         cell.pharmacyCity.font =[UIFont fontWithName:@"GothamRounded-Medium" size:20];
         cell.pharmacyCountry.font =[UIFont fontWithName:@"GothamRounded-Medium" size:20];
         
         cell.leftColorView.frame = CGRectMake(0, 1,5,cell.containerView.frame.size.height-1);
         }*/
        //-----------comment---------------------------------------------------
        
        }
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"row no-->%ld",(long)indexPath.row);
    
    
    [[NSUserDefaults standardUserDefaults]setInteger:indexPath.row   forKey:@"rowNo"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    [[NSUserDefaults standardUserDefaults]setValue:[[jsonArray objectAtIndex:indexPath.row ]objectForKey:@"doctor_id"] forKey:@"doctorid" ];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
    [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"Fav"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
    
    PsychologistVC *psychologist=[[PsychologistVC alloc]init];
    
    
    [self.navigationController pushViewController:psychologist animated:YES];
    
    
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([ jsonArray count] ==0){
        return 0;
    }
    else {
       
        return [jsonArray count];
    }

   // return jsonArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //float stringHeight=[self calculateHeight:[[jsonArray  objectAtIndex:indexPath.row]objectForKey:@"doctorAbout"]];
    return 100;
    
}
-(void)fetchPshycology{
    NSError * error ;
    NSURLResponse * urlResponse;
    
    NSURL * postUrl =[NSURL URLWithString:fecthFavProviderService];
    
    
    NSString* body =[NSString stringWithFormat:@"userId=%@&offset=%d&limit=2",[[NSUserDefaults standardUserDefaults] objectForKey:@"patientid"],ofset];
    
    
    
    
    NSMutableURLRequest * request =[[NSMutableURLRequest alloc]initWithURL:postUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
    
    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (!data) {
        
        [activityIndicator stopAnimating];
        return;
    }
    
    id json =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    NSLog(@"json %@",json);
    if ([[json objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
        response=YES;
        
        NSArray * arr =[json objectForKey:@"data"];
        for (int i=0; i<arr.count; i++) {
            [jsonArray addObject:[arr objectAtIndex:i]];
              [duplicateAr addObject:[arr objectAtIndex:i]];
        }
        
        
        [psychologistTableView reloadData];
        
    }
    else
    {
        response=NO;
        [activityIndicator stopAnimating];
        activityIndicator.hidden=YES;
        [spinner stopAnimating];
    }
    
    
    
    
    
}



#pragma mark-Delete Favorite Pharmacy Service
-(void)deleteFavProvider:(long)index{
    
    [self activityAction];
    
    dispatch_async(dispatch_get_global_queue(0, 0),^{
        
        
        dispatch_async(dispatch_get_main_queue(),^{
            
            
            NSError *error;
            NSURLResponse * urlResponse;
            
            NSString * urlStr =[NSString stringWithFormat:deleteFavProviderService];
            NSURL * url =[NSURL URLWithString:urlStr];
            
            NSMutableURLRequest  * request =[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
            
            NSString * body =[NSString stringWithFormat:@"userId=%@&favouritesId=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"patientid"],[[duplicateAr objectAtIndex:index]objectForKey:@"favouritesId"]];
            
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
            
            
            NSLog(@"Delete pharem--%@",jsonResponse);
            
            
            if ([[jsonResponse objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
                
                
                
                
            }
            
            
            
            
            
            [activityIndicator stopAnimating];
            [spinner stopAnimating];
        });
        
    });
    
}





#pragma mark-Activity Indicator
-(void)activityAction{
    CGSize windowSize =[UIScreen  mainScreen].bounds.size;
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.frame = CGRectMake(windowSize.width/2-20, windowSize.height/2-55,40 ,40);
    activityIndicator.color = [UIColor blackColor];
    activityIndicator.alpha = 1;
    [self.view addSubview:activityIndicator];
    //[self placeSearchbaseId];
    
    [activityIndicator startAnimating];
    
    
}
#pragma mark-create no appointment

-(void)noProvider{
    
    
    UILabel *noneShedule=[[UILabel alloc]initWithFrame:CGRectMake(0,70, screenRect.width, 30)];
    noneShedule.textAlignment=NSTextAlignmentCenter;
    noneShedule.text=@"No Favorite Providers";
    noneShedule.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
    noneShedule.textColor=[UIColor blackColor];
    [self.view addSubview:noneShedule];
    
    
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
