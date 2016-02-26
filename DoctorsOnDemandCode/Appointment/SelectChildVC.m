//
//  SelectChildVC.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 9/18/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "SelectChildVC.h"

@interface SelectChildVC (){
    CGSize screenRect;
    UITableView *selectChildTableView;
    UITableViewCell *cell;
    int numberOfRows;
 UIActivityIndicatorView *activityIndicator;
    NSMutableDictionary *jasonDict;
    
}


@end

@implementation SelectChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    screenRect=[[UIScreen mainScreen]bounds].size;
     [self activityAction];
    dispatch_async(dispatch_get_global_queue(0, 0),^{
        
       
        [self fetchChild];
        dispatch_async(dispatch_get_main_queue(),^{
            [self createUi];
            [activityIndicator stopAnimating]; 
        });
        
       
    });

    jasonDict=[[NSMutableDictionary alloc]init];
    numberOfRows=1;
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, screenRect.width-120, 25)];
    titleLable.text =@"Select Child";
    titleLable.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];
    titleLable.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
    [backButton setFrame:CGRectMake(15, 18, 55, 35)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
   
    if (UIUserInterfaceIdiomPad== UI_USER_INTERFACE_IDIOM()) {
        
        headerView.frame= CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80);
        
        [backButton setImage:[UIImage imageNamed:@"back_btn_ipad.png"] forState:UIControlStateNormal];
        [backButton setFrame:CGRectMake(15, 30, 80, 30)];
        
//                titleLable.frame= CGRectMake(60, 25, screenRect.width-120, 35);
//                titleLable.font =[UIFont boldSystemFontOfSize:25];
        titleLable.frame= CGRectMake(60, 25, screenRect.width-120, 35);
        titleLable.font=[UIFont fontWithName:@"GothamRounded-Light" size:30];
    }

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)createUi{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20, 80, screenRect.width, 40)];
    label.numberOfLines=2;
    label.text=@"Please tell us some basic info to\ncomplete your profile:";
    label.font=[UIFont fontWithName:@"GothamRounded-Medium" size:14];
    label.textColor=[UIColor blackColor];
    
    [self.view addSubview:label];
    
     UIButton *addButton =  [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    if(jasonDict.count!=0){
        selectChildTableView=[[UITableView alloc]init];
        selectChildTableView.frame=CGRectMake(10, 135 ,screenRect.width-20,200+(numberOfRows*60));
        selectChildTableView.backgroundColor=[UIColor clearColor];
        
        
        selectChildTableView.delegate=self;
        selectChildTableView.dataSource=self;
        [self.view addSubview:selectChildTableView];

   
    addButton.frame=CGRectMake(0, selectChildTableView.frame.size.height-100, selectChildTableView.frame.size.width, 60.0);
    
    [addButton addTarget:self action:@selector(addChildActn) forControlEvents:UIControlEventTouchUpInside];
    
    [addButton setBackgroundImage:[UIImage imageNamed:@"add_child.png"] forState:UIControlStateNormal];
    selectChildTableView.tableFooterView=addButton;
    }
    
    else{
        
       
        
        
       
        addButton.frame=CGRectMake(10,140, screenRect.width-20, 60.0);
        
        
        
        [addButton setBackgroundImage:[UIImage imageNamed:@"add_child.png"] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addChildActn) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:addButton];
    }

    
    //---------comment--------------------------------
  
    if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()) {
        label.frame=CGRectMake(30,100, screenRect.width, 100);
        label.font = [UIFont boldSystemFontOfSize:30];
        selectChildTableView.frame=CGRectMake(10,250 ,screenRect.width-20,screenRect.height-400);
        addButton.frame=CGRectMake(0, selectChildTableView.frame.size.height-100, screenRect.width-20, 100);
        [addButton setBackgroundImage:[UIImage imageNamed:@"addallergy_btn_ipad.png"] forState:UIControlStateNormal];
        
    }
    
    //---------comment--------------------------------
    
    
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell1 forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    

    cell1.layer.cornerRadius = 3;
    cell1.clipsToBounds = YES;
    
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
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    
         cell.backgroundColor = [UIColor whiteColor];
    
        cell.textLabel.text = [[jasonDict objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]]objectForKey:@"firstName"];
    cell.textLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:14];
    cell.accessoryView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"forward_arrow.png"]];
      if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad){
          
          
            cell.textLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:25];
      }
    
    
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    NSLog(@"section>>>>>>%ld",(long)indexPath.section);
    
    
    SelectPharmacyVC *pharmacy=[[SelectPharmacyVC alloc]init];
    [self.navigationController pushViewController:pharmacy animated:YES];
    
//    
    [[NSUserDefaults standardUserDefaults]setObject:[[jasonDict objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]]objectForKey:@"id"]  forKey:@"childId"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [jasonDict count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
- (CGFloat)tableView:(UITableView*)tableView
heightForFooterInSection:(NSInteger)section {
    return 5.0;
}


#pragma mark-Add child Button Action
-(void)addChildActn{
    YourChildVC *yourChild=[[YourChildVC alloc]init];
    [self.navigationController pushViewController:yourChild animated:YES];
}
#pragma mark-fetch child
-(void)fetchChild{
    NSError * error;
    NSURLResponse *  urlResponse;
    
    
    NSURL * postUrl =[NSURL URLWithString:fetchChildService];
    
    
    
    
    NSMutableURLRequest * request =[[NSMutableURLRequest alloc]initWithURL:postUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    
    NSString * body =[NSString stringWithFormat:@"patient_id=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"patientid"]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    if (!data) {
        NSLog(@"error...%@",error);
     
        [activityIndicator stopAnimating];
        return;
    }
    
    id json =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"json %@",json);
    if ([[json objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
        
        NSArray *arr=[json objectForKey:@"data"];
        for (int i=0; i<arr.count; i++) {
            [jasonDict setObject:[arr objectAtIndex:i] forKey:[NSString stringWithFormat:@"%d",i]];
        }
    }
    
    

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
