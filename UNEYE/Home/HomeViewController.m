//
//  HomeViewController.m
//  UNEYE
//
//  Created by Satya Kumar on 10/03/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"At Home sharedInstance userDictionary :- %@", [CommonUtility sharedInstance].userDictionary);
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark API Call get Sale Representative List
-(void)getSaleRepresentativeList:(NSString *)email password:(NSString *)password{
    
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable){
        kCustomAlertWithParamAndTarget(@"Message", @"Internet connection not available.", nil);
        return;
    }
    
    [kAppDelegete showHUDVIEW:self.view];
    
    NSString *userId = [[[CommonUtility sharedInstance] userDictionary] valueForKey:@""];
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:
                                userId, @"id",
                                nil];
    
    [[IQWebService service] signIn:parameters completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
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

@end
