//
//  Constant.h
//  UNEYE
//
//  Created by Satya Kumar on 27/08/15.
//  Copyright (c) 2015 Satya Kumar. All rights reserved.
//

// ************** Version Checks ************

#define IS_OS_5_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define IS_OS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

//**************** Alert *******************

#define ShowAlert(title,msg,target) [[[UIAlertView alloc] initWithTitle:title message:msg delegate:target cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show]

#define kKeyHudMessage                      @"Please wait"

#define kKeyIsInternetAvailabel             [[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable

#define kKeyInternetAlertTitle                    @"Message"
#define kKeyInternetAlertMessage            @"Internet connection not available."
#define kKeyInternetAlertDismissTitle       @"dismiss"

#define kKeyErrorAlertTitle                       @"Error Message"
#define kKeyErrorAlertMessage               @"Error occured, please try again later."
#define kKeyErrorAlertDismissTitle          @"dismiss"

#define DOCUMENT_DIR_PATH   [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define USER_PLIST_NAME     @"/UserData.plist"

//**************** Base URL & Methods *******************
#define BaseUrl             @"http://xyz.com/"

#define MethodName           @"methodname"

//**************** location service massage *******************

#define kLocationMassage @"Your location settings are off, please turn on your location for the app to function properly."

//**************** Custom Log Defines *******************
#define DevLog NSLog(@"Dev Log - \"%s\"", __PRETTY_FUNCTION__)
/* if(0)--> for stop print the log text on console
 *  if(1)--> for start print the log text on console
 */

#define kFontSize    20
#define kUIDefult    0
#define NSLog if(1) NSLog

//************ Google API *************************
static NSString * const kGoogleClientId = @"527464938404-cioa6bf6fhjls38cjtsmur53vtfkb1s9.apps.googleusercontent.com";

//************************************************//************************************************

