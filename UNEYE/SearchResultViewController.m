//
//  SearchResultViewController.m
//  UNEYE
//
//  Created by AppTech_Mac1 on 4/15/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import "SearchResultViewController.h"
#import "SearchResultCell.h"
#import "ChosenProfileViewController.h"

@interface SearchResultViewController (){

    NSMutableDictionary *selectedUserDictData;
}

@end

@implementation SearchResultViewController

@synthesize imageView1;
@synthesize searchType, searchResultDict, isSavedProfile;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([searchType isEqualToString:@"tutor"])
    {
        self.imageView1.image = [UIImage imageNamed:@"tutor_option"];
    }
    else if ([searchType isEqualToString:@"coach"])
    {
        self.imageView1.image = [UIImage imageNamed:@"coach_option"];
    }
    
    NSLog(@"searchResultArray :- %@", searchResultDict);
    
    if ([[searchResultDict valueForKey:@"results"] count] == 0) {
        kCustomAlertWithParamAndTarget(@"Message", @"No record found", self);
    }
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
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    ChosenProfileViewController *ChosenProfileVC = (ChosenProfileViewController *)segue.destinationViewController;

    if ([segue.identifier isEqualToString:@"SearchResultViewController"])
    {
  
        ChosenProfileVC.searchType = searchType;
        ChosenProfileVC.selectedUserID = selectedUserDictData[@"uid"];
        ChosenProfileVC.selectedUserDict = selectedUserDictData;
        if (isSavedProfile) {
            ChosenProfileVC.isSavedProfile = YES;
        }else{
        
            ChosenProfileVC.isSavedProfile = NO;
        }
    }
}


#pragma mark tableview delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[searchResultDict valueForKey:@"results"] count];
}

/* -(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 514;
} */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier;
    MyIdentifier = @"searchResultCell";
    SearchResultCell *cell = (SearchResultCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[SearchResultCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //--- Set Data
    cell.userNameLbl.text = [[[searchResultDict valueForKey:@"results"] objectAtIndex:indexPath.row] valueForKey:@"Name"];
    cell.userPostCodeLbl.text = [[[searchResultDict valueForKey:@"results"] objectAtIndex:indexPath.row] valueForKey:@"Postcode"];
    cell.userRateLbl.text = [NSString stringWithFormat:@"$ %@", [[[searchResultDict valueForKey:@"results"] objectAtIndex:indexPath.row] valueForKey:@"rate"]];
    
    cell.userImageView.layer.cornerRadius = 40;
    [cell.userImageView setClipsToBounds:YES];
    
    [cell.userImageView loadImage:[[[searchResultDict valueForKey:@"results"] objectAtIndex:indexPath.row] valueForKey:@"Picture"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    selectedUserDictData = [[searchResultDict valueForKey:@"results"] objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"SearchResultViewController" sender:nil];
}

- (IBAction)backBtnClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
        if(buttonIndex == 0)//OK button pressed
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
}
    
@end
