//
//  JobSeekerProfileViewController.m
//  UNEYE
//
//  Created by Satya Kumar on 24/05/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import "JobSeekerProfileViewController.h"
#import "InformationCell.h"
#import "AddMoreTypeOfCareTableViewCell.h"
#import "AddMoreProfessionalInfoTableViewCell.h"
#import "CalenderCell.h"
#import "ProfileSignUpBtnCell.h"
#import "RSDatePickerController.h"
#import "popviewController.h"
#import "JobSeekerProfileEditViewController.h"
#import "ShowProfessionalInfoTableViewCell.h"

@interface JobSeekerProfileViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, InformationCellDelegate, AddMoreTypeOfCareTableViewCellDelegate, AddMoreProfessionalInfoTableViewCellDelegate, CalendercellDelegate, ProfileSignUpBtnCellDelegate, EducationsCustomCellDelegate>{

    NSMutableArray *arrProfessionalInfo;
    
    BOOL isEditProfileFlag;
    BOOL isProfileFlag;
    BOOL isIntroBtnClickFlag;
    BOOL isQualificationClickFlag;
    
    NSArray *arrLevel_of_study;
    NSString *selectedQualifications;
    
    NSMutableDictionary *updatedDataDict;
    NSMutableDictionary *tempUpdatedVideoData;
    
    //--- Temp hold selected dates
    NSMutableArray *tempSelectedDateArr;
}

@property (weak, nonatomic) IBOutlet UIView *profileImage_View;
@property (weak, nonatomic) IBOutlet AsyncImageView *profileImageViewBtn;
@property (weak, nonatomic) IBOutlet UITableView *seekerInfoTableView;

@end

@implementation JobSeekerProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _seekerInfoTableView.alpha = 0.7;
    _profileImageViewBtn.userInteractionEnabled = NO;
    isEditProfileFlag = NO;
    
     isIntroBtnClickFlag = NO;
     isQualificationClickFlag = NO;
    
//    //--- Multiple Professional Info ---
//    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Type of care", @"typeofcare",
//                                     @"Type of care Rate", @"typeofcarerate",
//                                     @"Area of skill", @"areaofskill",
//                                     @"Area of skill Rate", @"areaofskillrate",
//                                     @"Area of study", @"areaofstudy",
//                                     @"Area of study Rate", @"areaofstudyrate",
//                                     nil];
//    arrProfessionalInfo = [[NSMutableArray alloc] initWithObjects:dataDict, nil];
    
    arrProfessionalInfo = [[NSMutableArray alloc] init];
    tempUpdatedVideoData = [[NSMutableDictionary alloc] init];
    
    //--- Dict for current updated data ---
    updatedDataDict = [[NSMutableDictionary alloc] init];
    
    //--- Gesture for hiding keyboard ---
    UIGestureRecognizer *tapperGesture = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(hideKeyBoardOnSingleTap:)];
    tapperGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapperGesture];
    
    //--- Copy user data ---
    [CommonUtility sharedInstance].screenDataDictionary = [CommonUtility sharedInstance].userDictionary;
    
    arrProfessionalInfo = [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"field_sub_typeofcares"];
    
    NSLog(@"screenDataDictionary :- %@", [CommonUtility sharedInstance].screenDataDictionary);
    
    //--- Load Profile image from url ---
    if ([[[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"picture"] valueForKey:@"url"] length] > 0) {
        [self.profileImageViewBtn loadImage:[[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"picture"] valueForKey:@"url"]];
    }
    
//    //--- Load field_level_of_study ---
//    if ([[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"field_level_of_study"] length] > 0) {
//        
//        NSString *strLevel_of_study = [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"field_level_of_study"];
//        arrLevel_of_study = [strLevel_of_study componentsSeparatedByString:@","];
//    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
     //isEditProfileFlag = NO;
    
//    _seekerInfoTableView.alpha = 0.7;
//    _profileImageViewBtn.userInteractionEnabled = NO;
    
    
    //--- Copy user data ---
    [CommonUtility sharedInstance].screenDataDictionary = [CommonUtility sharedInstance].userDictionary;
    
    arrProfessionalInfo = [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"field_sub_typeofcares"];
    
    NSLog(@"screenDataDictionary :- %@", [CommonUtility sharedInstance].screenDataDictionary);
    
    //--- Load Profile image from url ---
    if ([[[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"picture"] valueForKey:@"url"] length] > 0) {
        [self.profileImageViewBtn loadImage:[[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"picture"] valueForKey:@"url"]];
    }
    
    [self.seekerInfoTableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"editProfileViewProfile"])
    {
        //JobSeekerProfileEditViewController *ConfirmDetailVC = (JobSeekerProfileEditViewController *)segue.destinationViewController;
    }
}

