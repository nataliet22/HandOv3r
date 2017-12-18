//
//  BaseViewController.h
//  UNEYE
//
//  Created by Satya Kumar on 15/03/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

-(void)setUpForNavigationBarBackButton;
-(void)closeLeftManuScreen;
-(IBAction)backBtnClick:(id)sender;

@end
