//
//  AMSlideMenuLeftTableViewController.h
//  AMSlideMenu
//
// Created by : TheTubes 2015
// Copyright (c) TheTubes 2015 All rights reserved.
//

#import <UIKit/UIKit.h>

@class AMSlideMenuMainViewController;

@interface AMSlideMenuLeftTableViewController : UITableViewController

@property (weak, nonatomic) AMSlideMenuMainViewController *mainVC;

// Only afor non storyboard use
- (void)openContentNavigationController:(UINavigationController *)nvc;

@end
