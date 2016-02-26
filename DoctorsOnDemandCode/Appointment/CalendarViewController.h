//
//  CalendarViewController.h
//  DoctorsOnDemandCode
//
//  Created by GBS-ios on 8/17/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableViewCell.h"

#import "JTCalendar/JTCalendar.h"



@interface CalendarViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,JTCalendarDelegate>

@property (strong, nonatomic)  JTCalendarMenuView *calendarMenuView;
@property (strong, nonatomic) JTHorizontalCalendarView *calendarContentView;

@property (strong, nonatomic) JTCalendarManager *calendarManager;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarContentViewHeight;


@end
