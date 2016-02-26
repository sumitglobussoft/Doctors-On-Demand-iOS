//
//  MapAnnotation.m
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 11/5/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation
-(id)initWithTitle:(NSString *)title andCoordinate:
(CLLocationCoordinate2D)coordinate2d{
    self.title = title;
    self.coordinate =coordinate2d;
    return self;
}




@end
