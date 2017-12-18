//
//  ConfirmDetailViewController.h
//  UNEYE
//
//  Created by AppTech_Mac1 on 4/16/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTextField.h"
#import "CommonUtility.h"

@protocol ConfirmDetailViewControllerDelegate <NSObject>
@required

- (void)get:(NSString *)text key:(NSString *)key;

@end


@interface ConfirmDetailViewController : UIViewController<CalenderPopUpViewControllerDelegate,UITextViewDelegate, UITextFieldDelegate>

@property (nonatomic, weak) id <ConfirmDetailViewControllerDelegate> mydelegate;

@property (weak, nonatomic) IBOutlet MyTextField *txtDate;
@property (weak, nonatomic) IBOutlet MyTextField *txtTime;
@property (weak, nonatomic) IBOutlet MyTextField *txtNumberOfChildren;
@property (weak, nonatomic) IBOutlet UITextView *additionalReqTextField;
- (IBAction)backBtnClick:(id)sender;

@property (weak, nonatomic) NSString *searchType;
@property (weak, nonatomic) NSMutableDictionary *selectedUserDict;

@property (weak, nonatomic) IBOutlet AsyncImageView *imageView;

@end
