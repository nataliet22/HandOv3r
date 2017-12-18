//
//  ChosenProfileViewController.m
//  UNEYE
//
//  Created by AppTech_Mac1 on 4/15/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import "ChosenProfileViewController.h"
#import "ChosenProfileCell.h"
#import "ConfirmDetailViewController.h"
#import "ProfessionalskillsDisplayCell.h"
#import "RefernceProfileDisplayCell.h"

@interface ChosenProfileViewController ()<ProfessionalskillsDisplayCellDelegate>{
    
    NSInteger professionalSkillCounts;
    
    NSMutableDictionary *selectedSkills;
    NSMutableArray *allProfessionalSkills;
    
}
@property (weak, nonatomic) IBOutlet UITableView *choosenProfileTableView;

@end

@implementation ChosenProfileViewController

@synthesize searchType;
@synthesize imageView;
@synthesize selectedUserDict, isSavedProfile;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imageView.layer.cornerRadius = 60;
    [self.imageView setClipsToBounds:YES];
    
    // Do any additional setup after loading the view.
    
    selectedSkills = [[NSMutableDictionary alloc] init];
    allProfessionalSkills = [[NSMutableArray alloc] init];
    
    professionalSkillCounts = [selectedUserDict[@"field_sub_typeofcares"] count];
    
    //allProfessionalSkills = selectedUserDict[@"field_sub_typeofcares"];
    
    if (allProfessionalSkills.count > 0) {
        [allProfessionalSkills removeAllObjects];
    }
    
    NSMutableArray *tempAllProfessionalSkills = selectedUserDict[@"field_sub_typeofcares"];
    
    for(NSDictionary *dict in tempAllProfessionalSkills){
        
        [allProfessionalSkills addObject:[self createMutableDict:dict]];
    }
    
}
-(void)getFullDetailsOfUserWithId :(NSString *)userID
{
    
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable){
        kCustomAlertWithParamAndTarget(@"Message", @"Internet connection not available.", nil);
        return;
    }
    
    [kAppDelegete showHUDVIEW:self.view];
    
    [[IQWebService service] getFullDetailsOfThisUserById:userID  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //---- Hide HUD View ---
        [kAppDelegete removeHUDVIEW];
        
        NSUInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
        if (!error && statusCode == 200) {
            
            //--- Get login token ---Json error :- (null)
            NSError *error = nil;
            NSDictionary * jsonObject = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSLog(@"jsonObject :- %@", jsonObject);
            
            selectedUserDict = [NSMutableDictionary dictionaryWithDictionary:jsonObject];
            
            [self.choosenProfileTableView reloadData];
            //--- Clear current screen data ---
            //[[CommonUtility sharedInstance].screenDataDictionary removeAllObjects];
            
            
        } else {
            
            kCustomAlertWithParamAndTarget(@"Message", error.localizedDescription, nil);
            
            NSError *error = nil;
            NSDictionary * jsonObject = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSLog(@"jsonObject :- %@", jsonObject);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (selectedUserDict[@"Picture"] != nil || ![selectedUserDict[@"Picture"] isEqualToString:@""])
    {
        [self.imageView loadImage:selectedUserDict[@"Picture"]];
    }
    else if ([searchType isEqualToString:@"tutor"])
    {
        [self.imageView setImage:[UIImage imageNamed:@"tutor_option"] forState:UIControlStateNormal];
    }
    else if ([searchType isEqualToString:@"coach"])
    {
        [self.imageView setImage:[UIImage imageNamed:@"coach_option"] forState:UIControlStateNormal];
    }
    
    NSLog(@"ChosenProfileViewController selectedUserDict :- %@", selectedUserDict);
    
}

- (NSMutableDictionary *)createMutableDict:(NSDictionary *)dict{
    
    NSMutableDictionary *mutableDict = [NSMutableDictionary new];
    
    for (NSString *key in dict.allKeys) {
        [mutableDict setValue:[dict valueForKey:key] forKey:key];
    }
    
    return mutableDict;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"ChosenProfileViewController"])
    {
        ConfirmDetailViewController *ConfirmDetailVC = (ConfirmDetailViewController *)segue.destinationViewController;
        ConfirmDetailVC.searchType = searchType;
        ConfirmDetailVC.selectedUserDict = selectedUserDict;
        
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
}


