//
//  CoachBasicSearchCell.h
//  UNEYE
//
//  Created by AppTech_Mac1 on 4/14/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTextField.h"
#import "CommonUtility.h"

@protocol CoachBasicSearchCellDelegate <NSObject>
@required

- (void)get:(NSString *)text key:(NSString *)key;

@end

@interface CoachBasicSearchCell : UITableViewCell<IQDropDownTextFieldDelegate>

@property (nonatomic, weak) id <CoachBasicSearchCellDelegate> mydelegate;

@property (weak, nonatomic) IBOutlet MyTextField *txtPostCode;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *txtActivity;
@property (weak, nonatomic) IBOutlet MyTextField *txtDate;
@property (weak, nonatomic) IBOutlet MyTextField *txtTime;

@end
