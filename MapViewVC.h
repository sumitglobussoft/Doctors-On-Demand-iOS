//
//  MapViewVC.h
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 11/5/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MapAnnotation.h"
#import "PaymentViewController.h"



@interface MapViewVC : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>



@property (strong, nonatomic)  MKMapView *mapView;
@property(strong,nonatomic) CLLocationManager *locationManager;


@end
