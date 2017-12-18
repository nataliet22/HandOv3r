//
//  ProfileViewController.m
//  UNEYE
//
//  Created by Satya Kumar on 10/03/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileSubmitBtnCell.h"
#import "BasicProfileCell.h"
#import "Additionalfamilymemebercell.h"

@interface ProfileViewController ()<BasicProfileCellDelegate, AdditionalfamilymemebercellDelegate, ProfileSubmitBtnCellDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    
    BOOL isProfileFlag;
    BOOL isEditProfileFlag;
    BOOL isIntroBtnClickFlag;
    
    NSInteger femilyMemCout;
    
    NSMutableDictionary *updatedDataDict;
    NSMutableDictionary *tempUpdatedVideoData;
}

@property (weak, nonatomic) IBOutlet UIView *profileImage_View;
@property (weak, nonatomic) IBOutlet AsyncImageView *profileImageViewBtn;
@property (weak, nonatomic) IBOutlet UITableView *providerInfoTableView;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    if (IS_IPHONE_6) {
//        _profileImage_View.translatesAutoresizingMaskIntoConstraints = NO;
//        [self.view addConstraints:[NSLayoutConstraint
//                                   constraintsWithVisualFormat:@"H:[_profileImage_View(==40)]-|"
//                                   options:NSLayoutFormatDirectionLeadingToTrailing
//                                   metrics:nil
//                                   views:NSDictionaryOfVariableBindings(_profileImage_View)]];
//    }else if (IS_IPHONE_6P) {
//        _profileImage_View.translatesAutoresizingMaskIntoConstraints = NO;
//        [self.view addConstraints:[NSLayoutConstraint
//                                   constraintsWithVisualFormat:@"H:[_profileImage_View(==60)]-|"
//                                   options:NSLayoutFormatDirectionLeadingToTrailing
//                                   metrics:nil
//                                   views:NSDictionaryOfVariableBindings(_profileImage_View)]];
//    }
    
    _providerInfoTableView.alpha = 0.7;
    _profileImageViewBtn.userInteractionEnabled = NO;
      isEditProfileFlag = NO;
      isIntroBtnClickFlag = NO;
    
    //--- Gesture for hiding keyboard ---
    UIGestureRecognizer *tapperGesture = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(hideKeyBoardOnSingleTap:)];
    tapperGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapperGesture];
    
    //--- Dict for current updated data ---
    updatedDataDict = [[NSMutableDictionary alloc] init];
    tempUpdatedVideoData = [[NSMutableDictionary alloc] init];
    
    //--- Copy user data ---
    NSMutableDictionary *tempDict = [self createMutableDict:[[CommonUtility sharedInstance].userDictionary valueForKey:@"user"]];
    [[CommonUtility sharedInstance].userDictionary setValue:tempDict forKey:@"user"];
    
    
    NSArray *tempFamilyArr = [[[CommonUtility sharedInstance].userDictionary valueForKey:@"user"] valueForKey:@"familymember"];
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    
    if (tempFamilyArr != nil && tempFamilyArr.count > 0) {
        
        for (NSDictionary *dict in tempFamilyArr) {
            
            NSMutableDictionary *tempDict = [self createMutableDict:dict];
            [tempArr addObject:tempDict];
        }
        
        [[[CommonUtility sharedInstance].userDictionary valueForKey:@"user"] setValue:tempArr forKey:@"familymember"];
    }
    
    [CommonUtility sharedInstance].screenDataDictionary = [[CommonUtility sharedInstance].userDictionary mutableCopy];
    
    NSLog(@"screenDataDictionary :- %@", [CommonUtility sharedInstance].screenDataDictionary);
    
    //--- Load Profile image from url ---
    if ([[[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"picture"] valueForKey:@"url"] length] > 0) {
        [self.profileImageViewBtn loadImage:[[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"picture"] valueForKey:@"url"]];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    //isEditProfileFlag = NO;
//    _providerInfoTableView.alpha = 0.7;
//    _profileImageViewBtn.userInteractionEnabled = NO;
    
    //--- Check FamilyMembers ---
    [self checkFamilyMembers];
}

