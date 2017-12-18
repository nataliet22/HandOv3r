//
//  BaseViewController.m
//  UNEYE
//
//  Created by Satya Kumar on 15/03/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import "BaseViewController.h"
#import "UIBarButtonItem+ImageItem.h"
#import "UIViewController+AMSlideMenu.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //--- Hide Navigation Bar ---
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self setLeftManuBtn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)styleNavBar
{
    UIFont *font = [UIFont fontWithName:@"OpenSans" size:17.0f];
    NSMutableDictionary *navBarTextAttributes = [NSMutableDictionary dictionaryWithCapacity:1];
    [navBarTextAttributes setObject:font forKey:NSFontAttributeName];
    [navBarTextAttributes setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = navBarTextAttributes;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
}

#pragma mark UiCustomization
-(void)setUpForNavigationBarBackButton
{
    //make cutom navigationBarButton and placed it to as a right bar button
    UIImage *backButton=[UIImage imageNamed:@"back_btn"];
    self.navigationItem.leftBarButtonItems=[NSArray arrayWithObjects:[UIBarButtonItem barButtonWithImage:backButton withTitle:nil target:self action:@selector(backButtonAction)], nil];
}

- (void)backButtonAction
{
    //--- Clear current screen data ---
    [[CommonUtility sharedInstance].screenDataDictionary removeAllObjects];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)closeLeftManuScreen
{
    [self.mainSlideMenu openLeftMenu];
}

-(void)setLeftManuBtn
{
    UIButton *btnLeftManu = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLeftManu addTarget:self action:@selector(closeLeftManuScreen) forControlEvents:UIControlEventTouchDown];
    [btnLeftManu setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    btnLeftManu.frame = CGRectMake(CGRectGetMinX(self.view.frame) + 20, CGRectGetMinY(self.view.frame) + 30, 30, 30);
    [self.view addSubview:btnLeftManu];
}

#pragma mark back button action for viewcontrollers
-(IBAction)backBtnClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
