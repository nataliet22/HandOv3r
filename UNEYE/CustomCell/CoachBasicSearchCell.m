//
//  CoachBasicSearchCell.m
//  UNEYE
//
//  Created by AppTech_Mac1 on 4/14/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import "CoachBasicSearchCell.h"

@implementation CoachBasicSearchCell

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
    
    //--- Sales Reps Detail ---
    //--- configure Postcode text field ---
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_txtPostCode imageName:@"postcode" width:47];
        _txtPostCode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Postcode" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_txtPostCode imageName:@"postcode" width:60];
        _txtPostCode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Postcode" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_txtPostCode imageName:@"postcode" width:55];
        _txtPostCode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Postcode" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    //--- configure Activity text field ---
    [CommonUtility setRightPadding:_txtActivity imageName:@"drop_btn" width:50];
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    
    UIBarButtonItem *buttonflexibleActivity = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *buttonDoneActivity = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    buttonDoneActivity.tag = 0;
    [toolbar setItems:[NSArray arrayWithObjects:buttonflexibleActivity, buttonDoneActivity, nil]];
    
    _txtActivity.inputAccessoryView = toolbar;
    _txtActivity.isOptionalDropDown = NO;
    
    NSArray *activityArray = [[NSArray alloc] initWithObjects:@"Chess",@"AFL",@"Athletics - Sprinter",@"Athletics - Cross-Country",@"Long-Distance",@"Badminton",@"Ballet",@"Baseball",@"Basketball",@"Beach Volleyball",@"Bowling",@"Canoeing",@"Cricket",@"Dancing",@"Fishing",@"Football",@"Golf",@"Gymnastics",@"Hockey",@"Horseback Riding",@"Karate",@"Kayaking",@"Netball",@"Pilates",@"Ping Pong",@"Roller Skating",@"Rollerblading",@"Rowing",@"Rugby Union",@"Rugby League",@"Sailing",@"Skateboarding",@"Skiing",@"Snow Boarding",@"Soccer",@"Softball",@"Swimming",@"Tennis",@"Touch Football", nil];
    
    NSArray *sortedArray = [activityArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    [_txtActivity setItemList:sortedArray];
    
    [_txtActivity setDropDownMode:IQDropDownModeDateTimePicker];
    //[[CommonUtility sharedInstance] addScreenDataInfo:[sortedArray firstObject] key:searchActivity];
    [[CommonUtility sharedInstance] addScreenDataInfo:[sortedArray firstObject] key:searchSubTypeofcare];
    
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_txtActivity imageName:@"activity" width:47];
        _txtActivity.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Activity" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_txtActivity imageName:@"activity" width:60];
        _txtActivity.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Activity" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_txtActivity imageName:@"activity" width:55];
        _txtActivity.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Activity" attributes:@{NSForegroundColorAttributeName: color}];
    }
    _txtActivity.delegate = self;
    //--- configure Date text field ---
    [CommonUtility setRightPadding:_txtDate imageName:@"drop_btn" width:50];
    
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_txtDate imageName:@"date" width:47];
        _txtDate.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Date" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_txtDate imageName:@"date" width:60];
        _txtDate.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Date" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_txtDate imageName:@"date" width:55];
        _txtDate.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Date" attributes:@{NSForegroundColorAttributeName: color}];
    }

    //--- configure Time text field ---
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
    
    _txtTime.inputAccessoryView = toolbar;
    
    UIDatePicker *timePicker = [[UIDatePicker alloc] init];
    timePicker.frame = CGRectMake(0, CGRectGetMaxY(self.frame)-200, self.frame.size.width, 200.0f);
    timePicker.datePickerMode = UIDatePickerModeCountDownTimer;
    [timePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    
    [_txtTime setInputView:timePicker];
}

- (void)dateChanged:(UIDatePicker*)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *currentTime = [dateFormatter stringFromDate:sender.date];
    NSLog(@"%@", currentTime);
    
    _txtTime.text = currentTime;
}

#pragma mark textField delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
//    MyTextField *txtFld = (MyTextField *)textField;
//    if (txtFld == _txtDate)
//    {
//        [_txtDate resignFirstResponder];
//        [mydelegate get:@"" key:searchDate];
//    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([textField isEqual:_txtPostCode])
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
        //[mydelegate get:[NSString stringWithFormat:@"%@", _txtActivity.selectedItem] key:searchActivity];
        [mydelegate get:[NSString stringWithFormat:@"%@", _txtActivity.selectedItem] key:searchSubTypeofcare];
    }else if (button.tag == 1) {
        [mydelegate get:_txtTime.text key:searchTime];
    }
}
-(void)textField:(IQDropDownTextField *)textField didSelectItem:(NSString *)item
{
    //[[CommonUtility sharedInstance]addScreenDataInfo:item key:searchActivity];
    [[CommonUtility sharedInstance] addScreenDataInfo:item key:searchSubTypeofcare];
}

-(IBAction)dateBtnClicked:(id)sender{
    
    [mydelegate get:@"" key:searchDate];
}

@end
