//
//  AMSlideMenuRightTableViewController.h
//  AMSlideMenu
//
// Created by : TheTubes 2015
// Copyright (c) 2014 SocialObjects Software. All rights reserved.
//


#import <UIKit/UIKit.h>

@class AMSlideMenuMainViewController;

@interface AMSlideMenuRightTableViewController : UITableViewController

@property (weak, nonatomic) AMSlideMenuMainViewController *mainVC;

- (void)openContentNavigationController:(UINavigationController *)nvc;

@end
