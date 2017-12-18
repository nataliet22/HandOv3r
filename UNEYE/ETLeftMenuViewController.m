//
//  ETLeftMenuViewController.m
//  UNEYE
//
//  Created by Satya 2015 on 28/11/14.
//  Copyright (c) Satya 2015 All rights reserved.
//

#import "ETLeftMenuViewController.h"

@interface ETLeftMenuViewController ()
@property (strong, nonatomic) UITableView *myTableView;

@end

@implementation ETLeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleBlackOpaque];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgimage"]]];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 && ![UIApplication sharedApplication].isStatusBarHidden)
    {
        self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}


@end