-(void)updateallUI{
    
    //--- Copy user data ---
    [CommonUtility sharedInstance].screenDataDictionary = [CommonUtility sharedInstance].userDictionary;
    
    NSLog(@"screenDataDictionary :- %@", [CommonUtility sharedInstance].screenDataDictionary);
    
    //--- Load Profile image from url ---
    if ([[[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"picture"] valueForKey:@"url"] length] > 0) {
        [self.profileImageViewBtn loadImage:[[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"picture"] valueForKey:@"url"]];
    }
    
    //--- Update Professional Info ---
    NSString *strLevelOfStudy = [[[CommonUtility sharedInstance].screenDataDictionary valueForKeyPath:@"user"] valueForKeyPath:@"field_level_of_study"];
    NSString *strRateForLevelOfStudy = [[[CommonUtility sharedInstance].screenDataDictionary valueForKeyPath:@"user"] valueForKeyPath:@"field_rate"];
    
}

- (IBAction)profileEditBtnClicked:(id)sender {
    
//    if (!isEditProfileFlag) {
//        isEditProfileFlag = YES;
//        _seekerInfoTableView.alpha = 1.0;
//        _profileImageViewBtn.userInteractionEnabled = YES;
//    }else{
//        
//        _profileImageViewBtn.userInteractionEnabled = NO;
//        _seekerInfoTableView.alpha = 0.7;
//        isEditProfileFlag = NO;
//    }
//    
//    [_seekerInfoTableView reloadData];
    
    
    [self performSegueWithIdentifier:@"editProfileViewProfile" sender:nil];
    
}


#pragma mark hide Key Board on Single Tap
- (void)hideKeyBoardOnSingleTap:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}

#pragma mark tableview delegates
-(IBAction)addMultiPleProfessionalInfo:(id)sender{
    
    //--- Multiple Professional Info ---
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Type of care", @"typeofcare",
                                     @"Type of care Rate", @"typeofcarerate",
                                     @"Area of skill", @"areaofskill",
                                     @"Area of skill Rate", @"areaofskillrate",
                                     @"Area of study", @"areaofstudy",
                                     @"Area of study Rate", @"areaofstudyrate",
                                     nil];
    [arrProfessionalInfo addObject:dataDict];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:arrProfessionalInfo.count - 1 inSection:1];
    
    NSLog(@"indexPath :- %@", indexPath);
    
    [self.seekerInfoTableView reloadData];
    [self.seekerInfoTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark Profile Image Button Action
- (IBAction)profileImageBtnClicked:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Options"
                                                                   message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *pictureAction = [UIAlertAction actionWithTitle:@"Photo Album"
                                                            style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                                
                                                                [self openCamera:YES sourceType:@"photo"];
                                                            }];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                               
                                                               [self openCamera:YES sourceType:@"camera"];
                                                           }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                               
                                                           }];
    
    [alert addAction:pictureAction];
    [alert addAction:cameraAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark Video Button Action
- (IBAction)videoBtnCliecked:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Message"
                                                                   message:@"What you want to upload for introduction?" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *pictureAction = [UIAlertAction actionWithTitle:@"Photo Album"
                                                            style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                                
                                                                isIntroBtnClickFlag = YES;
                                                                [self openCamera:NO sourceType:@"photo"];
                                                            }];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                               
                                                               isIntroBtnClickFlag = YES;
                                                               [self openCamera:NO sourceType:@"camera"];
                                                           }];
    UIAlertAction *videoAction = [UIAlertAction actionWithTitle:@"Video"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                              
                                                              isIntroBtnClickFlag = YES;
                                                              [self openCamera:NO sourceType:@"video"];
                                                          }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                               
                                                           }];
    
    [alert addAction:pictureAction];
    [alert addAction:cameraAction];
    [alert addAction:videoAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)openCamera:(BOOL)isProfile sourceType:(NSString *)sourceType{
    
    isProfileFlag = isProfile;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    [picker setDelegate:self];
    picker.allowsEditing = YES;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] && [sourceType isEqualToString:@"video"])
    {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.showsCameraControls = YES;
        picker.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeMovie];
        picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
        
    }else if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] && [sourceType isEqualToString:@"camera"]){
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        NSArray *mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeLivePhoto, (NSString *)kUTTypeMovie];
        picker.mediaTypes = mediaTypes;
    }
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    NSLog(@"type=%@",type);
    
    if ([type isEqualToString:(NSString *)kUTTypeVideo] || [type isEqualToString:(NSString *)kUTTypeMovie])
    {
        NSURL *urlvideo = [info objectForKey:UIImagePickerControllerMediaURL];
        
        [picker dismissViewControllerAnimated:YES completion:^{
            
            NSData *videoData = [NSData dataWithContentsOfURL:urlvideo];
            NSString *base64Encoded = [videoData base64EncodedStringWithOptions:0];
            
            [tempUpdatedVideoData setValue:[urlvideo absoluteString] forKey:@"vedioUrl"];
            [tempUpdatedVideoData setValue:@"YES" forKey:@"isVedioUrl"];
            
            //---  Updated data ---
            [updatedDataDict setValue:[NSString stringWithFormat:@"%@%@", vedioTypeMedia, base64Encoded] forKey:userIntroImageKey];
            
            [_seekerInfoTableView reloadData];
        }];
    }else{
        
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        
        [picker dismissViewControllerAnimated:YES completion:^{
            
            if (isProfileFlag) {
                
                UIImage *image = [chosenImage resizedImageWithContentMode:UIViewContentModeScaleAspectFit bounds:CGSizeMake(500.0, 500.0) interpolationQuality:kCGInterpolationMedium];
            
                [_profileImageViewBtn setBackgroundImage:chosenImage forState:UIControlStateNormal];
                
                [updatedDataDict setValue:[NSString stringWithFormat:@"%@%@", imageTypeMedia, [[CommonUtility sharedInstance] encodeToBase64String:image]] forKey:userProfileImageKey];
                
            }else{
                
                UIImage *image = [chosenImage resizedImageWithContentMode:UIViewContentModeScaleAspectFit bounds:CGSizeMake(500.0, 500.0) interpolationQuality:kCGInterpolationMedium];
                
                [tempUpdatedVideoData setValue:image forKey:@"image"];
                [tempUpdatedVideoData setValue:@"NO" forKey:@"isVedioUrl"];
                
                //--- Updated data ---
                [updatedDataDict setValue:[NSString stringWithFormat:@"%@%@", imageTypeMedia, [[CommonUtility sharedInstance] encodeToBase64String:image]] forKey:userIntroImageKey];
                
            }
            [_seekerInfoTableView reloadData];
        }];
    }
}

