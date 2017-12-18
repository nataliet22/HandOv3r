//
//  CommonClass.m
//  UNEYE
//
//  Created by Satya Kumar on 29/07/15.
//  Copyright (c) 2015 Satya Kumar All rights reserved.
//

#import "CommonUtility.h"
#import "Constant.h"
#import "NSDictionary+IgnoreNull.h"

@implementation CommonUtility

+(CommonUtility *)sharedInstance
{
    static CommonUtility *instance;
    if(!instance){
        instance=[[CommonUtility alloc] init];
        instance.userDictionary = [[NSMutableDictionary alloc] init];
    }
    return instance;
}


+(UIView*)makeRoundedView:(UIView*)view withBorderColor:(UIColor*)borderColor andBorderWidth:(float)borderWidth
{
    [view setClipsToBounds:YES];
    [[view layer] setCornerRadius:view.bounds.size.width/2];
    [view.layer setBorderColor:borderColor.CGColor];
    [view.layer setBorderWidth:borderWidth];
    return view;
}

#pragma mark - textFieldPedding

+(void)setLeftPadding:(UITextField *)textField imageName:(NSString *)image width:(int)width
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, textField.frame.size.height)];
    UIButton *leftImage=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, paddingView.frame.size.width/2, paddingView.frame.size.width/2)];
    leftImage.center=paddingView.center;
    [leftImage setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [leftImage setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    [leftImage addTarget:self action:@selector(peddingAction:) forControlEvents:UIControlEventTouchUpInside];
    leftImage.contentMode=UIViewContentModeScaleAspectFit;
    [paddingView addSubview:leftImage];
    textField.leftView = paddingView;
    textField.leftViewMode = UITextFieldViewModeAlways;
}

+(void)setRightPadding:(UITextField *)textField imageName:(NSString *)image width:(int)width
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, textField.frame.size.height)];
    UIButton *rightImage=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, paddingView.frame.size.width/2, paddingView.frame.size.width/2)];
    rightImage.center=paddingView.center;
    [rightImage setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [rightImage setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    [rightImage addTarget:self action:@selector(peddingAction:) forControlEvents:UIControlEventTouchUpInside];
    rightImage.contentMode=UIViewContentModeScaleAspectFit;
    [paddingView addSubview:rightImage];
    textField.rightView = paddingView;
    textField.rightViewMode = UITextFieldViewModeAlways;
}

+(void)peddingAction:(UIButton *)btn
{
    UIView *vw = [btn superview];
    UITextField *fild = (UITextField*)[vw superview];
    [fild becomeFirstResponder];
}

-(BOOL)Emailvalidate:(NSString *)tempMail
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:tempMail];
}


#pragma mark -session
// Initialize user on sign-in or registration
-(void)initializeUser:(NSDictionary *)dictionary
{
    
    NSMutableDictionary *tempDict = [self createMutableDict:dictionary];
    self.userDictionary = [tempDict mutableCopy];
    
    NSData *saveUserData = [NSKeyedArchiver archivedDataWithRootObject:self.userDictionary];
    [[NSUserDefaults standardUserDefaults] setObject:saveUserData forKey:userdata];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSMutableDictionary *)createMutableDict:(NSDictionary *)dict{
    
    NSMutableDictionary *mutableDict = [NSMutableDictionary new];
    
    for (NSString *key in dict.allKeys) {
        [mutableDict setValue:[dict valueForKey:key] forKey:key];
    }
    
    return mutableDict;
}

-(void)initializeFacebookUser:(NSMutableDictionary*)dictionary{

    self.facebookUserInfoDictionary = [dictionary mutableCopy];
}

// set user info
-(void)addUserInfo:(NSMutableDictionary *)dictionary
{
    NSArray *keys = [dictionary allKeys];
    
    for (NSString *key in keys) {
        [self.userDictionary setValue:[dictionary valueForKey:key] forKey:key];
    }
}

// set user qualification indexes
-(void)setSeekerQualificationIndexes:(NSMutableDictionary *)indexesDict qualificationDict:(NSMutableDictionary *)qualificationDict
{
    if (indexesDict) {
        self.selectedQualificationIndex = [indexesDict mutableCopy];
    }
    
    if (qualificationDict) {
        self.selectedQualificationDict = [qualificationDict mutableCopy];
    }
    
}

