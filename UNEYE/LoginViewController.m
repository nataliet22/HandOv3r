//
//  ViewController.m
//  UNEYE
//
//  Created by Satya Kumar on 07/03/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import "LoginViewController.h"
#import "MyTextField.h"
#import "CommonUtility.h"
#import  "ETMenuViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>


@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet MyTextField *txtEmailAddress;
@property (weak, nonatomic) IBOutlet MyTextField *txtPassword;
@property (weak, nonatomic)UITextField *myTextField;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //---- Call configureUI
    [self configureUI];
    
    //---- Testing ---
//    _txtEmailAddress.text = @"babu@gmail.com";
//    _txtPassword.text = @"qwerty";

}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark configure initial UI
-(void)configureUI{

    UIColor *color = [UIColor lightGrayColor];
    
    if(IS_IPHONE_5)
    {
        //--- configure email text field ---
        [CommonUtility setLeftPadding:_txtEmailAddress imageName:@"email" width:57];
        _txtEmailAddress.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: color}];
        
        //--- configure password text field ---
        [CommonUtility setLeftPadding:_txtPassword imageName:@"password" width:57];
        _txtPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        //--- configure email text field ---
        [CommonUtility setLeftPadding:_txtEmailAddress imageName:@"email" width:75];
        _txtEmailAddress.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: color}];
        
        //--- configure password text field ---
        [CommonUtility setLeftPadding:_txtPassword imageName:@"password" width:75];
        _txtPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        //--- configure email text field ---
        [CommonUtility setLeftPadding:_txtEmailAddress imageName:@"email" width:70];
        _txtEmailAddress.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: color}];
        
        //--- configure password text field ---
        [CommonUtility setLeftPadding:_txtPassword imageName:@"password" width:70];
        _txtPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    //--- Gesture for hiding keyboard ---
    UIGestureRecognizer *tapperGesture = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(hideKeyBoardOnSingleTap:)];
    tapperGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapperGesture];
}

#pragma mark hide Key Board on Single Tap
- (void)hideKeyBoardOnSingleTap:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}


#pragma mark button actions
- (IBAction)signinBtnClicked:(id)sender {
    
    //--- Call SignIn API ---
    if (_txtEmailAddress.text.length != 0 && _txtPassword.text.length != 0)
    {
        [self signInAPI:_txtEmailAddress.text password:_txtPassword.text];
    }
    else
    {
        kCustomAlertWithParamAndTarget(@"Message",@"Email or Password shouldn't be empty", nil);

    }
}

- (IBAction)signUpBtnClicked:(id)sender {
    

}

- (IBAction)loginViaFacebook:(id)sender {
    
    //---- Show HUD View ---
    [kAppDelegete showHUDVIEW:self.view];
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions:@[@"public_profile", @"email", @"user_friends"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
    
         if (error) {
             NSLog(@"Process error");
             //---- Hide HUD View ---
             [kAppDelegete removeHUDVIEW];
             
             kCustomAlertWithParamAndTargetDelegate(@"Message",error.description, nil);
             
         }
         else if (result.isCancelled)
         {
             NSLog(@"Cancelled");
             //---- Hide HUD View ---
             [kAppDelegete removeHUDVIEW];
         }
         else
         {
             [[IQWebService service]loginWithFacebookTokenWithToken:result.token.tokenString CompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                
                 //---- Hide HUD View ---
                 [kAppDelegete removeHUDVIEW];
                 
                 NSMutableDictionary * jsonObject = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                 NSLog(@"jsonObject :- %@", jsonObject);

                 if (![[jsonObject valueForKey:@"success"] boolValue]) {
                     kCustomAlertWithParamAndTargetDelegate(@"Message",@"That Facebook account is not registered with us.\nDo you want register with us?", self);
                 }

             }];
             
             NSLog(@"Logged in");
         }
     }];
}

