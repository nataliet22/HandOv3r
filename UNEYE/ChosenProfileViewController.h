//
//  ChosenProfileViewController.h
//  UNEYE
//
//  Created by AppTech_Mac1 on 4/15/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChosenProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *sitterTitle_View;
- (IBAction)backBtnClick:(id)sender;

@property (weak, nonatomic) NSString *searchType;
@property (weak, nonatomic) NSString *selectedUserID;
@property (strong, nonatomic) NSMutableDictionary *selectedUserDict;
@property (nonatomic) BOOL isSavedProfile;

@property (weak, nonatomic) IBOutlet AsyncImageView *imageView;

@end
