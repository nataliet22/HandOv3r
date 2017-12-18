//
//  ETMenuViewController.m
//  UNEYE
//
//  Created by Satya 2015 on 28/11/14.
//  Copyright (c) Satya 2015 All rights reserved.
//

#import "ETMenuViewController.h"

@interface ETMenuViewController ()

@end

@implementation ETMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)segueIdentifierForIndexPathInLeftMenu:(NSIndexPath *)indexPath
{
    NSString *identifier = @"";
    switch (indexPath.row) {

        case 0 :
        case 1 :
            identifier = @"home";
            break;
        case 2 :
            
            if ([[[[CommonUtility sharedInstance].userDictionary valueForKey:@"user"] valueForKey:userRole] isEqualToString:@"seeker"]){
            
                identifier = @"jobseekerprofile";
                
                //identifier = @"profile";
            }else{
            
                identifier = @"profile";
            }
            
            break;
        case 3 :
            identifier = @"messages";
            break;
        case 4 :
            identifier = @"bookings";
            break;
        case 5:
            identifier = @"savedprofiles";
            break;
        case 6:
            identifier = @"calender";
            break;
        case 7:
            identifier = @"invoices";
            break;
        case 8:
            identifier = @"faq";
            break;
        case 9:
            //--- Stay login ---
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLogin"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self closeLeftMenu];
            
            //--- Logout from API --
            [self logout];
            break;
    }
    
    return identifier;
}


- (CGFloat)leftMenuWidth
{
    return 250;
}

- (void)configureLeftMenuButton:(UIButton *)button
{
    CGRect frame = button.frame;
    frame = CGRectMake(10,0, 30, 20);
    button.frame = frame;
    button.backgroundColor = [UIColor clearColor];
    [button setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
}

- (void) configureSlideLayer:(CALayer *)layer
{
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOpacity = 1;
    layer.shadowOffset = CGSizeMake(0, 0);
    layer.shadowRadius = 5;
    layer.masksToBounds = NO;
    layer.shadowPath =[UIBezierPath bezierPathWithRect:self.view.layer.bounds].CGPath;
}

- (AMPrimaryMenu)primaryMenu
{
    return AMPrimaryMenuLeft;
}

- (BOOL)deepnessForLeftMenu
{
    return YES;
}
- (CGFloat)maxDarknessWhileLeftMenu
{
    return 0.5;
}

#pragma mark logout API Call
-(void)logout{
    
    NSMutableDictionary *headers = [NSMutableDictionary new];
    if ([[CommonUtility sharedInstance].userDictionary valueForKey:@"token"]) {
        [headers setValue:[[CommonUtility sharedInstance].userDictionary valueForKey:@"token"] forKey:@"X-CSRF-Token"];
    }
   
    if ([[CommonUtility sharedInstance].userDictionary valueForKey:@"sessid"]) {
        [headers setValue:[[CommonUtility sharedInstance].userDictionary valueForKey:@"sessid"] forKey:@"sessid"];
    }
    
    if ([[CommonUtility sharedInstance].userDictionary valueForKey:@"session_name"]) {
        [headers setValue:[[CommonUtility sharedInstance].userDictionary valueForKey:@"session_name"] forKey:@"session_name"];
    }
    
    //---- Hide HUD View ---
    [kAppDelegete showHUDVIEW:self.view];
    [[IQWebService service] logout:headers completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //---- Hide HUD View ---
        [kAppDelegete removeHUDVIEW];
        
        NSUInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
        if (!error && statusCode == 200) {
            
            //--- Get login token ---
            NSError *error = nil;
            NSDictionary * jsonObject = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSLog(@"jsonObject :- %@", jsonObject);
            
            //--- Logout successfully ---
            [[CommonUtility sharedInstance] initializeUser:jsonObject];
            //--- Remove User Token ---
            [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:XCSRFToken];
            [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:userdata];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            if ([CommonUtility sharedInstance].screenDataDictionary.count > 0) {
                [[CommonUtility sharedInstance].screenDataDictionary removeAllObjects];
            }
            
            //--- Logout compeletly ---
            [kAppDelegete logout];
            
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

@end
