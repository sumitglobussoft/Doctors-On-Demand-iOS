//
//  SelectPharmacyVC.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 9/25/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "SelectPharmacyVC.h"

@interface SelectPharmacyVC ()
{
   
        CGSize screenRect;
        float height;
        int fontSize,headerBtnfont;
        CGSize windowSize;
        UITableView * pharmacyAppTbl;
    
    NSString * pharmacyno;
     UIScrollView *myScroll;
    UITextField *zipCodeTxtFld,*nameTxtFld,*phTextFld;
    BOOL isShowClicked;
    UIButton *shwFilterBtn;
    NSArray *tableArray;
    UIButton *scheduleAppButton,*searchNearMe;
    UIActivityIndicatorView *activityIndicator;
    int selectedIndex,hourSelectedIndex;
    UIView *backPopUp,*areUsePopUp;
}

@end

@implementation SelectPharmacyVC


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self activityAction];
  
    dispatch_async(dispatch_get_global_queue(0, 0),^{
        
        if([SingletonClass sharedSingleton].back==0)
        [self fetchFavPharmacy];
        dispatch_async(dispatch_get_main_queue(),^{
            
            [self createUI];
            
            
            [activityIndicator stopAnimating];
        });
        
    });
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:(BOOL)animated];    // Call the super class implementation.
    
    [pharmacyAppTbl removeFromSuperview];
    [activityIndicator removeFromSuperview];
    [myScroll removeFromSuperview];
    
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
    titleLable.text =@"SELECT PHARMACY";
    titleLable.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    titleLable.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:titleLable];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
    [backButton setFrame:CGRectMake(15, 18, 55, 35)];
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
  if(![[[NSUserDefaults standardUserDefaults]objectForKey:@"MYHEALTH"]isEqual:@"yes"]){
    UIButton *skipButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [skipButton setImage:[UIImage imageNamed:@"skip_btn.png"] forState:UIControlStateNormal];
   [skipButton setFrame:CGRectMake(screenRect.width-60, 28, 50, 20)];
    [skipButton addTarget:self action:@selector(skipButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:skipButton];
      if (UIUserInterfaceIdiomPad ==  UI_USER_INTERFACE_IDIOM()){
      [skipButton setImage:[UIImage imageNamed:@"skip_btn_ipad.png"] forState:UIControlStateNormal];
      [skipButton setFrame:CGRectMake(screenRect.width-100, 28, 80, 25)];
      }
      
      
    }
 
    if (UIUserInterfaceIdiomPad ==  UI_USER_INTERFACE_IDIOM()) {
        headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 75);
        
        titleLable.frame = CGRectMake(60, 25, screenRect.width-120, 25);
        titleLable.font=[UIFont fontWithName:@"GothamRounded-Light" size:26];
        
        [backButton setImage:[UIImage imageNamed:@"back_btn_ipad.png"] forState:UIControlStateNormal];
        [backButton setFrame:CGRectMake(15, 30, 80, 25)];
        
        
       
        
        
    }

    //[self createUI];
        // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- create UI


