//
//  SingletonClass.h
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 8/26/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingletonClass : NSObject

@property(nonatomic,assign)int item;
@property(nonatomic,assign)int deptId;
@property(nonatomic,assign)int exercise;
@property(nonatomic,assign)int exerciseB;
@property(nonatomic,assign)int back;

@property(nonatomic,assign)BOOL scheduledAppointment;
@property(nonatomic, retain)NSMutableDictionary *globalDictionry1,*globalDictionry2;
+(SingletonClass*)sharedSingleton;
+(BOOL)networkcheck;



@end