//--- Current screen data ---
-(void)addScreenDataInfo:(NSString *)text key:(NSString *)key
{
    if (self.screenDataDictionary == nil) {
        self.screenDataDictionary = [[NSMutableDictionary alloc] init];
    }
    
    [self.screenDataDictionary setValue:text forKey:key];
}
//--- Add family member data ---
-(void)addScreenDataFamilyInfo:(NSMutableArray *)arrey key:(NSString *)key
{
    if (self.screenDataDictionary == nil) {
        self.screenDataDictionary = [[NSMutableDictionary alloc] init];
    }
    
    [self.screenDataDictionary setValue:arrey forKey:key];
}
//--- Add Array into ---
-(void)addScreenData:(NSMutableArray *)arrey key:(NSString *)key
{
    if (self.screenDataDictionary == nil) {
        self.screenDataDictionary = [[NSMutableDictionary alloc] init];
    }
    
    [self.screenDataDictionary setValue:arrey forKey:key];
}

-(void)addDictScreenDataInfo:(NSMutableDictionary *)dict key:(NSString *)key
{
    if (self.screenDataDictionary == nil) {
        self.screenDataDictionary = [[NSMutableDictionary alloc] init];
    }
    
    [self.screenDataDictionary setValue:dict forKey:key];
}

//--- Current screen data ---
-(void)addImageScreenDataInfo:(UIImage *)image key:(NSString *)key
{
    if (self.screenDataDictionary == nil) {
        self.screenDataDictionary = [[NSMutableDictionary alloc] init];
    }
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    [self.screenDataDictionary setObject:imageData forKey:key];
}

-(void)logoutAndRemoveUserData
{
    [self.userDictionary removeAllObjects];
}

-(void)updateCurrentLocation
{
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [_locationManager requestAlwaysAuthorization];
    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"didUpdateLocations: %@", [locations lastObject]);
    _userlocation = [locations lastObject];
    
    _locationManager = manager;
    [_locationManager stopUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    if ([error domain] == kCLErrorDomain) {
        
        // We handle CoreLocation-related errors here
        switch ([error code]) {
                // "Don't Allow" on two successive app launches is the same as saying "never allow". The user
                // can reset this for all apps by going to Settings > General > Reset > Reset Location Warnings.
            case kCLErrorDenied:
                ShowAlert(@"Message", kLocationMassage, nil);
            case kCLErrorLocationUnknown:
            default:
                break;
        }
    }
    else
    {
        // We handle all non-CoreLocation errors here
    }
}

-(NSString *)removeSpacialChar:(NSString *)str
{
    NSArray *data = [str componentsSeparatedByString:@"@"];
    
    if([data count]==2)
    {
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^a-zA-Z0-9]*$'" options:0 error:NULL];
        NSString *string = [data firstObject];
        NSString *modifiedString = [regex stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, [string length]) withTemplate:@""];
        modifiedString=[modifiedString stringByReplacingOccurrencesOfString:@" " withString:@""];
        modifiedString = [modifiedString stringByReplacingOccurrencesOfString:@"'" withString:@""];
        return [NSString stringWithFormat:@"%@@%@",modifiedString,[data lastObject]];
    }
    else
    {
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^a-zA-Z0-9]*$" options:0 error:NULL];
        NSString *string = str;
        NSString *modifiedString = [regex stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, [string length]) withTemplate:@""];
        modifiedString=[modifiedString stringByReplacingOccurrencesOfString:@" " withString:@""];
        return modifiedString;
    }
}

-(void)setLatLong:(float )lat setLong:(float)longs
{
    _getLat = lat;
    _getLong = longs;
}

-(void)FromMapToSetConury:(NSString*)cntryName
{
    _counrtyName = cntryName;
}

-(void)showAlertWithMessage:(NSString*)message
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}

+ (BOOL) isEmptyTextField: (UITextField *)textField
{
    if ([textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0)
        return YES;
    
    return NO;
}

#pragma mark Encoding base64
- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

#pragma mark Decoding base64
- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

@end
