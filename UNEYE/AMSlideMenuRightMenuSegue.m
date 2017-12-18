//
//  AMSlideMenuRightMenuSegue.m
//  AMSlideMenu
//
// Created by : TheTubes 2015
// Copyright (c) TheTubes 2015. All rights reserved.
//

#import "AMSlideMenuRightMenuSegue.h"

#import "AMSlideMenuContentSegue.h"
#import "AMSlideMenuMainViewController.h"
#import "AMSlideMenuRightTableViewController.h"

@implementation AMSlideMenuRightMenuSegue

- (void)perform
{
    AMSlideMenuMainViewController* mainVC = self.sourceViewController;
    AMSlideMenuRightTableViewController* rightMenu = self.destinationViewController;
    
    mainVC.rightMenu = rightMenu;
    rightMenu.mainVC = mainVC;
        
    [mainVC addChildViewController:rightMenu];
    
    double delayInSeconds = 0.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        CGRect bounds = mainVC.view.bounds;
        rightMenu.view.frame = CGRectMake(bounds.size.width - [mainVC rightMenuWidth],0,[mainVC rightMenuWidth],bounds.size.height);
    });
    [mainVC.view addSubview:rightMenu.view];
    NSIndexPath *initialIndexPath = [mainVC initialIndexPathForRightMenu];
    
    [rightMenu.navigationController setNavigationBarHidden:YES];
    
    
#ifndef AMSlideMenuWithoutStoryboards
    if ([mainVC respondsToSelector:@selector(navigationControllerForIndexPathInRightMenu:)]) {
        UINavigationController *navController = [mainVC navigationControllerForIndexPathInRightMenu:initialIndexPath];
        AMSlideMenuContentSegue *segue = [[AMSlideMenuContentSegue alloc] initWithIdentifier:@"ContentSugue" source:rightMenu destination:navController];
        [segue perform];
    } else {
        NSString *segueIdentifier = [mainVC segueIdentifierForIndexPathInRightMenu:initialIndexPath];
        [rightMenu performSegueWithIdentifier:segueIdentifier sender:self];
    }
#else
    [rightMenu tableView:rightMenu.tableView didSelectRowAtIndexPath:initialIndexPath];
#endif

}

@end
