//
//  MapViewVC.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 11/5/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "MapViewVC.h"



@interface MapViewVC (){
  
        
        CGSize screenRect;

        UIButton *nextButton;
    NSArray *pharmAr;
    CLLocation *location;
    UIView*  mapVieww;
    id json;
    
    CGFloat swlat,swlong,nelat,nelong;

    MKAnnotationView *annotationView;
    NSMutableArray *nearbyPharmacy;
    MKPointAnnotation *point;
   
//    MKPinAnnotationView * annotationView;
    //MapAnnotation *newAnnotation2;
    CGFloat maplongi,maplat;
   //   GMSMapView *mapView_;
    
    int pharmacyID;
   
}

@end

@implementation MapViewVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self mapViewDisplay];
    
    
  //  [self performSelector:@selector(fetchNearPharmacy) withObject:nil afterDelay:2];
    
    
    
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:(BOOL)animated];    // Call the super class implementation.
    
//    mapVieww=nil;
//  //  locationManager=nil;
//    nearbyPharmacy=nil;
//    _mapView=nil;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
      screenRect=[[UIScreen mainScreen]bounds].size;
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)239/255 blue:(CGFloat)239/255 alpha:1];
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel * titleLable =[[UILabel alloc]init];
    titleLable.frame= CGRectMake(60, 25, screenRect.width-120, 25);
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.text =@"Map View";
    titleLable.font=[UIFont fontWithName:@"GothamRounded-Light" size:12];
    [headerView addSubview:titleLable];
    
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
  [backButton setFrame:CGRectMake(15, 18, 55, 35)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
      if(![[[NSUserDefaults standardUserDefaults]objectForKey:@"MYHEALTH"]isEqual:@"yes"])
      {
    nextButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setImage:[UIImage imageNamed:@"skip_btn.png"] forState:UIControlStateNormal];
     [nextButton setFrame:CGRectMake(screenRect.width-60, 28, 45, 25)];
    [nextButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:nextButton];
}
    
    
   
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)nextAction{
    
    PaymentViewController *paymrnt=[[PaymentViewController alloc]init];
    [self.navigationController pushViewController:paymrnt animated:YES];
    
}


#pragma mark-Map view display
-(void)mapViewDisplay{
    
    mapVieww=[[UIView alloc]init];
    mapVieww.frame=CGRectMake(0, 55, screenRect.width, screenRect.height-55);
    [self.view addSubview:mapVieww];
    
    
  _mapView   = [[MKMapView alloc]init];
  _mapView.frame=CGRectMake(0, 0, mapVieww.frame.size.width, mapVieww.frame.size.height);
    
    _mapView.delegate=self;
   
    _mapView.showsUserLocation=YES;

  [mapVieww addSubview:_mapView];
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:21.2101582
//                                                            longitude:81.3234275
//                                                                 zoom:6];
//   mapView_ = [GMSMapView mapWithFrame:CGRectMake(0, 55, screenRect.width, screenRect.height-55) camera:camera];
//   mapView_.myLocationEnabled = YES;
//    [self.view addSubview:mapView_];
//    
//    
//    // Creates a marker in the center of the map.
//    GMSMarker *marker = [[GMSMarker alloc] init];
//    marker.position = CLLocationCoordinate2DMake(21.2101582, 81.3234275);
//    marker.title = @"Sydney";
//    marker.snippet = @"Australia";
//    marker.map = mapView_; //   mapView.centerCoordinate = CLLocationCoordinate2DMake(37.32, -122.03);
  
   // locationManager =[[CLLocationManager alloc]init];
  //  locationManager.distanceFilter = kCLDistanceFilterNone;
   // locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    
  //  [locationManager startUpdatingLocation];
//    [locationManager requestWhenInUseAuthorization];
//    [locationManager requestAlwaysAuthorization];
    
//    maplongi =locationManager.location.coordinate.longitude;
//    maplat = locationManager.location.coordinate.latitude;
//    NSLog(@"ELongitude : %f", maplongi);
//    NSLog(@"ELatitude : %f", maplat);
//    
    
    
//    mapView.mapType = MKMapTypeHybrid;
//    mapView.showsUserLocation = YES;
    
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate=self;
    
   //  we have to setup the location maanager with permission in later iOS versions
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    //[[self locationManager] setDesiredAccuracy:kCLLocationAccuracyBest];
    [[self locationManager] startUpdatingLocation];
    
//    MapAnnotation *newAnnotation = [[MapAnnotation alloc]
//                                   initWithTitle:@"It's Me" andCoordinate:locationManager.location.coordinate];
//    
//    
//  [_mapView addAnnotation:newAnnotation];
//    
    
    
    
    //[mapVieww addSubview:_mapView];
//    dispatch_async(dispatch_get_global_queue(0, 0),^{
//        
//        
//        [self fetchNearPharmacy];
//        dispatch_async(dispatch_get_main_queue(),^{
//            
//                   });
//        
//    });
//
 //  [self fetchNearPharmacy];
   
    //To calculate the search bounds...
    //First we need to calculate the corners of the map so we get the points
    
}