//--- Fetch user info from Facebook ---
-(void)fetchUserInfo
{
    
    //---- Show HUD View ---
    [kAppDelegete showHUDVIEW:self.view];
    
    if ([FBSDKAccessToken currentAccessToken])
    {
        NSLog(@"Token is available : %@",[[FBSDKAccessToken currentAccessToken]tokenString]);
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, link, first_name, last_name, picture.type(large), email, birthday, bio ,location ,friends ,hometown , friendlists"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             
             //---- Hide HUD View ---
             [kAppDelegete removeHUDVIEW];
             
             if (!error)
             {
                 NSLog(@"result is :%@", result);
                 
                 //--- Current screen data ---
                 [[CommonUtility sharedInstance] initializeFacebookUser:result];
                 
                 [self performSegueWithIdentifier:@"signupoptions" sender:nil];
             }
             else
             {
                 NSLog(@"Error %@",error);
                 
                  kCustomAlertWithParamAndTargetDelegate(@"Message",error.description, nil);
             }
         }];
    }
    
}

- (IBAction)forgotPasswordBtnClicked:(id)sender {
    
    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Message"
                                                          message:@"Please enter your email-id" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    myAlertView.tag = 100;
    myAlertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [myAlertView show];

   
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100) {
        self.myTextField =  [alertView textFieldAtIndex:0];
        
        NSLog(@"string entered=%@",self.myTextField.text);
        
        if (![[CommonUtility sharedInstance] Emailvalidate:self.myTextField.text]) {
            kCustomAlertWithParamAndTarget(@"Message", @"Email should be in valid format.", nil);
            return;
        }
        else
        {
            NSDictionary *param = @{@"email":self.myTextField.text};
            
            
            [[IQWebService service]forgotPasswordApiWithParameters:param CompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                NSDictionary * jsonObject = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                NSLog(@"jsonObject :- %@", jsonObject);
                
            }];
        }
    }else{
    
        if (buttonIndex == 1) {
            //--- Fetch user info from Facebook
            [self fetchUserInfo];
        }
    }
    
}

#pragma mark textField delegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark API Call
#pragma mark signIn API Call
-(void)signInAPI:(NSString *)email password:(NSString *)password{
    
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable){
        kCustomAlertWithParamAndTarget(@"Message", @"Internet connection not available.", nil);
        return;
    }
    
    [kAppDelegete showHUDVIEW:self.view];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                email, @"name",
                                password, @"pass",
                                nil];
    
    [[IQWebService service] signIn:parameters completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //---- Hide HUD View ---
        [kAppDelegete removeHUDVIEW];
        
        NSUInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
        if (error == nil && statusCode == 401){
        
            NSString* errorStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            kCustomAlertWithParamAndTarget(@"Message", errorStr, nil);
            return ;
        }
        
        if (!error && statusCode == 200) {
            
            //--- Save Device Token on Server ---
            [self saveDeviceTokenAPI];
            
            //--- Get login token ---
            NSError *error = nil;
            NSDictionary * jsonObject = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSLog(@"jsonObject :- %@", jsonObject);
            
            //--- Store user info ---
            [[CommonUtility sharedInstance] initializeUser:jsonObject];
            
            //--- Store User Token ---
            [[NSUserDefaults standardUserDefaults] setValue:[[CommonUtility sharedInstance].userDictionary valueForKey:@"token"] forKey:XCSRFToken];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            //--- Navigate to home screen ---
            ETMenuViewController *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"UNEYEMenuViewController"];
            [self.navigationController pushViewController:controller animated:YES];
            
        } else {
            
            if (error) {
                kCustomAlertWithParamAndTarget(@"Message", error.localizedDescription, nil);
            }else{
            
                NSError *error = nil;
                NSDictionary * jsonObject = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                NSLog(@"jsonObject :- %@", jsonObject);
            }
        }
    }];
}


#pragma mark save Device Token API Call
-(void)saveDeviceTokenAPI{
    
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable){
        kCustomAlertWithParamAndTarget(@"Message", @"Internet connection not available.", nil);
        return;
    }
    
    [kAppDelegete showHUDVIEW:self.view];
    
    NSString *deviceTokenStr;
    
    if ( [CommonUtility sharedInstance].deviceToken.length > 0) {
        deviceTokenStr = [CommonUtility sharedInstance].deviceToken;
    }else{
        
        deviceTokenStr = @"";
    }

    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                       deviceTokenStr, @"token",
                                       @"ios", @"type",
                                       nil];
    
    [[IQWebService service] saveDeviceToken:parameters completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //---- Hide HUD View ---
        [kAppDelegete removeHUDVIEW];
        
        NSUInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
        if (error == nil && statusCode == 401){
            
            //NSString* errorStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //kCustomAlertWithParamAndTarget(@"Message", errorStr, nil);
            return ;
        }
        
        if (!error && statusCode == 200) {
            
            //--- Get login token ---
            NSError *error = nil;
            NSDictionary * jsonObject = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSLog(@"jsonObject :- %@", jsonObject);
            
            
        } else {
            
            if (error) {
                //kCustomAlertWithParamAndTarget(@"Message", error.localizedDescription, nil);
            }else{
                
                NSError *error = nil;
                NSDictionary * jsonObject = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                NSLog(@"jsonObject :- %@", jsonObject);
            }
        }
    }];
}

