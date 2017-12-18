//
//  NewEnrollQuestLegalPracticeCell.m
//  UNEYE
//
//  Created by Satya Kumar on 17/03/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import "BasicProfileCell.h"

@implementation BasicProfileCell

@synthesize mydelegate;

- (void)awakeFromNib {
    // Initialization code
    [self configureUI];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark configure initial UI
-(void)configureUI{
    
    UIColor *color = [UIColor darkGrayColor];
    
    //--- Sales Reps Detail ---
    //--- configure Sales Representative text field ---
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_txtName imageName:@"user-icon" width:47];
        _txtName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Name" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_txtName imageName:@"user-icon" width:60];
        _txtName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Name" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_txtName imageName:@"user-icon" width:55];
        _txtName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Name" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    [CommonUtility setRightPadding:_txtRequired imageName:@"drop_btn" width:50];
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    UIBarButtonItem *buttonflexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *buttonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    
    [toolbar setItems:[NSArray arrayWithObjects:buttonflexible,buttonDone, nil]];
    _txtRequired.inputAccessoryView = toolbar;
    _txtRequired.isOptionalDropDown = NO;
    [_txtRequired setItemList:[NSArray arrayWithObjects:@"Babysitter",@"Nanny",@"Special Needs Friend",@"Pet Sitter",@"House Sitter",@"Special Occassion Helper", nil]];
    [_txtRequired setDropDownMode:IQDropDownModeDateTimePicker];
    
//    //--- Set default value into current screen data ---
//    NSMutableDictionary *userTypeOfCareDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"Babysitter", valuekey, nil], @"0", nil];
//    [[CommonUtility sharedInstance] addDictScreenDataInfo:userTypeOfCareDict key:field_typeofcare];
    
    [[CommonUtility sharedInstance] addScreenDataInfo:@"Babysitter" key:field_typeofcare];
    
    //--- configure Legal Practice Required text field ---
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_txtRequired imageName:@"required" width:47];
        _txtRequired.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Type of Care" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_txtRequired imageName:@"required" width:60];
        _txtRequired.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Type of Care" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_txtRequired imageName:@"required" width:55];
        _txtRequired.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Type of Care" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    //--- configure Legal Practice Email text field ---
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_txtEmail imageName:@"email" width:47];
        _txtEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_txtEmail imageName:@"email" width:60];
        _txtEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_txtEmail imageName:@"email" width:55];
        _txtEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    //--- configure Legal Practice Password text field ---
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_txtPassword imageName:@"password" width:47];
        _txtPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_txtPassword imageName:@"password" width:60];
        _txtPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_txtPassword imageName:@"password" width:55];
        _txtPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    //--- configure Legal Practice Confirm Password text field ---
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_txtConfirmPassword imageName:@"password" width:47];
        _txtConfirmPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Confirm Password" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_txtConfirmPassword imageName:@"password" width:60];
        _txtConfirmPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Confirm Password" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_txtConfirmPassword imageName:@"password" width:55];
        _txtConfirmPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Confirm Password" attributes:@{NSForegroundColorAttributeName: color}];
    }
}

#pragma mark textField delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([textField isEqual:_txtName])
    {
        [mydelegate get:newString key:@"name"];
    }
    else if ([textField isEqual:_txtRequired])
    {
        [mydelegate get:newString key:TypeOfCare];
    }
    else if ([textField isEqual:_txtEmail])
    {
        [mydelegate get:newString key:@"mail"];
    }
    else if ([textField isEqual:_txtPassword])
    {
        [mydelegate get:newString key:@"pass"];
    }
    else if ([textField isEqual:_txtConfirmPassword])
    {
        [mydelegate get:newString key:@"confirmPass"];
    }
    
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark textView delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSLog(@"TextView Text :- %@", [NSString stringWithFormat:@"%@%@", textView.text, text]);
    
    NSString *newString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    [mydelegate get:newString key:AboutKey];
    
    if ([text isEqualToString:@"\n"]) {
        NSLog(@"Return pressed, do whatever you like here");
        return NO;
    }
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"About Me/Us"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"About Me/Us";
        textView.textColor = [UIColor lightGrayColor];
    }
    [textView resignFirstResponder];
}

#pragma mark dropdown textField delegate
-(void)doneClicked:(UIBarButtonItem*)button
{
    [self endEditing:YES];
    [mydelegate get:[NSString stringWithFormat:@"%@", _txtRequired.selectedItem] key:field_typeofcare];
}

@end