-(void)createUI{
    
    isShowClicked=NO;
    
    myScroll = [[UIScrollView alloc] init];
    myScroll.frame = CGRectMake(0,55, screenRect.width, screenRect.height);
    
        myScroll.backgroundColor = [UIColor clearColor];
    
    myScroll.showsVerticalScrollIndicator = NO;    // to hide scroll indicators!
    
    
    
    myScroll.scrollEnabled = YES;                 //say "NO" to disable scroll
    
    
    [self.view addSubview:myScroll];//adding to parent view!
    
    searchNearMe =[[UIButton alloc]initWithFrame:CGRectMake(10,20, myScroll.frame.size.width-20, 50)];
    [searchNearMe setImage:[UIImage imageNamed:@"searchnearme_btn"] forState:UIControlStateNormal];
    [searchNearMe addTarget:self action:@selector(searchPharmacyNearMe) forControlEvents:UIControlEventTouchUpInside];
    [myScroll addSubview:searchNearMe];
    
    

    

    UIView * separator = [[UIView alloc] initWithFrame:CGRectMake(0 ,80,screenRect.width, 1)];
    separator.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
    [myScroll addSubview:separator];
   
    
    
    
    UILabel *label=[UILabel new];
    label.frame=CGRectMake(0,separator.frame.origin.y+10, screenRect.width, 30);
    label.textAlignment=NSTextAlignmentCenter;
    label.text=@"OR SEARCH MANUALLY:";
    label.textColor=[UIColor blackColor];
    label.font=[UIFont fontWithName:@"GothamRounded-Light" size:10];
    [myScroll addSubview:label];
    
    
    zipCodeTxtFld=[[UITextField alloc]initWithFrame:CGRectMake(10  , 120,screenRect.width-20, 40)];
    zipCodeTxtFld.borderStyle=UITextBorderStyleRoundedRect;
    zipCodeTxtFld.font= [UIFont fontWithName:@"GothamRounded-Light" size:12];
    zipCodeTxtFld.placeholder=@" Zip code(optional)";
    zipCodeTxtFld.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dr_icon.png"]];
    zipCodeTxtFld.layer.cornerRadius=2;
    zipCodeTxtFld.delegate=self;
    zipCodeTxtFld.keyboardType=UIKeyboardTypeNumberPad;
    [myScroll addSubview:zipCodeTxtFld];
    
    
    nameTxtFld=[[UITextField alloc]initWithFrame:CGRectMake(10  , 170,screenRect.width-20, 40)];
    nameTxtFld.borderStyle=UITextBorderStyleRoundedRect;
    nameTxtFld.font= [UIFont fontWithName:@"GothamRounded-Light" size:12];
    nameTxtFld.placeholder=@" Name(optional)";
    nameTxtFld.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dr_icon.png"]];
    nameTxtFld.layer.cornerRadius=2;
    nameTxtFld.delegate=self;
    [myScroll addSubview:nameTxtFld];
    
    
    phTextFld=[[UITextField alloc]initWithFrame:CGRectMake(10  , 220,screenRect.width-20, 40)];
    phTextFld.borderStyle=UITextBorderStyleRoundedRect;
    phTextFld.font= [UIFont fontWithName:@"GothamRounded-Light" size:12];
    phTextFld.placeholder=@" Phone number(optional)";
    phTextFld.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dr_icon.png"]];
    phTextFld.layer.cornerRadius=2;
    phTextFld.keyboardType=UIKeyboardTypeNumberPad;
    phTextFld.delegate=self;
    [myScroll addSubview:phTextFld];
    
    shwFilterBtn=  [UIButton buttonWithType:UIButtonTypeRoundedRect];
    shwFilterBtn.frame=CGRectMake(myScroll.frame.size.width-110 , 270, 100, 40);
    [shwFilterBtn addTarget:self action:@selector(showActn) forControlEvents:UIControlEventTouchUpInside];
    [shwFilterBtn setBackgroundImage:[UIImage imageNamed:@"showfilters_btn.png"] forState:UIControlStateNormal];
    
    [myScroll addSubview:shwFilterBtn];


    
    
    pharmacyAppTbl = [[UITableView alloc]init];
    pharmacyAppTbl.frame =  CGRectMake(10, 320, myScroll.frame.size.width-20,myScroll.frame.size.height-320);
    
    if(screenRect.height>=736){
           pharmacyAppTbl.frame =  CGRectMake(10, 320, myScroll.frame.size.width-20,180);
    }
    pharmacyAppTbl.delegate = self;
    pharmacyAppTbl.dataSource = self;
    pharmacyAppTbl.backgroundColor =[UIColor cyanColor];
    pharmacyAppTbl.showsVerticalScrollIndicator = NO;
    pharmacyAppTbl.backgroundColor=[UIColor clearColor];
    pharmacyAppTbl.scrollEnabled = NO;
    pharmacyAppTbl.layer.borderWidth = 2.0;
    pharmacyAppTbl.layer.borderColor = [UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1].CGColor;
    [pharmacyAppTbl setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    

    [myScroll addSubview:pharmacyAppTbl];
    
    pharmacyAppTbl.hidden=YES;
     //tableArray=[NSArray arrayWithObjects:@"24 Hours",@"Retail",@"Mail Order",@"Long Term Care",@"Speciality",nil];
    
    
   scheduleAppButton =[[UIButton alloc]initWithFrame:CGRectMake(10,370, myScroll.frame.size.width-20, 50)];
  
   

    [scheduleAppButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [scheduleAppButton setBackgroundColor:[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)0.1]];
    [scheduleAppButton setTitle:@"Search for Pharmacy" forState:UIControlStateNormal];
    [scheduleAppButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    scheduleAppButton.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    [scheduleAppButton addTarget:self action:@selector(searchPharmacy) forControlEvents:UIControlEventTouchUpInside];
    scheduleAppButton.layer.cornerRadius=10.0f;
    scheduleAppButton.enabled=NO;
    [myScroll addSubview:scheduleAppButton];

    
    if (UIUserInterfaceIdiomPad ==  UI_USER_INTERFACE_IDIOM()){
        
        
         searchNearMe.frame=CGRectMake(10,50, myScroll.frame.size.width-20, 80);
    separator.frame= CGRectMake(0 ,180,screenRect.width, 1);
        
          label.frame=CGRectMake(0,190, screenRect.width, 30);
        label.font=[UIFont fontWithName:@"GothamRounded-Light" size:20];
        
        zipCodeTxtFld.frame=CGRectMake(10  ,230,screenRect.width-20,80);
        zipCodeTxtFld.font=[UIFont fontWithName:@"GothamRounded-Light" size:25];
//        zipCodeTxtFld.attributedPlaceholder =
//        [[NSAttributedString alloc] initWithString:@"Placeholder Text"
//                                        attributes:@{
//                                                     NSForegroundColorAttributeName: [UIColor blackColor],
//                                                     NSFontAttributeName : [UIFont fontWithName:@"GothamRounded-Light" size:25.0]
//                                                     }
//         ];
        zipCodeTxtFld.placeholder=@" Zip code(optional)";
         nameTxtFld.frame=CGRectMake(10  , 320,screenRect.width-20, 80);
          nameTxtFld.font=[UIFont fontWithName:@"GothamRounded-Light" size:25];
        nameTxtFld.placeholder=@" Name(optional)";         phTextFld.frame=CGRectMake(10  , 410,screenRect.width-20, 80);
          phTextFld.font=[UIFont fontWithName:@"GothamRounded-Light" size:25];
            phTextFld.placeholder=@" Phone number(optional)";
    
        
        
         shwFilterBtn.frame=CGRectMake(myScroll.frame.size.width-110 , 520, 100, 40);
        
         pharmacyAppTbl.frame =  CGRectMake(10, 580, myScroll.frame.size.width-20,380);
     
       scheduleAppButton.frame=CGRectMake(10,580, myScroll.frame.size.width-20, 80);
        scheduleAppButton.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:25];
        
    
    }
    
    
    float sizeOfContent = 0;
    UIView *lLast = [myScroll.subviews lastObject];
    NSInteger wd = lLast.frame.origin.y;
    NSInteger ht = lLast.frame.size.height;
    NSInteger offset=80;
    sizeOfContent = wd+ht;
    myScroll.contentSize=CGSizeMake(screenRect.width,sizeOfContent+offset);
    


}

#pragma mark-table Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(section==0)
        return 1;
        else
    
    return 4;
    
}