//-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
////    location = locations.lastObject;
////   
////    
////    [[self labelLatitude] setText:[NSString stringWithFormat:@"%.6f", location.coordinate.latitude]];
////    
////    NSLog(@"Long-->%f",location.coordinate.latitude);
////     NSLog(@"Long-->%f",location.coordinate.longitude);
////    [[self labelLongitude] setText:[NSString stringWithFormat:@"%.6f", location.coordinate.longitude]];
////    
////     [[self labelAltitude] setText:[NSString stringWithFormat:@"%.2f feet", location.altitude*METERS_FEET]];
////    
//    
//    
//   
//
//}
//


    
    
    
    
    

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{

//    annotationView = [views lastObject];
//    id <MKAnnotation> mp = [annotationView annotation];
//    annotationView.tintColor=[UIColor blueColor];
//    
 //   self.locationManager = [[CLLocationManager alloc] init];
  

//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance
//  (self.locationManager.location.coordinate, 8500, 8500);
// //  [[self mapView] setRegion:region animated:YES];
//    //[[self mapView] selectAnnotation:mp animated:YES];
//    
////    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(self.locationManager.location.coordinate,8500, 8500);
//   // [[self mapView] setRegion:region animated:YES];
////    
//    
//    CLLocationCoordinate2D center   = region.center;
//     CLLocationCoordinate2D neCorner, swCorner;
//    neCorner.latitude  = center.latitude  + (region.span.latitudeDelta  / 2.0);
//    neCorner.longitude = center.longitude + (region.span.longitudeDelta / 2.0);
//    swCorner.latitude  = center.latitude  - (region.span.latitudeDelta  / 2.0);
//    swCorner.longitude = center.longitude - (region.span.longitudeDelta / 2.0);
//    NSLog(@"NE Lat-->%f",neCorner.latitude);
//    NSLog(@"NE long-->%f",neCorner.longitude);
//    
//    NSLog(@"sw Lat-->%f",swCorner.latitude);
//    NSLog(@"sw Long-->%f",swCorner.longitude);
//    swlat=swCorner.latitude;
//    swlong=swCorner.longitude;
//    
//    nelat=neCorner.latitude;
//    nelong=neCorner.longitude;
//    
   

}
//
//#pragma mark-Back Action
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark-Fetch Near By Pharmacy
-(void)fetchNearPharmacy{
    
   // nearbyPharmacy=[[NSMutableArray alloc]init];
    
    NSError * error;
    NSURLResponse *  urlResponse;
    
    
    NSURL * postUrl =[NSURL URLWithString:pharmNearByService];
    
    
    
    NSMutableURLRequest * request =[[NSMutableURLRequest alloc]initWithURL:postUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    
   NSString * body =[NSString stringWithFormat:@"NElat=%f&NElng=%f&SWlat=%f&SWlng=%f",nelat,nelong,swlat,swlong];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    if (!data) {
        NSLog(@"error...%@",error);
                NSLog(@"rturned.........");
        
        return;
    }
    
   json =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"json %@",json);
      if ([[json objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
          
          
          NSArray *ar=[json objectForKey:@"data"];
          for (int i=0; i<ar.count; i++) {
              
             // [nearbyPharmacy addObject:ar];
              
              
              CLLocationCoordinate2D location2;
              location2.latitude = [[[ar objectAtIndex:i]objectForKey:@"lat"] floatValue];
              location2.longitude = [[[ar objectAtIndex:i]objectForKey:@"lng"]floatValue ];
        
//           newAnnotation2    = [[MapAnnotation alloc]
//                                                 initWithTitle:[NSString stringWithFormat:@"%@\n%@,%@",[[ar objectAtIndex:i]objectForKey:@"pharmacyName"] ,[[ar objectAtIndex:i]objectForKey:@"city"],[[ar objectAtIndex:i]objectForKey:@"country"]]   andCoordinate:location2];
//              
//              //_mapView.delegate=self;
//     
//                            [_mapView addAnnotation:newAnnotation2];
//              
              
            point   = [[MKPointAnnotation alloc] init];
              point.coordinate = location2;
              point.title = [[ar objectAtIndex:i]objectForKey:@"pharmacyName"];
              point.subtitle = [NSString stringWithFormat:@"%@,%@",[[ar objectAtIndex:i]objectForKey:@"city"],[[ar objectAtIndex:i]objectForKey:@"country"]   ];
              
              
              [self.mapView addAnnotation:point];
              
              
              
              
              
             [mapVieww addSubview:_mapView];
              
          }
          
      }
    
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
  annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"loc"];
    //annotationView=[[MKPinAnnotationView alloc]init];
    annotationView.canShowCallout = YES;

    
    UIButton *selectButtom=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    selectButtom.frame=CGRectMake(10, 10,60, 50);
    selectButtom.backgroundColor=[UIColor redColor];
    [selectButtom setTitle:@"Select" forState:UIControlStateNormal];
    [selectButtom setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    [selectButtom addTarget:self action:@selector(selectPharmacyAction)  forControlEvents:UIControlEventTouchUpInside];
    
    annotationView.rightCalloutAccessoryView =selectButtom;
    
    return annotationView;
}


#pragma mark-select Near Pharmacy Action
    -(void)selectPharmacyAction{
         
         
         [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",pharmacyID] forKey:@"pharmacyId"];
         [[NSUserDefaults standardUserDefaults]synchronize];
         
         if(![[[NSUserDefaults standardUserDefaults]objectForKey:@"MYHEALTH"]isEqual:@"yes"])
         {
            
             [self addFavorite];
             
             PaymentViewController *paymnt=[PaymentViewController new];
             
             [self.navigationController pushViewController:paymnt animated:YES];
             
            
         }
         else{
             
             [self addFavorite];
        
        
         }
         
     }



#pragma mark-Add Favorite

-(void)addFavorite{
    
    NSError *error;
    NSURLResponse * urlResponse;
    
    NSString * urlStr =[NSString stringWithFormat:addPharmacyFavoriteService];
    NSURL * url =[NSURL URLWithString:urlStr];
    
    NSMutableURLRequest  * request =[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    
    NSString * body =[NSString stringWithFormat:@"pharmacyId=%@&userId=%@",[NSString stringWithFormat:@"%d",pharmacyID],[[NSUserDefaults standardUserDefaults] objectForKey:@"patientid"]];
    
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
        
        
        if(![[[NSUserDefaults standardUserDefaults]objectForKey:@"MYHEALTH"]isEqual:@"yes"])
        {
            
        }
        
        else{
        NSArray *array = [self.navigationController viewControllers];
        NSLog(@"array--->%@",array);
        
        
        
        
                [self.navigationController popToViewController:[array objectAtIndex:1] animated:YES];
        }
       
        // [self.navigationController popViewControllerAnimated:YES];
        
        
    }
    
    
    
    
}


-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    
    NSLog( @"Anotation no-->%@",[view.annotation title] );
    
   pharmAr=[json objectForKey:@"data"];
    int i;
    for (i=0; i<pharmAr.count; i++)
    {
      
        if([[[pharmAr objectAtIndex:i] objectForKey:@"pharmacyName"]isEqual:[view.annotation title]])
        {
            break;
        }
            
        
    }
    
    NSLog(@"selected phar ID-->%@",[[pharmAr objectAtIndex:i] objectForKey:@"pharmacyId"]);
    
    
    pharmacyID=[[[pharmAr objectAtIndex:i] objectForKey:@"pharmacyId"]intValue];
}
-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    
    
    
//    self.locationManager = [[CLLocationManager alloc] init];
//
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance
    (mapView.centerCoordinate, 8500, 8500);
//   // [[self mapView] setRegion:region animated:YES];
//    //[[self mapView] selectAnnotation:mp animated:YES];
//    
//    //    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(self.locationManager.location.coordinate,8500, 8500);
// //   [[self mapView] setRegion:region animated:YES];
//
    CLLocationCoordinate2D center   = mapView.centerCoordinate;
    CLLocationCoordinate2D neCorner, swCorner;
    neCorner.latitude  = center.latitude  + (region.span.latitudeDelta  / 2.0);
    neCorner.longitude = center.longitude + (region.span.longitudeDelta / 2.0);
    swCorner.latitude  = center.latitude  - (region.span.latitudeDelta  / 2.0);
    swCorner.longitude = center.longitude - (region.span.longitudeDelta / 2.0);
    NSLog(@"changed  NE Lat-->%f",neCorner.latitude);
    NSLog(@"cheged NE long-->%f",neCorner.longitude);
    
    NSLog(@"changed sw Lat-->%f",swCorner.latitude);
    NSLog(@" changed sw Long-->%f",swCorner.longitude);
    swlat=swCorner.latitude;
    swlong=swCorner.longitude;
    
    nelat=neCorner.latitude;
    nelong=neCorner.longitude;
    

    
   [self fetchNearPharmacy];
    

 
}
- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView{
    
    
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance
//    (locationManager.location.coordinate, 8500, 8500);
//    [[self mapView] setRegion:region animated:YES];
//    //[[self mapView] selectAnnotation:mp animated:YES];
//    
//    //    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(self.locationManager.location.coordinate,8500, 8500);
//    [[self mapView] setRegion:region animated:YES];
//    //
//    
//    CLLocationCoordinate2D center   = region.center;
//    CLLocationCoordinate2D neCorner, swCorner;
//    neCorner.latitude  = center.latitude  + (region.span.latitudeDelta  / 2.0);
//    neCorner.longitude = center.longitude + (region.span.longitudeDelta / 2.0);
//    swCorner.latitude  = center.latitude  - (region.span.latitudeDelta  / 2.0);
//    swCorner.longitude = center.longitude - (region.span.longitudeDelta / 2.0);
//    NSLog(@"NE Lat-->%f",neCorner.latitude);
//    NSLog(@"NE long-->%f",neCorner.longitude);
//    
//    NSLog(@"sw Lat-->%f",swCorner.latitude);
//    NSLog(@"sw Long-->%f",swCorner.longitude);
//    swlat=swCorner.latitude;
//    swlong=swCorner.longitude;
//    
//    nelat=neCorner.latitude;
//    nelong=neCorner.longitude;
    
}

-(void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region{
  
   }

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
}
-(void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region{
    
}
-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    
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
