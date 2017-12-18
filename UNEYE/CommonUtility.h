//
//  CommonClass.h
//  UNEYE
//
//  Created by Satya Kumar on 29/07/15.
//  Copyright (c) 2015 Satya Kumar All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
//#import "MHCustomTabBarController.h"
@interface CommonUtility : NSObject <MKMapViewDelegate,CLLocationManagerDelegate>

+(CommonUtility *)sharedInstance;
@property (nonatomic,strong) NSString *deviceToken;
@property (nonatomic,strong) NSString *numberTyped;
@property (nonatomic,strong) NSString *nameforuser;
@property  CGRect keyboardRect;
@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) NSMutableDictionary *userDictionary;
@property (nonatomic,strong) NSMutableArray *arrayPerentGroup;
@property (nonatomic,strong) NSString *mapShow;
@property (nonatomic,strong) CLLocation *userlocation;
@property (nonatomic,strong) NSString *mapAddress;
@property (nonatomic,strong) NSString *counrtyName;

//--- Current screen data ---
@property (nonatomic,strong) NSMutableDictionary *screenDataDictionary;
//--- User Info From Facebook ---
@property (nonatomic,strong) NSMutableDictionary *facebookUserInfoDictionary;
//--- Current screen job seeker qualification data ---
@property (nonatomic,strong) NSMutableDictionary *selectedQualificationIndex;
@property (nonatomic,strong) NSMutableDictionary *selectedQualificationDict;

@property  float  getLat;
@property  float  getLong;

+(UIView*)makeRoundedView:(UIView*)view withBorderColor:(UIColor*)borderColor andBorderWidth:(float)borderWidth;
#pragma mark - Textfield Padding
+(void)setLeftPadding:(UITextField *)textField imageName:(NSString *)image width:(int)width;
+(void)setRightPadding:(UITextField *)textField imageName:(NSString *)image width:(int)width;

#pragma mark - Session
-(void)initializeUser:(NSDictionary*)dictionary;
-(void)initializeFacebookUser:(NSDictionary*)dictionary;

-(void)addUserInfo:(NSDictionary *)dictionary;
-(void)logoutAndRemoveUserData;

//--- Current screen data ---
-(void)addScreenDataInfo:(NSString *)text key:(NSString *)key;
-(void)addImageScreenDataInfo:(UIImage *)image key:(NSString *)key;
-(void)addDictScreenDataInfo:(NSMutableDictionary *)dict key:(NSString *)key;
-(void)addScreenDataFamilyInfo:(NSMutableArray *)arrey key:(NSString *)key;
-(void)addScreenData:(NSMutableArray *)arrey key:(NSString *)key;
-(void)setSeekerQualificationIndexes:(NSMutableDictionary *)indexesDict qualificationDict:(NSMutableDictionary *)qualificationDict;

# pragma mark - validation
-(BOOL)Emailvalidate:(NSString *)tempMail;
-(void)updateCurrentLocation;

-(NSString *)removeSpacialChar:(NSString *)str;

-(void)setLatLong:(float )lat setLong:(float)longs;
-(void)FromMapToSetConury:(NSString*)cntryName;

-(void)showAlertWithMessage:(NSString*)message;

+ (BOOL) isEmptyTextField: (UITextField *)textField;

#pragma mark Encoding/Decoding base64
- (NSString *)encodeToBase64String:(UIImage *)image;
- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData;

@end