//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    if(UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad){
//        
//        cell.textLabel.font = [UIFont systemFontOfSize:30];
//    }
//    
//    cell.layer.cornerRadius = 3;
//    cell.clipsToBounds = YES;
//    
//}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
   
    if(indexPath.section==0){
        cell.textLabel.text = @"24 Hours";
    }
    else{
        switch (indexPath.row) {
            case 0:
                
                
               
                cell.textLabel.text = @"Retail";

                break;
            case 1:
                cell.textLabel.text = @"Mail Order";
                
                break;
            case 2:
                cell.textLabel.text = @"Lob Term Care";
                
                break;
            case 3:
                cell.textLabel.text = @"Specialty";
                
                break;
                
            default:
                break;
        }
    }
    
    cell.textLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad){
        cell.textLabel.font=[UIFont fontWithName:@"GothamRounded-Light" size:25];

    }

//    
//    if(indexPath.section==1){
//    
//    if (indexPath.section == selectedIndex) {
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    }
//    else{
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
//
//    }
    

//if(hourSelectedIndex==1 && indexPath.section==0 ){
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//        }
//        else{
//            cell.accessoryType = UITableViewCellAccessoryNone;
//        }
//
//  
//    if(selectedIndex==indexPath.row && indexPath.section==1){
//        
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    }
//    else{
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
//
//
    
    
    if(hourSelectedIndex==1 && indexPath.section==0 ){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            else{
                if(selectedIndex==indexPath.row && indexPath.section==1){
                    
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
                else{
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
                
            }
    
    
    

    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    NSLog(@"section>>>>>>%ld",(long)indexPath.section);
    
    if(indexPath.section==1){
         selectedIndex = (int)indexPath.row;
        NSLog(@"imndex path-->%d",selectedIndex);
           }
    if(indexPath.section==0){
        if(hourSelectedIndex==0)
        hourSelectedIndex=1;
        else
            hourSelectedIndex=0;
      //  [pharmacyAppTbl reloadData];
        
    }

    [pharmacyAppTbl reloadData];

    

    
    
    }
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad) {
        if (section == 0) {
            return  0;
        }
        
        return  40;
    }
    else{
        if (section == 0) {
            return  0;
        }
        
        return 10;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UIUserInterfaceIdiomPad==UI_USER_INTERFACE_IDIOM()) {
        if(indexPath.section==0 && indexPath.row==0){
            
            return 100;
        }
        else
            return 80;
    }
    else return 40;
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






#pragma mark-Show/Hide Filter  Action
-(void)showActn{
    
    
    if(isShowClicked==NO){
        pharmacyAppTbl.hidden=NO;
 scheduleAppButton.frame =CGRectMake(10,320+pharmacyAppTbl.frame.size.height, myScroll.frame.size.width-20, 50);
       
        if (UIUserInterfaceIdiomPad==UI_USER_INTERFACE_IDIOM()){
            scheduleAppButton.frame =CGRectMake(10,580+pharmacyAppTbl.frame.size.height, myScroll.frame.size.width-20, 80);

        }
        
    
         [shwFilterBtn setBackgroundImage:[UIImage imageNamed:@"hidefilters_btn.png"] forState:UIControlStateNormal];
        float sizeOfContent = 0;
        UIView *lLast = [myScroll.subviews lastObject];
        NSInteger wd = lLast.frame.origin.y;
        NSInteger ht = lLast.frame.size.height;
        NSInteger offset=80;
        sizeOfContent = wd+ht;
        myScroll.contentSize=CGSizeMake(screenRect.width,sizeOfContent+offset);

       
//        numberOfRows=6;
//        [childTableView reloadData];
        isShowClicked=YES;
        
       // addTextField=[NSArray arrayWithObjects:firstName.text,lastName.text,dob.text, nil];
        
        
        
    }
    else{
        pharmacyAppTbl.hidden=YES;
        
        scheduleAppButton.frame =CGRectMake(10,370, myScroll.frame.size.width-20, 50);
        
        if (UIUserInterfaceIdiomPad==UI_USER_INTERFACE_IDIOM()){
            scheduleAppButton.frame =CGRectMake(10,580, myScroll.frame.size.width-20, 80);
            
        }
  [shwFilterBtn setBackgroundImage:[UIImage imageNamed:@"showfilters_btn.png"] forState:UIControlStateNormal];
        
        float sizeOfContent = 0;
        UIView *lLast = [myScroll.subviews lastObject];
        NSInteger wd = lLast.frame.origin.y;
        NSInteger ht = lLast.frame.size.height;
        NSInteger offset=80;
        sizeOfContent = wd+ht;
        myScroll.contentSize=CGSizeMake(screenRect.width,sizeOfContent+offset);

      
//        numberOfRows=3;
//        [childTableView reloadData];
        isShowClicked=NO;
        
    }
    
    
}


#pragma mark-text field Delegate
//-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    if(textField==phTextFld||textField==nameTxtFld||textField==zipCodeTxtFld)
//    {
//        if([textField.text isEqual:@""])
//                 else{
//          
//        }
//    }
//}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
        NSLog(@"text-->%lu  %ld  %ld",(unsigned long)textField.text.length,(unsigned long)range.length,range.location);
    
       if( range.location>0)
    {
        
        

        scheduleAppButton.enabled=YES;
           [scheduleAppButton setBackgroundColor:[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)1]];
        
        
    }
    else {
        
        
        scheduleAppButton.enabled=NO;
        [scheduleAppButton setBackgroundColor:[UIColor colorWithRed:(CGFloat)41/255 green:(CGFloat)182/255 blue:(CGFloat)246/255 alpha:(CGFloat)0.1]];
    }
   
    return YES;
}
   -(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}