#pragma mark tableview delegates
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0){
        return 184;
    }else if (indexPath.row == (professionalSkillCounts + 2) - 1){
        return 339;
    }else{
        return 83;
    }
    
    return 523;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return professionalSkillCounts + 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *MyIdentifier;
    MyIdentifier = @"professionalskills";
    ProfessionalskillsDisplayCell *cell = (ProfessionalskillsDisplayCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (indexPath.row == 0){
        
        static NSString *MyIdentifier;
        MyIdentifier = @"chosenProfileCell";
        ChosenProfileCell *cell = (ChosenProfileCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        if (cell == nil)
        {
            cell = [[ChosenProfileCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:MyIdentifier];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.nameLabel.text = [selectedUserDict valueForKey:@"Name"];
        cell.ageLabel.text = [selectedUserDict valueForKey:@"Age"];
        cell.aboutMeLabel.text = [selectedUserDict valueForKey:@"aboutme"];
        cell.experienceLabel.text = [selectedUserDict valueForKey:@"experience"] ;
        cell.rateLabel.text = [NSString stringWithFormat:@"$ %@",[selectedUserDict valueForKey:@"rate"]];
        
        //          cell.nameLabel.text = [selectedUserDict valueForKey:@"name"];
        //    cell.ageLabel.text = [[[[selectedUserDict valueForKey:@"field_age"]valueForKey:@"und"]firstObject]valueForKey:@"value"];
        //    cell.aboutMeLabel.text = [[[[selectedUserDict valueForKey:@"field_about"]valueForKey:@"und"]firstObject]valueForKey:@"value"];
        //    cell.experienceLabel.text = [[[[selectedUserDict valueForKey:@"field_experience"]valueForKey:@"und"]firstObject]valueForKey:@"value"] ;
        //    cell.rateLabel.text = [NSString stringWithFormat:@"$ %@",[[[[selectedUserDict valueForKey:@"field_rate"]valueForKey:@"und"]firstObject]valueForKey:@"value"]];
        //
        
        if ([selectedUserDict valueForKey:userIntroImageKey] != nil && [[selectedUserDict valueForKey:userIntroImageKey]count] !=0 ) {
            [cell.videoPreviewButton setBackgroundImage:[self loadThumbNail:[selectedUserDict valueForKey:userIntroImageKey]] forState:UIControlStateNormal];
            [cell.videoPreviewButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
            
        }else if ([selectedUserDict valueForKey:userProfileImageKey] != nil) {
            
            //NSLog(@"image str :- %@", [[CommonUtility sharedInstance].screenDataDictionary valueForKey:userIntroImageKey]);
            
            UIImage *image = [[CommonUtility sharedInstance] decodeBase64ToImage:[[selectedUserDict valueForKey:userProfileImageKey] stringByReplacingOccurrencesOfString:imageTypeMedia withString:@""]];
            [cell.videoPreviewButton setBackgroundImage:image forState:UIControlStateNormal];
            [cell.videoPreviewButton setImage:nil forState:UIControlStateNormal];
        }
        
        
         return cell;
        
    }else if (indexPath.row == (professionalSkillCounts + 2) - 1){
        
        static NSString *MyIdentifier;
        MyIdentifier = @"refernceProfileCell";
        RefernceProfileDisplayCell *cell = (RefernceProfileDisplayCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        if (cell == nil)
        {
            cell = [[RefernceProfileDisplayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (isSavedProfile) {
            [cell.requestButton setTitle:@"Save" forState:UIControlStateNormal];
        }
        
        [cell.requestButton addTarget:self action:@selector(requestOrSaveBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

        
        return cell;
    }else{
        
        if (cell == nil)
        {
            cell = [[ProfessionalskillsDisplayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.areaOFSkillCheckBoxBtn.tag = indexPath.row;
        cell.mydelegate = self;
        
        if ((indexPath.row < (professionalSkillCounts + 2))) {
            
            NSDictionary *professinalSkillItem = [allProfessionalSkills objectAtIndex:indexPath.row - 1];
            
            if (professinalSkillItem.count > 0) {
                
                if ([[professinalSkillItem valueForKey:@"title"] length] > 0) {
                    cell.areaOFSkillLbl.text = [professinalSkillItem valueForKey:@"title"];
                }
                
                if ([[professinalSkillItem valueForKey:@"rate"] length] > 0) {
                    cell.areaOFSkillRateLbl.text = [professinalSkillItem valueForKey:@"rate"];
                }
                
            }
        }
        
        if ([[selectedSkills valueForKey:[NSString stringWithFormat:@"%ld", indexPath.row]] length] > 0 && [[selectedSkills valueForKey:[NSString stringWithFormat:@"%ld", indexPath.row]] isEqualToString:@"checked"]) {
            
            [cell.areaOFSkillCheckBoxBtn setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
            
        }else{
            
            [cell.areaOFSkillCheckBoxBtn setImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
        }
        
        return cell;
        
    }
    
    return cell;
    
}

#pragma mark tableview Professional skills Display Cell Delegate
- (void)getCheckMarkIndex:(NSString *)text key:(NSString *)key{

    if (([key integerValue] < (professionalSkillCounts + 2))) {
        
        if ([[selectedSkills valueForKey:key] length] > 0 && [[selectedSkills valueForKey:key] isEqualToString:@"checked"]) {
            
            [selectedSkills setValue:@"unchecked" forKey:key];
            [[allProfessionalSkills objectAtIndex:[key integerValue] - 1] removeObjectForKey:[NSString stringWithFormat:@"%ld", [key integerValue] - 1]];
            
//            if ([[[allProfessionalSkills objectAtIndex:[key integerValue]] valueForKey:key] length] > 0) {
//                [[allProfessionalSkills objectAtIndex:[key integerValue]] removeObjectForKey:key];
//            }
            
        }else{
            
            [selectedSkills setValue:text forKey:key];
            [[allProfessionalSkills objectAtIndex:[key integerValue] - 1] setValue:text forKey:[NSString stringWithFormat:@"%ld", [key integerValue] - 1]];
        }
        
    }
    
     [self.choosenProfileTableView reloadData];
}


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

- (IBAction)backBtnClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)requestOrSaveBtnClicked:(UIButton *)sender{
    
    if ([sender.currentTitle isEqualToString:@"Save"]) {
        
        [self savedProfile:@{@"field_favouraite": [selectedUserDict valueForKey:@"uid"]} userId:[[[CommonUtility sharedInstance].userDictionary valueForKey:@"user"] valueForKey:@"uid"]];
        
    }else{
        
        bool isSelectedAnyItem = NO;
        
        for (int i = 0; i < allProfessionalSkills.count; i++) {
            
            if ([[allProfessionalSkills objectAtIndex:i] count] > 3) {
               
                isSelectedAnyItem = YES;
            }
        }
        if (isSelectedAnyItem) {
            
            NSMutableDictionary *tempDict = [self createMutableDict:selectedUserDict];
            
            selectedUserDict = [tempDict mutableCopy];
            
            [selectedUserDict setValue:allProfessionalSkills forKey:selectedSubTypeofcare];
            
            NSLog(@"selectedUserDict :- %@", selectedUserDict);
            
            [self performSegueWithIdentifier:@"ChosenProfileViewController" sender:nil];
        }
        else{
             kCustomAlertWithParamAndTarget(@"Message", @"Please select at least one skill for hiring this person", nil);
        }
    }
}


//- (void)requestOrSaveBtnClicked:(UIButton *)sender{
//    
//    if ([sender.currentTitle isEqualToString:@"Save"]) {
//        
//        [self savedProfile:@{@"field_favouraite": [selectedUserDict valueForKey:@"uid"]} userId:[[[CommonUtility sharedInstance].userDictionary valueForKey:@"user"] valueForKey:@"uid"]];
//        
//    }else{
//        [self performSegueWithIdentifier:@"ChosenProfileViewController" sender:nil];
//    }
//}

#pragma mark API Call
-(void)savedProfile:(NSDictionary *)parameters userId:(NSString*)userId {
    
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable){
        kCustomAlertWithParamAndTarget(@"Message", @"Internet connection not available.", nil);
        return;
    }
    
    [kAppDelegete showHUDVIEW:self.view];
    
    NSMutableDictionary *headers = [NSMutableDictionary new];
    if ([[CommonUtility sharedInstance].userDictionary valueForKey:@"token"]) {
        [headers setValue:[[CommonUtility sharedInstance].userDictionary valueForKey:@"token"] forKey:@"X-CSRF-Token"];
    }
    
    [[IQWebService service] savedProfile:parameters userId:userId CompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //---- Hide HUD View ---
        [kAppDelegete removeHUDVIEW];
        
        NSUInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
        if (!error && statusCode == 200) {
            
            //--- Get login token ---Json error :- (null)
            NSError *error = nil;
            NSMutableArray * jsonObject = (NSMutableArray *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSLog(@"jsonObject :- %@", jsonObject);
            
            kCustomAlertWithParamAndTarget(@"Message", @"Selected user profile have been saved successfully into your favourite list.", nil);
            
            [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:0] animated:YES];
            
        } else {
            
            kCustomAlertWithParamAndTarget(@"Message", error.localizedDescription, nil);
            
            NSError *error = nil;
            NSDictionary * jsonObject = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSLog(@"jsonObject :- %@", jsonObject);
        }
    }];
}

@end
