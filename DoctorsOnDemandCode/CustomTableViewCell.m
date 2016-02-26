//
//  CustomTableViewCell.m
//  DoctorsApp
//
//  Created by GBS-ios on 9/4/15.
//  Copyright (c) 2015 globussoft. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        if ([reuseIdentifier isEqualToString:@"calender"]) {
            
            self.contentView.backgroundColor =[UIColor clearColor];
       
            
            self.containerView = [[UIView alloc]init];
            self.containerView.frame = CGRectMake(10, 5, [UIScreen mainScreen].bounds.size.width-40, 50);
            self.containerView.backgroundColor = [UIColor whiteColor];
//            self.containerView.layer.shadowColor = [UIColor blackColor].CGColor;
//            self.containerView.layer.shadowOffset = CGSizeMake(0, 0);
//            self.containerView.layer.shadowOpacity = 0.5;
//            self.containerView.layer.shadowRadius = 3;
//            self.containerView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.containerView.bounds].CGPath;
            [self.contentView addSubview:self.containerView];
            
            self.leftColorView = [[UIView alloc]init];
            self.leftColorView.frame = CGRectMake(0, 0,5,self.containerView.frame.size.height);
            self.leftColorView.backgroundColor = [UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)37/255 blue:(CGFloat)101/255 alpha:(CGFloat)1];
            [self.containerView addSubview:self.leftColorView];
            
           
            
            
            self.appointmentTime = [[UILabel alloc]init];
            self.appointmentTime.frame = CGRectMake(25, 16, [UIScreen mainScreen].bounds.size.width, 20);
            self.appointmentTime.text = @"4:30PM - 5:30PM ";
            self.appointmentTime.font =[UIFont fontWithName:@"GothamRounded-Light" size:14];
            self.appointmentTime.textColor = [UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)37/255 blue:(CGFloat)101/255 alpha:(CGFloat)1];
            [self.containerView addSubview:self.appointmentTime];
            
            if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()) {
                self.containerView.frame = CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width, 90);
                self.leftColorView.frame = CGRectMake(0, 0,5,self.containerView.frame.size.height);
                self.appointmentTime.frame = CGRectMake(25, 45, [UIScreen mainScreen].bounds.size.width, 30);
                self.appointmentTime.font = [UIFont fontWithName:@"GothamRounded-Light" size:25];
            }

        }
        
        if ([reuseIdentifier isEqualToString:@"Pharmacy"]) {
            
            self.contentView.backgroundColor =[UIColor clearColor];
            
            self.containerView = [[UIView alloc]init];
            self.containerView.frame = CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width, 50);
            self.containerView.backgroundColor = [UIColor whiteColor];
            self.containerView.layer.shadowColor = [UIColor blackColor].CGColor;
            self.containerView.layer.shadowOffset = CGSizeMake(0, 0);
            self.containerView.layer.shadowOpacity = 0.5;
            self.containerView.layer.shadowRadius = 3;
            self.containerView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.containerView.bounds].CGPath;
            [self.contentView addSubview:self.containerView];
            
            self.leftColorView = [[UIView alloc]init];
            self.leftColorView.frame = CGRectMake(0, 0,5,self.containerView.frame.size.height);
            self.leftColorView.backgroundColor = [UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)37/255 blue:(CGFloat)101/255 alpha:(CGFloat)1];
            [self.containerView addSubview:self.leftColorView];
            
            
            
            
            self.pharmacyName = [[UILabel alloc]init];
           // self.pharmacyName.frame = CGRectMake(25, 25, [UIScreen mainScreen].bounds.size.width, 20);
            self.pharmacyName.text = @"OM pharmacy";
            self.pharmacyName.font =[UIFont fontWithName:@"GothamRounded-Light" size:8];
            self.pharmacyName.textColor = [UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)37/255 blue:(CGFloat)101/255 alpha:(CGFloat)1];
            [self.containerView addSubview:self.pharmacyName];
            
            self.pharmacyPhNo = [[UILabel alloc]init];
            // self.pharmacyName.frame = CGRectMake(25, 25, [UIScreen mainScreen].bounds.size.width, 20);
            self.pharmacyPhNo.text = @"9778484578";
            self.pharmacyPhNo.font =[UIFont fontWithName:@"GothamRounded-Light" size:8];
            self.pharmacyPhNo.textColor = [UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)37/255 blue:(CGFloat)101/255 alpha:(CGFloat)1];
            [self.containerView addSubview:self.pharmacyPhNo];
            
            
            self.pharmacyCity = [[UILabel alloc]init];
            // self.pharmacyName.frame = CGRectMake(25, 25, [UIScreen mainScreen].bounds.size.width, 20);
            self.pharmacyCity.text = @"Bhubaneswar";
            self.pharmacyCity.font =[UIFont fontWithName:@"GothamRounded-Light" size:8];
            self.pharmacyCity.textColor = [UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)37/255 blue:(CGFloat)101/255 alpha:(CGFloat)1];
            [self.containerView addSubview:self.pharmacyCity];
            
            
            
            
            self.pharmacyCountry = [[UILabel alloc]init];
            // self.pharmacyName.frame = CGRectMake(25, 25, [UIScreen mainScreen].bounds.size.width, 20);
            self.pharmacyCountry.text = @"India";
            self.pharmacyCountry.font =[UIFont fontWithName:@"GothamRounded-Light" size:8];
            self.pharmacyCountry.textColor = [UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)37/255 blue:(CGFloat)101/255 alpha:(CGFloat)1];
            [self.containerView addSubview:self.pharmacyCountry];
            
            
            
            
            
            
            if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()) {
                self.containerView.frame = CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width, 90);
                self.leftColorView.frame = CGRectMake(0, 0,5,self.containerView.frame.size.height);
                self.pharmacyName.frame = CGRectMake(25, 45, [UIScreen mainScreen].bounds.size.width, 30);
                self.pharmacyName.font = [UIFont fontWithName:@"GothamRounded-Light" size:15];
            }
            
        }
        
        if ([reuseIdentifier isEqualToString:@"pshychologist"]) {
            
            self.contentView.backgroundColor =[UIColor clearColor];
            
            self.containerView = [[UIView alloc]init];
            self.containerView.frame = CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width, 100);
            self.containerView.backgroundColor = [UIColor whiteColor];
            self.containerView.layer.shadowColor = [UIColor blackColor].CGColor;
            self.containerView.layer.shadowOffset = CGSizeMake(0, 0);
            self.containerView.layer.shadowOpacity = 0.5;
            self.containerView.layer.shadowRadius = 3;
            self.containerView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.containerView.bounds].CGPath;
            [self.contentView addSubview:self.containerView];
            
            
            
            self.pharmacyName = [[UILabel alloc]init];
         self.pharmacyName.frame = CGRectMake(0, 0, self.containerView.frame.size.width, 20);
            self.pharmacyName.textAlignment=NSTextAlignmentCenter;
            ///self.pharmacyName.text = @"OM pharmacy";
            self.pharmacyName.font =[UIFont fontWithName:@"GothamRounded-Bold" size:15];
            self.pharmacyName.textColor = [UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)37/255 blue:(CGFloat)101/255 alpha:(CGFloat)1];
            [self.containerView addSubview:self.pharmacyName];
            
            
            
            
            
            
            self.pharmacyPhNo = [[UILabel alloc]init];
      self.pharmacyPhNo.frame = CGRectMake(10, 30, self.containerView.frame.size.width-20, 50);
            //self.pharmacyPhNo.text = @"9778484578";
            self.pharmacyPhNo.numberOfLines=3;
            self.pharmacyPhNo.font =[UIFont fontWithName:@"GothamRounded-Light" size:14];
            self.pharmacyPhNo.textColor = [UIColor blackColor];
            [self.containerView addSubview:self.pharmacyPhNo];

            self.leftColorView = [[UIView alloc]init];
            self.leftColorView.backgroundColor=[UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)37/255 blue:(CGFloat)101/255 alpha:(CGFloat)1];
             [self.containerView addSubview:self.leftColorView];
            
            
            if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()) {
//                self.containerView.frame = CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width, 90);
                
                self.pharmacyName.frame = CGRectMake(0, 20, self.containerView.frame.size.width, 20);
                
                self.pharmacyPhNo.frame = CGRectMake(0, 50, self.containerView.frame.size.width-20, 50);

            
            }
            
        }
        if ([reuseIdentifier isEqualToString:@"AppointmentHistory"]) {
            
            self.contentView.backgroundColor =[UIColor clearColor];
            
            self.containerView = [[UIView alloc]init];
            self.containerView.frame = CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width, 100);
            self.containerView.backgroundColor = [UIColor whiteColor];
            self.containerView.layer.shadowColor = [UIColor blackColor].CGColor;
            self.containerView.layer.shadowOffset = CGSizeMake(0, 0);
            self.containerView.layer.shadowOpacity = 0.5;
            self.containerView.layer.shadowRadius = 3;
            self.containerView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.containerView.bounds].CGPath;
            [self.contentView addSubview:self.containerView];
            
            
            
            self.pharmacyName = [[UILabel alloc]init];
            self.pharmacyName.frame = CGRectMake(15, 10, self.contentView.frame.size.width, 20);
           
            ///self.pharmacyName.text = @"OM pharmacy";
            self.pharmacyName.font =[UIFont fontWithName:@"GothamRounded-Bold" size:16];
            self.pharmacyName.textColor = [UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)37/255 blue:(CGFloat)101/255 alpha:(CGFloat)1];
            [self.containerView addSubview:self.pharmacyName];
            
            
            
            
            
            
            self.pharmacyPhNo = [[UILabel alloc]init];
            self.pharmacyPhNo.frame = CGRectMake(10, 40, self.contentView.frame.size.width, 40);
            //self.pharmacyPhNo.text = @"9778484578";
            self.pharmacyPhNo.numberOfLines=3;
            self.pharmacyPhNo.font =[UIFont fontWithName:@"GothamRounded-Light" size:13];
            self.pharmacyPhNo.textColor = [UIColor blackColor];
            [self.containerView addSubview:self.pharmacyPhNo];
            
            
            self.leftColorView = [[UIView alloc]init];
            self.leftColorView.backgroundColor=[UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)37/255 blue:(CGFloat)101/255 alpha:(CGFloat)1];
            [self.containerView addSubview:self.leftColorView];
            
            if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()) {
                self.containerView.frame = CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width, 90);
                
            }
            
        }

        
        if ([reuseIdentifier isEqualToString:@"PharmacyDetails"]) {
            
            self.contentView.backgroundColor =[UIColor clearColor];
            
            self.containerView = [[UIView alloc]init];
          self.containerView.frame = CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width, 100);
            self.containerView.backgroundColor = [UIColor whiteColor];
