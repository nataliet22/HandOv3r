//
//  ConfirmDetailViewController.m
//  UNEYE
//
//  Created by AppTech_Mac1 on 4/16/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import "ConfirmDetailViewController.h"
#import "ConfirmationViewController.h"
#import "ConfirmationViewController.h"

@interface ConfirmDetailViewController (){

    NSString *additional_requirements_str;
    
    NSString *selectedDateInYYYYMMDD;
}

@end

@implementation ConfirmDetailViewController
@synthesize mydelegate;
@synthesize searchType;
@synthesize imageView;
@synthesize selectedUserDict;
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureUI];
    
    if (selectedUserDict[@"Picture"] != nil || ![selectedUserDict[@"Picture"] isEqualToString:@""])
    {
        [self.imageView loadImage:selectedUserDict[@"Picture"]];
    }
    else if ([searchType isEqualToString:@"tutor"])
    {
        [self.imageView setImage:[UIImage imageNamed:@"tutor_option"] forState:UIControlStateNormal];
    }
    else if ([searchType isEqualToString:@"coach"])
    {
        [self.imageView setImage:[UIImage imageNamed:@"coach_option"] forState:UIControlStateNormal];
    }
    [CommonUtility setRightPadding:_txtTime imageName:@"drop_btn" width:50];
    [CommonUtility setRightPadding:_txtDate imageName:@"drop_btn" width:50];
    
    if ([searchType length] > 0) {
        [[CommonUtility sharedInstance]addScreenDataInfo:selectedUserDict[@"uid"] key:searchType];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ConfirmDetailViewController"])
    {
        ConfirmationViewController *ConfirmationVC = (ConfirmationViewController *)segue.destinationViewController;
        ConfirmationVC.searchType = searchType;
        ConfirmationVC.selectedUserDict = selectedUserDict;
        //ConfirmationVC.selectedAppointmentData =  [NSMutableDictionary dictionaryWithDictionary:@{@"date" : _txtDate.text, @"time" : _txtTime.text}];
        ConfirmationVC.selectedAppointmentData =  [NSMutableDictionary dictionaryWithDictionary:@{@"date" : selectedDateInYYYYMMDD, @"time" : _txtTime.text}];
        
        if (additional_requirements_str.length == 0) {
            additional_requirements_str = @"";
        }
        
        ConfirmationVC.additional_requirements_str = additional_requirements_str;
    }
}

#pragma mark configure initial UI
-(void)configureUI
{
    self.imageView.layer.cornerRadius = 60;
    [self.imageView setClipsToBounds:YES];
    
    UIColor *color = [UIColor darkGrayColor];
    
    //--- Sales Reps Detail ---
    //--- configure Date text field ---
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
    _txtDate.delegate = self;
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
    UIDatePicker *timePicker = [[UIDatePicker alloc] init];
    timePicker.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame)-200, self.view.frame.size.width, 200.0f);
    timePicker.datePickerMode = UIDatePickerModeTime;
    [timePicker addTarget:self action:@selector(timeChanged:) forControlEvents:UIControlEventValueChanged];
    [self.txtTime setInputView:timePicker];

    //--- configure Number Of Children text field ---
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_txtNumberOfChildren imageName:@"child" width:47];
        _txtNumberOfChildren.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Number of Children" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_txtNumberOfChildren imageName:@"child" width:60];
        _txtNumberOfChildren.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Number of Children" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_txtNumberOfChildren imageName:@"child" width:55];
        _txtNumberOfChildren.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Number of Children" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    _txtNumberOfChildren.delegate = self;
    _additionalReqTextField.delegate = self;
}

- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"yyyy-MM-dd"; //@"dd-MM-yyyy";
    }
    
    return dateFormatter;
}

- (NSDateFormatter *)dateFormatterAsDDMMYYYY
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd-MM-yyyy";
    }
    
    return dateFormatter;
}

#pragma mark open POPUPView
-(void)openPOPUPView{
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    CalenderPopUpViewController *objCalenderPopUpViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"CalenderPopUpViewController"];
    objCalenderPopUpViewController.mydelegate = self;
    
    [objCalenderPopUpViewController resignFirstResponder];
    [objCalenderPopUpViewController showInView:self.view animated:YES];
    
    [self addChildViewController:objCalenderPopUpViewController];
}
#pragma mark CalenderPopUpViewController delegates
- (void)getSelectedItems:(NSString *)selectedDate{
    
    //--- Current screen data ---
    [[CommonUtility sharedInstance] addScreenDataInfo:selectedDate key:searchDate];
    selectedDateInYYYYMMDD = selectedDate;
    
    NSDate *tempSelectedDate = [[self dateFormatter] dateFromString:selectedDate];
    NSString *tempSelectedDateStr = [[self dateFormatterAsDDMMYYYY] stringFromDate:tempSelectedDate];
    
    _txtDate.text = tempSelectedDateStr;
}

#pragma mark textField delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if ([textField isEqual:_txtDate])
    {
        [self openPOPUPView];
        [_txtDate resignFirstResponder];

    }
}
#pragma mark textView delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSLog(@"TextView Text :- %@", [NSString stringWithFormat:@"%@%@", textView.text, text]);
    
    additional_requirements_str = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    
    if ([text isEqualToString:@"\n"]) {
        NSLog(@"Return pressed, do whatever you like here");
        return NO;
    }
    
    return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Additional Requirements"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Additional Requirements";
        textView.textColor = [UIColor lightGrayColor];
    }
    [textView resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    return YES;
}

- (void)timeChanged:(UIDatePicker*)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm a"];
    NSString *currentTime = [dateFormatter stringFromDate:sender.date];
    NSLog(@"%@", currentTime);
    _txtTime.text = currentTime;
}

- (IBAction)backBtnClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}
- (IBAction)requestBtnClick:(id)sender
{
    [self.additionalReqTextField endEditing:YES];
    [self.additionalReqTextField resignFirstResponder];
    
    if(_txtTime.text.length != 0 && _txtDate.text.length !=0)
    {
        [self performSegueWithIdentifier:@"ConfirmDetailViewController" sender:nil];
    }
    else
    {
        kCustomAlertWithParamAndTarget(@"Message", @"Please fill Date/Time", self);
    }
}
@end
