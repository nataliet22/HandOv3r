//
//  JobSeekerViewController.m
//  UNEYE
//
//  Created by AppTech_Mac1 on 4/6/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import "JobSeekerViewController.h"
#import "popviewController.h"
#import "AddMoreTypeOfCareTableViewCell.h"
#import "AddMoreProfessionalInfoTableViewCell.h"

@interface JobSeekerViewController ()<EducationsCustomCellDelegate, AddMoreProfessionalInfoTableViewCellDelegate>{

    BOOL isProfileFlag;
    NSString *selectedQualifications;
    //--- Temp hold confirm pass
    NSString *temp_confirmpass;
    //--- Temp hold selected dates
    NSMutableArray *tempSelectedDateArr;
    
    NSMutableArray *arrProfessionalInfo;
}

@property (weak, nonatomic) IBOutlet UIView *profileImage_View;
@property (weak, nonatomic) IBOutlet AsyncImageView *profileImageViewBtn;
@property (weak, nonatomic) IBOutlet UITableView *jobSeekerInfoTableView;

@end

@implementation JobSeekerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //--- Multiple Professional Info ---
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Type of care", @"typeofcare",
                                     @"Type of care Rate", @"typeofcarerate",
                                     @"Area of skill", @"areaofskill",
                                     @"Area of skill Rate", @"areaofskillrate",
                                     @"Area of study", @"areaofstudy",
                                     @"Area of study Rate", @"areaofstudyrate",
                                     nil];
    arrProfessionalInfo = [[NSMutableArray alloc] initWithObjects:dataDict, nil];
    
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
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)signUpForm{
    
    NSLog(@"Seeker arrProfessionalInfo :- %@", arrProfessionalInfo);
    
    if (![[CommonUtility sharedInstance] Emailvalidate:[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"mail"]]) {
        kCustomAlertWithParamAndTarget(@"Message", @"Email should be in valid format.", nil);
        return;
    }else if(![[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"pass"] isEqualToString:temp_confirmpass]){
        kCustomAlertWithParamAndTarget(@"Message", @"Password and Confirm Password should be same.", nil);
        return;
    }
    
    //--- Set User Role ---
    [[CommonUtility sharedInstance] addScreenDataInfo:@"seeker" key:userRole];
    [[CommonUtility sharedInstance] addScreenDataInfo:@"1" key:@"status"];
    
    [[CommonUtility sharedInstance].screenDataDictionary setValue:[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"name"] forKey:userNameKey];
    
    //--- Set Confirm Email force fully ---
    [[CommonUtility sharedInstance].screenDataDictionary setValue:[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"mail"] forKey:@"conf_mail"];
    
    //--- set avaialble dates as string into dict ----
    [[CommonUtility sharedInstance].screenDataDictionary setValue:[self getCommaSeparateString] forKey:seekerAvailableDates];
    
    //--- Remove support key item ---
    [[CommonUtility sharedInstance].screenDataDictionary removeObjectForKey:qualifications];
    
    [[CommonUtility sharedInstance].screenDataDictionary setValue:@"" forKey:subCategoriesKey];
    
//    //---- New Field
//    [[CommonUtility sharedInstance].screenDataDictionary setValue:[self setMultipleProfessionalSkills] forKey:field_level_of_study];
//    
//    [[CommonUtility sharedInstance].screenDataDictionary setValue:[self setMultipleProfessionalSkillsRate] forKey:@"field_rate"];
    
     //---- New Field Multiple field with rates ---
    [[CommonUtility sharedInstance].screenDataDictionary setValue:[self setMultipleProfessionalSkillsInNewFormat] forKey:@"field_sub_typeofcares"];
    
    //--- Add device token into request param ---
    NSString *deviceTokenStr;
    
    if ( [CommonUtility sharedInstance].deviceToken.length > 0) {
        deviceTokenStr = [CommonUtility sharedInstance].deviceToken;
    }else{
    
        deviceTokenStr = @"";
    }
    
    [[CommonUtility sharedInstance].screenDataDictionary setValue:deviceTokenStr forKey:@"device_token"];
    [[CommonUtility sharedInstance].screenDataDictionary setValue:@"ios" forKey:@"device_type"];
    
    NSLog(@"Seeker screenDataDictionary :- %@", [CommonUtility sharedInstance].screenDataDictionary);
    
    //--- Register Seeker ---
    [self signupAPI:[CommonUtility sharedInstance].screenDataDictionary];
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

- (NSString *)setMultipleProfessionalSkills{
    
    NSString *multipleProfessionalSkills;
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    for(NSDictionary *dict in arrProfessionalInfo) {
        
        NSArray *keysArr = [dict allKeys];
        for (NSString *key in keysArr) {
            
            /* NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Type of care", @"typeofcare",
             @"Type of care Rate", @"typeofcarerate",
             @"Area of skill", @"areaofskill",
             @"Area of skill Rate", @"areaofskillrate",
             @"Area of study", @"areaofstudy",
             @"Area of study Rate", @"areaofstudyrate",
             nil];
             */

            if ([key isEqualToString:@"typeofcarerate"] || [key isEqualToString:@"areaofskillrate"] || [key isEqualToString:@"areaofstudyrate"]) {
                continue;
            }else{
            
            if (![[dict valueForKey:key] isEqualToString:@"Type of care"] && ![[dict valueForKey:key] isEqualToString:@"Area of skill"] && ![[dict valueForKey:key] isEqualToString:@"Area of study"]) {
                [tempArray addObject:[dict valueForKey:key]];
            }
         }
        }
    }
    
    multipleProfessionalSkills = [tempArray componentsJoinedByString:@","];
    
    return multipleProfessionalSkills;
}

- (NSString *)setMultipleProfessionalSkillsRate{
    
    NSString *multipleProfessionalSkillsRate;
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    for(NSDictionary *dict in arrProfessionalInfo) {
        
        NSArray *keysArr = [dict allKeys];
        for (NSString *key in keysArr) {
                if (![[dict valueForKey:key] isEqualToString:@"Type of care"] && ![[dict valueForKey:key] isEqualToString:@"Area of skill"] && ![[dict valueForKey:key] isEqualToString:@"Area of study"]) {
                    
                    if ([key isEqualToString:@"typeofcarerate"] || [key isEqualToString:@"areaofskillrate"] || [key isEqualToString:@"areaofstudyrate"]) {
                        
                        [tempArray addObject:[dict valueForKey:key]];
                    }
            }
        }
    }
    
    multipleProfessionalSkillsRate = [tempArray componentsJoinedByString:@","];
    
    return multipleProfessionalSkillsRate;
    
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
    
    [self.jobSeekerInfoTableView reloadData];
    [self.jobSeekerInfoTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
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
        return 592;
    }else if (indexPath.section == 1){
        
        if (indexPath.row == arrProfessionalInfo.count -1){
            return 348;
        }else{
            return 310;
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
        
        if ([[[CommonUtility sharedInstance].screenDataDictionary valueForKey:qualifications] length] > 0) {
            cell.txtQualification.text = [[CommonUtility sharedInstance].screenDataDictionary valueForKey:qualifications];
        }else{
        
            cell.txtQualification.text = @"";
        }
        
        cell.subCategories.enabled = YES;
        cell.subCategories.delegate  = self;
        
        if ([[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"mail"] length] > 0) {
            cell.txtEmail.text = [[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"mail"];
        }

        if ([[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"name"] length] > 0) {
            cell.txtName.text = [[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"name"];
        }
        
        /*
        if ([[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"field_typeofcare"] isEqualToString:@"Babysitting"]){
            
            [[CommonUtility sharedInstance] addScreenDataInfo:@"Babysitter" key:subCategoriesKey];
            [cell.subCategories setSelectedItem:@"Babysitter"];
            
        }else if ([[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"field_typeofcare"] isEqualToString:@"Coaching"]){
            
            [[CommonUtility sharedInstance] addScreenDataInfo:@"Netball" key:subCategoriesKey];
            [cell.subCategories setSelectedItem:@"Netball"];
        }else if ([[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"field_typeofcare"] isEqualToString:@"Tutoring"]){
            [[CommonUtility sharedInstance] addScreenDataInfo:@"Primary" key:subCategoriesKey];
            [cell.subCategories setSelectedItem:@"Primary"];
        }
        else if ([[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"field_typeofcare"] isEqualToString:gender]){
            [[CommonUtility sharedInstance] addScreenDataInfo:@"Female" key:gender];
        }
        */
        
        if ([[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"field_typeofcare"] isEqualToString:@"Babysitting"] && [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:subCategoriesKey] length] == 0){
            
            [[CommonUtility sharedInstance] addScreenDataInfo:@"Babysitter" key:subCategoriesKey];
            [cell.subCategories setSelectedItem:@"Babysitter"];
            
        }else if ([[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"field_typeofcare"] isEqualToString:@"Coaching"] && [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:subCategoriesKey] length] == 0){
            
            [[CommonUtility sharedInstance] addScreenDataInfo:@"Netball" key:subCategoriesKey];
            [cell.subCategories setSelectedItem:@"Netball"];
            
        }else if ([[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"field_typeofcare"] isEqualToString:@"Tutoring"] && [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:subCategoriesKey] length] == 0){
            
            [[CommonUtility sharedInstance] addScreenDataInfo:@"Primary" key:subCategoriesKey];
            [cell.subCategories setSelectedItem:@"Primary"];
        }
        else if ([[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"field_typeofcare"] isEqualToString:gender] && [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:gender] length] == 0){
            [[CommonUtility sharedInstance] addScreenDataInfo:@"Female" key:gender];
        }

        
        return cell;
     }else if (indexPath.section == 1){
     
         static NSString *MyIdentifier;
         MyIdentifier = @"professionalInfocell";
         AddMoreProfessionalInfoTableViewCell *cell = (AddMoreProfessionalInfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
         
         if (cell == nil)
         {
             cell = [[AddMoreProfessionalInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:MyIdentifier];
         }
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
         cell.mydelegate = self;
         
         //--- Set tag to text fields ---
         cell.txtTypeOfCare.tag = indexPath.row;
         cell.txtAreaOfSkill.tag = indexPath.row;
         cell.txtStudyLevel.tag = indexPath.row;
         
         //--- Set text on text fields ---
         if ([[arrProfessionalInfo objectAtIndex:indexPath.row] valueForKey:@"typeofcare"] != nil) {
             cell.txtTypeOfCare.selectedItem = [[arrProfessionalInfo objectAtIndex:indexPath.row] valueForKey:@"typeofcare"];
         }
         
         if ([[arrProfessionalInfo objectAtIndex:indexPath.row] valueForKey:@"areaofskill"] != nil) {
             cell.txtAreaOfSkill.selectedItem = [[arrProfessionalInfo objectAtIndex:indexPath.row] valueForKey:@"areaofskill"];
         }
         
         if ([[arrProfessionalInfo objectAtIndex:indexPath.row] valueForKey:@"areaofstudy"] != nil) {
             cell.txtStudyLevel.selectedItem = [[arrProfessionalInfo objectAtIndex:indexPath.row] valueForKey:@"areaofstudy"];
         }

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
        
        if ([[CommonUtility sharedInstance] screenDataDictionary] != nil) {
            
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
        
        return cell;
    }
}

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
 if (indexPath.row == 0){
 
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
 
 if ([[[CommonUtility sharedInstance].screenDataDictionary valueForKey:qualifications] length] > 0) {
 cell.txtQualification.text = [[CommonUtility sharedInstance].screenDataDictionary valueForKey:qualifications];
 }else{
 
 cell.txtQualification.text = @"";
 }
 
 cell.subCategories.enabled = YES;
 //cell.subCategories.delegate  = self;
 
 if ([[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"mail"] length] > 0) {
 cell.txtEmail.text = [[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"mail"];
 }
 
 if ([[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"name"] length] > 0) {
 cell.txtName.text = [[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"name"];
 }
 
 //        if ([[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"field_typeofcare"] isEqualToString:@"Babysitting"]){
 //
 //            [[CommonUtility sharedInstance] addScreenDataInfo:@"Babysitter" key:subCategoriesKey];
 //            [cell.subCategories setSelectedItem:@"Babysitter"];
 //
 //        }else if ([[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"field_typeofcare"] isEqualToString:@"Coaching"]){
 //
 //            [[CommonUtility sharedInstance] addScreenDataInfo:@"Netball" key:subCategoriesKey];
 //            [cell.subCategories setSelectedItem:@"Netball"];
 //        }else if ([[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"field_typeofcare"] isEqualToString:@"Tutoring"]){
 //            [[CommonUtility sharedInstance] addScreenDataInfo:@"Primary" key:subCategoriesKey];
 //            [cell.subCategories setSelectedItem:@"Primary"];
 //        }
 //        else if ([[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"field_typeofcare"] isEqualToString:gender]){
 //            [[CommonUtility sharedInstance] addScreenDataInfo:@"Female" key:gender];
 //        }


if ([[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"field_typeofcare"] isEqualToString:@"Babysitting"] && [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:subCategoriesKey] length] == 0){
    
    [[CommonUtility sharedInstance] addScreenDataInfo:@"Babysitter" key:subCategoriesKey];
    [cell.subCategories setSelectedItem:@"Babysitter"];
    
}else if ([[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"field_typeofcare"] isEqualToString:@"Coaching"] && [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:subCategoriesKey] length] == 0){
    
    [[CommonUtility sharedInstance] addScreenDataInfo:@"Netball" key:subCategoriesKey];
    [cell.subCategories setSelectedItem:@"Netball"];
    
}else if ([[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"field_typeofcare"] isEqualToString:@"Tutoring"] && [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:subCategoriesKey] length] == 0){
    
    [[CommonUtility sharedInstance] addScreenDataInfo:@"Primary" key:subCategoriesKey];
    [cell.subCategories setSelectedItem:@"Primary"];
}
else if ([[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"field_typeofcare"] isEqualToString:gender] && [[[CommonUtility sharedInstance].screenDataDictionary valueForKey:gender] length] == 0){
    [[CommonUtility sharedInstance] addScreenDataInfo:@"Female" key:gender];
}


return cell;
}
else if (indexPath.row == 1)
{
    
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
    
    if ([[CommonUtility sharedInstance] screenDataDictionary] != nil) {
        
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
    
    return cell;
}
}
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}

- (IBAction)backBtnClick:(id)sender
{
    //--- Clear current screen data ---
    [[CommonUtility sharedInstance].screenDataDictionary removeAllObjects];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark custom cell delegates
- (void)get:(NSString *)text key:(NSString *)key{
    
    if ([key isEqualToString:gender])
    {
        if ([text isEqualToString:@"(null)"])
        {
            text = @"Female";

        }
    }
    if ([key isEqualToString:@"qualification"]) {
        [self openPOPUPView];
        return;
    }
    
    if ([key isEqualToString:@"confirmPass"]) {
        temp_confirmpass = text;
        return;
    }
    
    //--- Current screen data ---
    [[CommonUtility sharedInstance] addScreenDataInfo:text key:key];
    
    NSLog(@"screenDataDictionary :- %@", [CommonUtility sharedInstance].screenDataDictionary);
}

- (void)getSubCategories:(NSString *)text key:(NSString *)key index:(NSInteger)index{
    
    if ([text isEqualToString:@"Type of care"] || [text isEqualToString:@"Area of skill"] || [text isEqualToString:@"Area of study"]) {
        return;
    }
    
    NSMutableDictionary *dataDict = [arrProfessionalInfo objectAtIndex:index];
    [dataDict setValue:text forKeyPath:key];
    [arrProfessionalInfo replaceObjectAtIndex:index withObject:dataDict];
    
}

-(void)textField:(nonnull IQDropDownTextField*)textField didSelectItem:(nullable NSString*)item
{
    // This texField will update subCategory data in "field_sub_typeofcare"
    
    //[[CommonUtility sharedInstance].screenDataDictionary setValue:item forKey:subCategoriesKey];

}
- (void)selectedDates:(NSMutableArray *)dateArray key:(NSString *)key{

    //--- Current screen data ---
    
    NSMutableArray *tempArray = [NSMutableArray new];
    
    for (NSDate *date in dateArray) {
        [tempArray addObject:[[self dateFormatter] stringFromDate:date]];
    }
    tempSelectedDateArr = [tempArray mutableCopy];
    [[RSDatePickerController sharedInstance] showTimePickerWithDate:[dateArray lastObject] dateFormat:nil fromView:self.view inViewController:self];

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

#pragma mark open POPUPView
-(void)openPOPUPView{
    
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

    NSMutableArray *arrayItems = [[NSMutableArray alloc] init];
    
    for (NSString *key in [items allKeys]) {
        [arrayItems addObjectsFromArray:[items valueForKey:key]];
    }
    selectedQualifications = [arrayItems componentsJoinedByString:@", "];
   

    [self setQualificationKeysWise:items];
    
    [[CommonUtility sharedInstance] addScreenDataInfo:selectedQualifications key:qualifications];
    
    [[CommonUtility sharedInstance] setSeekerQualificationIndexes:nil qualificationDict:items];
    
    [_jobSeekerInfoTableView reloadData];

}

//--- Set education values by keys ---
- (void)setQualificationKeysWise:(NSMutableDictionary *)courses{
    
    for (NSString *key in [courses allKeys]) {
        
        if ([key isEqualToString:keyPlistfieldPrimaryEducation]) {
            
            NSString *strPrimaryEducation = [[courses valueForKey:key] componentsJoinedByString:@", "];
            [[CommonUtility sharedInstance].screenDataDictionary setValue:strPrimaryEducation forKey:keyfieldPrimaryEducation];
            
        }else if ([key isEqualToString:keyPlistfieldLanguage]) {
            
            NSString *strLanguage = [[courses valueForKey:key] componentsJoinedByString:@", "];
            [[CommonUtility sharedInstance].screenDataDictionary setValue:strLanguage forKey:keyfieldLanguage];
            
        }else if ([key isEqualToString:keyPlistfieldSecondaryEducation]) {
            
            NSString *strSecondaryEducation = [[courses valueForKey:key] componentsJoinedByString:@", "];
            [[CommonUtility sharedInstance].screenDataDictionary setValue:strSecondaryEducation forKey:keyfieldSecondaryEducation];
            
        }else if ([key isEqualToString:keyPlistfieldCommunityFamilyStudies]) {
            
            NSString *strCommunityFamilyStudies = [[courses valueForKey:key] componentsJoinedByString:@", "];
            [[CommonUtility sharedInstance].screenDataDictionary setValue:[NSString stringWithFormat:@"%@", strCommunityFamilyStudies] forKey:keyfieldCommunityStudies];
            
        }else if ([key isEqualToString:keyPlistfieldTechnicalCourses]) {
            
            NSString *strTechnicalCourses = [[courses valueForKey:key] componentsJoinedByString:@", "];
            [[CommonUtility sharedInstance].screenDataDictionary setValue:[NSString stringWithFormat:@"%@", strTechnicalCourses] forKey:keyfieldTechnicalCourse];
            
        }else if ([key isEqualToString:keyPlistfieldTertiaryEducation]) {
            
            NSString *strTertiaryEducation = [[courses valueForKey:key] componentsJoinedByString:@", "];
            [[CommonUtility sharedInstance].screenDataDictionary setValue:strTertiaryEducation forKey:keyfieldTertiaryEducation];
        }
    }
    
    NSLog(@"setQualificationKeysWise screenDataDictionary :- %@", [CommonUtility sharedInstance].screenDataDictionary);
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
            
            //--- Current screen data ---
            [[CommonUtility sharedInstance].screenDataDictionary setValue:[NSString stringWithFormat:@"%@%@", vedioTypeMedia, base64Encoded] forKey:userIntroImageKey];
            
            //--- Current screen data ---
            [[CommonUtility sharedInstance] addScreenDataInfo:[urlvideo absoluteString] key:@"video"];
            [_jobSeekerInfoTableView reloadData];
        }];
    }else{
        
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        
        [picker dismissViewControllerAnimated:YES completion:^{
            
            if (isProfileFlag) {
                
                UIImage *image = [chosenImage resizedImageWithContentMode:UIViewContentModeScaleAspectFit bounds:CGSizeMake(500.0, 500.0) interpolationQuality:kCGInterpolationMedium];
                
                //--- Current screen data ---
                [[CommonUtility sharedInstance].screenDataDictionary setValue:[NSString stringWithFormat:@"%@%@", imageTypeMedia, [[CommonUtility sharedInstance] encodeToBase64String:image]] forKey:userProfileImageKey];
                
                [_profileImageViewBtn setBackgroundImage:chosenImage forState:UIControlStateNormal];
            }else{
                
                UIImage *image = [chosenImage resizedImageWithContentMode:UIViewContentModeScaleAspectFit bounds:CGSizeMake(500.0, 500.0) interpolationQuality:kCGInterpolationMedium];
                
                //--- Current screen data ---
                [[CommonUtility sharedInstance].screenDataDictionary setValue:[NSString stringWithFormat:@"%@%@", imageTypeMedia, [[CommonUtility sharedInstance] encodeToBase64String:image]] forKey:userIntroImageKey];
                
            }
            [_jobSeekerInfoTableView reloadData];
            
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
            [tempSelectedDateArr removeAllObjects];
            
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

@end
