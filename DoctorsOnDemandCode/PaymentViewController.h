//
//  PaymentViewController.h
//  DoctorsOnDemandCode
//
//  Created by GBS-ios on 9/11/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayPalMobile.h"
#import "SingletonClass.h"
#import "VideoChatViewController.h"
#import "LoginViewController.h"

@interface PaymentViewController : UIViewController<PayPalPaymentDelegate,PayPalProfileSharingDelegate,PayPalFuturePaymentDelegate>

@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;
@property(nonatomic, assign, readwrite) BOOL acceptCreditCards;

-(void)scheduleSeeDocNow;
-(void)scheduleAppointment;
@end