#pragma mark custom cell delegates
- (void)get:(NSString *)text key:(NSString *)key{

    if ([key isEqualToString:@"qualification"]) {
        [self openPOPUPView];
        return;
    }
    
    
    //--- Current screen data ---
    //[[CommonUtility sharedInstance] addScreenDataInfo:text key:key];
    [updatedDataDict setValue:text forKey:key];
    
}

- (void)getSubCategories:(NSString *)text key:(NSString *)key index:(NSInteger)index{
    
    if ([text isEqualToString:@"Type of care"] || [text isEqualToString:@"Area of skill"] || [text isEqualToString:@"Area of study"]) {
        return;
    }
    
    NSMutableDictionary *dataDict = [arrProfessionalInfo objectAtIndex:index];
    [dataDict setValue:text forKeyPath:key];
    [arrProfessionalInfo replaceObjectAtIndex:index withObject:dataDict];
    
}

#pragma mark open POPUPView
-(void)openPOPUPView{
    
    isQualificationClickFlag = YES;
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    popviewController *objpopviewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"popviewController"];
    objpopviewController.mydelegate = self;
    
    NSMutableArray *titleArray = [[NSMutableArray alloc] init];
    NSMutableArray *imagesArray = [[NSMutableArray alloc] init];
    
    objpopviewController.selectionType = @"educations";
    [objpopviewController showInView:self.view animated:YES arrayItemTitles:titleArray arrayItemImages:imagesArray];
    
    [self addChildViewController:objpopviewController];
}

#pragma mark tableview delegates
- (void)getSelectedItems:(NSMutableDictionary *)items{
    
    if (items != nil) {
        NSMutableArray *arrayItems = [[NSMutableArray alloc] init];
        
        for (NSString *key in [items allKeys]) {
            [arrayItems addObjectsFromArray:[items valueForKey:key]];
        }
        selectedQualifications = [arrayItems componentsJoinedByString:@", "];
        
        [self setQualificationKeysWise:items];
        
        [[CommonUtility sharedInstance] setSeekerQualificationIndexes:nil qualificationDict:items];
        
        [_seekerInfoTableView reloadData];
    }
}

