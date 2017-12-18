//
//  IQWebService.m
//  UNEYE
//
//  Created by Satya on 29/03/16.
//  Copyright (c) 2013 Apptech. All rights reserved.
//

#import "IQWebService.h"

//POST
NSString *WEBSERVICE_REGISTER                       =   @"/register/user";
NSString *WEBSERVICE_SIGNIN                         =   @"/user/login";
NSString *WEBSERVICE_SAVE_DEVICE_TOKEN              =   @"/push_notifications";
NSString *WEBSERVICE_FORGOTPASSWORD                 =   @"/user/request_new_password";
NSString *WEBSERVICE_LOGOUT                         =   @"/user/logout";
NSString *WEBSERVICE_GETSESSIONID                   =   @"http://199.175.48.83/sitter/services/session/token";
NSString *WEBSERVICE_LOGINWITHFACEBOOKTOKEN         =   @"/fboauth/connect";
NSString *WEBSERVICE_SUBMITAPPPOINTMENT             =   @"/node";
NSString *WEBSERVICE_SENDINGMESSAGEWITHINTHREAD     =   @"/msg";
NSString *WEBSERVICE_ADDEVENT                       =   @"/node";

//PUT
NSString *WEBSERVICE_SAVEDPROFILE                   =   @"/user/";
NSString *WEBSERVICE_UPDATEPROFILE                  =   @"/user/";

//GET
NSString *WEBSERVICE_USERINFO                       =   @"/user/";
NSString *WEBSERVICE_SEARCHUSERBYNAME               =   @"/search_user?name=";
NSString *WEBSERVICE_SEARCHBYQUERY                  =   @"/search_user?";

NSString *WEBSERVICE_GETBOOKINGS                    =   @"/appointment";
NSString *WEBSERVICE_GETBOOKINGSDETAIL              =   @"/appointment?nid=";
NSString *WEBSERVICE_GETFULLUSERDETAILS             =   @"/user/";
NSString *WEBSERVICE_GETALLINVOICES                 =   @"/invoices";
NSString *WEBSERVICE_GETALLINVOICEDETAIL            =   @"/invoices?nid=";
NSString *WEBSERVICE_GETBRAINTREETOKEN              =   @"/braintree-token";

NSString *WEBSERVICE_GETALLMESSAGES                 =   @"/usermsg/";
NSString *WEBSERVICE_GETALLMESSAGESFORTHREAD        =   @"/thread/";
NSString *WEBSERVICE_GETALLSAVEDPROFILE             =   @"/favouraite";
NSString *WEBSERVICE_GETALLEVENTS                   =   @"/events";

@implementation IQWebService
{
    NSString *serviceURL;
    NSOperationQueue *operationQueue;
}

@synthesize logEnabled = _logEnabled;

- (id)init
{
    self = [super init];
    if (self)
    {
        //serviceURL = @"http://162.208.11.30/sitter/apiv1";
        
        //--- New API Link ---
        serviceURL = @"http://199.175.48.83/sitter/apiv1";
        
    }
    return self;
}

+(IQWebService*)service
{
    static IQWebService *sharedService;
    if (sharedService == nil)
    {
        sharedService = [[IQWebService alloc] init];
    }
    
    return sharedService;
}

-(void)setLogEnabled:(BOOL)logEnabled
{
    _logEnabled = logEnabled;
}

-(BOOL)isLogEnabled
{
    return _logEnabled;
}

+(NSMutableURLRequest*)requestWithURL:(NSURL*)url httpMethod:(NSString*)httpMethod contentType:(NSString*)contentType body:(NSData*)body
{
    if (url != nil)
    {
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:300];
        
        if ([httpMethod length])    [request setHTTPMethod:httpMethod];
        if ([contentType length])   [request addValue:contentType forHTTPHeaderField:kIQContentType];
        if ([body length])          [request setHTTPBody:body];
        
        return request;
    }
    else
    {
        return nil;
    }
}

-(void)sendAsyncronousRequest:(NSURLRequest*)request withCompletionHandler:(IQCompletionBlock)completionHandler
{
    if (_logEnabled)
    {
        NSLog(@"RequestURL:- %@",request.URL);
        NSLog(@"HTTPHeaderFields:- %@",request.allHTTPHeaderFields);
        NSLog(@"Body:- %@",[[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding]);
    }
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:request
                completionHandler:^(NSData *data,
                                    NSURLResponse *response,
                                    NSError *error) {
                    // handle response
                    if (_logEnabled)
                    {
                        NSLog(@"URL:- %@",request.URL);
                        
                        if (error)	NSLog(@"error:- %@",error);
                        else		NSLog(@"Response:- %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                    }
                    
                    if (completionHandler != NULL)
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            completionHandler(data, response, error);
                        });
                    }
                    
                }] resume];
}

