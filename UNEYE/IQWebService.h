//
//  IQWebService.h
//  UNEYE
//
//  Created by Satya on 29/03/16.
//  Copyright (c) 2013 Apptech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IQWebServiceConstants.h"

@interface IQWebService : NSObject

@property(nonatomic, assign, getter = isLogEnabled) BOOL logEnabled;

+(IQWebService*)service;

//------- Webservice method's -----

//POST
-(void)signup:(NSDictionary*)attribute completionHandler:(IQCompletionBlock)completionHandler;
-(void)signIn:(NSDictionary*)attribute completionHandler:(IQCompletionBlock)completionHandler;
-(void)saveDeviceToken:(NSDictionary*)attribute completionHandler:(IQCompletionBlock)completionHandler;
-(void)forgotPasswordApiWithParameters :(NSDictionary*)params CompletionHandler:(IQCompletionBlock)completionHandler;
-(void)logout:(NSDictionary*)attribute completionHandler:(IQCompletionBlock)completionHandler;
-(void)loginWithFacebookTokenWithToken :(NSString *)token CompletionHandler:(IQCompletionBlock)completionHandler;
-(void)submitApplication:(NSDictionary*)attribute parameters:(NSDictionary*)parameters appointmentid:(NSString *)appointmentid completionHandler:(IQCompletionBlock)completionHandler;
-(void)sendMessageWithinThread:(NSDictionary *)parameters CompletionHandler:(IQCompletionBlock)completionHandler;
-(void)cancelBooking:(NSString *)bookingId parameters:(NSDictionary *)parameters CompletionHandler:(IQCompletionBlock)completionHandler;
-(void)addEvent:(NSDictionary *)parameters CompletionHandler:(IQCompletionBlock)completionHandler;


//PUT
-(void)savedProfile:(NSDictionary *)parameters userId:(NSString *)userId CompletionHandler:(IQCompletionBlock)completionHandler;
-(void)updateProfile:(NSDictionary*)attribute headers:(NSMutableDictionary *)headers userId:(NSString *)userId completionHandler:(IQCompletionBlock)completionHandler;

//GET
-(void)getSessionID :(IQCompletionBlock)completionHandler;
-(void)getUserInfo:(NSDictionary*)attribute userid:(NSString *)userid completionHandler:(IQCompletionBlock)completionHandler;
-(void)searchByQuery:(NSDictionary*)attribute queryParam:(NSDictionary*)queryParam completionHandler:(IQCompletionBlock)completionHandler;
-(void)searchByName:(NSDictionary*)attribute name:(NSString *)name completionHandler:(IQCompletionBlock)completionHandler;

-(void)getBookingsWithcompletionHandler:(IQCompletionBlock)completionHandler;
-(void)getBookingDetail:(NSString *)bookingId CompletionHandler:(IQCompletionBlock)completionHandler;
-(void)getFullDetailsOfThisUserById:(NSString *)userID completionHandler:(IQCompletionBlock)completionHandler;
-(void)getAllInvoicesWithCompletionHandler:(IQCompletionBlock)completionHandler;
-(void)getInvoiceDetail:(NSString *)invoiceId CompletionHandler:(IQCompletionBlock)completionHandler;
-(void)getBrainTreeTokenCompletionHandler:(IQCompletionBlock)completionHandler;

-(void)getAllMessagesWithUserId :(NSString *)userID CompletionHandler:(IQCompletionBlock)completionHandler;
-(void)getAllMessagesForThisThread :(NSString *)threadId CompletionHandler:(IQCompletionBlock)completionHandler;
-(void)getSavedProfiles:(IQCompletionBlock)completionHandler;
-(void)getAllEventCompletionHandler:(IQCompletionBlock)completionHandler;


@end