-(void)nextButtonAction{
    pharmacyno=@"";
        PaymentViewController * paymentVC =[[PaymentViewController alloc]init];
        [self.navigationController pushViewController:paymentVC animated:YES];
    [[NSUserDefaults standardUserDefaults]setObject:pharmacyno  forKey:@"pharmacy"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}

#pragma mark- set autolayout for table content  here

-(UIView *)setAutolayoutConstarints{
    
    UIView * sectionView =[[UIView alloc]init];
    sectionView.frame = CGRectMake(0, 0, pharmacyAppTbl.frame.size.width, 40);
    sectionView.backgroundColor =[UIColor whiteColor];
    //------------------------------------
    UILabel * nameLbl =[[UILabel alloc]init];
    nameLbl.frame=CGRectMake(0, 5, 100, 30);
    //nameLbl.translatesAutoresizingMaskIntoConstraints = NO;
    nameLbl.text = @"Pharmacy";
    nameLbl.font =[UIFont fontWithName:@"GothamRounded-Medium" size:10];
    nameLbl.textAlignment = NSTextAlignmentCenter;
    
    nameLbl.textColor = [UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)37/255 blue:(CGFloat)101/255 alpha:(CGFloat)1];
    [sectionView addSubview:nameLbl];
    
    UILabel * startTime =[[UILabel alloc]init];
    //startTime.translatesAutoresizingMaskIntoConstraints = NO;
    startTime.frame=CGRectMake(pharmacyAppTbl.frame.size.width/2-60, 5, 60, 30);
    startTime.text = @"Phone";
    startTime.font =[UIFont fontWithName:@"GothamRounded-Medium" size:10];
    startTime.textAlignment = NSTextAlignmentCenter;
    startTime.textColor = [UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)37/255 blue:(CGFloat)101/255 alpha:(CGFloat)1];
    [sectionView addSubview:startTime];
    
    UILabel * endTime=[[UILabel alloc]init];
    endTime.frame=CGRectMake(pharmacyAppTbl.frame.size.width/2+20, 5, 60, 30);
    endTime.text=@"City";
    endTime.textColor = [UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)37/255 blue:(CGFloat)101/255 alpha:(CGFloat)1];
    endTime.font =[UIFont fontWithName:@"GothamRounded-Medium" size:10];

    [sectionView addSubview:endTime];
    
    
    UILabel * dateLbl =[[UILabel alloc]init];
    dateLbl.frame=CGRectMake(pharmacyAppTbl.frame.size.width/2+80, 5, 60, 30);
    //dateLbl.translatesAutoresizingMaskIntoConstraints = NO;
    dateLbl.text = @"Country";
    dateLbl.font =[UIFont fontWithName:@"GothamRounded-Medium" size:10];
    dateLbl.textAlignment = NSTextAlignmentCenter;
    dateLbl.textColor = [UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)37/255 blue:(CGFloat)101/255 alpha:(CGFloat)1];
    [sectionView addSubview:dateLbl];
    
    
    if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()) {
        nameLbl.frame=CGRectMake(0, 5, 60, 30);
        startTime.frame=CGRectMake(pharmacyAppTbl.frame.size.width/2-170, 5, 120, 30);
        dateLbl.frame=CGRectMake(pharmacyAppTbl.frame.size.width/2-10, 5, 60, 30);
       // locationLbl.frame=CGRectMake(pharmacyAppTbl.frame.size.width/2+65, 5,pharmacyAppTbl.frame.size.width-(pharmacyAppTbl.frame.size.width/2+80), 30);
        
        dateLbl.font =[UIFont fontWithName:@"GothamRounded-Medium" size:20];
       // locationLbl.font =[UIFont fontWithName:@"GothamRounded-Medium" size:20];
        startTime.font =[UIFont fontWithName:@"GothamRounded-Medium" size:20];
        nameLbl.font =[UIFont fontWithName:@"GothamRounded-Medium" size:20];
    }
    
    return sectionView;
}