#pragma mark API Call
-(void)getUserInfo:(NSString *)access_token{
    
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable){
        kCustomAlertWithParamAndTarget(@"Message", @"Internet connection not available.", nil);
        return;
    }
    
    [kAppDelegete showHUDVIEW:self.view];
    
    NSDictionary *headers;
    if ([[CommonUtility sharedInstance].userDictionary valueForKey:@"token"]) {
        headers = @{@"token": [[CommonUtility sharedInstance].userDictionary valueForKey:@"token"]};
    }
    
    if ([[CommonUtility sharedInstance].userDictionary valueForKey:@"sessid"]) {
        [headers setValue:[[CommonUtility sharedInstance].userDictionary valueForKey:@"sessid"] forKey:@"sessid"];
    }
    
    if ([[CommonUtility sharedInstance].userDictionary valueForKey:@"session_name"]) {
        [headers setValue:[[CommonUtility sharedInstance].userDictionary valueForKey:@"session_name"] forKey:@"session_name"];
    }
    
    [[IQWebService service] getUserInfo:headers userid:[[CommonUtility sharedInstance].userDictionary valueForKey:@"userid"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //---- Hide HUD View ---
        [kAppDelegete removeHUDVIEW];
        
        NSUInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
        if (!error && statusCode == 200) {
            
            //--- Get login token ---
            NSError *error = nil;
            NSDictionary * jsonObject = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSLog(@"jsonObject :- %@", jsonObject);
            
            //--- Store user info ---
            [[CommonUtility sharedInstance] initializeUser:jsonObject];
            
            //--- Navigate to home screen ---
            ETMenuViewController *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"UNEYEMenuViewController"];
            [self.navigationController pushViewController:controller animated:YES];
            
        } else {
            kCustomAlertWithParamAndTarget(@"Message", error.localizedDescription, nil);
        }
    }];
}

#pragma mark API Call
-(void)signupAPI:(NSString *)email password:(NSString *)password confirmpassword:(NSString *)confirmpassword{
    
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable){
        kCustomAlertWithParamAndTarget(@"Message", @"Internet connection not available.", nil);
        return;
    }
    
    [kAppDelegete showHUDVIEW:self.view];
   
    NSDictionary *familyMem = [[NSDictionary alloc] initWithObjectsAndKeys:@{ @"name": @"seekername11", @"age": @"12",@"requirements": @"abc"}, @"family_member", nil];
    
    NSArray *arr = [[NSArray alloc] initWithObjects:familyMem, familyMem, nil];
    
    NSDictionary *careType = [[NSDictionary alloc] initWithObjectsAndKeys:@{ @"value": @"provider about me blah blah"}, @"field_typeofcare", nil];
    
    NSArray *arr2 = [[NSArray alloc] initWithObjects:careType, careType, nil];
    
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:
                                @"e@g.com", @"mail",
                                @"qwerty", @"pass",
                                @"e@g.com", @"mail",
                                @"1", @"status",
                                @"e@g.com", @"conf_mail",
                                @"AmitP", @"name",
                                @"This is the job provider", @"field_about",
                                arr, @"family_member",
                                arr2, @"field_typeofcare",
                                nil];
    
    [[IQWebService service] signup:parameters completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //---- Hide HUD View ---
        [kAppDelegete removeHUDVIEW];
        
        NSUInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
        if (!error && statusCode == 200) {
            //--- Registeration success ---
            kCustomAlertWithParamAndTarget(@"Congratulation!", @"Your registaration process have been successfully completed.", nil);
            //--- Back to login screen ---
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            
            kCustomAlertWithParamAndTarget(@"Message", error.localizedDescription, nil);
            
            NSError *error = nil;
            NSDictionary * jsonObject = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSLog(@"jsonObject :- %@", jsonObject);
        }
    }];
}

