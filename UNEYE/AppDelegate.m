//
//  AppDelegate.m
//  UNEYE
//
//  Created by Satya Kumar on 07/03/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"
#import "BraintreeCore.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize dictionaryForImageCacheing=_dictionaryForImageCacheing;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // register Push Notification Center
    [self registerPushNotificationCenterAction];
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    
    [BTAppSwitch setReturnURLScheme:@"com.apptech.uneye.payments"];

    CGSize result = [[UIScreen mainScreen] bounds].size;
    
    switch ((int) result.height) {
        case 480:{
            //kCustomAlertWithParamAndTarget(@"Message", @"The minimum supporting device is iPhone 5.", nil);
            
            UIStoryboard *mStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *nvController = [mStoryboard instantiateViewControllerWithIdentifier:@"alertforsupportingdevice"];
            self.window.rootViewController = nvController;
            return NO;
            break;
        }
        default:
            NSLog(@"Other screen size, could be an iPad or new device model.");        
            break;
    }
    
    if (![[CommonUtility sharedInstance].userDictionary valueForKey:@"token"]) {
        [self getSessionID];
    }
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    return YES;
}

-(void)registerPushNotificationCenterAction{

    if(SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(@"10.0")){
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
            if( !error ){
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            }
        }];  
    }else{
    
        if([[UIApplication sharedApplication] respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
        {
            [[UIApplication sharedApplication] registerUserNotificationSettings:  [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound) categories:nil]];
            
            [[UIApplication sharedApplication] registerForRemoteNotifications];
        }
        else
        {
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIUserNotificationTypeAlert | UIUserNotificationTypeBadge |    UIUserNotificationTypeSound)];
        }

    }

}

//==================== Push Notification Delegates For iOS 9 ====================
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *devicetokenString = [[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""] stringByReplacingOccurrencesOfString: @">" withString: @""] stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    NSLog(@"Did Register for Remote Notifications with Device Token DATA (%@) \n STRING token (%@)", deviceToken, devicetokenString);
    
    //--- Store device token ---
    [CommonUtility sharedInstance].deviceToken = devicetokenString;
}

- (void)application:(UIApplication *)application  didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Did Fail to Register for Remote Notifications");
    NSLog(@"%s:%@, %@",__PRETTY_FUNCTION__,error, error.localizedDescription);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"Did Receive for Remote Notifications with UserInfo:%@", userInfo);
}

//==================== Push Notification Delegates For iOS 10 ====================
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    
    //Called when a notification is delivered to a foreground app.
    
    NSLog(@"Userinfo %@",notification.request.content.userInfo);
    
    completionHandler(UNNotificationPresentationOptionAlert);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
    
    //Called to let your app know which action was selected by the user for a given notification.
    
    NSLog(@"Userinfo %@",response.notification.request.content.userInfo);
    
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    if ([url.scheme localizedCaseInsensitiveCompare:@"com.apptech.uneye.payments"] == NSOrderedSame) {
        return [BTAppSwitch handleOpenURL:url sourceApplication:sourceApplication];
    }
    else
    {
        return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                              openURL:url
                                                    sourceApplication:sourceApplication
                                                           annotation:annotation];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.apptech.uneye.UNEYE" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"UNEYE" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"UNEYE.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark Logout
- (void)logout{

    UIStoryboard *mStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *nvController = [mStoryboard instantiateViewControllerWithIdentifier:@"loginrootnavigationcontroller"];
    self.window.rootViewController = nvController;
}

#pragma mark HUD VIEW Handler's
-(void)showHUDVIEW:(UIView *)view{
    
    if(HUD){
        [HUD removeFromSuperview];
    }
    
    HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.labelText = @"Please wait...";
    HUD.mode = MBProgressHUDModeIndeterminate;
    [HUD show:YES];
    [view addSubview:HUD];
}

-(void)showHUDWINDOWVIEW:(UIWindow *)window{
    
    if(HUD){
        [HUD removeFromSuperview];
    }
    
    HUD = [[MBProgressHUD alloc] initWithWindow:window];
    HUD.labelText = @"Please wait...";
    HUD.mode = MBProgressHUDModeIndeterminate;
    [HUD show:YES];
    [window addSubview:HUD];
}


-(void)removeHUDVIEW{
    
    if(HUD)
        [HUD removeFromSuperview];
}

#pragma mark get session API Call
-(void)getSessionID{
    
    //---- Show HUD View ---
    [kAppDelegete showHUDWINDOWVIEW:self.window];
    
    [[IQWebService service] getSessionID:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //---- Hide HUD View ---
        [kAppDelegete removeHUDVIEW];
        
        NSUInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
        if (!error && statusCode == 200) {
            
            //--- Get login token ---
            NSString * tokenStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"tokenStr :- %@", tokenStr);
            
            if (![[[NSUserDefaults standardUserDefaults] valueForKey:XCSRFToken] isEqualToString:tokenStr]) {
                return ;
            }
            
            //--- Restore User data ---
            NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:userdata];
            NSMutableDictionary *savedUserData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [[CommonUtility sharedInstance] initializeUser:savedUserData];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            //--- Navigate to home screen ---
            UIStoryboard *mStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ETMenuViewController *controller=[mStoryboard instantiateViewControllerWithIdentifier:@"UNEYEMenuViewController"];
            self.window.rootViewController = controller;
        } else {
            
            //--- Navigate to login screen ---
            UIStoryboard *mStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UINavigationController *navigationController = [mStoryboard instantiateViewControllerWithIdentifier:@"loginrootnavigationcontroller"];
            UIViewController *loginController = [mStoryboard instantiateViewControllerWithIdentifier:@"objLoginViewController"];
            
            [navigationController setViewControllers:[NSArray arrayWithObjects:loginController, nil] animated:YES];
            self.window.rootViewController = navigationController;
            
            if (error) {
                kCustomAlertWithParamAndTarget(@"Message", error.localizedDescription, nil);
            }else{
                
                NSLog(@"error");
            }
        }
    }];
}

@end