#pragma mark-back Action
-(void)backButtonAction{
    
    
    

    
    
//    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"pop"]isEqual:@"fromhealth"]){
//        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"pop"];
//        [[NSUserDefaults standardUserDefaults]synchronize];
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//    
//    
//    
//    else{
    
    NSArray *array = [self.navigationController viewControllers];
    NSLog(@"array--->%@",array);
    
        if([SingletonClass sharedSingleton].deptId==4)
            [self.navigationController popToViewController:[array objectAtIndex:array.count-3] animated:YES];
         //   [self.navigationController popViewControllerAnimated:YES];
        else if ([SingletonClass sharedSingleton].deptId==2)
          [self.navigationController popToViewController:[array objectAtIndex:array.count-4] animated:YES];
        else if ([SingletonClass sharedSingleton].deptId==5){
           [self.navigationController popToViewController:[array objectAtIndex:array.count-3] animated:YES];
        }
       else if ([SingletonClass sharedSingleton].deptId==3){
            [self.navigationController popToViewController:[array objectAtIndex:array.count-3] animated:YES];
        }
       else if ([SingletonClass sharedSingleton].deptId==1){
           [self.navigationController popToViewController:[array objectAtIndex:array.count-3] animated:YES];
       }

    else
        [self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];
    }
//}


