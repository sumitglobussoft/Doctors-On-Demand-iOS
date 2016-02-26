//
//  SignUpView.h
//  DoctorsOnDemandCode
//
//  Created by GLB-163 on 8/7/15.
//  Copyright (c) 2015 GLB-163. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignInView.h"

@interface SignUpView : UIViewController<UITextFieldDelegate>
{
    UITextField *email,*dateOfBirth,*password,*nameTxt;
}
-(void)signUp;

@end
