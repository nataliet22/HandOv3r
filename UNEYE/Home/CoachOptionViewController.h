//
//  CoachOptionViewController.h
//  UNEYE
//
//  Created by AppTech_Mac1 on 4/14/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+AMSlideMenu.h"

@interface CoachOptionViewController : UIViewController
{
    BOOL flag;
}

- (IBAction)advanceSearchBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UITextField *txtSearch;

- (IBAction)leftMenuBtn:(id)sender;

@end