//-(void)fetchPharDetails{
//    resultArr
//}
#pragma mark-search Pharmacy Action
-(void)searchPharmacy{
    
    [[NSUserDefaults standardUserDefaults]setObject:@"fetchPharamcy" forKey:@"ViewControllerState"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    [[NSUserDefaults standardUserDefaults]setObject:zipCodeTxtFld.text forKey:@"PharmzipCode"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:nameTxtFld.text forKey:@"Pharmname"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    
    
    [[NSUserDefaults standardUserDefaults]setObject:phTextFld.text forKey:@"PharmPh"];
    [[NSUserDefaults standardUserDefaults]synchronize];

//    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"MYHEALTH"]isEqual:@"yes"])
//    {
//    [[NSUserDefaults standardUserDefaults]setObject:@"fromhealth" forKey:@"pop"];
//    [[NSUserDefaults standardUserDefaults]synchronize];
//    }
    
    SelectDetailPharmacy *detail=[SelectDetailPharmacy new];
    [self.navigationController pushViewController:detail animated:YES];
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
    
    
    
    
  //  NSLog(@"Pharmacy favorite---->%@",jsonResponse);
    
    if ([[jsonResponse objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
        
        
        [[NSUserDefaults standardUserDefaults]setObject:@"favoritePhar" forKey:@"ViewControllerState"];
        [[NSUserDefaults  standardUserDefaults]synchronize];
        
        

        dispatch_async(dispatch_get_main_queue(),^{
          
            SelectDetailPharmacy *detail=[SelectDetailPharmacy new];
            [self.navigationController pushViewController:detail animated:YES];

        });
        
        
        
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

#pragma mark-Skip Button Actio
-(void)skipButtonAction{
    
//    PaymentViewController *payment=[PaymentViewController new];
//    [self.navigationController pushViewController:payment animated:YES];
    [self createPopUp];
//    
}


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
    //header.font=[UIFont systemFontOfSize:30];
    header.numberOfLines=2;
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
    information.numberOfLines=15;
    information.textAlignment=NSTextAlignmentCenter;
   information.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    information.textColor=[UIColor blackColor];
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
    [goSelect setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    goSelect.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
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
-(void)goSelectActn
{
    
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

#pragma mark-Search Pharmacy Near Me ACtion
-(void)searchPharmacyNearMe{
    
    
    MapViewVC *mapView=[[MapViewVC alloc]init];
    [self.navigationController pushViewController:mapView animated:YES];
    
    
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
