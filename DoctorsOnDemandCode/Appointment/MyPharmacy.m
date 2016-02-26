//
//  MyPharmacy.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 10/30/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "MyPharmacy.h"


@interface MyPharmacy (){
    UIActivityIndicatorView *activityIndicator;
    CGSize screenRect;
    float height;
    int fontSize,headerBtnfont;
    CGSize windowSize;
    UITableView * favPharmacyTbl;
    UIButton *editBtn,*addPharmacyBtn,*minusBtn;
    BOOL editPress;
    CustomTableViewCell * cell;
    NSMutableArray* resultArr,*duplicateAr;
    
}

@end

@implementation MyPharmacy
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self activityAction];
    editPress=NO;
    resultArr=[[NSMutableArray alloc]init];
    duplicateAr=[[NSMutableArray alloc]init];
    dispatch_async(dispatch_get_global_queue(0, 0),^{
        
            [self fetchFavPharmacy];
        dispatch_async(dispatch_get_main_queue(),^{
            
            [self createUI];
            
            
            [activityIndicator stopAnimating];
        });
        
    });
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:(BOOL)animated];
    resultArr=nil;
    duplicateAr=nil;
    [favPharmacyTbl removeFromSuperview];
    [addPharmacyBtn removeFromSuperview];
    // Call the super class implementation.
  }



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
    
    windowSize = [UIScreen mainScreen].bounds.size;
    
    
    
    
    
    
    UIView * headerView =[[UIView alloc]init];
    headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55);
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]init];
    titleLable.frame = CGRectMake(60, 25, screenRect.width-120, 25);
    titleLable.text =@"My Pharmacies";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font =[UIFont fontWithName:@"GothamRounded-Light" size:14];
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
   [backButton setFrame:CGRectMake(15, 18, 55, 35)];
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
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

#pragma mark-Back Action
-(void)backButtonAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark-Create UI
-(void)createUI{
    
    favPharmacyTbl = [[UITableView alloc]init];
    favPharmacyTbl.frame =  CGRectMake(0 , 55,screenRect.width,screenRect.height);
    favPharmacyTbl.delegate = self;
    favPharmacyTbl.dataSource = self;
    favPharmacyTbl.backgroundColor =[UIColor cyanColor];
    favPharmacyTbl.showsVerticalScrollIndicator = YES;
    favPharmacyTbl.backgroundColor=[UIColor clearColor];
    favPharmacyTbl.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:favPharmacyTbl];
    
    
    
    if(resultArr.count!=0){
    UIView *footerView=[[UIView alloc]init];
    footerView.frame=CGRectMake(0, 0, favPharmacyTbl.frame.size.width, 70);
    [self.view addSubview:footerView];
    
    addPharmacyBtn =  [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addPharmacyBtn.frame=CGRectMake(10 ,20, footerView.frame.size.width-20, 60);
    [addPharmacyBtn setBackgroundImage:[UIImage imageNamed:@"add_pharmacy.png"] forState:UIControlStateNormal];

    [addPharmacyBtn addTarget:self action:@selector(addPharmacyActn) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView addSubview:addPharmacyBtn];
    
    favPharmacyTbl.tableFooterView=footerView;
    }
    
    else{
        addPharmacyBtn =  [UIButton buttonWithType:UIButtonTypeRoundedRect];
        addPharmacyBtn.frame=CGRectMake(10, 65, screenRect.width-20, 60.0);
        
        
        
        [addPharmacyBtn setBackgroundImage:[UIImage imageNamed:@"add_pharmacy.png"] forState:UIControlStateNormal];
        [addPharmacyBtn addTarget:self action:@selector(addPharmacyActn) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:addPharmacyBtn];

    }
    

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark-TableView Delegates

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return resultArr.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 110;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell1 forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    cell1.layer.cornerRadius = 3;
    cell1.clipsToBounds = YES;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell =(CustomTableViewCell*) [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
       cell = [[CustomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PharmacyDetails"];
        cell.backgroundColor = [UIColor clearColor];
            
        cell.containerView.frame = CGRectMake(10, 10, favPharmacyTbl.frame.size.width-20, 80);
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
        
        
    }
    cell.accessoryView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"forward_arrow.png"]];
    
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    


}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        return  UITableViewCellEditingStyleDelete;
}



-(void)tableView: (UITableView *)tableView commitEditingStyle: (UITableViewCellEditingStyle)editingStyle forRowAtIndexPath: (NSIndexPath *)indexPath

{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
        [self deleteFavPharma:indexPath.row];
        
        
        
        
        [resultArr removeObjectAtIndex:indexPath.row];
        
        [favPharmacyTbl reloadData];
        
    }
    
    
}



#pragma mark-Delete Favorite Action
-(void)deleteFavorite{
    
   
    
    
}



#pragma mark-Edit Action

-(void)editAction{
    
    if(editPress==NO){
        editPress=YES;
        
   
         [favPharmacyTbl setEditing:YES animated:YES];
        
         [editBtn setTitle:@"Done" forState:UIControlStateNormal];
    }
    else{
        editPress=NO;
      
         [favPharmacyTbl setEditing:NO animated:YES];
        [editBtn setTitle:@"Edit" forState:UIControlStateNormal];
    }
   
    
    
    
    
}

#pragma mark-Add Pharmacy Action

-(void)addPharmacyActn{
    
    [SingletonClass sharedSingleton].back=1;
    
//       [[NSUserDefaults standardUserDefaults]setObject:@"fromhealth" forKey:@"pop"];
//    [[NSUserDefaults standardUserDefaults]synchronize];
    
    SelectPharmacyVC *selectPharma=[[SelectPharmacyVC alloc]init];
    [self.navigationController pushViewController:selectPharma animated:YES];
    
    
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
#pragma mark-Fetch Favorite Pharmacy list

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
    
    
    
    
    NSLog(@"Pharmacy favorite---->%@",jsonResponse);
    
    if ([[jsonResponse objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
        
        NSArray *ar=[jsonResponse objectForKey:@"data"];
        for (int i=0; i<ar.count; i++) {
            [resultArr addObject:[ar objectAtIndex:i]];
            [duplicateAr addObject:[ar objectAtIndex:i]];
        }
      //  resultArr=[jsonResponse objectForKey:@"data"] ;

        
        
    }
    
    
    
    
}

#pragma mark-Delete Favorite Pharmacy Service
-(void)deleteFavPharma:(long)index{
    
    [self activityAction];
    
    dispatch_async(dispatch_get_global_queue(0, 0),^{
        
       
        dispatch_async(dispatch_get_main_queue(),^{
            
            
            NSError *error;
            NSURLResponse * urlResponse;
            
            NSString * urlStr =[NSString stringWithFormat:deleteFavoritePharmacyService];
            NSURL * url =[NSURL URLWithString:urlStr];
            
            NSMutableURLRequest  * request =[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
            
            NSString * body =[NSString stringWithFormat:@"favPharmacyId=%@",[[duplicateAr objectAtIndex:index]objectForKey:@"favouritePharmacyId"]];
            
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
        });
        
    });
    
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
