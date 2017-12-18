//
//  InformationCell.h
//  UNEYE
//
//  Created by AppTech_Mac1 on 4/8/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTextField.h"
#import "CommonUtility.h"

@protocol InformationCellDelegate <NSObject>
@required
- (void)get:(NSString *)text key:(NSString *)key;
@end

@interface InformationCell : UITableViewCell{

    UITextField *lastSelectedTextFld;
    
    NSMutableDictionary *dictTypeOfCare;
}

@property (nonatomic, weak) id <InformationCellDelegate> mydelegate;

@property (weak, nonatomic) IBOutlet MyTextField *txtName;
@property (weak, nonatomic) IBOutlet MyTextField *txtAge;
@property (weak, nonatomic) IBOutlet MyTextField *postCode;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *txtGender;
@property (weak, nonatomic) IBOutlet MyTextField *txtEmail;
@property (weak, nonatomic) IBOutlet MyTextField *txtPassword;
@property (weak, nonatomic) IBOutlet MyTextField *txtConfirmPassword;
@property (weak, nonatomic) IBOutlet UITextView *txtAbout;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *lookingFor;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *subCategories;

@property (weak, nonatomic) IBOutlet IQDropDownTextField *lookingForCoaching;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *coachingSubCategories;

@property (weak, nonatomic) IBOutlet IQDropDownTextField *lookingForTutor;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *tutoringSubCategories;

@property (weak, nonatomic) IBOutlet MyTextField *txtExperience;
@property (weak, nonatomic) IBOutlet MyTextField *rate;
@property (weak, nonatomic) IBOutlet MyTextField *txtQualification;
@property (weak, nonatomic) IBOutlet MyTextField *addPayPalEmail;
@property (weak, nonatomic) IBOutlet UIButton *btnQualification;

@end
