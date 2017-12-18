//
//  AdvanceSearchBtnCell.m
//  UNEYE
//
//  Created by AppTech_Mac1 on 4/13/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import "AdvanceSearchBtnCell.h"

@implementation AdvanceSearchBtnCell

@synthesize mydelegate;


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self configureUI];

     self.hidden = YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark configure initial UI
-(void)configureUI
{
    
    UIColor *color = [UIColor darkGrayColor];
    
    //--- Sales Reps Detail ---
    //--- configure Age text field ---
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_txtAge imageName:@"age" width:47];
        _txtAge.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Age" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_txtAge imageName:@"age" width:60];
        _txtAge.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Age" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_txtAge imageName:@"age" width:55];
        _txtAge.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Age" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    //--- configure Gender text field ---
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    UIBarButtonItem *buttonflexibleGender = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *buttonDoneGender = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    buttonDoneGender.tag = 0;
    [toolbar setItems:[NSArray arrayWithObjects:buttonflexibleGender,buttonDoneGender, nil]];
    
    //--- Gender ---
    [CommonUtility setRightPadding:_txtGender imageName:@"drop_btn" width:50];
    
    _txtGender.inputAccessoryView = toolbar;
    _txtGender.isOptionalDropDown = NO;
    [_txtGender setItemList:[NSArray arrayWithObjects:@"Female", @"Male", nil]];
    [_txtGender setDropDownMode:IQDropDownModeDateTimePicker];
    [[CommonUtility sharedInstance] addScreenDataInfo:@"Female" key:gender];
    
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_txtGender imageName:@"gender" width:47];
        _txtGender.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Gender" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_txtGender imageName:@"gender" width:60];
        _txtGender.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Gender" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_txtGender imageName:@"gender" width:55];
        _txtGender.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Gender" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    //--- configure Rate p/h text field ---
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_txtRate imageName:@"rate" width:47];
        _txtRate.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Rate p/h" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_txtRate imageName:@"rate" width:60];
        _txtRate.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Rate p/h" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_txtRate imageName:@"rate" width:55];
        _txtRate.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Rate p/h" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    
    //--- configure Experience text field ---
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_txtExperience imageName:@"exoerience" width:47];
        _txtExperience.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Experience" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_txtExperience imageName:@"exoerience" width:60];
        _txtExperience.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Experience" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_txtExperience imageName:@"exoerience" width:55];
        _txtExperience.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Experience" attributes:@{NSForegroundColorAttributeName: color}];
    }
}

#pragma mark textField delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([textField isEqual:_txtAge])
    {
        [mydelegate get:newString key:searchAge];
    }
    else if ([textField isEqual:_txtRate])
    {
        [mydelegate get:newString key:searchRate];
    }
    else if ([textField isEqual:_txtExperience])
    {
        [mydelegate get:newString key:searchExperience];
    }
    return YES;
}

#pragma mark dropdown textField delegate
-(void)doneClicked:(UIBarButtonItem*)button
{
    [self endEditing:YES];
    
    [mydelegate get:[[NSString stringWithFormat:@"%@", _txtGender.selectedItem] lowercaseString] key:searchGender];
}

@end
