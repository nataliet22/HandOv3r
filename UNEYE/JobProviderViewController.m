//
//  JobProviderViewController.m
//  UNEYE
//
//  Created by AppTech_Mac1 on 4/6/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import "JobProviderViewController.h"
#import "ProfileSubmitBtnCell.h"
#import "BasicProfileCell.h"
#import "Additionalfamilymemebercell.h"
#import "AddMoreTypeOfCareTableViewCell.h"


@interface JobProviderViewController ()<BasicProfileCellDelegate, AdditionalfamilymemebercellDelegate, ProfileSubmitBtnCellDelegate, AddMoreTypeOfCareTableViewCellDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    
    BOOL isProfileFlag;
    NSInteger femilyMemCout;
    NSString *temp_confirmpass;
    NSInteger totalRowCount;
    
    NSMutableArray *arrTypeOfcare;
    
}

@property (weak, nonatomic) IBOutlet UIView *profileImage_View;
@property (weak, nonatomic) IBOutlet AsyncImageView *profileImageViewBtn;
@property (weak, nonatomic) IBOutlet UITableView *providerInfoTableView;

@end

@implementation JobProviderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //       if (IS_IPHONE_6) {
    //           _profileImage_View.translatesAutoresizingMaskIntoConstraints = NO;
    //           [self.view addConstraints:[NSLayoutConstraint
    //                                      constraintsWithVisualFormat:@"H:[_profileImage_View(==10)]-|"
    //                                      options:NSLayoutFormatDirectionLeadingToTrailing
    //                                      metrics:nil
    //                                      views:NSDictionaryOfVariableBindings(_profileImage_View)]];
    //       }else if (IS_IPHONE_6P) {
    //           _profileImage_View.translatesAutoresizingMaskIntoConstraints = NO;
    //           [self.view addConstraints:[NSLayoutConstraint
    //                                      constraintsWithVisualFormat:@"H:[_profileImage_View(==30)]-|"
    //                                      options:NSLayoutFormatDirectionLeadingToTrailing
    //                                      metrics:nil
    //                                      views:NSDictionaryOfVariableBindings(_profileImage_View)]];
    //       }
    
    
    //--- Multiple Type of cares ---
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Type of care", @"typeofcare",
                                     @"Area of skill", @"areaofskill",
                                     @"Area of study", @"areaofstudy",
                                     nil];
    arrTypeOfcare = [[NSMutableArray alloc] initWithObjects:dataDict, nil];
    
    //--- Gesture for hiding keyboard ---
    UIGestureRecognizer *tapperGesture = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(hideKeyBoardOnSingleTap:)];
    tapperGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapperGesture];
    
    @try {
        //--- Check Facebook Account Data ---
        if ([CommonUtility sharedInstance].facebookUserInfoDictionary.count > 0) {
            [[CommonUtility sharedInstance] addScreenDataInfo:[[CommonUtility sharedInstance].facebookUserInfoDictionary valueForKey:@"email"] key:@"mail"];
            [[CommonUtility sharedInstance] addScreenDataInfo:[NSString stringWithFormat:@"%@ %@", [[CommonUtility sharedInstance].facebookUserInfoDictionary valueForKey:@"first_name"], [[CommonUtility sharedInstance].facebookUserInfoDictionary valueForKey:@"last_name"]] key:@"name"];
            
            if ([[CommonUtility sharedInstance].facebookUserInfoDictionary valueForKey:@"picture"] != nil) {
                
                NSDictionary *pictDict = [[CommonUtility sharedInstance].facebookUserInfoDictionary valueForKey:@"picture"];
                
                if (pictDict != nil) {
                    
                    NSDictionary *pictData = [pictDict valueForKey:@"data"];
                    
                    if ([[pictData valueForKey:@"url"] length] > 0) {
                        
                        [_profileImageViewBtn loadImage:[pictData valueForKey:@"url"]];
                    }
                }
            }
            
            [[CommonUtility sharedInstance].facebookUserInfoDictionary removeAllObjects];
        }

    } @catch (NSException *exception) {
        NSLog(@"exception :- %@", exception.description);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    NSLog(@"screenDataDictionary :- %@", [CommonUtility sharedInstance].screenDataDictionary);
    
    if ([[[CommonUtility sharedInstance].screenDataDictionary valueForKey:femilymember] count] == 0) {
        //---- Set initial family member ---
        NSMutableArray *memberData = [[NSMutableArray alloc] initWithObjects:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"", @"age", @"", @"name", @"", @"requirements", nil], nil];
        [[CommonUtility sharedInstance] addScreenDataFamilyInfo:memberData key:femilymember];
        
        //femilyMemCout = [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:femilymember] count];
        
    }else if([[[CommonUtility sharedInstance].screenDataDictionary valueForKey:femilymember] count] > 0){
    
        //femilyMemCout = [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:femilymember] count];
    
    }
    
}

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
                                                                
                                                                [self openCamera:NO sourceType:@"photo"];
                                                            }];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                               
                                                               [self openCamera:NO sourceType:@"camera"];
                                                           }];
    UIAlertAction *videoAction = [UIAlertAction actionWithTitle:@"Video"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                              
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
    
    if ([CommonUtility sharedInstance].screenDataDictionary == nil || [[CommonUtility sharedInstance].screenDataDictionary valueForKey:femilymember] == nil) {
        
        kCustomAlertWithParamAndTarget(@"Message", @"Please add atleast one family member.", nil);
        return;
        
    }
    
    [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:femilymember] addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"", @"age", @"", @"name", @"", @"requirements", nil]];
    
    if ([[CommonUtility sharedInstance] screenDataDictionary] != nil) {
        
        NSMutableArray *familyMemArray = [[CommonUtility sharedInstance].screenDataDictionary valueForKey:femilymember];
            femilyMemCout = [familyMemArray count];
    }
    
    //femilyMemCout++;  // update the data source
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:totalRowCount - 1 inSection:1];
    
    NSLog(@"indexPath :- %@", indexPath);
    
    //[self.providerInfoTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    [self.providerInfoTableView reloadData];
    
    //[self.providerInfoTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
    
    [self.providerInfoTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark Camera Controller Handler Delegate
-(void)getImage:(UIImage *)image vedioUrl:(NSURL *)vedioUrl key:(NSString *)key{
    
    if (image) {
        //--- Add screen data ---
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

//#pragma mark tableview delegates
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    
//    if ([[CommonUtility sharedInstance] screenDataDictionary] != nil) {
//        
//        NSMutableArray *familyMemArray = [[CommonUtility sharedInstance].screenDataDictionary valueForKey:femilymember];
//        if ([familyMemArray count] > 0) {
//            //femilyMemCout = [familyMemArray count];
//        }
//    }
//    
//    return femilyMemCout + 3;
//}

#pragma mark tableview delegates
-(IBAction)addMultiPleTypeOfCare:(id)sender{

    //--- Multiple Type of cares ---
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Type of care", @"typeofcare",
                                     @"Area of skill", @"areaofskill",
                                     @"Area of study", @"areaofstudy",
                                     nil];
    [arrTypeOfcare addObject:dataDict];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:arrTypeOfcare.count - 1 inSection:0];
    
    NSLog(@"indexPath :- %@", indexPath);
    
    [self.providerInfoTableView reloadData];
    [self.providerInfoTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark tableview delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    if ([[CommonUtility sharedInstance] screenDataDictionary] != nil) {
//        
//        NSMutableArray *familyMemArray = [[CommonUtility sharedInstance].screenDataDictionary valueForKey:femilymember];
//        if ([familyMemArray count] > 0) {
//            femilyMemCout = [familyMemArray count];
//            return femilyMemCout + 2;
//        }
//    }
    
    //NSLog(@"numberOfRowsInSection screenDataDictionary :- %@", [CommonUtility sharedInstance].screenDataDictionary);
    
    femilyMemCout = [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:femilymember] count];
    
//    if (femilyMemCout == 1) {
//        femilyMemCout = 0;
//        return 3;
//    }
    
    
    if (section == 0) {
        return [arrTypeOfcare count];
    }
    
     totalRowCount = femilyMemCout + 2;
    
    return totalRowCount;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    /*
    if (indexPath.row == 0) {
        
        return 353;
    }else if (indexPath.row == femilyMemCout + 2) {
        
        return 62;
    }else{
        
        if (indexPath.row == femilyMemCout + 1)
            return 360;
        else
            return 175;
    }
*/
/*
    if (indexPath.row == 0) {
        
        return 203;
    }else if (indexPath.row == 1) {
        
        return 353;
    }else if (indexPath.row == totalRowCount - 1) {
        
        return 62;
    }else{
        
        if (indexPath.row == totalRowCount - 2)
            return 360;
        else
            return 175;
    }
    
*/
  
    if (indexPath.section == 0) {
        
        if (indexPath.row == arrTypeOfcare.count -1){
        
            return 251;
        }else{
            
        return 180;
        }
    }else {
 
    if (indexPath.row == 0) {
        
        return 313;
    }else if (indexPath.row == totalRowCount - 1) {
        
        return 62;
    }else{
        
        if (indexPath.row == totalRowCount - 2)
            return 360;
        else
            return 175;
    }
    
}

    
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        static NSString *MyIdentifier;
        MyIdentifier = @"typeofcarecell";
        AddMoreTypeOfCareTableViewCell *cell = (AddMoreTypeOfCareTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        if (cell == nil)
        {
            cell = [[AddMoreTypeOfCareTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:MyIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.mydelegate = self;
        
        return cell;
        
    }else if (indexPath.row == 1) {
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
            
            if ([[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"name"] != nil) {
                [cell.txtName setText:[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"name"]];
            }
            
            if ([[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"required"] != nil) {
                cell.txtRequired.selectedItem = [[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"required"];
            }
            
            if ([[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"mail"] != nil) {
                [cell.txtEmail setText:[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"mail"]];
            }
            
            if ([[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"password"] != nil) {
                [cell.txtPassword setText:[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"password"]];
            }
            
            if ([[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"confirmpassword"] != nil) {
                [cell.txtConfirmPassword setText:[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"confirmpassword"]];
            }
            
            if ([[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"about"] != nil) {
                [cell.txtAbout setText:[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"about"]];
            }
        }
        
        return cell;
        
    }else if (indexPath.row == totalRowCount - 1){
        
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
        
        return cell;
        
    }else{
        static NSString *MyIdentifier;
        MyIdentifier = @"familymemebercell";
        
        Additionalfamilymemebercell *cell = (Additionalfamilymemebercell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier forIndexPath:indexPath];
        
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
            
            NSMutableArray *familyMemArray = [[CommonUtility sharedInstance].screenDataDictionary valueForKey:femilymember];
            
            //NSLog(@"cell.tag :- %ld", (long)cell.tag);
            
            if(cell.tag > 0 && cell.tag < totalRowCount - 1) {
                
                NSInteger index = cell.tag - 1;
                
                NSMutableDictionary *memberDict = [familyMemArray objectAtIndex:index];
                
                //--- Set family members ---
                if ([memberDict valueForKey:familyMemberNameKey] != nil) {
                    [cell.txtName setText:[memberDict valueForKey:familyMemberNameKey]];
                    
                }else if ([memberDict valueForKey:familyMemberAgeKey] != nil) {
                    [cell.txtAge setText:[memberDict valueForKey:familyMemberAgeKey]];
                    
                }else if ([memberDict valueForKey:familyMemberRequirementsKey] != nil) {
                    [cell.txtRequirements setText:[memberDict valueForKey:familyMemberRequirementsKey]];
                }
            }
            
            if (indexPath.row == totalRowCount - 2) {
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
            if ([[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"video"] != nil) {
                [cell.videoThumpBtn setBackgroundImage:[self loadThumbNail:[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"video"]] forState:UIControlStateNormal];
                [cell.videoThumpBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
                
            }else if ([[CommonUtility sharedInstance].screenDataDictionary valueForKey:userIntroImageKey] != nil) {
                
                //NSLog(@"image str :- %@", [[CommonUtility sharedInstance].screenDataDictionary valueForKey:userIntroImageKey]);
                
                UIImage *image = [[CommonUtility sharedInstance] decodeBase64ToImage:[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:userIntroImageKey] stringByReplacingOccurrencesOfString:imageTypeMedia withString:@""]];
                [cell.videoThumpBtn setBackgroundImage:image forState:UIControlStateNormal];
                [cell.videoThumpBtn setImage:nil forState:UIControlStateNormal];
            }
            
        }
        
        return cell;
        
    }
}
*/


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        static NSString *MyIdentifier;
        MyIdentifier = @"typeofcarecell";
        AddMoreTypeOfCareTableViewCell *cell = (AddMoreTypeOfCareTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        if (cell == nil)
        {
            cell = [[AddMoreTypeOfCareTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                         reuseIdentifier:MyIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.mydelegate = self;
        
        //--- Set tag to text fields ---
        cell.txtRequired.tag = indexPath.row;
        cell.txtCaochRequired.tag = indexPath.row;
        cell.txtTutorRequired.tag = indexPath.row;
        
        //--- Set text on text fields ---
        if ([[arrTypeOfcare objectAtIndex:indexPath.row] valueForKey:@"typeofcare"] != nil) {
             cell.txtRequired.selectedItem = [[arrTypeOfcare objectAtIndex:indexPath.row] valueForKey:@"typeofcare"];
        }
        
        if ([[arrTypeOfcare objectAtIndex:indexPath.row] valueForKey:@"areaofskill"] != nil) {
            cell.txtCaochRequired.selectedItem = [[arrTypeOfcare objectAtIndex:indexPath.row] valueForKey:@"areaofskill"];
        }
        
        if ([[arrTypeOfcare objectAtIndex:indexPath.row] valueForKey:@"areaofstudy"] != nil) {
            cell.txtTutorRequired.selectedItem = [[arrTypeOfcare objectAtIndex:indexPath.row] valueForKey:@"areaofstudy"];
        }
        
        cell.lblAddmore.hidden = YES;
        cell.addMoreBtn.hidden = YES;
        cell.basicInfoVw.hidden = YES;
        
        if (indexPath.row == arrTypeOfcare.count -1){
            
            cell.lblAddmore.hidden = NO;
            cell.addMoreBtn.hidden = NO;
            cell.basicInfoVw.hidden = NO;
        }
        
        return cell;
        
    }else{
        
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
            
            if ([[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"name"] != nil) {
                [cell.txtName setText:[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"name"]];
            }
            
            if ([[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"required"] != nil) {
                cell.txtRequired.selectedItem = [[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"required"];
            }
            
            if ([[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"mail"] != nil) {
                [cell.txtEmail setText:[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"mail"]];
            }
            
            if ([[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"password"] != nil) {
                [cell.txtPassword setText:[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"password"]];
            }
            
            if ([[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"confirmpassword"] != nil) {
                [cell.txtConfirmPassword setText:[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"confirmpassword"]];
            }
            
            if ([[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"about"] != nil) {
                [cell.txtAbout setText:[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"about"]];
            }
        }
        
        return cell;
        
    }else if (indexPath.row == totalRowCount - 1){
        
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
        
        return cell;
        
    }else{
        static NSString *MyIdentifier;
        MyIdentifier = @"familymemebercell";
        
        Additionalfamilymemebercell *cell = (Additionalfamilymemebercell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier forIndexPath:indexPath];
        
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
            
            NSMutableArray *familyMemArray = [[CommonUtility sharedInstance].screenDataDictionary valueForKey:femilymember];
            
            //NSLog(@"cell.tag :- %ld", (long)cell.tag);
            
            if(cell.tag > 0 && cell.tag < totalRowCount - 1) {
                
                NSInteger index = cell.tag - 1;
                
                NSMutableDictionary *memberDict = [familyMemArray objectAtIndex:index];
                
                //--- Set family members ---
                if ([memberDict valueForKey:familyMemberNameKey] != nil) {
                    [cell.txtName setText:[memberDict valueForKey:familyMemberNameKey]];
                    
                }else if ([memberDict valueForKey:familyMemberAgeKey] != nil) {
                    [cell.txtAge setText:[memberDict valueForKey:familyMemberAgeKey]];
                    
                }else if ([memberDict valueForKey:familyMemberRequirementsKey] != nil) {
                    [cell.txtRequirements setText:[memberDict valueForKey:familyMemberRequirementsKey]];
                }
            }
 
            if (indexPath.row == totalRowCount - 2) {
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
            if ([[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"video"] != nil) {
                [cell.videoThumpBtn setBackgroundImage:[self loadThumbNail:[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"video"]] forState:UIControlStateNormal];
                [cell.videoThumpBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
                
            }else if ([[CommonUtility sharedInstance].screenDataDictionary valueForKey:userIntroImageKey] != nil) {
                
                //NSLog(@"image str :- %@", [[CommonUtility sharedInstance].screenDataDictionary valueForKey:userIntroImageKey]);
                
                UIImage *image = [[CommonUtility sharedInstance] decodeBase64ToImage:[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:userIntroImageKey] stringByReplacingOccurrencesOfString:imageTypeMedia withString:@""]];
                [cell.videoThumpBtn setBackgroundImage:image forState:UIControlStateNormal];
                [cell.videoThumpBtn setImage:nil forState:UIControlStateNormal];
            }
        }
        
        return cell;
        
    }
}
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
            
            if ([[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"name"] != nil) {
                [cell.txtName setText:[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"name"]];
            }else if ([[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"required"] != nil) {
                cell.txtRequired.selectedItem = [[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"required"];
            }else if ([[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"email"] != nil) {
                [cell.txtEmail setText:[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"email"]];
            }else if ([[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"password"] != nil) {
                [cell.txtPassword setText:[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"password"]];
            }else if ([[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"confirmpassword"] != nil) {
                [cell.txtConfirmPassword setText:[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"confirmpassword"]];
            }else if ([[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"about"] != nil) {
                [cell.txtAbout setText:[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"about"]];
            }
        }
        
        return cell;
    }else if (indexPath.row == totalRowCount - 1){
        
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
            
            NSMutableArray *familyMemArray = [[CommonUtility sharedInstance].screenDataDictionary valueForKey:femilymember];
            
            //--- Set family members ---
            if ([[familyMemArray objectAtIndex:cell.tag] valueForKey:familyMemberNameKey] != nil) {
                [cell.txtName setText:[[familyMemArray objectAtIndex:cell.tag] valueForKey:familyMemberNameKey]];
                
            }else if ([[familyMemArray objectAtIndex:cell.tag] valueForKey:familyMemberAgeKey] != nil) {
                [cell.txtAge setText:[[familyMemArray objectAtIndex:cell.tag] valueForKey:familyMemberAgeKey]];
                
            }else if ([[familyMemArray objectAtIndex:cell.tag] valueForKey:familyMemberRequirementsKey] != nil) {
                [cell.txtRequirements setText:[[familyMemArray objectAtIndex:cell.tag] valueForKey:familyMemberRequirementsKey]];
            }
            
            
//            if (familyMemArray && cell.tag < [familyMemArray count] && cell.tag < totalRowCount - 2) {
//                
//                //--- Set family members ---
//                if ([[familyMemArray objectAtIndex:cell.tag] valueForKey:familyMemberNameKey] != nil) {
//                    [cell.txtName setText:[[familyMemArray objectAtIndex:cell.tag] valueForKey:familyMemberNameKey]];
//                    
//                }else if ([[familyMemArray objectAtIndex:cell.tag] valueForKey:familyMemberAgeKey] != nil) {
//                    [cell.txtAge setText:[[familyMemArray objectAtIndex:cell.tag] valueForKey:familyMemberAgeKey]];
//                    
//                }else if ([[familyMemArray objectAtIndex:cell.tag] valueForKey:familyMemberRequirementsKey] != nil) {
//                    [cell.txtRequirements setText:[[familyMemArray objectAtIndex:cell.tag] valueForKey:familyMemberRequirementsKey]];
//                }
//
//                
////                //--- Set family members ---
////                if ([[CommonUtility sharedInstance].screenDataDictionary valueForKey:[NSString stringWithFormat:@"fMembername%ld", (long)cell.tag]] != nil) {
////                    [cell.txtName setText:[[CommonUtility sharedInstance].screenDataDictionary valueForKey:[NSString stringWithFormat:@"fMembername%ld", (long)cell.tag]]];
////                }else if ([[CommonUtility sharedInstance].screenDataDictionary valueForKey:[NSString stringWithFormat:@"fMemberage%ld", (long)cell.tag]] != nil) {
////                    [cell.txtAge setText:[[CommonUtility sharedInstance].screenDataDictionary valueForKey:[NSString stringWithFormat:@"fMemberage%ld", (long)cell.tag]]];
////                }else if ([[CommonUtility sharedInstance].screenDataDictionary valueForKey:[NSString stringWithFormat:@"fMemberrequirements%ld", (long)cell.tag]] != nil) {
////                    [cell.txtRequirements setText:[[CommonUtility sharedInstance].screenDataDictionary valueForKey:[NSString stringWithFormat:@"fMemberrequirements%ld", (long)cell.tag]]];
////                }
//            }
            
            
            //if (indexPath.row == femilyMemCout + 1) {
            if (indexPath.row == totalRowCount - 2) {
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
            
//            //--- Set introduction video ---
//            if ([[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"video"] != nil) {
//                [cell.videoThumpBtn setBackgroundImage:[self loadThumbNail:[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"video"]] forState:UIControlStateNormal];
//                [cell.videoThumpBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
//                
//            }else if ([[[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:userIntroImageKey] valueForKey:undefinekey] valueForKey:@"0"] valueForKey:valuekey] != nil) {
//                
//                NSLog(@"image str :- %@", [[[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:userIntroImageKey] valueForKey:undefinekey] valueForKey:@"0"] valueForKey:valuekey]);
//                
//                UIImage *image = [[CommonUtility sharedInstance] decodeBase64ToImage:[[[[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:userIntroImageKey] valueForKey:undefinekey] valueForKey:@"0"] valueForKey:valuekey] stringByReplacingOccurrencesOfString:imageTypeMedia withString:@""]];
//                [cell.videoThumpBtn setBackgroundImage:image forState:UIControlStateNormal];
//                [cell.videoThumpBtn setImage:nil forState:UIControlStateNormal];
//            }

            //--- Set introduction video ---
            if ([[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"video"] != nil) {
                [cell.videoThumpBtn setBackgroundImage:[self loadThumbNail:[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"video"]] forState:UIControlStateNormal];
                [cell.videoThumpBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
                
            }else if ([[CommonUtility sharedInstance].screenDataDictionary valueForKey:userIntroImageKey] != nil) {
                
                //NSLog(@"image str :- %@", [[CommonUtility sharedInstance].screenDataDictionary valueForKey:userIntroImageKey]);
                
                UIImage *image = [[CommonUtility sharedInstance] decodeBase64ToImage:[[[CommonUtility sharedInstance].screenDataDictionary valueForKey:userIntroImageKey] stringByReplacingOccurrencesOfString:imageTypeMedia withString:@""]];
                [cell.videoThumpBtn setBackgroundImage:image forState:UIControlStateNormal];
                [cell.videoThumpBtn setImage:nil forState:UIControlStateNormal];
            }
        
        }
    
        return cell;
        
    }
}
*/

#pragma mark custom cell delegates
- (void)get:(NSString *)text key:(NSString *)key{
    
//    //--- Add about text current screen data ---
//    if ([key isEqualToString:About]) {
//        NSDictionary *userAboutDict = @{undefinekey: @{@"0": @{valuekey: text}}};
//        [[CommonUtility sharedInstance].screenDataDictionary setValue:userAboutDict forKey:AboutKey];
//        return;
//    }
    
//    else if ([key isEqualToString:field_typeofcare]) {
//        //--- Add Type Of Care into current screen data ---
//        
//        NSMutableDictionary *userTypeOfCareDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSMutableDictionary dictionaryWithObjectsAndKeys:text, valuekey, nil], @"0", nil];
//        [[CommonUtility sharedInstance].screenDataDictionary setValue:userTypeOfCareDict forKey:field_typeofcare];
//        return;
//    }
    
    if ([key isEqualToString:@"confirmPass"]) {
        temp_confirmpass = text;
        return;
    }
    
//    if ([key isEqualToString:field_typeofcare]) {
//    
//        NSString *strTypeOfCare = [[CommonUtility sharedInstance].screenDataDictionary valueForKey:field_typeofcare];
//        [[CommonUtility sharedInstance].screenDataDictionary setValue:[NSString stringWithFormat:@"%@,%@", strTypeOfCare, text] forKey:field_typeofcare];
//        
//        NSLog(@"strTypeOfCare :- %@", [[CommonUtility sharedInstance].screenDataDictionary valueForKey:field_typeofcare]);
//    }
    
    //--- Current screen data ---
    [[CommonUtility sharedInstance] addScreenDataInfo:text key:key];
    
    NSLog(@"screenDataDictionary :- %@", [CommonUtility sharedInstance].screenDataDictionary);
}

- (void)getSubCategories:(NSString *)text key:(NSString *)key index:(NSInteger)index{
    
    if ([text isEqualToString:@"Type of care"] || [text isEqualToString:@"Area of skill"] || [text isEqualToString:@"Area of study"]) {
        return;
    }
    
    NSMutableDictionary *dataDict = [arrTypeOfcare objectAtIndex:index];
    [dataDict setValue:text forKeyPath:key];
    [arrTypeOfcare replaceObjectAtIndex:index withObject:dataDict];
    
}

- (void)get:(NSString *)key value:(NSString *)value parentkey:(NSString *)parentkey index:(NSString *)index{
//    
//    NSLog(@"screenDataDictionary :- %@", [CommonUtility sharedInstance].screenDataDictionary);
//    NSLog(@"key :- %@", key);
//    NSLog(@"value :- %@", value);
//    NSLog(@"index :- %@", index);
    
    //--- Add Family members text current screen data ---
    if ([parentkey isEqualToString:femilymember]) {
        
        if([[CommonUtility sharedInstance].screenDataDictionary valueForKey:femilymember]){
            
            NSMutableArray *familyArray = [[CommonUtility sharedInstance].screenDataDictionary valueForKey:femilymember];
            
            if ([index intValue] < [familyArray count]) {
                
                NSMutableDictionary *userFamilyMemDict = [familyArray objectAtIndex:[index intValue]];
                [userFamilyMemDict setValue:value forKey:key];
            }else{
                
                [familyArray insertObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:value, key, nil] atIndex:[index intValue]];
            }
        }else{
            
            [[CommonUtility sharedInstance].screenDataDictionary setObject:[[NSMutableArray alloc] initWithObjects:[NSMutableDictionary dictionaryWithObjectsAndKeys:value, key, nil], nil] forKey:femilymember];
        }
    }
    
    NSLog(@"screenDataDictionary :- %@", [CommonUtility sharedInstance].screenDataDictionary);
}

-(void)submitForm{
    
    //--- Set All Key Values Parameters and Call API ---
    [self setAllKeyValuesParameters];
}

//--- Set All Key Values Parameters ---
-(void)setAllKeyValuesParameters{
    
    NSLog(@"Job Provider screenDataDictionary :- %@", [CommonUtility sharedInstance].screenDataDictionary);
    
    if (![[CommonUtility sharedInstance] Emailvalidate:[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"mail"]]) {
        kCustomAlertWithParamAndTarget(@"Message", @"Email should be in valid format.", nil);
        return;
    }else if(![[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"pass"] isEqualToString:temp_confirmpass]){
        kCustomAlertWithParamAndTarget(@"Message", @"Password and Confirm Password should be same.", nil);
        return;
    }
    
    //--- Set User Name ---
    //NSDictionary *userNameDict = @{undefinekey: @{@"0": @{valuekey: [[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"name"]}}};
    [[CommonUtility sharedInstance].screenDataDictionary setValue:[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"name"] forKey:userNameKey];
    
    //--- Set User Role ---
    //NSDictionary *userRoleDic = @{undefinekey: @"provider"};
    
    [[CommonUtility sharedInstance].screenDataDictionary setValue:@"provider" forKey:userRole];
    [[CommonUtility sharedInstance].screenDataDictionary setValue:@"1" forKey:@"status"];
    //--- Set Confirm Email force fully ---
    [[CommonUtility sharedInstance].screenDataDictionary setValue:[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"mail"] forKey:@"conf_mail"];
    
    [[CommonUtility sharedInstance].screenDataDictionary setValue:@"" forKey:field_typeofcare];
    //--- New Field
    [[CommonUtility sharedInstance].screenDataDictionary setValue:[self setMultipleProfessionalSkills] forKey:field_level_of_study];
    
    
    //--- Add device token into request param ---
    NSString *deviceTokenStr;
    
    if ( [CommonUtility sharedInstance].deviceToken.length > 0) {
        deviceTokenStr = [CommonUtility sharedInstance].deviceToken;
    }else{
        
        deviceTokenStr = @"";
    }
    
    [[CommonUtility sharedInstance].screenDataDictionary setValue:deviceTokenStr forKey:@"device_token"];
    [[CommonUtility sharedInstance].screenDataDictionary setValue:@"ios" forKey:@"device_type"];
    
    NSLog(@"Job Provider screenDataDictionary :- %@", [CommonUtility sharedInstance].screenDataDictionary);
    NSLog(@"Job Provider arrTypeOfcare :- %@", arrTypeOfcare);
    
    
    //--- Register Provider ---
    [self signupAPI:[CommonUtility sharedInstance].screenDataDictionary];
}

- (NSString *)setMultipleProfessionalSkills{
    
    NSString *multipleProfessionalSkills;
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    for(NSDictionary *dict in arrTypeOfcare) {
        
        NSArray *keysArr = [dict allKeys];
        for (NSString *key in keysArr) {
            
            if (![[dict valueForKey:key] isEqualToString:@"Type of care"] && ![[dict valueForKey:key] isEqualToString:@"Area of skill"] && ![[dict valueForKey:key] isEqualToString:@"Area of study"]) {
                 [tempArray addObject:[dict valueForKey:key]];
            }
        }
    }
    
    multipleProfessionalSkills = [tempArray componentsJoinedByString:@","];
    
    return multipleProfessionalSkills;

}

#pragma mark API Call
-(void)signupAPI:(NSDictionary*)parameters {
    
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable){
        kCustomAlertWithParamAndTarget(@"Message", @"Internet connection not available.", nil);
        return;
    }
    
    [kAppDelegete showHUDVIEW:self.view];
    
    [[IQWebService service] signup:parameters completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //---- Hide HUD View ---
        [kAppDelegete removeHUDVIEW];
        
        NSUInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
        
        if (error == nil && statusCode == 406){
            
            NSError *error = nil;
            NSDictionary * jsonObject = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSLog(@"jsonObject :- %@", jsonObject);
            
            NSDictionary *errorMessageDict = [jsonObject valueForKey:@"form_errors"];
            NSArray *keysArr = [errorMessageDict allKeys];
            NSMutableString *errorMessareStr = [[NSMutableString alloc] init];
            for (NSString *key in keysArr) {
                [errorMessareStr appendFormat:@"%@\n", [errorMessageDict valueForKey:key]];
            }
            
            kCustomAlertWithParamAndTarget(@"Message", errorMessareStr, nil);
            return ;
        }
        
        if (!error && statusCode == 200) {
            
            //--- Get login token ---Json error :- (null)
            NSError *error = nil;
            NSDictionary * jsonObject = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSLog(@"jsonObject :- %@", jsonObject);
            
            //--- Store user info ---
            [[CommonUtility sharedInstance] initializeUser:jsonObject];
            
            //--- Clear current screen data ---
            [[CommonUtility sharedInstance].screenDataDictionary removeAllObjects];
       
            temp_confirmpass = @"";

            //--- Store User Token ---
            [[NSUserDefaults standardUserDefaults] setValue:[[CommonUtility sharedInstance].userDictionary valueForKey:@"token"] forKey:XCSRFToken];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            //--- Navigate to home screen ---
            ETMenuViewController *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"UNEYEMenuViewController"];
            [self.navigationController pushViewController:controller animated:YES];
            
        } else {
            
            kCustomAlertWithParamAndTarget(@"Message", error.localizedDescription, nil);
        }
    }];
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
            
            //NSDictionary *userVideoDict = @{undefinekey: @{@"0": @{valuekey: [NSString stringWithFormat:@"%@%@", vedioTypeMedia, base64Encoded]}}};
            
            //--- Current screen data ---
            //[[CommonUtility sharedInstance].screenDataDictionary setValue:userVideoDict forKey:userIntroImageKey];
            
            //--- Current screen data ---
            [[CommonUtility sharedInstance].screenDataDictionary setValue:[NSString stringWithFormat:@"%@%@", vedioTypeMedia, base64Encoded] forKey:userIntroImageKey];
            
            
            //--- Current screen data ---
            [[CommonUtility sharedInstance] addScreenDataInfo:[urlvideo absoluteString] key:@"video"];
            [_providerInfoTableView reloadData];
        }];
    }else{
        
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        
        [picker dismissViewControllerAnimated:YES completion:^{
            
            if (isProfileFlag) {
                
                UIImage *image = [chosenImage resizedImageWithContentMode:UIViewContentModeScaleAspectFit bounds:CGSizeMake(500.0, 500.0) interpolationQuality:kCGInterpolationMedium];
                
                //NSDictionary *userImageDict = @{undefinekey: @{@"0": @{valuekey: [[CommonUtility sharedInstance] encodeToBase64String:image]}}};
                
                //--- Current screen data ---
                //[[CommonUtility sharedInstance].screenDataDictionary setValue:userImageDict forKey:userProfileImageKey];
                
                //--- Current screen data ---                
                [[CommonUtility sharedInstance].screenDataDictionary setValue:[NSString stringWithFormat:@"%@%@", imageTypeMedia, [[CommonUtility sharedInstance] encodeToBase64String:image]] forKey:userProfileImageKey];
                
                [_profileImageViewBtn setBackgroundImage:chosenImage forState:UIControlStateNormal];
            }else{
                
                UIImage *image = [chosenImage resizedImageWithContentMode:UIViewContentModeScaleAspectFit bounds:CGSizeMake(500.0, 500.0) interpolationQuality:kCGInterpolationMedium];
                //NSDictionary *userImageDict = @{undefinekey: @{@"0": @{valuekey: [NSString stringWithFormat:@"%@%@", imageTypeMedia, [[CommonUtility sharedInstance] encodeToBase64String:image]]}}};
                
                //--- Current screen data ---
                //[[CommonUtility sharedInstance].screenDataDictionary setValue:userImageDict forKey:userIntroImageKey];
                
                //--- Current screen data ---
                [[CommonUtility sharedInstance].screenDataDictionary setValue:[NSString stringWithFormat:@"%@%@", imageTypeMedia, [[CommonUtility sharedInstance] encodeToBase64String:image]] forKey:userIntroImageKey];
                
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
