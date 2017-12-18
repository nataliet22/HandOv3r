//
//  AddEventPopUpViewController.m
//  UNEYE
//
//  Created by Satya on 23/08/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import "AddEventPopUpViewController.h"

@interface AddEventPopUpViewController ()<CalenderPopUpViewControllerDelegate, UITextFieldDelegate>

@end

@implementation AddEventPopUpViewController

@synthesize mydelegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self.view endEditing:YES];
//    
//    self.view.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:.6];
//    self.popUpView.layer.cornerRadius = 5;
//    self.popUpView.layer.shadowOpacity = 0.8;
//    self.popUpView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
//    self.popUpView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgimage"]];
    
    
    UIColor *color = [UIColor lightGrayColor];
    
    _eventName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Name" attributes:@{NSForegroundColorAttributeName: color}];
    _eventVanue.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Venue" attributes:@{NSForegroundColorAttributeName: color}];
    _eventDate.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Date" attributes:@{NSForegroundColorAttributeName: color}];
    _eventDate.delegate = self;
    _eventTime.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Time" attributes:@{NSForegroundColorAttributeName: color}];
    
    UIDatePicker *timePicker = [[UIDatePicker alloc] init];
    timePicker.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame)-200, self.view.frame.size.width, 200.0f);
    timePicker.datePickerMode = UIDatePickerModeTime;
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"NL"];
    [timePicker setLocale:locale];
    
    [timePicker addTarget:self action:@selector(timeChanged:) forControlEvents:UIControlEventValueChanged];
    [_eventTime setInputView:timePicker];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)timeChanged:(UIDatePicker*)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *currentTime = [dateFormatter stringFromDate:sender.date];
    NSLog(@"%@", currentTime);
    _eventTime.text = currentTime;
}

#pragma mark - IBAction
- (IBAction)closePopup:(id)sender {
    //[self removeAnimate];
    
    [self.mydelegate submitEventData:nil];
}

- (IBAction)backBtnCliecked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addEvent:(id)sender {
    
    if ([_eventName.text length] == 0) {
        kCustomAlertWithParamAndTarget(@"Message", @"Please enter event name.", nil);
        return;
    }else if ([_eventVanue.text length] == 0) {
        kCustomAlertWithParamAndTarget(@"Message", @"Please enter event vanue.", nil);
        return;
    }else if ([_eventDate.text length] == 0) {
        kCustomAlertWithParamAndTarget(@"Message", @"Please choose event date.", nil);
        return;
    }else if ([_eventTime.text length] == 0) {
        kCustomAlertWithParamAndTarget(@"Message", @"Please choose event time.", nil);
        return;
    }
    
    NSString *eventdateStr = [NSString stringWithFormat:@"%@ %@", [self dateFormateChange:_eventDate.text], _eventTime.text];
    NSDictionary *paramDict = [NSDictionary dictionaryWithObjectsAndKeys:_eventName.text, @"title",
                               _eventVanue.text, @"field_venue",
                               eventdateStr, @"date",
                               @"event", @"type",
                               nil];
    
    NSLog(@"event paramDict :- %@", paramDict);
    
    //--- Add event API Calling ---
    [self addEventAPI:paramDict];
    
}

- (NSString *)dateFormateChange:(NSString *)selectedDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"]; //]@"dd/MM/yyyy"];
    
    NSDate *date = [[NSDate alloc] init];
    if ([selectedDate length] > 0) {
        date = [dateFormatter dateFromString:selectedDate];
    }
    
    //[dateFormatter setDateFormat:@"dd/MM/yyyy"];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    NSLog(@"%@", dateStr);
    
    return dateStr;
}

- (void)showAnimate
{
    self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.view.alpha = 0;
    [UIView animateWithDuration:.25 animations:^{
        self.view.alpha = 1;
        self.view.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)removeAnimate
{
    [UIView animateWithDuration:.25 animations:^{
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.view removeFromSuperview];
        }
    }];
}

- (void)showInView:(UIView *)aView animated:(BOOL)animated
{
    [aView addSubview:self.view];
    if (animated) {
        [self showAnimate];
    }
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
    _eventDate.text = selectedDate;
}

#pragma mark textField delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if ([textField isEqual:_eventDate])
    {
        [_eventDate resignFirstResponder];
        [self openPOPUPView];
        
    }
}

#pragma mark get All Events web services
-(void)addEventAPI:(NSDictionary *)parameters {
    
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable){
        kCustomAlertWithParamAndTarget(@"Message", @"Internet connection not available.", nil);
        return;
    }
    
    [kAppDelegete showHUDVIEW:self.view];
    
    
    [[IQWebService service] addEvent:parameters CompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //---- Hide HUD View ---
        [kAppDelegete removeHUDVIEW];
        
        NSUInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
        if (!error && statusCode == 200) {
            
            //--- Get login token ---Json error :- (null)
            NSError *error = nil;
            NSMutableArray * jsonObject = (NSMutableArray *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSLog(@"jsonObject :- %@", jsonObject);
            
            if([jsonObject count] > 0){
            
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        } else {
            
            kCustomAlertWithParamAndTarget(@"Message", error.localizedDescription, nil);
        }
    }];
}


@end