#pragma mark logout API Call
-(void)logout{
    
        NSDictionary *headers = @{ @"sessid": [[CommonUtility sharedInstance].userDictionary valueForKey:@"sessid"],
                                   @"session_name": [[CommonUtility sharedInstance].userDictionary valueForKey:@"session_name"],
                                   @"token": [[CommonUtility sharedInstance].userDictionary valueForKey:@"token"]};
        
        [[IQWebService service] logout:headers completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            //---- Hide HUD View ---
            [kAppDelegete removeHUDVIEW];
            
            NSUInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
            if (!error && statusCode == 200) {
                
                //--- Get login token ---
                NSError *error = nil;
                NSDictionary * jsonObject = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                NSLog(@"jsonObject :- %@", jsonObject);
                
                //--- Store user info ---
                [[CommonUtility sharedInstance] initializeUser:jsonObject];
                
                //--- Navigate to home screen ---
                ETMenuViewController *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"UNEYEMenuViewController"];
                [self.navigationController pushViewController:controller animated:YES];
                
            } else {
                
                if (error) {
                    kCustomAlertWithParamAndTarget(@"Message", error.localizedDescription, nil);
                }else{
                    
                    NSError *error = nil;
                    NSDictionary * jsonObject = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                    NSLog(@"jsonObject :- %@", jsonObject);
                }
            }
        }];
}

#pragma mark get session API Call
-(void)getSessionID{
    
    [[IQWebService service] getSessionID:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //---- Hide HUD View ---
        [kAppDelegete removeHUDVIEW];
        
        NSUInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
        if (!error && statusCode == 200) {
            
            //--- Get login token ---
            NSString * tokenStr =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"tokenStr :- %@", tokenStr);
            
            //--- Store user info ---
            [[CommonUtility sharedInstance].userDictionary setValue:tokenStr forKey:@"token"];
            
        } else {
            
            if (error) {
                kCustomAlertWithParamAndTarget(@"Message", error.localizedDescription, nil);
            }else{
    
                NSLog(@"error");
            }
        }
    }];
}

#pragma mark API Call
-(void)searchUserByKeyWord:(NSString *)keyword{
    
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable){
        kCustomAlertWithParamAndTarget(@"Message", @"Internet connection not available.", nil);
        return;
    }
    
    [kAppDelegete showHUDVIEW:self.view];
    
    NSDictionary *headers;
    if ([[CommonUtility sharedInstance].userDictionary valueForKey:@"token"]) {
        headers = @{@"token": [[CommonUtility sharedInstance].userDictionary valueForKey:@"token"]};
    }
    
    if ([[CommonUtility sharedInstance].userDictionary valueForKey:@"sessid"]) {
        [headers setValue:[[CommonUtility sharedInstance].userDictionary valueForKey:@"sessid"] forKey:@"sessid"];
    }
    
    if ([[CommonUtility sharedInstance].userDictionary valueForKey:@"session_name"]) {
        [headers setValue:[[CommonUtility sharedInstance].userDictionary valueForKey:@"session_name"] forKey:@"session_name"];
    }
    
//    [[IQWebService service] searchByKeyWord:headers keyword:keyword completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        
//        //---- Hide HUD View ---
//        [kAppDelegete removeHUDVIEW];
//        
//        NSUInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
//        if (!error && statusCode == 200) {
//            
//            //--- Get login token ---
//            NSError *error = nil;
//            NSDictionary * jsonObject = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
//            NSLog(@"jsonObject :- %@", jsonObject);
//            
//            //--- Store user info ---
//            [[CommonUtility sharedInstance] initializeUser:jsonObject];
//            
//        } else {
//            
//            if (error) {
//                kCustomAlertWithParamAndTarget(@"Message", error.localizedDescription, nil);
//            }else{
//                
//                NSError *error = nil;
//                NSDictionary * jsonObject = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
//                NSLog(@"jsonObject :- %@", jsonObject);
//            }
//        }
//    }];
}

@end
