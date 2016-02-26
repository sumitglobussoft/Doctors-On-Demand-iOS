//
//  CustomTableViewCell.h
//  DoctorsApp
//
//  Created by GBS-ios on 9/4/15.
//  Copyright (c) 2015 globussoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell


@property(nonatomic,strong)UILabel  * appointmentTime;
@property(nonatomic,strong)UILabel  * pharmacyName,*pharmacyPhNo,*pharmacyCity,*pharmacyCountry,*userName,*appointmentStatus;
@property(nonatomic,strong)UIView * containerView,*leftColorView;

@end
