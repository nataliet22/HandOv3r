//
//  BasicSearchCell.m
//  UNEYE
//
//  Created by AppTech_Mac1 on 4/11/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import "BasicSearchCell.h"

@implementation BasicSearchCell

@synthesize mydelegate;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self configureUI];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark configure initial UI
-(void)configureUI
{
    
    UIColor *color = [UIColor darkGrayColor];
    
    //--- configure Postcode text field ---
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_postCode imageName:@"postcode" width:47];
        _postCode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Postcode" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_postCode imageName:@"postcode" width:60];
        _postCode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Postcode" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_postCode imageName:@"postcode" width:55];
        _postCode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Postcode" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    //--- configure required text field ---
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    UIBarButtonItem *buttonflexibleReq = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *buttonDoneReq = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    buttonDoneReq.tag = 0;
    [toolbar setItems:[NSArray arrayWithObjects:buttonflexibleReq,buttonDoneReq, nil]];
    
    //--- Sub Categories of Type Of Care ---
    [CommonUtility setRightPadding:_required imageName:@"drop_btn" width:50];
    
    _required.inputAccessoryView = toolbar;
    _required.isOptionalDropDown = NO;
    [_required setItemList:[NSArray arrayWithObjects:@"Babysitter",@"Nanny",@"Special Needs Friend", @"Pet Sitter", @"House Sitter",@"Special Occassion Helper", nil]];
    [_required setDropDownMode:IQDropDownModeDateTimePicker];
    [[CommonUtility sharedInstance] addScreenDataInfo:@"Babysitter" key:searchSubTypeofcare];
    _required.delegate = self;
    //--- configure Required text field ---
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_required imageName:@"required" width:47];
        _required.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Required" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_required imageName:@"required" width:60];
        _required.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Required" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_required imageName:@"required" width:55];
        _required.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Required" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    //--- configure Date text field ---
    [CommonUtility setRightPadding:_date imageName:@"drop_btn" width:50];
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_date imageName:@"date" width:47];
        _date.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Date" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_date imageName:@"date" width:60];
        _date.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Date" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_date imageName:@"date" width:55];
        _date.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Date" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    //--- configure time text field ---
    
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_txtTime imageName:@"time" width:47];
        _txtTime.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Time" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_txtTime imageName:@"time" width:60];
        _txtTime.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Time" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_txtTime imageName:@"time" width:55];
        _txtTime.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Time" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    [CommonUtility setRightPadding:_txtTime imageName:@"drop_btn" width:50];
    
    UIBarButtonItem *buttonflexibleTime = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *buttonDoneTime = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    buttonDoneTime.tag = 1;
    [toolbar setItems:[NSArray arrayWithObjects:buttonflexibleTime,buttonDoneTime, nil]];
    
    self.txtTime.inputAccessoryView = toolbar;
    
    UIDatePicker *timePicker = [[UIDatePicker alloc] init];
    timePicker.frame = CGRectMake(0, CGRectGetMaxY(self.frame)-200, self.frame.size.width, 200.0f);
    timePicker.datePickerMode = UIDatePickerModeCountDownTimer;
    [timePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];

    [self.txtTime setInputView:timePicker];
}

- (void)dateChanged:(UIDatePicker*)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *currentTime = [dateFormatter stringFromDate:sender.date];
    NSLog(@"%@", currentTime);
    
    self.txtTime.text = currentTime;
}

-(void)textField:(nonnull IQDropDownTextField*)textField didSelectItem:(nullable NSString*)item
{
    [[CommonUtility sharedInstance] addScreenDataInfo:item key:searchSubTypeofcare];
}

#pragma mark textField delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
//    MyTextField *txtFld = (MyTextField *)textField;
//    if (txtFld == _date)
//    {
//        [_date resignFirstResponder];
//        [mydelegate get:@"" key:searchDate];
//    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([textField isEqual:_postCode])
    {
        [mydelegate get:newString key:searchPostCode];
    }

   return YES;
}

#pragma mark dropdown textField delegate
-(void)doneClicked:(UIBarButtonItem*)button
{
    [self endEditing:YES];
    
    if (button.tag == 0) {
        [mydelegate get:[NSString stringWithFormat:@"%@", _required.selectedItem] key:searchSubTypeofcare];
    }else if (button.tag == 1) {
        
        if ([self.txtTime.text length] > 0) {
            NSArray *stringArray = [self.txtTime.text componentsSeparatedByString: @" "];
            
            NSString *str = [NSString stringWithFormat:@"%@%@",[stringArray objectAtIndex:0],@":00"];
            [mydelegate get:str key:searchTime];
        }
        else {
            [mydelegate get:self.txtTime.text key:searchTime];
        }
    }
}

-(IBAction)dateBtnClicked:(id)sender{

    [mydelegate get:@"" key:searchDate];
}

@end
