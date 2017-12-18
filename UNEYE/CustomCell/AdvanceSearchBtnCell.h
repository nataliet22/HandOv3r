//
//  AdvanceSearchBtnCell.h
//  UNEYE
//
//  Created by AppTech_Mac1 on 4/13/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTextField.h"
#import "CommonUtility.h"

@protocol AdvanceSearchBtnCellDelegate <NSObject>
@required

- (void)get:(NSString *)text key:(NSString *)key;

@end

@interface AdvanceSearchBtnCell : UITableViewCell

@property (nonatomic, weak) id <AdvanceSearchBtnCellDelegate> mydelegate;

@property (weak, nonatomic) IBOutlet MyTextField *txtAge;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *txtGender;
@property (weak, nonatomic) IBOutlet MyTextField *txtRate;
@property (weak, nonatomic) IBOutlet MyTextField *txtExperience;

@end