//--- Set education values by keys ---
- (void)setQualificationKeysWise:(NSMutableDictionary *)courses{
    
    for (NSString *key in [courses allKeys]) {
        
        if ([key isEqualToString:keyPlistfieldPrimaryEducation]) {
            
            NSString *strPrimaryEducation = [[courses valueForKey:key] componentsJoinedByString:@", "];
            [updatedDataDict setValue:strPrimaryEducation forKey:keyfieldPrimaryEducation];
            
        }else if ([key isEqualToString:keyPlistfieldLanguage]) {
            
            NSString *strLanguage = [[courses valueForKey:key] componentsJoinedByString:@", "];
            [updatedDataDict setValue:strLanguage forKey:keyfieldLanguage];
            
        }else if ([key isEqualToString:keyPlistfieldSecondaryEducation]) {
            
            NSString *strSecondaryEducation = [[courses valueForKey:key] componentsJoinedByString:@", "];
            [updatedDataDict setValue:strSecondaryEducation forKey:keyfieldSecondaryEducation];
            
        }else if ([key isEqualToString:keyPlistfieldCommunityFamilyStudies]) {
            
            NSString *strCommunityFamilyStudies = [[courses valueForKey:key] componentsJoinedByString:@", "];
            [updatedDataDict setValue:[NSString stringWithFormat:@"%@", strCommunityFamilyStudies] forKey:keyfieldCommunityStudies];
            
        }else if ([key isEqualToString:keyPlistfieldTechnicalCourses]) {
            
            NSString *strTechnicalCourses = [[courses valueForKey:key] componentsJoinedByString:@", "];
            [updatedDataDict setValue:[NSString stringWithFormat:@"%@", strTechnicalCourses] forKey:keyfieldTechnicalCourse];
            
        }else if ([key isEqualToString:keyPlistfieldTertiaryEducation]) {
            
            NSString *strTertiaryEducation = [[courses valueForKey:key] componentsJoinedByString:@", "];
            [updatedDataDict setValue:strTertiaryEducation forKey:keyfieldTertiaryEducation];
        }
    }
    
    NSLog(@"setQualificationKeysWise updatedDataDict :- %@", updatedDataDict);
}


-(void)signUpForm{
    
    //--- Set All Key Values Parameters and Call API ---
    [self setAllKeyValuesParameters];
}

//--- Set All Key Values Parameters ---
-(void)setAllKeyValuesParameters{

     //--- set avaialble dates as string into dict ----
    if (tempSelectedDateArr.count > 0) {
        [updatedDataDict setValue:[self getCommaSeparateString] forKey:@"available_dates"]; //seekerAvailableDates
    }
    
    //---- New Field Multiple field with rates ---
    [updatedDataDict setValue:[self setMultipleProfessionalSkillsInNewFormat] forKey:@"field_sub_typeofcares"];
        
    [self updateProfileAPI:updatedDataDict];
    
}

//--- Method to convert Multiple Professional Skills new format
- (NSMutableArray *)setMultipleProfessionalSkillsInNewFormat{
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    for(NSDictionary *dict in arrProfessionalInfo) {
        
        /*
         {
         areaofskill = AFL;
         areaofskillrate = 89;
         areaofstudy = Chemistry;
         areaofstudyrate = 23;
         typeofcare = "House Sitter";
         typeofcarerate = 78;
         }
         */
        
        if ([[dict valueForKey:@"areaofskill"] length] > 0 && [[dict valueForKey:@"areaofskillrate"] length]) {
            
            NSDictionary *tempdictForAreaofskill = [[NSDictionary alloc] initWithObjectsAndKeys:[dict valueForKey:@"areaofskill"], @"title",
                                                    [dict valueForKey:@"areaofskillrate"], @"rate", @"areaofskill", @"type", nil];
            [tempArray addObject:tempdictForAreaofskill];
        }
        
        if ([[dict valueForKey:@"areaofstudy"] length] > 0 && [[dict valueForKey:@"areaofstudyrate"] length]) {
            
            NSDictionary *tempdictForAreaofstudy = [[NSDictionary alloc] initWithObjectsAndKeys:[dict valueForKey:@"areaofstudy"], @"title",
                                                    [dict valueForKey:@"areaofstudyrate"], @"rate", @"areaofstudy", @"type",nil];
            [tempArray addObject:tempdictForAreaofstudy];
        }
        
        if ([[dict valueForKey:@"typeofcare"] length] > 0 && [[dict valueForKey:@"typeofcarerate"] length]) {
            
            NSDictionary *tempdictForTypeofcare = [[NSDictionary alloc] initWithObjectsAndKeys:[dict valueForKey:@"typeofcare"], @"title",
                                                   [dict valueForKey:@"typeofcarerate"], @"rate", @"typeofcare", @"type",nil];
            [tempArray addObject:tempdictForTypeofcare];
        }
    }
    
    return tempArray;
}