-(void)updateallUI{
   
    //--- Copy user data ---
    [CommonUtility sharedInstance].screenDataDictionary = [[CommonUtility sharedInstance].userDictionary mutableCopy];
    
    NSLog(@"screenDataDictionary :- %@", [CommonUtility sharedInstance].screenDataDictionary);
    
    //--- Load Profile image from url ---
    if ([[[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"picture"] valueForKey:@"url"] length] > 0) {
        [self.profileImageViewBtn loadImage:[[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"picture"] valueForKey:@"url"]];
    }

    //--- Check FamilyMembers ---
    [self checkFamilyMembers];
    
}

- (void)checkFamilyMembers{
    
    @try {
        NSArray *membersArr = [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"familymember"];
        
        if (![membersArr isKindOfClass:[NSNull class]] && membersArr.count > 1){
            femilyMemCout = membersArr.count;
        }else{
            
            femilyMemCout = 0;
        }
    } @catch (NSException *exception) {
        NSLog(@"exception :- %@", exception.description);
    }
    
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

- (IBAction)backButtonAction:(id)sender
{
    //--- Clear current screen data ---
    [[CommonUtility sharedInstance].screenDataDictionary removeAllObjects];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark hide Key Board on Single Tap
- (void)hideKeyBoardOnSingleTap:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}
- (IBAction)profileEditBtnClicked:(id)sender {
    
    
    if (!isEditProfileFlag) {
        isEditProfileFlag = YES;
        _providerInfoTableView.alpha = 1.0;
        _profileImageViewBtn.userInteractionEnabled = YES;
    }else{
    
        _profileImageViewBtn.userInteractionEnabled = NO;
        _providerInfoTableView.alpha = 0.7;
        isEditProfileFlag = NO;
    }
    
    [_providerInfoTableView reloadData];

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

- (IBAction)addFamilyMembers:(id)sender {
    
    //    UIButton *button = (UIButton *)sender;
    //    //--- Set family members ---
    //    if ([CommonUtility sharedInstance].screenDataDictionary == nil || [[CommonUtility sharedInstance].screenDataDictionary valueForKey:[NSString stringWithFormat:@"family_member[%ld][name]", button.tag-1]] == nil) {
    //
    //        kCustomAlertWithParamAndTarget(@"Message", @"Please add family member name.", nil);
    //        return;
    //
    //    }else if ([[CommonUtility sharedInstance].screenDataDictionary valueForKey:[NSString stringWithFormat:@"family_member[%ld][age]", button.tag-1]] == nil) {
    //
    //        kCustomAlertWithParamAndTarget(@"Message", @"Please add family member age.", nil);
    //        return;
    //
    //    }else if ([[CommonUtility sharedInstance].screenDataDictionary valueForKey:[NSString stringWithFormat:@"family_member[%ld][requirements]", button.tag-1]] == nil) {
    //
    //        kCustomAlertWithParamAndTarget(@"Message", @"Please add family member requirement.", nil);
    //        return;
    //    }
    
    if ([CommonUtility sharedInstance].screenDataDictionary == nil || [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"familymember"] == nil) {
        
        kCustomAlertWithParamAndTarget(@"Message", @"Please add atleast one family member.", nil);
        return;
        
    }
    
    femilyMemCout++;  // update the data source
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:femilyMemCout+1 inSection:0];
    [self.providerInfoTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    [self.providerInfoTableView reloadData];
    [self.providerInfoTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark Camera Controller Handler Delegate
-(void)getImage:(UIImage *)image vedioUrl:(NSURL *)vedioUrl key:(NSString *)key{
    
    if (image) {
        //--- Current screen data ---
        [[CommonUtility sharedInstance] addImageScreenDataInfo:image key:key];
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark tableview delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return femilyMemCout + 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        return 263;
    }else if (indexPath.row == femilyMemCout + 2) {
        
        return 62;
    }else{
        
        if (indexPath.row == femilyMemCout + 1)
            return 366;
        else
            return 175;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    @try {
        if (indexPath.row == 0) {
            static NSString *MyIdentifier;
            MyIdentifier = @"basicprofilecell";
            BasicProfileCell *cell = (BasicProfileCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
            if (cell == nil)
            {
                cell = [[BasicProfileCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:MyIdentifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.mydelegate = self;
            
            if ([[CommonUtility sharedInstance] screenDataDictionary] != nil) {
                
                if ([[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:userNameKey] != nil) {
                    [cell.txtName setText:[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:userNameKey]];
                }
                if ([[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"]valueForKey:field_typeofcare] != nil) {
                    cell.txtRequired.selectedItem = [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:field_typeofcare];
                }
                if ([[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:userEmailKey] != nil) {
                    [cell.txtEmail setText:[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:userEmailKey]];
                }
                
                if ([[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:AboutKey] != nil) {
                    
                    cell.txtAbout.textColor = [UIColor blackColor];
                    cell.txtAbout.text = [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:AboutKey];
                }
            }
            
            //---- Edit Mode ----
            cell.txtName.userInteractionEnabled = NO;
            cell.txtName.alpha = 0.6;
            cell.txtRequired.userInteractionEnabled = NO;
            cell.txtAbout.userInteractionEnabled = NO;
            cell.txtEmail.userInteractionEnabled = NO;
            cell.txtEmail.alpha = 0.6;
            cell.txtPassword.userInteractionEnabled = NO;
            cell.txtConfirmPassword.userInteractionEnabled = NO;
            
            if (isEditProfileFlag) {
                //cell.txtName.userInteractionEnabled = YES;
                cell.txtRequired.userInteractionEnabled = YES;
                cell.txtAbout.userInteractionEnabled = YES;
                //cell.txtEmail.userInteractionEnabled = YES;
                cell.txtPassword.userInteractionEnabled = YES;
                cell.txtConfirmPassword.userInteractionEnabled = YES;
            }
            
            return cell;
        }else if (indexPath.row == femilyMemCout + 2){
            
            static NSString *MyIdentifier;
            MyIdentifier = @"submitBtncell";
            ProfileSubmitBtnCell *cell = (ProfileSubmitBtnCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
            
            if (cell == nil)
            {
                cell = [[ProfileSubmitBtnCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:MyIdentifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.mydelegate = self;
            
            cell.submitBtn.userInteractionEnabled = NO;
            
            if (isEditProfileFlag) {
                cell.submitBtn.userInteractionEnabled = YES;
            }
            
            return cell;
            
            
        }else{
            static NSString *MyIdentifier;
            MyIdentifier = @"familymemebercell";
            Additionalfamilymemebercell *cell = (Additionalfamilymemebercell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
            
            if (cell == nil)
            {
                cell = [[Additionalfamilymemebercell alloc] initWithStyle:UITableViewCellStyleDefault
                                                          reuseIdentifier:MyIdentifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.mydelegate = self;
            cell.tag = indexPath.row;
            cell.btnAddMoreMem.tag = indexPath.row;
            
            if ([[CommonUtility sharedInstance] screenDataDictionary] != nil) {
                
                NSArray *membersArr = [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"familymember"];
                //--- Set family members ---
                if (![membersArr isKindOfClass:[NSNull class]] && membersArr.count > indexPath.row - 1) {
                    
                    NSMutableDictionary *memDict = [[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"familymember"] objectAtIndex:indexPath.row - 1];
                    
                    if ([memDict valueForKeyPath:@"title"] != nil && ![[memDict valueForKeyPath:@"title"] isKindOfClass:[NSNull class]]) {
                        
                        [cell.txtName setText:[memDict valueForKeyPath:@"title"]];
                    }
                    
                    if ([memDict valueForKeyPath:@"field_age"] != nil && ![[memDict valueForKeyPath:@"field_age"] isKindOfClass:[NSNull class]]) {
                        
                        [cell.txtAge setText:[memDict valueForKeyPath:@"field_age"]];
                    }
                    
                    if ([memDict valueForKeyPath:@"field_requirements"] != nil && ![[memDict valueForKeyPath:@"field_requirements"] isKindOfClass:[NSNull class]]) {
                        
                        [cell.txtRequirements setText:[memDict valueForKeyPath:@"field_requirements"]];
                    }
                }
                
                if (indexPath.row == femilyMemCout + 1) {
                    cell.videoThumpBtn.hidden = NO;
                    cell.lblAddMoreMem.hidden = NO;
                    cell.lblVideoIntro.hidden = NO;
                    cell.btnAddMoreMem.hidden = NO;
                    cell.videoThumpBtn.hidden = NO;
                }else{
                    
                    cell.videoThumpBtn.hidden = YES;
                    cell.lblAddMoreMem.hidden = YES;
                    cell.lblVideoIntro.hidden = YES;
                    cell.btnAddMoreMem.hidden = YES;
                    cell.videoThumpBtn.hidden = YES;
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
                        
                        dispatch_async(dispatch_get_global_queue(0, 0), ^{
                            //load your data here.
                            UIImage *image = [self loadThumbNail:[[[[CommonUtility sharedInstance].screenDataDictionary valueForKeyPath:@"user"] valueForKeyPath:userIntroImageKey] valueForKeyPath:@"url"]];
                            dispatch_async(dispatch_get_main_queue(), ^{
                                //update UI in main thread.
                                [cell.videoThumpBtn setBackgroundImage:image forState:UIControlStateNormal];
                                [cell.videoThumpBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
                            });
                        });
                        
                        [cell.videoThumpBtn setBackgroundImage:[self loadThumbNail:[[[[CommonUtility sharedInstance].screenDataDictionary valueForKeyPath:@"user"] valueForKeyPath:userIntroImageKey] valueForKeyPath:@"url"]] forState:UIControlStateNormal];
                        [cell.videoThumpBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
                        
                    }else if ([[[[[CommonUtility sharedInstance].screenDataDictionary valueForKeyPath:@"user"] valueForKeyPath:userIntroImageKey] valueForKeyPath:filetype] isEqualToString:@"image/png"]) {
                        
                        if ([[[[[CommonUtility sharedInstance].screenDataDictionary valueForKeyPath:@"user"] valueForKeyPath:userIntroImageKey] valueForKeyPath:@"url"] length] > 0) {
                            [cell.videoThumpBtn setImage:nil forState:UIControlStateNormal];
                            [cell.videoThumpBtn loadImage:[[[[CommonUtility sharedInstance].screenDataDictionary valueForKeyPath:@"user"] valueForKeyPath:userIntroImageKey] valueForKeyPath:@"url"]];
                        }
                    }
                }
            }
            
            //---- Edit Mode ----
            cell.txtName.userInteractionEnabled = NO;
            cell.txtAge.userInteractionEnabled = NO;
            cell.txtRequirements.userInteractionEnabled = NO;
            
            cell.videoThumpBtn.userInteractionEnabled = NO;
            cell.lblAddMoreMem.userInteractionEnabled = NO;
            cell.lblVideoIntro.userInteractionEnabled = NO;
            cell.btnAddMoreMem.userInteractionEnabled = NO;
            cell.videoThumpBtn.userInteractionEnabled = NO;
            
            if (isEditProfileFlag) {
                
                cell.txtName.userInteractionEnabled = YES;
                cell.txtAge.userInteractionEnabled = YES;
                cell.txtRequirements.userInteractionEnabled = YES;
                
                cell.videoThumpBtn.userInteractionEnabled = YES;
                cell.lblAddMoreMem.userInteractionEnabled = YES;
                cell.lblVideoIntro.userInteractionEnabled = YES;
                cell.btnAddMoreMem.userInteractionEnabled = YES;
                cell.videoThumpBtn.userInteractionEnabled = YES;
            }
            
            return cell;
            
        }
    } @catch (NSException *exception) {
         NSLog(@"exception :- %@", exception.description);
    }
}

#pragma mark custom cell delegates
- (void)get:(NSString *)text key:(NSString *)key{
    
//    //--- Add about text current screen data ---
//    if ([key isEqualToString:About]) {
//        NSDictionary *userAboutDict = @{undefinekey: @{@"0": @{valuekey: text}}};
//        [[CommonUtility sharedInstance].screenDataDictionary setValue:userAboutDict forKey:AboutKey];
//        [updatedDataDict setValue:text forKey:AboutKey];
//        
//        return;
//    }

    if ([key isEqualToString:AboutKey]) {
        
        //[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:AboutKey]
        
        [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] setValue:text forKey:AboutKey];
        [updatedDataDict setValue:text forKey:AboutKey];
        
        return;
    }else if ([key isEqualToString:field_typeofcare]) {
        //--- Add Type Of Care into current screen data ---
        
        NSMutableDictionary *userTypeOfCareDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSMutableDictionary dictionaryWithObjectsAndKeys:text, valuekey, nil], @"0", nil];
        [[CommonUtility sharedInstance].screenDataDictionary setValue:userTypeOfCareDict forKey:field_typeofcare];
        [updatedDataDict setValue:text forKey:field_typeofcare];
        
        return;
    }
    
    //--- Current screen data ---
    [[CommonUtility sharedInstance] addScreenDataInfo:text key:key];
    [updatedDataDict setValue:text forKey:key];
}

- (void)get:(NSString *)key value:(NSString *)value parentkey:(NSString *)parentkey index:(NSString *)index{
    
    //--- Add Family members text current screen data ---
    if ([parentkey isEqualToString:femilymember]) {
    
        if ([key isEqualToString:@"name"]) {
            key = @"title";
        }else if ([key isEqualToString:@"age"]) {
            key = @"field_age";
        }else if ([key isEqualToString:@"requirements"]) {
            key = @"field_requirements";
        }
        
        NSMutableArray *familyArray = [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] valueForKey:@"familymember"];
        
        if(familyArray && [index intValue] <  familyArray.count){
            
            //NSMutableDictionary *userFamilyMemDict = [familyArray valueForKey:index];
            NSMutableDictionary *userFamilyMemDict = [familyArray objectAtIndex:[index intValue]];
            
            if (userFamilyMemDict) {
                [userFamilyMemDict setValue:value forKey:key];
                
                if (familyArray.count > [index intValue]) {
                    [familyArray replaceObjectAtIndex:[index intValue] withObject:userFamilyMemDict];
                }
                
                [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] setValue:familyArray forKey:@"familymember"];
                [updatedDataDict setValue:familyArray forKey:femilymember];
            }else{
                
//                [familyArray setValue:[NSMutableDictionary dictionaryWithObjectsAndKeys:value, key, nil] forKey:index];
//                [[updatedDataDict valueForKey:femilymember] setValue:[NSMutableDictionary dictionaryWithObjectsAndKeys:value, key, nil] forKey:index];
            }
        }else{
            
            //NSMutableDictionary *userFamilyMemDict = [NSMutableDictionary dictionaryWithObjectsAndKeys: [NSMutableDictionary dictionaryWithObjectsAndKeys:value, key, nil], index, nil];
            
            NSMutableDictionary *userFamilyMemDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:value, key, nil];

            [familyArray addObject:userFamilyMemDict];
            [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"user"] setValue:familyArray forKey:@"familymember"];
            [updatedDataDict setValue:userFamilyMemDict forKey:femilymember];
        }
    }
}

-(void)submitForm{
    
    //--- Set All Key Values Parameters and Call API ---
    [self setAllKeyValuesParameters];
}

//--- Set All Key Values Parameters ---
-(void)setAllKeyValuesParameters{
    

    //--- Update Profile API ---
     [self updateProfileAPI:updatedDataDict];
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
        
            kCustomAlertWithParamAndTarget(@"Message", @"Your profile has been successfully updated.", nil);
            isEditProfileFlag = NO;
            _providerInfoTableView.alpha = 0.7;
            _profileImageViewBtn.userInteractionEnabled = NO;
            [self.providerInfoTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:0 animated:YES];
            [self.providerInfoTableView reloadData];
            
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
            
            [_providerInfoTableView reloadData];
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
            [_providerInfoTableView reloadData];
        }];
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
