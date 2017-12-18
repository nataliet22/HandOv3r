//
//  CoachOptionViewController.m
//  UNEYE
//
//  Created by AppTech_Mac1 on 4/14/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import "CoachOptionViewController.h"
#import "CoachBasicSearchCell.h"
#import "AdvanceSearchCell.h"
#import "ProfileSubmitBtnCell.h"
#import "AdvanceSearchBtnCell.h"
#import "SearchResultViewController.h"

@interface CoachOptionViewController ()<CoachBasicSearchCellDelegate, AdvanceSearchBtnCellDelegate, ProfileSubmitBtnCellDelegate, CalenderPopUpViewControllerDelegate>{
    
    NSMutableDictionary *searchResultDict;
    
    NSString *tempSelectedDate;
    NSString *tempSelectedTime;
}

@end

@implementation CoachOptionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([[CommonUtility sharedInstance].screenDataDictionary count] > 0) {
        [[CommonUtility sharedInstance].screenDataDictionary removeAllObjects];
    }
    
//    [[CommonUtility sharedInstance] addScreenDataInfo:@"Coaching" key:searchTypeofcare];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"CoachOptionViewController"])
    {
        SearchResultViewController *searchResultVC = (SearchResultViewController *)segue.destinationViewController;
        searchResultVC.searchType = @"coach";
        searchResultVC.searchResultDict = searchResultDict;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark tableview delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (flag == NO)
    {
        return 3;
    }
    if(flag == YES)
    {
        return 4;
    }
    else
    {
        return 3;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 196;
    }
    else if (indexPath.row == 1)
    {
        return 34;
    }
    else if (indexPath.row == 2 && flag == YES)
    {
        return 196;
    }
    else
    {
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   if (indexPath.row == 0)
    {
        static NSString *MyIdentifier;
        MyIdentifier = @"coachBasicSearchCell";
    CoachBasicSearchCell *cell = (CoachBasicSearchCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        if (cell == nil)
        {
            cell = [[CoachBasicSearchCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:MyIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.mydelegate = self;
        
        if ([[[CommonUtility sharedInstance].screenDataDictionary valueForKey:searchDate] length] > 0) {
            cell.txtDate.text = [[CommonUtility sharedInstance].screenDataDictionary valueForKey:searchDate];
        }
        
        if ([[[CommonUtility sharedInstance].screenDataDictionary valueForKey:searchActivity] length] > 0) {
            cell.txtActivity.selectedItem = [[CommonUtility sharedInstance].screenDataDictionary valueForKey:searchActivity];
        }
        
        if ([[[CommonUtility sharedInstance].screenDataDictionary valueForKey:searchPostCode] length] > 0) {
            cell.txtPostCode.text = [[CommonUtility sharedInstance].screenDataDictionary valueForKey:searchPostCode];
        }
        
        if ([[[CommonUtility sharedInstance].screenDataDictionary valueForKey:searchTime] length] > 0) {
            cell.txtTime.text = [[CommonUtility sharedInstance].screenDataDictionary valueForKey:searchTime];
        }
        
        
        return cell;
    }
   else if (indexPath.row == 1)
    {
        static NSString *MyIdentifier;
        MyIdentifier = @"advanceSearchCell";
        AdvanceSearchCell *cell = (AdvanceSearchCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        if (cell == nil)
        {
            cell = [[AdvanceSearchCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:MyIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
   else if (indexPath.row == 2 && flag == YES)
    {
        static NSString *MyIdentifier;
        MyIdentifier = @"advanceSearchBtnCell";
        AdvanceSearchBtnCell *cell = (AdvanceSearchBtnCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        if (cell == nil)
        {
            cell = [[AdvanceSearchBtnCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:MyIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.mydelegate = self;
        
        return cell;
    }
   else
    {
        
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
    }
}

#pragma mark Coach Basic Search Cell Delegate
- (void)get:(NSString *)text key:(NSString *)key{
    
    if ([key isEqualToString:searchDate]) {
        [self openPOPUPView];
        return;
    }
    
    //--- Current screen data ---
    [[CommonUtility sharedInstance] addScreenDataInfo:text key:key];
    
    if ([key isEqualToString:searchTime]) {
        tempSelectedTime = text;
    }
    
    NSLog(@"screenDataDictionary :- %@", [CommonUtility sharedInstance].screenDataDictionary);
    
}

#pragma mark Profile Submit Btn Cell
- (void)submitForm{
    
    [self.view endEditing:YES];
    
    if ([_txtSearch.text length] > 0) {
        
        //--- Call Search API By Name
        [self searchUserByName:_txtSearch.text];
    }else{
        
        if ([[CommonUtility sharedInstance].screenDataDictionary count] > 0) {
            
            [[CommonUtility sharedInstance].screenDataDictionary setValue:tempSelectedDate forKey:searchDate];
            [[CommonUtility sharedInstance].screenDataDictionary setValue:tempSelectedTime forKey:searchTime];
            
            if ([[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"field_sub_typeofcare"] length] > 0) {
                
                NSString *levelOfStudy = [[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"field_sub_typeofcare"];
                
                [[CommonUtility sharedInstance].screenDataDictionary setValue:levelOfStudy forKey:searchLevelOfStudy];
                [[CommonUtility sharedInstance].screenDataDictionary removeObjectForKey:@"field_sub_typeofcare"];
                
                //--- New Search Field ---
                [[CommonUtility sharedInstance].screenDataDictionary setValue:levelOfStudy forKey:searchSubTypeofcares];
            }
            
//            [[CommonUtility sharedInstance].screenDataDictionary setValue:@"" forKey:@"field_typeofcare"];
            
            //--- New Param for Available Dates ----
            //field_available_dates[value][date]=2017-05-24-05:40:00
            
            NSMutableString *availableDatesTimeStr = [[NSMutableString alloc] init];
            
            if ([[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"field_available_dates"] length] > 0) {
                
                if ([[[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"field_time"] length] > 0) {
                    
                    NSString *timeStr = [[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"field_time"];
                    NSArray *timeSplitArr = [timeStr componentsSeparatedByString:@" "];
                    
                    NSString *timeTempStr = @"";
                    if ([timeSplitArr count] > 0) {
                        timeTempStr = [timeSplitArr firstObject];
                    }
                    
                    [availableDatesTimeStr appendFormat:@"%@-%@", [[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"field_available_dates"], timeTempStr];
                }else{
                    
                    [availableDatesTimeStr appendFormat:@"%@", [[CommonUtility sharedInstance].screenDataDictionary valueForKey:@"field_available_dates"]];
                }
            }
            
            if (availableDatesTimeStr.length > 0) {
                [[CommonUtility sharedInstance].screenDataDictionary setValue:availableDatesTimeStr forKey:searchDateNewKey];
            }
//            else{
//
//                [[CommonUtility sharedInstance].screenDataDictionary setValue:@"" forKey:searchDateNewKey];
//            }
            
            [self searchUserByQuery:[self arrangeDateTimeParam:[CommonUtility sharedInstance].screenDataDictionary]];
        }else{
            
            kCustomAlertWithParamAndTarget(@"Message", @"Please fill and choose options for search", nil);
        }
    }
}

//--- Arrange Date Time Param ---
-(NSMutableDictionary *)arrangeDateTimeParam:(NSMutableDictionary*)parameters{
    
    if ([[parameters valueForKey:searchDate] length] > 0) {
        
        if ([[parameters valueForKey:searchTime] length] > 0) {
            [parameters setValue:[NSString stringWithFormat:@"%@ %@", [parameters valueForKey:searchDate], [parameters valueForKey:searchTime]] forKey:searchDate];
            
            [parameters removeObjectForKey:searchTime];
        }
    }
    
    NSLog(@"screenDataDictionary :- %@", parameters);
    
    return parameters;
}

- (IBAction)advanceSearchBtn:(id)sender
{
    if(flag == NO)
    {
        flag = YES;
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:flag+1 inSection:0];
        [self.myTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [self.myTableView reloadData];

    }
    
    else if (flag == YES)
    {
        flag = NO;
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:flag+1 inSection:0];
        [self.myTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]withRowAnimation:UITableViewRowAnimationNone];
        
        [self.myTableView reloadData];

    }
}

- (IBAction)leftMenuBtn:(id)sender
{
    [self.mainSlideMenu openLeftMenu];
}

- (IBAction)backBtnClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark open POPUPView
-(void)openPOPUPView{
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    CalenderPopUpViewController *objCalenderPopUpViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"CalenderPopUpViewController"];
    objCalenderPopUpViewController.mydelegate = self;
    
    [objCalenderPopUpViewController showInView:self.view animated:YES];
    
    [self addChildViewController:objCalenderPopUpViewController];
}
#pragma mark CalenderPopUpViewController delegates
- (void)getSelectedItems:(NSString *)selectedDate{
    
    //--- Current screen data ---
    [[CommonUtility sharedInstance] addScreenDataInfo:selectedDate key:searchDate];
    
    tempSelectedDate = selectedDate;
    
    [self.myTableView reloadData];
    
}

#pragma mark API Call
-(void)searchUserByName:(NSString*)name {
    
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable){
        kCustomAlertWithParamAndTarget(@"Message", @"Internet connection not available.", nil);
        return;
    }
    
    [kAppDelegete showHUDVIEW:self.view];
    
    NSMutableDictionary *headers = [NSMutableDictionary new];
    if ([[CommonUtility sharedInstance].userDictionary valueForKey:@"token"]) {
        [headers setValue:[[CommonUtility sharedInstance].userDictionary valueForKey:@"token"] forKey:@"X-CSRF-Token"];
    }
    
    [[IQWebService service] searchByName:headers name:name completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //---- Hide HUD View ---
        [kAppDelegete removeHUDVIEW];
        
        NSUInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
        if (!error && statusCode == 200) {
            
            //--- Get login token ---Json error :- (null)
            NSError *error = nil;
            NSMutableArray * jsonObject = (NSMutableArray *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSLog(@"jsonObject :- %@", jsonObject);
            
            //--- Clear current screen data ---
            [[CommonUtility sharedInstance].screenDataDictionary removeAllObjects];
            
            searchResultDict = [jsonObject mutableCopy];
            [self performSegueWithIdentifier:@"CoachOptionViewController" sender:nil];
            
        } else {
            
            kCustomAlertWithParamAndTarget(@"Message", error.localizedDescription, nil);
            
            NSError *error = nil;
            NSDictionary * jsonObject = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSLog(@"jsonObject :- %@", jsonObject);
        }
    }];
}

-(void)searchUserByQuery:(NSMutableDictionary*)parameters {
    
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable){
        kCustomAlertWithParamAndTarget(@"Message", @"Internet connection not available.", nil);
        return;
    }
    
    [kAppDelegete showHUDVIEW:self.view];
    
    NSMutableDictionary *headers = [NSMutableDictionary new];
    if ([[CommonUtility sharedInstance].userDictionary valueForKey:@"token"]) {
        [headers setValue:[[CommonUtility sharedInstance].userDictionary valueForKey:@"token"] forKey:@"X-CSRF-Token"];
    }
    
    [[IQWebService service] searchByQuery:headers queryParam:parameters completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //---- Hide HUD View ---
        [kAppDelegete removeHUDVIEW];
        
        NSUInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
        if (!error && statusCode == 200) {
            
            //--- Get login token ---Json error :- (null)
            NSError *error = nil;
            NSMutableArray * jsonObject = (NSMutableArray *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSLog(@"jsonObject :- %@", jsonObject);
            
            //--- Clear current screen data ---
            //[[CommonUtility sharedInstance].screenDataDictionary removeAllObjects];
            
            searchResultDict = [jsonObject mutableCopy];
            [self performSegueWithIdentifier:@"CoachOptionViewController" sender:nil];
            
        } else {
            
            kCustomAlertWithParamAndTarget(@"Message", error.localizedDescription, nil);
            
            NSError *error = nil;
            NSDictionary * jsonObject = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSLog(@"jsonObject :- %@", jsonObject);
        }
    }];
}

@end
