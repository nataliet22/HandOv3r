//
//  popviewController.m
//  Seek
//
//  Created by Satya Kumar on 14/05/16.
//  Copyright © 2016 AppTech_Mac1. All rights reserved.
//

#import "popviewController.h"
#import "EducationsCustomCell.h"
#import "AppDelegate.h"

@implementation popviewController

@synthesize mydelegate, selectionType;

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view endEditing:YES];
    
    self.view.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:.6];
    self.popUpView.layer.cornerRadius = 5;
    self.popUpView.layer.shadowOpacity = 0.8;
    self.popUpView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.popUpView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgimage"]];
    
    selectedItemIndex = [NSMutableDictionary new];
    
    //NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"QualificationList" ofType:@"plist"];
    
    //--- New Qualification List ---
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Qualifications2" ofType:@"plist"];
    items = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];

/*
    NSArray *sortedKeys = [items.allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
    NSString * otherkey;
    for (NSString * key in sortedKeys) {
        
        if ([key isEqualToString:@"Others"]) {
            otherkey = key;
        }else{
        
            [tempDict setValue:[items valueForKey:key] forKey:key];
        }
    }
    
    [tempDict setValue:[items valueForKey:otherkey] forKey:otherkey];
    
    if ([items count] > 0) {
        [items removeAllObjects];
    }
    
    items = [tempDict mutableCopy];
*/
    
    NSLog(@"qualifications :- %@", [CommonUtility sharedInstance].selectedQualificationDict);
    
    if ([[CommonUtility sharedInstance].screenDataDictionary valueForKey:qualifications]) {
        selectedQualificationItems = [[CommonUtility sharedInstance].selectedQualificationDict mutableCopy];
    }
    
    if ([CommonUtility sharedInstance].selectedQualificationIndex) {
        selectedItemIndex = [[CommonUtility sharedInstance].selectedQualificationIndex mutableCopy];
    }
}

-(void)setItems:(NSMutableArray *)arrayItemTitles arrayItemImages:(NSMutableArray *)arrayItemImages{
    
    if (!itemsImageArr) {
        itemsImageArr = [[NSMutableArray alloc] init];
    }
    
    if (!itemsTitleArr) {
        itemsTitleArr = [[NSMutableArray alloc] init];
    }
    
    itemsTitleArr = [arrayItemTitles mutableCopy];
    itemsImageArr = [arrayItemImages mutableCopy];
}

- (void)showAnimate
{
    self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.view.alpha = 0;
    [UIView animateWithDuration:.25 animations:^{
        self.view.alpha = 1;
        self.view.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)removeAnimate
{
    [UIView animateWithDuration:.25 animations:^{
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.view removeFromSuperview];
        }
    }];
}

- (IBAction)closePopup:(id)sender {
    [self removeAnimate];
    
    [self.mydelegate getSelectedItems:selectedQualificationItems];
}

- (void)showInView:(UIView *)aView animated:(BOOL)animated arrayItemTitles:(NSMutableArray *)arrayItemTitles arrayItemImages:(NSMutableArray *)arrayItemImages
{
    
    [self.view endEditing:YES];
    
    if (!itemsImageArr) {
        itemsImageArr = [[NSMutableArray alloc] init];
    }
    
    if (!itemsTitleArr) {
        itemsTitleArr = [[NSMutableArray alloc] init];
    }
    
    itemsTitleArr = [arrayItemTitles mutableCopy];
    itemsImageArr = [arrayItemImages mutableCopy];
    [_optionsTableView reloadData];
    
    [aView addSubview:self.view];
    if (animated) {
        [self showAnimate];
    }
}

#pragma mark tableview delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return [[items allKeys] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSInteger rowsCount;
    if (section < [[items allKeys] count]) {
        
        rowsCount = [[items valueForKey:[[items allKeys] objectAtIndex:section]] count];
    }
    
    return rowsCount;
}

