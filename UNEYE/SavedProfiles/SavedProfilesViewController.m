//
//  SavedProfilesViewController.m
//  UNEYE
//
//  Created by Satya Kumar on 16/03/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import "SavedProfilesViewController.h"
#import "CustomCell.h"
#import "SearchResultViewController.h"
#import "ChosenProfileViewController.h"
#import "SendMessageViewController.h"

@interface SavedProfilesViewController (){

    NSMutableDictionary *searchResultDict;
    
    //--- Selected User Id ---
    NSString *selectedUserId;
    NSString *selectedUserPic;
    NSMutableDictionary *selectedUser;
}

@property (weak, nonatomic) IBOutlet UIView *invoicesTitle_View;
@property (weak, nonatomic) IBOutlet UITextField *txtSearchField;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;
@property (weak, nonatomic) IBOutlet UITableView *savedProfileTableView;

@end

@implementation SavedProfilesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
//       if (IS_IPHONE_6) {
//           _invoicesTitle_View.translatesAutoresizingMaskIntoConstraints = NO;
//           [self.view addConstraints:[NSLayoutConstraint
//                                      constraintsWithVisualFormat:@"H:[_invoicesTitle_View(==20)]-|"
//                                      options:NSLayoutFormatDirectionLeadingToTrailing
//                                      metrics:nil
//                                      views:NSDictionaryOfVariableBindings(_invoicesTitle_View)]];
//       }else if (IS_IPHONE_6P) {
//           _invoicesTitle_View.translatesAutoresizingMaskIntoConstraints = NO;
//           [self.view addConstraints:[NSLayoutConstraint
//                                      constraintsWithVisualFormat:@"H:[_invoicesTitle_View(==40)]-|"
//                                      options:NSLayoutFormatDirectionLeadingToTrailing
//                                      metrics:nil
//                                      views:NSDictionaryOfVariableBindings(_invoicesTitle_View)]];
//       }
    
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    //--- Get Saved Profiles
    [self getAllSavedProfiles];
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
 
    if ([segue.identifier isEqualToString:@"searchresultsegue"])
    {
        SearchResultViewController *searchResultVC = segue.destinationViewController;
        searchResultVC.imageView1.image = [UIImage imageNamed:@"sitter_option"];
        searchResultVC.searchResultDict = searchResultDict;
        searchResultVC.searchType = @"sitter";
        searchResultVC.isSavedProfile = YES;
    }else if ([segue.identifier isEqualToString:@"savedprofilesegue"]){
    
        ChosenProfileViewController *objChosenProfileViewController = segue.destinationViewController;
        objChosenProfileViewController.isSavedProfile = NO;
        objChosenProfileViewController.selectedUserID = selectedUserId;
        objChosenProfileViewController.selectedUserDict  = selectedUser;
        
    }else if ([segue.identifier isEqualToString:@"savedusermessagesegue"]){
    
        SendMessageViewController *objSendMessageViewController = (SendMessageViewController *)[segue destinationViewController];
        objSendMessageViewController.recipientId = selectedUserId;
        objSendMessageViewController.recipientPic = nil;
    }
}

- (IBAction)searchBtnClicked:(id)sender {
    
    if ([_txtSearchField.text length] > 0) {
        
        //--- Call Search API By Name
        [self searchUserByName:_txtSearchField.text];
    }else{
    
        kCustomAlertWithParamAndTarget(@"Message", @"Please enter name", nil);
    }
}

#pragma mark tableview delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (!searchResultDict) {
        return 0;
    }
    
    return [[searchResultDict valueForKey:@"results"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *MyIdentifier;
    MyIdentifier = @"customCell";
    CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault
                                 reuseIdentifier:MyIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.lblTitle.text = [[[searchResultDict valueForKey:@"results"] objectAtIndex:indexPath.row] valueForKey:@"Name"];
    
//    NSString *detalStr = [NSString stringWithFormat:@"Postcode : %@\nRate p/h : $%@", [[[searchResultDict valueForKey:@"results"] objectAtIndex:indexPath.row] valueForKey:@"Postcode"], [[[searchResultDict valueForKey:@"results"] objectAtIndex:indexPath.row] valueForKey:@"rate"]];
    
    NSString *detalStr = [NSString stringWithFormat:@"Postcode : %@\n    ", [[[searchResultDict valueForKey:@"results"] objectAtIndex:indexPath.row] valueForKey:@"Postcode"]];
    
    cell.lblDetailText.text = detalStr;
    
    cell.btnMessage.tag = indexPath.row;
    cell.btnCancelOrBook.tag = indexPath.row;
    [cell.btnMessage addTarget:self action:@selector(messageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnCancelOrBook addTarget:self action:@selector(bookBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.userImageView loadImage:[[[searchResultDict valueForKey:@"results"] objectAtIndex:indexPath.row] valueForKey:@"Picture"]];
    return cell;
    
}

-(IBAction)messageBtnClick:(id)sender{

    UIButton *btn = (UIButton *)sender;
    selectedUserId = [[[searchResultDict valueForKey:@"results"] objectAtIndex:btn.tag] valueForKey:@"uid"];
    selectedUserPic = [[[searchResultDict valueForKey:@"results"] objectAtIndex:btn.tag] valueForKey:@"Picture"];
    [self performSegueWithIdentifier:@"savedusermessagesegue" sender:nil];
}

-(IBAction)bookBtnClick:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    selectedUser = [[searchResultDict valueForKey:@"results"] objectAtIndex:btn.tag];
    selectedUserId = [[[searchResultDict valueForKey:@"results"] objectAtIndex:btn.tag] valueForKey:@"uid"];
    [self performSegueWithIdentifier:@"savedprofilesegue" sender:nil];
}

#pragma mark API
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
            
            _txtSearchField.text = @"";
            
            searchResultDict = [jsonObject mutableCopy];
            [self performSegueWithIdentifier:@"searchresultsegue" sender:nil];
            
        } else {
            
            kCustomAlertWithParamAndTarget(@"Message", error.localizedDescription, nil);
            
            NSError *error = nil;
            NSDictionary * jsonObject = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSLog(@"jsonObject :- %@", jsonObject);
        }
    }];
}

#pragma mark API Call
-(void)getAllSavedProfiles {
    
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable){
        kCustomAlertWithParamAndTarget(@"Message", @"Internet connection not available.", nil);
        return;
    }
    
    [kAppDelegete showHUDVIEW:self.view];
    
    NSMutableDictionary *headers = [NSMutableDictionary new];
    if ([[CommonUtility sharedInstance].userDictionary valueForKey:@"token"]) {
        [headers setValue:[[CommonUtility sharedInstance].userDictionary valueForKey:@"token"] forKey:@"X-CSRF-Token"];
    }
    
    [[IQWebService service] getSavedProfiles:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //---- Hide HUD View ---
        [kAppDelegete removeHUDVIEW];
        
        NSUInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
        if (!error && statusCode == 200) {
            
            //--- Get login token ---Json error :- (null)
            NSError *error = nil;
            NSMutableDictionary * jsonObject = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSLog(@"jsonObject :- %@", jsonObject);
            
            searchResultDict = [jsonObject mutableCopy];
            [_savedProfileTableView reloadData];
            
        } else {
            
            kCustomAlertWithParamAndTarget(@"Message", error.localizedDescription, nil);
            
            NSError *error = nil;
            NSDictionary * jsonObject = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSLog(@"jsonObject :- %@", jsonObject);
        }
    }];
}

@end
