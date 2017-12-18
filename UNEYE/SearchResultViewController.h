//
//  SearchResultViewController.h
//  UNEYE
//
//  Created by AppTech_Mac1 on 4/15/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultViewController :UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView1;

@property (weak, nonatomic) NSString *searchType;
@property (weak, nonatomic) NSMutableDictionary *searchResultDict;
@property (nonatomic) BOOL isSavedProfile;


- (IBAction)backBtnClick:(id)sender;

@end