/* -(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 return 514;
 } */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier;
    MyIdentifier = @"EducationsCustomCell";
    EducationsCustomCell *cell = (EducationsCustomCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[EducationsCustomCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:MyIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIColor *color = [UIColor grayColor];
    
    if (indexPath.row < [[items valueForKey:[[items allKeys] objectAtIndex:indexPath.section]] count]) {
        
        cell.educationTitleLbl.text = [[items valueForKey:[[items allKeys] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    }
    
    NSIndexPath *selectedItemIndexPath = (NSIndexPath *)[selectedItemIndex objectForKey:[NSString stringWithFormat:@"selectedIndex%ld%ld", (long)indexPath.section, (long)indexPath.row]];
    
    if (selectedItemIndexPath && selectedItemIndexPath.section == indexPath.section && selectedItemIndexPath.row == indexPath.row) {
        [cell.eduSelectionBtn setImage:[UIImage imageNamed:@"on_btn"] forState:UIControlStateNormal];
    }else{
    
        [cell.eduSelectionBtn setImage:[UIImage imageNamed:@"off_btn"] forState:UIControlStateNormal];
    }
    
    cell.textLabel.textColor = color;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 20.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:15]];
    label.textColor = [UIColor blackColor];
    
    //--- Set Section Header ---
    NSString *string = [NSString stringWithFormat:@"%@ :", [[items allKeys] objectAtIndex:section]];
    
    //--- Hide due to new Qualification List ---
    label.hidden = YES;
    
    [label setText:string];
    [view addSubview:label];
    
    [view setBackgroundColor:[UIColor clearColor]];
    return view;
}

#pragma mark - TableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath{
    
    @try {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        EducationsCustomCell *cell = (EducationsCustomCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        //--- Store selected items ---
        if (!selectedQualificationItems) {
            selectedQualificationItems = [[NSMutableDictionary alloc] init];
        }
        
        if ([selectedItemIndex objectForKey:[NSString stringWithFormat:@"selectedIndex%ld%ld", (long)indexPath.section, (long)indexPath.row]]) {
            [selectedItemIndex removeObjectForKey:[NSString stringWithFormat:@"selectedIndex%ld%ld", (long)indexPath.section, (long)indexPath.row]];
            [cell.eduSelectionBtn setImage:[UIImage imageNamed:@"off_btn"] forState:UIControlStateNormal];
            
            int i = 0;
            for (NSString *objectStr in [selectedQualificationItems valueForKey:[[items allKeys] objectAtIndex:indexPath.section]]) {
                if ([objectStr isEqualToString:[[items valueForKey:[[items allKeys] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]]) {
                    
                    [[selectedQualificationItems valueForKey:[[items allKeys] objectAtIndex:indexPath.section]] removeObjectAtIndex:i];
                    break;
                }else{
                    i++;
                }
            }
            
        }else{
            
            [selectedItemIndex setObject:indexPath forKey:[NSString stringWithFormat:@"selectedIndex%ld%ld", (long)indexPath.section, (long)indexPath.row]];
            [cell.eduSelectionBtn setImage:[UIImage imageNamed:@"on_btn"] forState:UIControlStateNormal];
            
            if ([selectedQualificationItems valueForKey:[[items allKeys] objectAtIndex:indexPath.section]]) {
                [[selectedQualificationItems valueForKey:[[items allKeys] objectAtIndex:indexPath.section]] addObject:[[items valueForKey:[[items allKeys] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]];
            }else{
                
                NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:[[items valueForKey:[[items allKeys] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row], nil];
                
                [selectedQualificationItems setValue:array forKey:[[items allKeys] objectAtIndex:indexPath.section]];
            }
        }
        
        [[CommonUtility sharedInstance] setSeekerQualificationIndexes:selectedItemIndex qualificationDict:nil];
        [_optionsTableView reloadData];
        
        NSLog(@"selectedItemItems :- %@", selectedQualificationItems);
        
    } @catch (NSException *exception) {
        
        NSLog(@"exception :- %@", exception.description);
    }
}

@end