//            self.containerView.layer.shadowColor = [UIColor blackColor].CGColor;
//            self.containerView.layer.shadowOffset = CGSizeMake(0, 0);
//            self.containerView.layer.shadowOpacity = 0.5;
            self.containerView.layer.shadowRadius = 3;
           // self.containerView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.containerView.bounds].CGPath;
            [self.contentView addSubview:self.containerView];
            
            
            
            
            
            if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()) {
                self.containerView.frame = CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width, 150);
                
            }
            
        }

        

        if ([reuseIdentifier isEqualToString:@"AppointmentDetails"]) {
            
            self.contentView.backgroundColor =[UIColor clearColor];
            
            self.containerView = [[UIView alloc]init];
            self.containerView.frame = CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width, 70);
            self.containerView.backgroundColor = [UIColor clearColor];
            //            self.containerView.layer.shadowColor = [UIColor blackColor].CGColor;
            //            self.containerView.layer.shadowOffset = CGSizeMake(0, 0);
            //            self.containerView.layer.shadowOpacity = 0.5;
            self.containerView.layer.shadowRadius = 3;
            // self.containerView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.containerView.bounds].CGPath;
            [self.contentView addSubview:self.containerView];
            
            
            
            self.userName = [[UILabel alloc]init];
            self.userName.frame = CGRectMake(20, 10, [UIScreen mainScreen].bounds.size.width, 20);
            self.userName.text = @"Jhon Doe";
            self.userName.font = [UIFont fontWithName:@"GothamRounded-Light" size:15];
            self.userName.textColor = [UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)37/255 blue:(CGFloat)101/255 alpha:(CGFloat)1];
            [self.containerView addSubview:self.userName];
            
            
            
            
            self.appointmentTime = [[UILabel alloc]init];
            self.appointmentTime.frame = CGRectMake(20, 35, [UIScreen mainScreen].bounds.size.width, 20);
            self.appointmentTime.text = @"4:30PM - 5:30PM ";
            self.appointmentTime.font =[UIFont fontWithName:@"GothamRounded-Light" size:12];
            self.appointmentTime.textColor = [UIColor blackColor];
            [self.containerView addSubview:self.appointmentTime];
            
            self.appointmentStatus = [[UILabel alloc]init];
            self.appointmentStatus.frame = CGRectMake(self.containerView.frame.size.width-95,10, [UIScreen mainScreen].bounds.size.width, 20);
            //self.appointmentTime.text = @"4:30PM - 5:30PM ";
            self.appointmentStatus.font =[UIFont fontWithName:@"GothamRounded-Light" size:12];
            self.appointmentStatus.textColor = [UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)37/255 blue:(CGFloat)101/255 alpha:(CGFloat)1];
            [self.containerView addSubview:self.appointmentStatus];
            
            if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()) {
                self.containerView.frame = CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width, 90);
                
            }
            
        }
 
        
       
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
