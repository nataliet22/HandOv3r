//
//  SitterSearchViewController.h
//  UNEYE
//
//  Created by AppTech_Mac1 on 4/12/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+AMSlideMenu.h"

@interface SitterSearchViewController : UIViewController
{
    BOOL flag;
}

@property (weak, nonatomic) IBOutlet UITextField *txtSearch;

- (IBAction)advanceSearchBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

- (IBAction)leftMenuBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