#pragma mark API Call
-(void)updateProfileAPI:(NSDictionary*)parameters {
    
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable){
        kCustomAlertWithParamAndTarget(@"Message", @"Internet connection not available.", nil);
        return;
    }
    
    [kAppDelegete showHUDVIEW:self.view];
    
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

    
    NSString *userId =  [[[CommonUtility sharedInstance].userDictionary objectForKey:@"user"]valueForKey:@"uid"];
    
    [[IQWebService service] updateProfile:parameters headers:headers userId:userId completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //---- Hide HUD View ---
        [kAppDelegete removeHUDVIEW];
        
        NSUInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
        if (!error && statusCode == 200) {
            
            //--- Get login token ---
            NSError *error = nil;
            NSDictionary * jsonObject = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSLog(@"jsonObject :- %@", jsonObject);
            
            NSMutableDictionary *tempDict = [self createMutableDict:[jsonObject valueForKey:@"user"]];
            [[CommonUtility sharedInstance].userDictionary setValue:tempDict forKey:@"user"];
            
            NSLog(@"userDictionary :- %@", [CommonUtility sharedInstance].userDictionary);
            
            //--- Update Local User Data ---
            [[CommonUtility sharedInstance] initializeUser:[CommonUtility sharedInstance].userDictionary];
            
            //--- Copy user data ---
            [CommonUtility sharedInstance].screenDataDictionary = [CommonUtility sharedInstance].userDictionary;
                        
            //--- Update all UI ---
            tempUpdatedVideoData = nil;
            isIntroBtnClickFlag = NO;
            [self updateallUI];
        
            if (tempSelectedDateArr.count > 0) {
                [tempSelectedDateArr removeAllObjects];
            }
            
            kCustomAlertWithParamAndTarget(@"Message", @"Your profile has been successfully updated.", nil);
            isEditProfileFlag = NO;
            _seekerInfoTableView.alpha = 0.7;
            _profileImageViewBtn.userInteractionEnabled = NO;
            [self.seekerInfoTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:0 animated:YES];
            [self.seekerInfoTableView reloadData];
            
        } else {
            
            kCustomAlertWithParamAndTarget(@"Message", error.localizedDescription, nil);
        }
    }];
}

- (NSMutableDictionary *)createMutableDict:(NSDictionary *)dict{
    
    NSMutableDictionary *mutableDict = [NSMutableDictionary new];
    
    for (NSString *key in dict.allKeys) {
        [mutableDict setValue:[dict valueForKey:key] forKey:key];
    }
    
    return mutableDict;
}

//--- Create comma seperate dates ---
- (NSString *)getCommaSeparateString{
    
    NSString *dates;
    NSMutableArray *dateFinalArray = [NSMutableArray new];
    
    for (NSString *date in tempSelectedDateArr) {
        
        NSDate *thisDate = [[self dateFormatter] dateFromString:date];
        NSString *dateString = [[self dateFormatter] stringFromDate:thisDate];
        [dateFinalArray addObject:dateString];
    }
    
    dates = [dateFinalArray componentsJoinedByString:@", "];
    
    return dates;
}

#pragma mark custom calender cell delegate
- (void)selectedDates:(NSMutableArray *)dateArray key:(NSString *)key{
    
    //--- Current screen data ---
    
    NSMutableArray *tempArray = [NSMutableArray new];
    
    for (NSDate *date in dateArray) {
        [tempArray addObject:[[self dateFormatter] stringFromDate:date]];
    }
    tempSelectedDateArr = [tempArray mutableCopy];
    [[RSDatePickerController sharedInstance]showTimePickerWithDate:[dateArray lastObject] dateFormat:nil fromView:self.view inViewController:self];
    
}

#pragma mark - RSDate Delegate
-(void)didSelectDate:(NSDate *)date dateString:(NSString *)dateString forView:(id)view
{
    NSString *dateStr = [[self dateFormatter] stringFromDate:date];
    [tempSelectedDateArr replaceObjectAtIndex:tempSelectedDateArr.count - 1 withObject:dateStr];
}

#pragma mark - Date Formatter
- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"yyyy-MM-dd hh:mm"; //@"dd-MM-yyyy";
    }
    
    return dateFormatter;
}