#pragma webservice methods
#pragma mark Sign Up
-(void)signup:(NSDictionary*)attribute completionHandler:(IQCompletionBlock)completionHandler{
    
    NSDictionary *parameters = [NSMutableDictionary new];
    NSArray *keys = [attribute allKeys];
    
    for (NSString *key in keys) {
        [parameters setValue:[attribute valueForKey:key] forKey:key];
    }
    
//    NSDictionary *parameters = @{ @"name": [attribute valueForKey:@"name"],
//                                  @"pass": [attribute valueForKey:@"pass"],
//                                  @"mail": [attribute valueForKey:@"mail"],
//                                  @"status": [attribute valueForKey:@"status"],
//                                  @"conf_mail": [attribute valueForKey:@"mail"]};
    
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error];

    NSString * jSonStr =[[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
    NSLog(@"jSonStr :- %@", jSonStr);
    
    NSLog(@"Json error :- %@", error);
    
    NSString *urlString = [[NSString stringWithFormat:@"%@%@",serviceURL,WEBSERVICE_REGISTER] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSLog(@"urlString :- %@", urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [IQWebService requestWithURL:url httpMethod:kIQHTTPMethodPOST contentType:kIQContentTypeApplicationJson body:postData];
    [self sendAsyncronousRequest:request withCompletionHandler:completionHandler];
}

#pragma mark Update Profile
-(void)updateProfile:(NSDictionary*)attribute headers:(NSMutableDictionary *)headers userId:(NSString *)userId completionHandler:(IQCompletionBlock)completionHandler{
    
    NSDictionary *parameters = [NSMutableDictionary new];
    NSArray *keys = [attribute allKeys];
    
    for (NSString *key in keys) {
        [parameters setValue:[attribute valueForKey:key] forKey:key];
    }
    
    //    NSDictionary *parameters = @{ @"name": [attribute valueForKey:@"name"],
    //                                  @"pass": [attribute valueForKey:@"pass"],
    //                                  @"mail": [attribute valueForKey:@"mail"],
    //                                  @"status": [attribute valueForKey:@"status"],
    //                                  @"conf_mail": [attribute valueForKey:@"mail"]};
    
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error];
    
    NSString * jSonStr =[[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
    NSLog(@"jSonStr :- %@", jSonStr);
    
    NSLog(@"Json error :- %@", error);
    
    NSString *urlString = [[NSString stringWithFormat:@"%@%@%@",serviceURL,WEBSERVICE_UPDATEPROFILE, userId] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSLog(@"urlString :- %@", urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [IQWebService requestWithURL:url httpMethod:kIQHTTPMethodPUT contentType:kIQContentTypeApplicationJson body:postData];
    [request setAllHTTPHeaderFields:headers];
    [self sendAsyncronousRequest:request withCompletionHandler:completionHandler];
}

/*
-(void)signup:(NSDictionary*)attribute completionHandler:(IQCompletionBlock)completionHandler
{
NSDictionary *headers = @{ @"content-type": @"multipart/form-data; boundary=---011000010111000001101001",
                           @"cache-control": @"no-cache",
                           @"postman-token": @"f07451d2-f484-35f2-19a5-c804866c35b2"};
NSArray *parameters = @[ @{ @"name": @"name", @"value": @"ss5" },
                         @{ @"name": @"mail", @"value": @"ss5@g.com" },
                         @{ @"name": @"pass", @"value": @"qwerty" },
                         @{ @"name": @"status", @"value": @"1" },
                         @{ @"name": @"conf_mail", @"value": @"ss5@g.com" },
                         //@{ @"name": @"files", @"fileName": @{ @"0": @{  } } },
                         @{ @"name": @"field_role[und]", @"value": @"provider" },
                         @{ @"name": @"field_typeofcare[und][0][value]", @"value": @"sitter" },
                         @{ @"name": @"field_about[und][0][value]", @"value": @"i am good" },
                         @{ @"name": @"family_member[0][name]", @"value": @"ammm" },
                         @{ @"name": @"family_member[0][age]", @"value": @"23" },
                         @{ @"name": @"family_member[0][requirements]", @"value": @"couch" } ];
NSString *boundary = @"---011000010111000001101001";

NSError *error;
NSMutableString *body = [NSMutableString string];
for (NSDictionary *param in parameters) {
    [body appendFormat:@"--%@\r\n", boundary];
    if (param[@"fileName"]) {
        [body appendFormat:@"Content-Disposition:form-data; name=\"%@\"; filename=\"%@\"\r\n", param[@"name"], param[@"fileName"]];
        [body appendFormat:@"Content-Type: %@\r\n\r\n", param[@"contentType"]];
        [body appendFormat:@"%@", [NSString stringWithContentsOfFile:param[@"fileName"] encoding:NSUTF8StringEncoding error:&error]];
        if (error) {
            NSLog(@"%@", error);
        }
    } else {
        [body appendFormat:@"Content-Disposition:form-data; name=\"%@\"\r\n\r\n", param[@"name"]];
        [body appendFormat:@"%@", param[@"value"]];
    }
}
[body appendFormat:@"\r\n--%@--\r\n", boundary];
NSData *postData = [body dataUsingEncoding:NSUTF8StringEncoding];

NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://162.208.11.30/sitter/apiv1/user/register"]
                                                       cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                   timeoutInterval:10.0];
[request setHTTPMethod:@"POST"];
[request setAllHTTPHeaderFields:headers];
[request setHTTPBody:postData];

NSURLSession *session = [NSURLSession sharedSession];
NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                if (error) {
                                                    NSLog(@"%@", error);
                                                } else {
                                                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                    NSLog(@"%@", httpResponse);
                                                }
                                            }];
[dataTask resume];
}
*/

//-(void)signup:(NSDictionary*)attribute completionHandler:(IQCompletionBlock)completionHandler
//{
//    
//    
//     NSDictionary *headers = @{ @"content-type": @"multipart/form-data; boundary=---011000010111000001101001",
//     @"cache-control": @"no-cache",
//     @"postman-token": @"081491ba-aa1f-bc6b-e44a-217489137704" };
//     NSArray *parameters = @[ @{ @"name": @"name", @"value": [attribute valueForKey:@"name"]},
//     @{ @"name": @"mail", @"value": [attribute valueForKey:@"mail"] },
//     @{ @"name": @"pass", @"value": [attribute valueForKey:@"pass"] },
//     @{ @"name": @"status", @"value": [attribute valueForKey:@"status"] },
//     @{ @"name": @"conf_mail", @"value": [attribute valueForKey:@"conf_mail"]},
//     //@{ @"name": @"files", @"fileName": @{ @"0": @{ }} },
////     @{ @"name": @"field_role[und]", @"value": [attribute valueForKey:@"field_role[und]"] },
////     @{ @"name": @"field_typeofcare[und][0][value]", @"value": [attribute valueForKey:@"field_typeofcare[und][0][value]"] },
////     @{ @"name": @"field_about[und][0][value]", @"value": [attribute valueForKey:@"field_about[und][0][value]"] },
////     @{ @"name": @"family_member[0][name]", @"value": [attribute valueForKey:@"family_member[0][name]"] },
////     @{ @"name": @"family_member[0][age]", @"value": [attribute valueForKey:@"family_member[0][age]"] },
////     @{ @"name": @"family_member[0][requirements]", @"value": [attribute valueForKey:@"family_member[0][requirements]"] }
//    ];
//     NSString *boundary = @"---011000010111000001101001";
//     
//     NSError *error;
//     NSMutableString *body = [NSMutableString string];
//     for (NSDictionary *param in parameters) {
//     //[body appendFormat:@"--\r\n%@\r\n", boundary];
//     [body appendFormat:@"\r\n"];
//     if (param[@"fileName"]) {
//     [body appendFormat:@"Content-Disposition:form-data; name=\"%@\"; filename=\"%@\"\r\n", param[@"name"], param[@"fileName"]];
//     [body appendFormat:@"Content-Type: %@\r\n\r\n", param[@"contentType"]];
//     [body appendFormat:@"%@", [NSString stringWithUTF8String:[[attribute objectForKey:@"profileimage"] bytes]]];
//     if (error) {
//     NSLog(@"%@", error);
//     }
//     } else {
//     //[body appendFormat:@"Content-Disposition:form-data; name=\"%@\"\r\n\r\n", param[@"name"]];
//     [body appendFormat:@"name=\"%@\"\r\n\r\n", param[@"name"]];
//     [body appendFormat:@"%@", param[@"value"]];
//     }
//     }
//    
//     [body appendFormat:@"\r\n"];
//     //[body appendFormat:@"\r\n--%@--\r\n", boundary];
//     NSData *postData = [body dataUsingEncoding:NSUTF8StringEncoding];
//    
//     NSLog(@"body :- %@", body);
//    
//    /*
//     NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://162.208.11.30/sitter/apiv1/user/register"]
//     cachePolicy:NSURLRequestUseProtocolCachePolicy
//     timeoutInterval:10.0];
//     [request setHTTPMethod:@"POST"];
//     [request setAllHTTPHeaderFields:headers];
//     [request setHTTPBody:postData];
//     
//     NSURLSession *session = [NSURLSession sharedSession];
//     NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
//     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//     if (error) {
//     NSLog(@"%@", error);
//     } else {
//     NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
//     NSLog(@"%@", httpResponse);
//     }
//     }];
//     [dataTask resume];
//    */
//  /*
//    NSMutableDictionary *parameters = [attribute mutableCopy];
//    
//    NSError *error;
//    NSMutableString *body = [NSMutableString string];
//    
//    NSArray *allKeys = [parameters allKeys];
//    NSString *boundary = @"---011000010111000001101001";
//    
//    for (NSString *key in allKeys) {
//        
//        NSData *imageData;
//        if (![[parameters valueForKey:key] isKindOfClass:[NSString class]]) {
//             imageData = [parameters objectForKey:key];
//        }
//       
//        [body appendFormat:@"--%@\r\n", boundary];
//        if (imageData) {
//            [body appendFormat:@"Content-Disposition:form-data; name=\"%@\"; filename=\"%@\"\r\n", key, parameters[key]];
//            [body appendFormat:@"Content-Type: %@\r\n\r\n", parameters[@"contentType"]];
//            [body appendFormat:@"%@", imageData];
//            if (error) {
//                NSLog(@"%@", error);
//            }
//        } else {
//            [body appendFormat:@"Content-Disposition:form-data; name=\"%@\"\r\n\r\n", key];
//            [body appendFormat:@"%@", parameters[key]];
//        }
//    }
//    
//    [body appendFormat:@"\r\n--%@--\r\n", boundary];
//    NSData *postData = [body dataUsingEncoding:NSUTF8StringEncoding];
//    
//    NSLog(@"body :- %@", body);
//    */
//    
////    NSData *imageData = UIImageJPEGRepresentation(parameters[@"profileimage"], 1.0);
////    //--- Remove UIImage Object ---
////    [parameters removeObjectForKey:@"profileimage"];
////    
////    NSMutableData *body = [[NSMutableData alloc] init];
////    NSArray *allKeys = [parameters allKeys];
////    
////    for (NSString *key in allKeys) {
////        
////        NSString *boundary = @"14737809831466499882746641449";
////        //NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
////        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
////        
////        //---- Append Image Data ---
////        if (imageData) {
////            
////            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"profileimage.png\"\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
////            [body appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
////            [body appendData:[NSData dataWithData:imageData]];
////            [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
////        }else{
////            
////            [body appendData:[[NSString stringWithFormat:@"Content-Disposition:form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
////            [body appendData:[[NSString stringWithFormat:@"%@", key] dataUsingEncoding:NSUTF8StringEncoding]];
////        }
////    }
////    
////    
////    
////    NSString * convertedStr =[[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
////    NSLog(@"convertedString :- %@", convertedStr);
//    
//    
//    NSString *urlString = [[NSString stringWithFormat:@"%@%@",serviceURL,WEBSERVICE_REGISTER] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
//    
//    NSURL *url = [NSURL URLWithString:urlString];
//    //NSMutableURLRequest *request = [IQWebService requestWithURL:url httpMethod:kIQHTTPMethodPOST contentType:kIQContentTypeApplicationJson body:postData];
//    NSMutableURLRequest *request = [IQWebService requestWithURL:url httpMethod:kIQHTTPMethodPOST contentType:kIQContentTypeMultipartFormData body:postData];
//    //[request setAllHTTPHeaderFields:headers];
//    [self sendAsyncronousRequest:request withCompletionHandler:completionHandler];
//}

/*
 -(void)signup:(NSDictionary*)attribute completionHandler:(IQCompletionBlock)completionHandler
 {
 //--- family member Formatted in JSON ---
 NSArray *arrFamily_member = [attribute objectForKey:@"family_member"];
 int i = 0;
 NSDictionary *dictFamily_member = [[NSDictionary alloc] init];
 for (NSMutableDictionary *dict in arrFamily_member) {
 [dictFamily_member setValue:dict forKey:[NSString stringWithFormat:@"%d", i]];
 i++;
 }
 
 //--- Typeofcare Formatted in JSON ---
 NSArray *arrTypeofcare = [attribute objectForKey:@"field_typeofcare"];
 i = 0;
 NSDictionary *dictTypeofcare = [[NSDictionary alloc] init];
 for (NSMutableDictionary *dict in arrTypeofcare) {
 [dictTypeofcare setValue:dict forKey:[NSString stringWithFormat:@"%d", i]];
 i++;
 }
 
 NSDictionary *parameters = @{ @"name": [attribute objectForKey:@"mail"],
 @"pass": [attribute objectForKey:@"pass"],
 @"mail": [attribute objectForKey:@"mail"],
 @"status": [attribute objectForKey:@"status"],
 @"conf_mail": [attribute objectForKey:@"mail"],
 @"field_role": @{ @"und": [attribute objectForKey:@"userType"] },
 @"field_name": @{ @"und": @{ @"0": @{ @"value": [attribute objectForKey:@"name"] } } },
 @"field_typeofcare": @{ @"und": dictTypeofcare },
 @"field_about": @{ @"und": @{ @"0": @{ @"value": [attribute objectForKey:@"field_about"] } } },
 @"family_member": dictFamily_member };
 
 NSError *error;
 NSData *postdata = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error];
 
 NSString *urlString = [[NSString stringWithFormat:@"%@%@",serviceURL,WEBSERVICE_REGISTER] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
 
 NSURL *url = [NSURL URLWithString:urlString];
 NSURLRequest *request = [IQWebService requestWithURL:url httpMethod:kIQHTTPMethodPOST contentType:kIQContentTypeApplicationJson body:postdata];
 [self sendAsyncronousRequest:request withCompletionHandler:completionHandler];
 }
 */

#pragma mark Get Token With Login
-(void)signIn:(NSDictionary*)attribute completionHandler:(IQCompletionBlock)completionHandler
{
    NSDictionary *parameters = @{ @"name": [attribute valueForKey:@"name"],
                                  @"pass": [attribute valueForKey:@"pass"]};
    
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error];
    
    NSLog(@"Json error :- %@", error);
    
    NSString *urlString = [[NSString stringWithFormat:@"%@%@",serviceURL,WEBSERVICE_SIGNIN] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSLog(@"urlString :- %@", urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [IQWebService requestWithURL:url httpMethod:kIQHTTPMethodPOST contentType:kIQContentTypeApplicationJson body:postData];
    [self sendAsyncronousRequest:request withCompletionHandler:completionHandler];
}

#pragma mark save Device Token after Login
-(void)saveDeviceToken:(NSDictionary*)attribute completionHandler:(IQCompletionBlock)completionHandler
{
    
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:attribute options:0 error:&error];
    
    NSLog(@"Json error :- %@", error);
    
    NSString *urlString = [[NSString stringWithFormat:@"%@%@",serviceURL,WEBSERVICE_SAVE_DEVICE_TOKEN] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSLog(@"urlString :- %@", urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [IQWebService requestWithURL:url httpMethod:kIQHTTPMethodPOST contentType:kIQContentTypeApplicationJson body:postData];
    [self sendAsyncronousRequest:request withCompletionHandler:completionHandler];
}

#pragma logout with token
-(void)logout:(NSDictionary*)attribute completionHandler:(IQCompletionBlock)completionHandler{
    
    NSMutableDictionary *headers = [NSMutableDictionary new];
    NSArray *keys = [attribute allKeys];
    
    for (NSString *key in keys) {
        [headers setValue:[attribute valueForKey:key] forKey:key];
    }
    
    NSString *urlString = [[NSString stringWithFormat:@"%@%@",serviceURL,WEBSERVICE_LOGOUT] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSLog(@"urlString :- %@", urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [IQWebService requestWithURL:url httpMethod:kIQHTTPMethodPOST contentType:nil body:nil];
    [request setAllHTTPHeaderFields:headers];
    [self sendAsyncronousRequest:request withCompletionHandler:completionHandler];
}

#pragma mark Get User Info
-(void)getUserInfo:(NSDictionary*)attribute userid:(NSString *)userid completionHandler:(IQCompletionBlock)completionHandler
{
    NSMutableDictionary *headers = [NSMutableDictionary new];
    NSArray *keys = [attribute allKeys];
    
    for (NSString *key in keys) {
        [headers setValue:[attribute valueForKey:key] forKey:key];
    }
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",serviceURL,WEBSERVICE_USERINFO,userid]];
    NSMutableURLRequest *request = [IQWebService requestWithURL:url httpMethod:kIQHTTPMethodGET contentType:nil body:nil];
    [request setAllHTTPHeaderFields:headers];
    [self sendAsyncronousRequest:request withCompletionHandler:completionHandler];
}

#pragma mark get SessionID
-(void)getSessionID :(IQCompletionBlock)completionHandler
{

    NSString *urlString = [[NSString stringWithFormat:@"%@",WEBSERVICE_GETSESSIONID] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    NSLog(@"urlString :- %@", urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [IQWebService requestWithURL:url httpMethod:kIQHTTPMethodPOST contentType:nil body:nil];
    [self sendAsyncronousRequest:request withCompletionHandler:completionHandler];
    
}

#pragma mark Search by query
-(void)searchByQuery:(NSDictionary*)attribute queryParam:(NSDictionary*)queryParam completionHandler:(IQCompletionBlock)completionHandler
{
    NSMutableDictionary *headers = [NSMutableDictionary new];
    NSArray *keys = [attribute allKeys];
    
    for (NSString *key in keys) {
        [headers setValue:[attribute valueForKey:key] forKey:key];
    }
    
    NSMutableString *parameterStr;
    NSArray *allKeys = [queryParam allKeys];
    
    NSString *lastKey = [allKeys lastObject];
    
    for (NSString *key in allKeys) {
        
        if ([lastKey isEqualToString:key]) {
            if ([allKeys count] == 1) {
                parameterStr = [NSMutableString stringWithFormat:@"%@=%@", key, [queryParam valueForKey:key]];
            }
            else {
                [parameterStr appendFormat:@"%@=%@", key, [queryParam valueForKey:key]];
            }
        }
        else {
            if (!parameterStr) {
                parameterStr = [NSMutableString stringWithFormat:@"%@=%@&", key, [queryParam valueForKey:key]];
            }else{
                
                [parameterStr appendFormat:@"%@=%@&", key, [queryParam valueForKey:key]];
            }
        }
    }
    
    NSString *urlString = [[NSString stringWithFormat:@"%@%@%@", serviceURL, WEBSERVICE_SEARCHBYQUERY, parameterStr] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
//    NSString* querystr;
//    if (urlString == nil) {
//        
//        querystr = [NSString stringWithUTF8String:[parameterStr cStringUsingEncoding:NSUTF8StringEncoding]];
//        
//        urlString = [[NSString stringWithFormat:@"%@%@%@", serviceURL, WEBSERVICE_SEARCHBYQUERY, querystr] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
//    }
    
    NSLog(@"urlString :- %@", urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [IQWebService requestWithURL:url httpMethod:kIQHTTPMethodGET contentType:nil body:nil];
    [request setAllHTTPHeaderFields:headers];
    [self sendAsyncronousRequest:request withCompletionHandler:completionHandler];
    
}

#pragma mark Search by name
-(void)searchByName:(NSDictionary*)attribute name:(NSString *)name completionHandler:(IQCompletionBlock)completionHandler
{
    NSMutableDictionary *headers = [NSMutableDictionary new];
    NSArray *keys = [attribute allKeys];
    
    for (NSString *key in keys) {
        [headers setValue:[attribute valueForKey:key] forKey:key];
    }
    
    NSString *urlString = [[NSString stringWithFormat:@"%@%@%@",serviceURL,WEBSERVICE_SEARCHUSERBYNAME, name] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    NSLog(@"urlString :- %@", urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [IQWebService requestWithURL:url httpMethod:kIQHTTPMethodGET contentType:nil body:nil];
    [request setAllHTTPHeaderFields:headers];
    [self sendAsyncronousRequest:request withCompletionHandler:completionHandler];
    
}
-(void)submitApplication:(NSDictionary*)attribute parameters:(NSDictionary*)parameters appointmentid:(NSString *)appointmentid completionHandler:(IQCompletionBlock)completionHandler
{
    NSMutableDictionary *headers = [NSMutableDictionary new];
    NSArray *keys = [attribute allKeys];

    for (NSString *key in keys) {
        [headers setValue:[attribute valueForKey:key] forKey:key];
    }

    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error];
    
    NSLog(@"postData error :- %@", error);
    
    NSString *urlString;
    if ([appointmentid length] > 0) {
        urlString = [[NSString stringWithFormat:@"%@%@/%@",serviceURL, WEBSERVICE_SUBMITAPPPOINTMENT, appointmentid] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        
        NSLog(@"urlString :- %@", urlString);
        
        NSURL *url = [NSURL URLWithString:urlString];
        NSMutableURLRequest *request = [IQWebService requestWithURL:url httpMethod:kIQHTTPMethodPUT contentType:kIQContentTypeApplicationJson body:postData];
        [request setAllHTTPHeaderFields:headers];
        [self sendAsyncronousRequest:request withCompletionHandler:completionHandler];
    
    }else{
    
        urlString = [[NSString stringWithFormat:@"%@%@",serviceURL,WEBSERVICE_SUBMITAPPPOINTMENT] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        
        NSLog(@"urlString :- %@", urlString);
        
        NSURL *url = [NSURL URLWithString:urlString];
        NSMutableURLRequest *request = [IQWebService requestWithURL:url httpMethod:kIQHTTPMethodPOST contentType:kIQContentTypeApplicationJson body:postData];
        [request setAllHTTPHeaderFields:headers];
        [self sendAsyncronousRequest:request withCompletionHandler:completionHandler];
    }
}

-(void)getBookingsWithcompletionHandler:(IQCompletionBlock)completionHandler
{
    NSMutableDictionary *headers = [NSMutableDictionary new];
    if ([[CommonUtility sharedInstance].userDictionary valueForKey:@"token"]) {
        [headers setValue:[[CommonUtility sharedInstance].userDictionary valueForKey:@"token"] forKey:@"X-CSRF-Token"];
    }
    NSString *urlString = [[NSString stringWithFormat:@"%@%@",serviceURL,WEBSERVICE_GETBOOKINGS] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    NSLog(@"urlString :- %@", urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [IQWebService requestWithURL:url httpMethod:kIQHTTPMethodGET contentType:nil body:nil];
    [request setAllHTTPHeaderFields:headers];
    [self sendAsyncronousRequest:request withCompletionHandler:completionHandler];
}
-(void)getFullDetailsOfThisUserById:(NSString *)userID completionHandler:(IQCompletionBlock)completionHandler
{
    NSMutableDictionary *headers = [NSMutableDictionary new];
    if ([[CommonUtility sharedInstance].userDictionary valueForKey:@"token"]) {
        [headers setValue:[[CommonUtility sharedInstance].userDictionary valueForKey:@"token"] forKey:@"X-CSRF-Token"];
    }
    NSString *urlString = [[NSString stringWithFormat:@"%@%@",serviceURL,[WEBSERVICE_GETFULLUSERDETAILS stringByAppendingString:userID]] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    NSLog(@"urlString :- %@", urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [IQWebService requestWithURL:url httpMethod:kIQHTTPMethodGET contentType:nil body:nil];
    [request setAllHTTPHeaderFields:headers];
    [self sendAsyncronousRequest:request withCompletionHandler:completionHandler];

    
}
-(void)getAllInvoicesWithCompletionHandler:(IQCompletionBlock)completionHandler
{
    NSMutableDictionary *headers = [NSMutableDictionary new];
    if ([[CommonUtility sharedInstance].userDictionary valueForKey:@"token"]) {
        [headers setValue:[[CommonUtility sharedInstance].userDictionary valueForKey:@"token"] forKey:@"X-CSRF-Token"];
    }
    NSString *urlString = [[NSString stringWithFormat:@"%@%@",serviceURL,WEBSERVICE_GETALLINVOICES] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    NSLog(@"urlString :- %@", urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [IQWebService requestWithURL:url httpMethod:kIQHTTPMethodGET contentType:nil body:nil];
    [request setAllHTTPHeaderFields:headers];
    [self sendAsyncronousRequest:request withCompletionHandler:completionHandler];
    
    
}
-(void)getBrainTreeTokenCompletionHandler:(IQCompletionBlock)completionHandler
{
    NSMutableDictionary *headers = [NSMutableDictionary new];
    if ([[CommonUtility sharedInstance].userDictionary valueForKey:@"token"]) {
        [headers setValue:[[CommonUtility sharedInstance].userDictionary valueForKey:@"token"] forKey:@"X-CSRF-Token"];
    }
    NSString *urlString = [[NSString stringWithFormat:@"%@%@",serviceURL,WEBSERVICE_GETBRAINTREETOKEN] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    NSLog(@"urlString :- %@", urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [IQWebService requestWithURL:url httpMethod:kIQHTTPMethodGET contentType:kIQContentTypeApplicationJson body:nil];
    [request setAllHTTPHeaderFields:headers];
    [self sendAsyncronousRequest:request withCompletionHandler:completionHandler];
}
-(void)loginWithFacebookTokenWithToken :(NSString *)token CompletionHandler:(IQCompletionBlock)completionHandler
{
    
    NSMutableDictionary *headers = [NSMutableDictionary new];
    if ([[CommonUtility sharedInstance].userDictionary valueForKey:@"token"]) {
        [headers setValue:[[CommonUtility sharedInstance].userDictionary valueForKey:@"token"] forKey:@"X-CSRF-Token"];
    }
    NSString *urlString = [[NSString stringWithFormat:@"%@%@",serviceURL,WEBSERVICE_LOGINWITHFACEBOOKTOKEN] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    NSLog(@"urlString :- %@", urlString);
    NSDictionary *parameters = @{ @"access_token": token};
    
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error];
    
    NSLog(@"Json error :- %@", error);

    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [IQWebService requestWithURL:url httpMethod:kIQHTTPMethodPOST contentType:kIQContentTypeApplicationJson body:postData];
    [request setAllHTTPHeaderFields:headers];
    [self sendAsyncronousRequest:request withCompletionHandler:completionHandler];

    
}
-(void)forgotPasswordApiWithParameters:(NSDictionary*)params CompletionHandler:(IQCompletionBlock)completionHandler
{
    
    NSString *urlString = [[NSString stringWithFormat:@"%@%@",serviceURL,WEBSERVICE_FORGOTPASSWORD] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    NSLog(@"urlString :- %@", urlString);
    
    NSDictionary *parameters = @{ @"name": params[@"email"]};
    
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error];
    
    NSLog(@"Json error :- %@", error);
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [IQWebService requestWithURL:url httpMethod:kIQHTTPMethodPOST contentType:kIQContentTypeApplicationJson body:postData];
    [self sendAsyncronousRequest:request withCompletionHandler:completionHandler];
    
}
-(void)getAllMessagesWithUserId :(NSString *)userID CompletionHandler:(IQCompletionBlock)completionHandler
{
    
    NSMutableDictionary *headers = [NSMutableDictionary new];
    if ([[CommonUtility sharedInstance].userDictionary valueForKey:@"token"]) {
        [headers setValue:[[CommonUtility sharedInstance].userDictionary valueForKey:@"token"] forKey:@"X-CSRF-Token"];
    }
    NSString *urlString = [[NSString stringWithFormat:@"%@%@",serviceURL,[WEBSERVICE_GETALLMESSAGES stringByAppendingString:userID]] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    NSLog(@"urlString :- %@", urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [IQWebService requestWithURL:url httpMethod:kIQHTTPMethodGET contentType:nil body:nil];
    [request setAllHTTPHeaderFields:headers];
    [self sendAsyncronousRequest:request withCompletionHandler:completionHandler];
}

-(void)getAllMessagesForThisThread:(NSString *)threadId CompletionHandler:(IQCompletionBlock)completionHandler
{
    
    NSMutableDictionary *headers = [NSMutableDictionary new];
    if ([[CommonUtility sharedInstance].userDictionary valueForKey:@"token"]) {
        [headers setValue:[[CommonUtility sharedInstance].userDictionary valueForKey:@"token"] forKey:@"X-CSRF-Token"];
    }
    NSString *urlString = [[NSString stringWithFormat:@"%@%@",serviceURL,[WEBSERVICE_GETALLMESSAGESFORTHREAD stringByAppendingString:threadId]] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    NSLog(@"urlString :- %@", urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [IQWebService requestWithURL:url httpMethod:kIQHTTPMethodGET contentType:nil body:nil];
    [request setAllHTTPHeaderFields:headers];
    [self sendAsyncronousRequest:request withCompletionHandler:completionHandler];
}

-(void)sendMessageWithinThread:(NSDictionary *)parameters CompletionHandler:(IQCompletionBlock)completionHandler
{
    
    NSMutableDictionary *headers = [NSMutableDictionary new];
    if ([[CommonUtility sharedInstance].userDictionary valueForKey:@"token"]) {
        [headers setValue:[[CommonUtility sharedInstance].userDictionary valueForKey:@"token"] forKey:@"X-CSRF-Token"];
    }
    
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error];
    
    NSLog(@"Json error :- %@", error);
    
    NSString *urlString = [[NSString stringWithFormat:@"%@%@",serviceURL, WEBSERVICE_SENDINGMESSAGEWITHINTHREAD] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    NSLog(@"urlString :- %@", urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [IQWebService requestWithURL:url httpMethod:kIQHTTPMethodPOST contentType:kIQContentTypeApplicationJson body:postData];
    [request setAllHTTPHeaderFields:headers];
    [self sendAsyncronousRequest:request withCompletionHandler:completionHandler];
}

#pragma mark cancel booking
-(void)cancelBooking:(NSString *)bookingId parameters:(NSDictionary *)parameters CompletionHandler:(IQCompletionBlock)completionHandler
{
    
    NSMutableDictionary *headers = [NSMutableDictionary new];
    if ([[CommonUtility sharedInstance].userDictionary valueForKey:@"token"]) {
        [headers setValue:[[CommonUtility sharedInstance].userDictionary valueForKey:@"token"] forKey:@"X-CSRF-Token"];
    }
    
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error];
    
    NSLog(@"Json error :- %@", error);
    
    NSString *urlString = [[NSString stringWithFormat:@"%@%@/%@",serviceURL, WEBSERVICE_SUBMITAPPPOINTMENT, bookingId] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    NSLog(@"urlString :- %@", urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [IQWebService requestWithURL:url httpMethod:kIQHTTPMethodPUT contentType:kIQContentTypeApplicationJson body:postData];
    [request setAllHTTPHeaderFields:headers];
    [self sendAsyncronousRequest:request withCompletionHandler:completionHandler];
}

#pragma mark Booking Detail
-(void)getBookingDetail:(NSString *)bookingId CompletionHandler:(IQCompletionBlock)completionHandler
{
    
    NSMutableDictionary *headers = [NSMutableDictionary new];
    if ([[CommonUtility sharedInstance].userDictionary valueForKey:@"token"]) {
        [headers setValue:[[CommonUtility sharedInstance].userDictionary valueForKey:@"token"] forKey:@"X-CSRF-Token"];
    }
    
    NSString *urlString = [[NSString stringWithFormat:@"%@%@%@",serviceURL, WEBSERVICE_GETBOOKINGSDETAIL, bookingId] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    NSLog(@"urlString :- %@", urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [IQWebService requestWithURL:url httpMethod:kIQHTTPMethodGET contentType:kIQContentTypeApplicationJson body:nil];
    [request setAllHTTPHeaderFields:headers];
    [self sendAsyncronousRequest:request withCompletionHandler:completionHandler];
}

#pragma mark Invoice Detail
-(void)getInvoiceDetail:(NSString *)invoiceId CompletionHandler:(IQCompletionBlock)completionHandler
{
    NSMutableDictionary *headers = [NSMutableDictionary new];
    if ([[CommonUtility sharedInstance].userDictionary valueForKey:@"token"]) {
        [headers setValue:[[CommonUtility sharedInstance].userDictionary valueForKey:@"token"] forKey:@"X-CSRF-Token"];
    }
    
    NSString *urlString = [[NSString stringWithFormat:@"%@%@%@",serviceURL, WEBSERVICE_GETALLINVOICEDETAIL, invoiceId] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    NSLog(@"urlString :- %@", urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [IQWebService requestWithURL:url httpMethod:kIQHTTPMethodGET contentType:kIQContentTypeApplicationJson body:nil];
    [request setAllHTTPHeaderFields:headers];
    [self sendAsyncronousRequest:request withCompletionHandler:completionHandler];
}

#pragma mark Saved Profile
-(void)savedProfile:(NSDictionary *)parameters userId:(NSString *)userId CompletionHandler:(IQCompletionBlock)completionHandler
{
    NSMutableDictionary *headers = [NSMutableDictionary new];
    if ([[CommonUtility sharedInstance].userDictionary valueForKey:@"token"]) {
        [headers setValue:[[CommonUtility sharedInstance].userDictionary valueForKey:@"token"] forKey:@"X-CSRF-Token"];
    }
    
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error];
    
    NSLog(@"Json error :- %@", error);
    
    NSString *urlString = [[NSString stringWithFormat:@"%@%@%@",serviceURL, WEBSERVICE_SAVEDPROFILE, userId] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    NSLog(@"urlString :- %@", urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [IQWebService requestWithURL:url httpMethod:kIQHTTPMethodPUT contentType:kIQContentTypeApplicationJson body:postData];
    [request setAllHTTPHeaderFields:headers];
    [self sendAsyncronousRequest:request withCompletionHandler:completionHandler];
}

#pragma mark Get All Saved Profiles
-(void)getSavedProfiles:(IQCompletionBlock)completionHandler
{
    NSMutableDictionary *headers = [NSMutableDictionary new];
    if ([[CommonUtility sharedInstance].userDictionary valueForKey:@"token"]) {
        [headers setValue:[[CommonUtility sharedInstance].userDictionary valueForKey:@"token"] forKey:@"X-CSRF-Token"];
    }
    
    NSString *urlString = [[NSString stringWithFormat:@"%@%@",serviceURL, WEBSERVICE_GETALLSAVEDPROFILE] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    NSLog(@"urlString :- %@", urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [IQWebService requestWithURL:url httpMethod:kIQHTTPMethodGET contentType:kIQContentTypeApplicationJson body:nil];
    [request setAllHTTPHeaderFields:headers];
    [self sendAsyncronousRequest:request withCompletionHandler:completionHandler];
}

#pragma mark Add Event
-(void)addEvent:(NSDictionary *)parameters CompletionHandler:(IQCompletionBlock)completionHandler
{
    
    NSMutableDictionary *headers = [NSMutableDictionary new];
    if ([[CommonUtility sharedInstance].userDictionary valueForKey:@"token"]) {
        [headers setValue:[[CommonUtility sharedInstance].userDictionary valueForKey:@"token"] forKey:@"X-CSRF-Token"];
    }
    
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error];
    
    NSLog(@"Json error :- %@", error);
    
    NSString *urlString = [[NSString stringWithFormat:@"%@%@",serviceURL, WEBSERVICE_ADDEVENT] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    NSLog(@"urlString :- %@", urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [IQWebService requestWithURL:url httpMethod:kIQHTTPMethodPOST contentType:kIQContentTypeApplicationJson body:postData];
    [request setAllHTTPHeaderFields:headers];
    [self sendAsyncronousRequest:request withCompletionHandler:completionHandler];
}

#pragma mark Get All Event
-(void)getAllEventCompletionHandler:(IQCompletionBlock)completionHandler
{
    
    NSMutableDictionary *headers = [NSMutableDictionary new];
    if ([[CommonUtility sharedInstance].userDictionary valueForKey:@"token"]) {
        [headers setValue:[[CommonUtility sharedInstance].userDictionary valueForKey:@"token"] forKey:@"X-CSRF-Token"];
    }
    
    NSString *urlString = [[NSString stringWithFormat:@"%@%@",serviceURL, WEBSERVICE_GETALLEVENTS] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    NSLog(@"urlString :- %@", urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [IQWebService requestWithURL:url httpMethod:kIQHTTPMethodGET contentType:kIQContentTypeApplicationJson body:nil];
    [request setAllHTTPHeaderFields:headers];
    [self sendAsyncronousRequest:request withCompletionHandler:completionHandler];
}

@end


