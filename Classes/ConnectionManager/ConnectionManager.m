//
//  ConnectionManager.m
//  QBRTCChatSemple
//
//  Created by Andrey Ivanov on 12.12.14.
//  Copyright (c) 2014 QuickBlox Team. All rights reserved.
//

#import "ConnectionManager.h"
#import "UsersDataSource.h"
#import "SVProgressHUD.h"
#import "SignUpView.h"



const NSTimeInterval kChatPresenceTimeInterval = 45;

@interface ConnectionManager()

<QBChatDelegate>

@property (copy, nonatomic) void(^chatLoginCompletionBlock)(BOOL error);
@property (strong, nonatomic) QBUUser *me;
@property (strong, nonatomic) NSTimer *presenceTimer;

@end

@implementation ConnectionManager

@dynamic users;
@dynamic usersWithoutMe;

+ (instancetype)instance {
    
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

#pragma mark - Login / Logout

- (void)logInWithUser:(QBUUser *)user
           completion:(void (^)(BOOL error))completion {
    
    
    
    
    [QBChat.instance loginWithUser:user];
    [QBChat.instance addDelegate:self];
    
    self.me = user;
    
    if (QBChat.instance.isLoggedIn) {
        completion(NO);
    }
    else {
        
        self.chatLoginCompletionBlock = completion;
    }
}


-(void)signUp:(QBUUser *)user{
   
   
    
    [QBRequest createSessionWithSuccessBlock:^(QBResponse *response, QBASession *session) {
        // session created
        
       
        
        // Registration sign up of User
        [QBRequest signUp:user successBlock:^(QBResponse *response, QBUUser *user) {
            
            NSError *error;
                id json =[NSJSONSerialization JSONObjectWithData:response.data options:NSJSONReadingAllowFragments error:&error];
            
         NSLog(@"Response------>%@",json);

            
            //[SVProgressHUD dismiss];
          
            
            [[NSUserDefaults standardUserDefaults]setObject:[[json objectForKey:@"user"] objectForKey:@"owner_id"] forKey:@"QBOwnerID"];
            [[NSUserDefaults standardUserDefaults]synchronize];
         
            
            
            [[NSUserDefaults standardUserDefaults]setInteger:user.ID  forKey:@"QuickBloxID"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            NSLog(@"Quick Blox ID is----->%lu",(unsigned long)user.ID);
            
            
            
            // NSLog(@"loginUser %@",response);

            
           
            
//                [QBRequest logInWithUserLogin:@"login" password:@"password"
//                                 successBlock:[self successBlock] errorBlock:[self errorBlock]];
            
            
//            [QBRequest logInWithUserLogin:@"Man@man.com" password:@"12345678" successBlock:^(QBResponse *response, QBUUser *user1) {
//                
//                NSLog(@"login %@",response);
//                
//                
//                
//                
//                [QBRequest deleteUserWithID:user.ID successBlock:^(QBResponse *response) {
//                    
//                    
//                    NSLog(@"Successfully deleted from QuickBlox Server %@",response);
//                    
//                    
//                    
//                } errorBlock:^(QBResponse *response) {
//                    NSLog(@"Error While detetion %@",response.error);
//                }];
//                
//                
//                
//                
//            } errorBlock:^(QBResponse *response) {
//                
//                NSLog(@"Failed to login %@",[response error]);
//                
//                // Handle error
//            }];
//            
//            
            

            
            
            

            SignUpView *signUp=[[SignUpView alloc]init];
            [signUp signUp];

                      } errorBlock:^(QBResponse *response) {
            // Handle error here
            NSLog(@"error while signing up with QB");
            
            NSLog(@"fail sign Up %@",response.error);;
         
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Login chat error!", nil)];

            
            return ;
            
        }];
    } errorBlock:^(QBResponse *response) {
        // handle errors
        NSLog(@" error in creating session %@", response.error);
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"SignUp to Chat error!", nil)];

    }];

    

}


- (void)logOut {
    
    [self.presenceTimer invalidate];
    self.presenceTimer = nil;
    if ([QBChat.instance isLoggedIn]) {
        
        [QBChat.instance logout];
    }
    
    self.me = nil;
}

#pragma mark - QBChatDelegate

- (void)chatDidNotLogin {
    
    if (self.chatLoginCompletionBlock) {
        self.chatLoginCompletionBlock(YES);
        self.chatLoginCompletionBlock = nil;
    }
}

- (void)chatDidFailWithError:(NSInteger)code {
    
    if (self.chatLoginCompletionBlock) {
        self.chatLoginCompletionBlock(YES);
        self.chatLoginCompletionBlock = nil;
    }
}

- (void)chatDidLogin {
    
    self.presenceTimer =
    [NSTimer scheduledTimerWithTimeInterval:kChatPresenceTimeInterval
                                     target:self
                                   selector:@selector(sendChatPresence:)
                                   userInfo:nil
                                    repeats:YES];
    
    if (self.chatLoginCompletionBlock) {
        self.chatLoginCompletionBlock(NO);
        self.chatLoginCompletionBlock = nil;
    }
}

#pragma mark - Send chat presence

- (void)sendChatPresence:(NSTimer *)timer {
    
    [[QBChat instance] sendPresence];
}

#pragma mark - Public

- (NSArray *)usersWithIDS:(NSArray *)ids {
    
    NSMutableArray *users = [NSMutableArray arrayWithCapacity:ids.count];
    [ids enumerateObjectsUsingBlock:^(NSNumber *userID,
                                      NSUInteger idx,
                                      BOOL *stop){
        
        QBUUser *user = [self userWithID:userID];
        [users addObject:user];
    }];
    
    return users;
}

- (NSArray *)idsWithUsers:(NSArray *)users {
    
    NSMutableArray *ids = [NSMutableArray arrayWithCapacity:users.count];
    [users enumerateObjectsUsingBlock:^(QBUUser  *obj,
                                        NSUInteger idx,
                                        BOOL *stop){
        [ids addObject:@(obj.ID)];
    }];
    
    return ids;
}

#pragma mark - Users Datasource

- (NSArray *)users {
    
    return UsersDataSource.instance.users;
}

- (NSArray *)usersWithoutMe {
    
    NSMutableArray *usersWithoutMe = UsersDataSource.instance.users.mutableCopy;
    [usersWithoutMe removeObject:self.me];
    
    return usersWithoutMe;
}

- (NSUInteger)indexOfUser:(QBUUser *)user {
    
    return [self.users indexOfObject:user];
}

- (UIColor *)colorAtUser:(QBUUser *)user {
    
    return [UsersDataSource.instance colorAtUser:user];
}

- (QBUUser *)userWithID:(NSNumber *)userID {
    
    __block QBUUser *resultUser = nil;
    [self.users enumerateObjectsUsingBlock:^(QBUUser *user,
                                             NSUInteger idx,
                                             BOOL *stop) {
        
        if (user.ID == userID.integerValue) {
            
            resultUser =  user;
            *stop = YES;
        }
    }];
    
    return resultUser;
}

@end

@implementation QBUUser (ConnectionManager)

- (NSUInteger)index {
    
    NSUInteger idx = [ConnectionManager.instance indexOfUser:self];
    return idx;
}

- (UIColor *)color {
    
    UIColor *color = [ConnectionManager.instance colorAtUser:self];
    return color;
}

@end