#pragma mark tableview delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 1) {
        return [arrProfessionalInfo count];
    }
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        return 515;
    }else if (indexPath.section == 1){
        
//        if (indexPath.row == arrProfessionalInfo.count -1){
//            return 348;
//        }else{
//            return 310;
//        }
        
        if (indexPath.row == arrProfessionalInfo.count -1){
            return 123;
        }else{
            return 123;
        }
    }else if (indexPath.section == 2){
        return 520;
    }else{
        return 62;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0){
        
        static NSString *MyIdentifier;
        MyIdentifier = @"InformationCell";
        InformationCell *cell = (InformationCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        if (cell == nil)
        {
            cell = [[InformationCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:MyIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.mydelegate = self;
        
        cell.subCategories.enabled = YES;
        //cell.subCategories.delegate  = self;
      
    if ([[CommonUtility sharedInstance] screenDataDictionary] != nil) {
        
        if ([[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"mail"] length] > 0) {
            cell.txtEmail.text = [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"mail"];
        }
        
        if ([[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:userNameKey] length] > 0) {
            cell.txtName.text = [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:userNameKey];
        }
        
        if ([[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"field_experience"] length] > 0) {
            cell.txtExperience.text = [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"field_experience"];
        }
        
        if ([[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"field_rate"] length] > 0) {
            cell.rate.text = [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"field_rate"];
        }
        
        if ([[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"field_paypal"] length] > 0) {
            cell.addPayPalEmail.text = [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"field_paypal"];
        }
        
        if ([[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"field_gender"] length] > 0) {
            cell.txtGender.selectedItem = [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"field_gender"];
        }
        
        if ([[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"field_about"] length] > 0) {
            cell.txtAbout.text = [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"field_about"];
        }
        
        if ([[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"field_age"] length] > 0) {
            cell.txtAge.text = [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"field_age"];
        }

        if ([[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"field_postcode"] length] > 0) {
            cell.postCode.text = [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"field_postcode"];
        }
        
        //---- Edit Mode ----
        cell.txtName.userInteractionEnabled = NO;
        cell.txtName.alpha = 0.6;
        cell.txtAge.userInteractionEnabled = NO;
        cell.postCode.userInteractionEnabled = NO;
        
        cell.txtAbout.userInteractionEnabled = NO;
        cell.txtGender.userInteractionEnabled = NO;
        cell.addPayPalEmail.userInteractionEnabled = NO;
        cell.rate.userInteractionEnabled = NO;
        cell.txtExperience.userInteractionEnabled = NO;
        cell.txtEmail.userInteractionEnabled = NO;
        cell.txtEmail.alpha = 0.6;
        cell.txtQualification.userInteractionEnabled = NO;
        cell.btnQualification.userInteractionEnabled = NO;
       
        if (isEditProfileFlag) {
            
            cell.txtAge.userInteractionEnabled = YES;
            cell.postCode.userInteractionEnabled = YES;
            
            cell.txtAbout.userInteractionEnabled = YES;
            cell.txtGender.userInteractionEnabled = YES;
            cell.addPayPalEmail.userInteractionEnabled = YES;
            cell.rate.userInteractionEnabled = YES;
            cell.txtExperience.userInteractionEnabled = YES;
            cell.txtQualification.userInteractionEnabled = YES;
            cell.btnQualification.userInteractionEnabled = YES;
        }

        if (isQualificationClickFlag) {
            cell.txtQualification.text = selectedQualifications;
        }else{
        
            NSMutableString *strQualification = [[NSMutableString alloc] init];
            if ([[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:keyfieldPrimaryEducation] length] > 0) {
                [strQualification appendFormat:@"%@,", [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:keyfieldPrimaryEducation]];
            }
            
            if ([[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:keyfieldSecondaryEducation] length] > 0) {
                [strQualification appendFormat:@"%@,", [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:keyfieldSecondaryEducation]];
            }
            
            if ([[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:keyfieldTertiaryEducation] length] > 0) {
                [strQualification appendFormat:@"%@,", [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:keyfieldTertiaryEducation]];
            }
            
            if ([[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:keyfieldLanguage] length] > 0) {
                [strQualification appendFormat:@"%@,", [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:keyfieldLanguage]];
            }
            
            if ([[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:keyfieldCommunityStudies] length] > 0) {
                [strQualification appendFormat:@"%@,", [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:keyfieldCommunityStudies]];
            }
            
            if ([[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:keyfieldTechnicalCourse] length] > 0) {
                [strQualification appendFormat:@"%@", [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:keyfieldTechnicalCourse]];
            }
            
            cell.txtQualification.text = strQualification;
            selectedQualifications = strQualification;
        }
        
        
     /*
        if ([[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"field_typeofcare"] isEqualToString:@"Babysitting"] && [[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"]valueForKey:subCategoriesKey] length] == 0){
            
            [[CommonUtility sharedInstance] addScreenDataInfo:@"Babysitter" key:subCategoriesKey];
            [cell.subCategories setSelectedItem:@"Babysitter"];
            
        }else if ([[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"field_typeofcare"] isEqualToString:@"Coaching"] && [[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:subCategoriesKey] length] == 0){
            
            [[CommonUtility sharedInstance] addScreenDataInfo:@"Netball" key:subCategoriesKey];
            [cell.subCategories setSelectedItem:@"Netball"];
            
        }else if ([[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"field_typeofcare"] isEqualToString:@"Tutoring"] && [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:subCategoriesKey] length] == 0){
            
            [[CommonUtility sharedInstance] addScreenDataInfo:@"Primary" key:subCategoriesKey];
            [cell.subCategories setSelectedItem:@"Primary"];
        }
        else if ([[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"field_typeofcare"] isEqualToString:gender] && [[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:gender] length] == 0){
            [[CommonUtility sharedInstance] addScreenDataInfo:@"Female" key:gender];
        }
      */
    }
        return cell;
    }else if (indexPath.section == 1){
        
        static NSString *MyIdentifier;
        //MyIdentifier = @"professionalInfocell";
        MyIdentifier = @"showProfessionalInfoTableViewCell";
        //AddMoreProfessionalInfoTableViewCell *cell = (AddMoreProfessionalInfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        ShowProfessionalInfoTableViewCell *cell = (ShowProfessionalInfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        if (cell == nil)
        {
//            cell = [[AddMoreProfessionalInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                                               reuseIdentifier:MyIdentifier];
            
            cell = [[ShowProfessionalInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                               reuseIdentifier:MyIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell.mydelegate = self;
        
        //--- Set tag to text fields ---
        cell.txtTypeOfCare.tag = indexPath.row;
        //cell.txtAreaOfSkill.tag = indexPath.row;
        //.txtStudyLevel.tag = indexPath.row;
        
//        //--- Set text on text fields ---
//        if ([[arrProfessionalInfo objectAtIndex:indexPath.row] valueForKey:@"typeofcare"] != nil) {
//            cell.txtTypeOfCare.selectedItem = [[arrProfessionalInfo objectAtIndex:indexPath.row] valueForKey:@"typeofcare"];
//        }
//        
//        if ([[arrProfessionalInfo objectAtIndex:indexPath.row] valueForKey:@"areaofskill"] != nil) {
//            cell.txtAreaOfSkill.selectedItem = [[arrProfessionalInfo objectAtIndex:indexPath.row] valueForKey:@"areaofskill"];
//        }
//        
//        if ([[arrProfessionalInfo objectAtIndex:indexPath.row] valueForKey:@"areaofstudy"] != nil) {
//            cell.txtStudyLevel.selectedItem = [[arrProfessionalInfo objectAtIndex:indexPath.row] valueForKey:@"areaofstudy"];
//        }
        
        
        //--- Set text on text fields ---
        if ([[[arrProfessionalInfo objectAtIndex:indexPath.row] valueForKey:@"type"] isEqualToString:@"typeofcare"]) {
            cell.txtTypeOfCare.text = [[arrProfessionalInfo objectAtIndex:indexPath.row] valueForKey:@"title"];
            cell.txtTypeOfCareRate.text = [[arrProfessionalInfo objectAtIndex:indexPath.row] valueForKey:@"rate"];
            
        }else if ([[[arrProfessionalInfo objectAtIndex:indexPath.row] valueForKey:@"type"] isEqualToString:@"areaofskill"]) {
            cell.txtTypeOfCare.text = [[arrProfessionalInfo objectAtIndex:indexPath.row] valueForKey:@"title"];
            cell.txtTypeOfCareRate.text = [[arrProfessionalInfo objectAtIndex:indexPath.row] valueForKey:@"rate"];
            
        }if ([[[arrProfessionalInfo objectAtIndex:indexPath.row] valueForKey:@"type"] isEqualToString:@"areaofstudy"]) {
            cell.txtTypeOfCare.text = [[arrProfessionalInfo objectAtIndex:indexPath.row] valueForKey:@"title"];
            cell.txtTypeOfCareRate.text = [[arrProfessionalInfo objectAtIndex:indexPath.row] valueForKey:@"rate"];
        }
        
//        if ([[[arrProfessionalInfo objectAtIndex:indexPath.row] valueForKey:@"type"] isEqualToString:@"areaofskill"]) {
//            cell.txtAreaOfSkill.selectedItem = [[arrProfessionalInfo objectAtIndex:indexPath.row] valueForKey:@"title"];
//            cell.txtAreaOfSkillRate.text = [[arrProfessionalInfo objectAtIndex:indexPath.row] valueForKey:@"rate"];
//
//        }else
//        
//        if ([[[arrProfessionalInfo objectAtIndex:indexPath.row] valueForKey:@"type"] isEqualToString:@"areaofstudy"]) {
//            cell.txtStudyLevel.selectedItem = [[arrProfessionalInfo objectAtIndex:indexPath.row] valueForKey:@"title"];
//            cell.txtStudyLevelRate.text = [[arrProfessionalInfo objectAtIndex:indexPath.row] valueForKey:@"rate"];
//        }
        
        cell.lblAddmore.hidden = YES;
        cell.addMoreBtn.hidden = YES;
        
        if (indexPath.row == arrProfessionalInfo.count -1){
            
            cell.lblAddmore.hidden = NO;
            cell.addMoreBtn.hidden = NO;
        }
        
        
        return cell;
        
    }else if (indexPath.section == 2){
        
        static NSString *MyIdentifier;
        MyIdentifier = @"CalenderCell";
        CalenderCell *cell = (CalenderCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        if (cell == nil)
        {
            cell = [[CalenderCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.mydelegate = self;
        
        cell.userInteractionEnabled = NO;
        
        if (isEditProfileFlag) {
        
            cell.userInteractionEnabled = YES;
        }
        
            //--- Set introduction video ---
            if (tempUpdatedVideoData != nil && isIntroBtnClickFlag) {
                
                if ([[tempUpdatedVideoData valueForKey:@"isVedioUrl"] isEqualToString:@"NO"]) {
                    
                    [cell.videoThumpBtn setBackgroundImage:nil forState:UIControlStateNormal];
                    [cell.videoThumpBtn setImage:[tempUpdatedVideoData valueForKey:@"image"] forState:UIControlStateNormal];
                }else{
                
                    [cell.videoThumpBtn setBackgroundImage:[self loadThumbNail:[tempUpdatedVideoData valueForKey:@"vedioUrl"]] forState:UIControlStateNormal];
                    [cell.videoThumpBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
                }
                
            }else{
        
            if (![[[[[CommonUtility sharedInstance].screenDataDictionary valueForKeyPath:@"user"] valueForKeyPath:userIntroImageKey] valueForKeyPath:filetype] isEqualToString:@"image/png"]) {
                
                [cell.videoThumpBtn setBackgroundImage:[self loadThumbNail:[[[[CommonUtility sharedInstance].screenDataDictionary valueForKeyPath:@"user"] valueForKeyPath:userIntroImageKey] valueForKeyPath:@"url"]] forState:UIControlStateNormal];
                [cell.videoThumpBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
                
            }else if ([[[[[CommonUtility sharedInstance].screenDataDictionary valueForKeyPath:@"user"] valueForKeyPath:userIntroImageKey] valueForKeyPath:filetype] isEqualToString:@"image/png"]) {
                
                if ([[[[[CommonUtility sharedInstance].screenDataDictionary valueForKeyPath:@"user"] valueForKeyPath:userIntroImageKey] valueForKeyPath:@"url"] length] > 0) {
                    [cell.videoThumpBtn setImage:nil forState:UIControlStateNormal];
                    [cell.videoThumpBtn loadImage:[[[[CommonUtility sharedInstance].screenDataDictionary valueForKeyPath:@"user"] valueForKeyPath:userIntroImageKey] valueForKeyPath:@"url"]];
                }
            }
        }
        
         cell.videoThumpBtn.userInteractionEnabled = NO;
        
         if (isEditProfileFlag) {
         
             cell.videoThumpBtn.userInteractionEnabled = YES;
         }
        
        return cell;
    }
    else
    {
        static NSString *MyIdentifier;
        MyIdentifier = @"signUpBtnCell";
        ProfileSignUpBtnCell *cell = (ProfileSignUpBtnCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        if (cell == nil)
        {
            cell = [[ProfileSignUpBtnCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:MyIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.mydelegate = self;
        cell.submitBtn.hidden = YES;
        
        return cell;
    }
}


#pragma mark thump nail image from video
-(UIImage *)loadThumbNail:(NSString *)urlVideo
{
    NSURL *url = [NSURL URLWithString:urlVideo];
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
    AVAssetImageGenerator *generate = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generate.appliesPreferredTrackTransform=TRUE;
    NSError *err = NULL;
    CMTime time = CMTimeMake(1, 60);
    CGImageRef imgRef = [generate copyCGImageAtTime:time actualTime:NULL error:&err];
    NSLog(@"err==%@, imageRef==%@", err, imgRef);
    return [[UIImage alloc] initWithCGImage:imgRef];
}

@end
