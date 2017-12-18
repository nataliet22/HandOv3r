//
//  NewEnrollQuestLegalPracticeCell.h
//  UNEYE
//
//  Created by Satya Kumar on 17/03/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTextField.h"
#import "CommonUtility.h"

@protocol BasicProfileCellDelegate <NSObject>
@required
- (void)get:(NSString *)text key:(NSString *)key;
@end

@interface BasicProfileCell : UITableViewCell

@property (nonatomic, weak) id <BasicProfileCellDelegate> mydelegate;

@property (weak, nonatomic) IBOutlet MyTextField *txtName;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *txtRequired;
@property (weak, nonatomic) IBOutlet UITextView *txtAbout;
@property (weak, nonatomic) IBOutlet MyTextField *txtEmail;
@property (weak, nonatomic) IBOutlet MyTextField *txtPassword;
@property (weak, nonatomic) IBOutlet MyTextField *txtConfirmPassword;

@end
