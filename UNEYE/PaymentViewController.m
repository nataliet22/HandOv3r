//
//  PaymentViewController.m
//  UNEYE
//
//  Created by AppTech_Mac1 on 4/19/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import "PaymentViewController.h"


@interface PaymentViewController ()

@property(nonatomic, strong, readwrite) NSString *environment;
@property(nonatomic, assign, readwrite) BOOL acceptCreditCards;
@property(nonatomic, strong, readwrite) NSString *resultText;
@property NSDecimalNumber * amount;
@property NSDecimalNumber * userRate;
@property (nonatomic) NSDecimalNumber *tenPercent;
@property (nonatomic, strong) BTAPIClient *braintreeClient;


@end


@implementation PaymentViewController
@synthesize mydelegate;
@synthesize searchType;
@synthesize imageView;
@synthesize selectedUserDict, selectedAppointmentData, additional_requirements_str;
@synthesize isBookedSucess;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureUI];
    
//    if (selectedUserDict[@"Picture"] != nil || ![selectedUserDict[@"Picture"] isEqualToString:@""])
//    {
//        [self.imageView loadImage:selectedUserDict[@"Picture"]];
//    }
//    else
    
        
    if ([searchType isEqualToString:@"tutor"])
    {
        [self.imageView setImage:[UIImage imageNamed:@"tutor_option"] forState:UIControlStateNormal];
    }
    else if ([searchType isEqualToString:@"coach"])
    {
        [self.imageView setImage:[UIImage imageNamed:@"coach_option"] forState:UIControlStateNormal];
    }
    
    UIDatePicker *startTimePicker = [[UIDatePicker alloc] init];
    startTimePicker.tag = 100;
    startTimePicker.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame)-200, self.view.frame.size.width, 200.0f);
    startTimePicker.datePickerMode = UIDatePickerModeDateAndTime;
    [startTimePicker addTarget:self action:@selector(timeChanged:) forControlEvents:UIControlEventValueChanged];
    [self.txtStartTime setInputView:startTimePicker];
    
    UIDatePicker *endTimePicker = [[UIDatePicker alloc] init];
    endTimePicker.tag = 200;
    endTimePicker.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame)-200, self.view.frame.size.width, 200.0f);
    endTimePicker.datePickerMode = UIDatePickerModeDateAndTime;
    [endTimePicker addTarget:self action:@selector(timeChanged:) forControlEvents:UIControlEventValueChanged];
    [self.txtEndTime setInputView:endTimePicker];

    //--- For new/existing appointment ---
    if (isBookedSucess) {
        _endBtn.enabled = YES;
        _txtStartTime.enabled = YES;
        _txtEndTime.enabled = YES;
    }else{
        _endBtn.enabled = NO;
        _txtStartTime.enabled = NO;
        _txtEndTime.enabled = NO;
    }
    
    [self getBraintreeApiToken];
}

- (void)timeChanged:(UIDatePicker*)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy hh:mm a"];
    NSString *currentTime = [dateFormatter stringFromDate:sender.date];
    NSLog(@"%@", currentTime);
    
    if (sender.tag == 100) {
        self.txtStartTime.text = currentTime;
    }else if (sender.tag == 200){
        self.txtEndTime.text = currentTime;
    }
    
    [self calculateHours:self.txtStartTime.text endTime:self.txtEndTime.text];
}

- (void)calculateHours:(NSString *)startTime endTime:(NSString *)endTime{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy hh:mm a"];
    
    NSDate* startDate = [dateFormatter dateFromString:startTime];
    NSDate* endDate = [dateFormatter dateFromString:endTime];
    
    NSInteger ratePerHrs = [selectedUserDict[@"rate"] integerValue];
    
    NSUInteger unitFlags = NSCalendarUnitHour;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:unitFlags fromDate:startDate toDate:endDate options:0];
    
    float totalAmount = [components hour] * ratePerHrs;
    self.totalAmountTextField.text = [NSString stringWithFormat:@"%0.2f", totalAmount];
    
}

#pragma mark call getBraintreeApiToken
-(void)getBraintreeApiToken{
    
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable){
        kCustomAlertWithParamAndTarget(@"Message", @"Internet connection not available.", nil);
        return;
    }
    
    [kAppDelegete showHUDVIEW:self.view];
    
    [[IQWebService service]getBrainTreeTokenCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //---- Hide HUD View ---
        [kAppDelegete removeHUDVIEW];
        
        NSUInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
        if (!error && statusCode == 200) {
            
            //--- Get Braintree token ---
            NSError *error = nil;
            NSMutableArray * jsonObject = (NSMutableArray *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSLog(@"jsonObject :- %@", jsonObject);
            NSLog(@"jsonObject error :- %@", error.description);
            
            NSString *clientToken = [[jsonObject firstObject] valueForKey:@"braintree_token"];
        
            self.braintreeClient = [[BTAPIClient alloc] initWithAuthorization:clientToken];
            
        } else {
            
            kCustomAlertWithParamAndTarget(@"Message", error.localizedDescription, nil);
        }
    }];

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    if ([selectedUserDict[@"rate"] length] > 0) {
//        _userRate = [NSDecimalNumber decimalNumberWithString:selectedUserDict[@"rate"]];
//    }
//    
//    if (!isBookedSucess) {
//        self.totalAmountTextField.text = selectedUserDict[@"rate"];
//    }
    
    if ([selectedUserDict[@"rate"] length] > 0) {
        _userRate = [NSDecimalNumber decimalNumberWithString:[self calculateTotalAmount]];
    }
    
    if (!isBookedSucess) {
        self.totalAmountTextField.text = [self calculateTotalAmount];
    }
    
    //self.tenPercentAmountTextField.text = [[self tenPercent] stringValue];
    
}

- (NSString *)calculateTotalAmount{
    
    float totalAmount = 0.0;
    
    NSMutableArray *allProfessionalSkills = [selectedUserDict valueForKey:selectedSubTypeofcare];
    
    for (int i = 0; i < allProfessionalSkills.count; i++) {
        
        NSMutableDictionary *dict = [allProfessionalSkills objectAtIndex:i];
        if ([[dict valueForKey:[NSString stringWithFormat:@"%d", i]] isEqualToString:@"checked"]) {
            
            totalAmount = totalAmount + [[dict valueForKey:@"rate"] floatValue];
        }
    }
    
    return [NSString stringWithFormat:@"%0.2f", totalAmount];
}


#pragma mark configure initial UI
-(void)configureUI
{
    self.imageView.layer.cornerRadius = 60;
    [self.imageView setClipsToBounds:YES];
    
    UIColor *color = [UIColor darkGrayColor];
    
    //--- Sales Reps Detail ---
    //--- configure Start Time text field ---
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_txtStartTime imageName:@"start" width:47];
        _txtStartTime.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Start Time" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_txtStartTime imageName:@"start" width:60];
        _txtStartTime.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Start Time" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_txtStartTime imageName:@"start" width:55];
        _txtStartTime.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Start Time" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    //--- configure End Time text field ---
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_txtEndTime imageName:@"end" width:47];
        _txtEndTime.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter End Time" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_txtEndTime imageName:@"end" width:60];
        _txtEndTime.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter End Time" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_txtEndTime imageName:@"end" width:55];
        _txtEndTime.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter End Time" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
}

- (void)dropInViewController:(BTDropInViewController *)viewController
  didSucceedWithTokenization:(BTPaymentMethodNonce *)paymentMethodNonce {
    // Send payment method nonce to your server for processing
    [self postNonceToServer:paymentMethodNonce.nonce];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dropInViewControllerDidCancel:(__unused BTDropInViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)userDidCancelPayment {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)postNonceToServer:(NSString *)paymentMethodNonce {

    
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable){
        kCustomAlertWithParamAndTarget(@"Message", @"Internet connection not available.", nil);
        return;
    }
    
    [kAppDelegete showHUDVIEW:self.view];
    
    //--- For new/existing appointment ---
    if (isBookedSucess) {
        
        if ([_txtStartTime.text length] == 0) {
            kCustomAlertWithParamAndTarget(@"Message", @"Please enter start time.", nil);
            return;
        }else if ([_txtEndTime.text length] == 0) {
            kCustomAlertWithParamAndTarget(@"Message", @"Please enter end time.", nil);
            return;
        }
    }
    
    
    NSInteger totalprice = [self.totalAmountTextField.text integerValue] + [self.tenPercentAmountTextField.text integerValue];
    
    //NSInteger totalprice = [self.totalAmountTextField.text integerValue];
    
    NSString *appointmentDate = [NSString stringWithFormat:@"%@ %@", [selectedAppointmentData valueForKey:@"date"], [selectedAppointmentData valueForKey:@"time"]];
    NSString *totalAmout = [NSString stringWithFormat:@"%0.2ld", (long)totalprice];
    
    if ([additional_requirements_str isKindOfClass:[NSString class]] && additional_requirements_str.length == 0) {
        additional_requirements_str = @"";
    }
    
    //{"title": "for something3971","type": "appointment","field_status":"active","booked_user": "429","start": "11/22/2016 17:16","end": "11/22/2016 22:16","paypal": "ZZCCX" }
    
    NSDictionary *parameters;
    
    if (isBookedSucess){
    
        parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                      @"Booking", @"title",
                      @"appointment", @"type",
                      @"active", @"field_status",
                      @"booking", @"appointment_type",
                      [selectedUserDict valueForKey:@"booked_user"], @"booked_user",
                      _txtStartTime.text, @"start",
                      _txtEndTime.text, @"end",
                      paymentMethodNonce, @"paypal",
                      [NSString stringWithFormat:@"%0.2f", [self.totalAmountTextField.text floatValue]], @"amount",
                      nil];
    }else{
    
        parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"Booking", @"title",
                                    @"appointment", @"type",
                                    @"booking", @"appointment_type",
                                    [selectedUserDict valueForKey:@"uid"], @"booked_user",
                                    appointmentDate, @"start",
                                    totalAmout, @"amount",
                                    @"", @"end",
                                    paymentMethodNonce, @"paypal",
                                    additional_requirements_str, @"additional_requirements",
                                    nil];
    }
        
    
    
    NSLog(@"parameters data :- %@", parameters);
    
    //--- For updating appoinments ---
    NSString *nodeId;
    if ([selectedUserDict valueForKey:@"nid"]) {
        nodeId = [selectedUserDict valueForKey:@"nid"];
    }else{
    
        nodeId = @"";
    }
    
    
    NSMutableDictionary *headers = [NSMutableDictionary new];
    if ([[CommonUtility sharedInstance].userDictionary valueForKey:@"token"]) {
        [headers setValue:[[CommonUtility sharedInstance].userDictionary valueForKey:@"token"] forKey:@"X-CSRF-Token"];
    }
    
    [[IQWebService service] submitApplication:headers parameters:parameters appointmentid:nodeId completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //---- Hide HUD View ---
        [kAppDelegete removeHUDVIEW];
        
        NSUInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
        if (!error && statusCode == 200) {
            
        
            NSError *error = nil;
            NSMutableArray * jsonObject = (NSMutableArray *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSLog(@"jsonObject :- %@", jsonObject);
            
            if ([[jsonObject valueForKey:@"success"] boolValue]) {
                
                if (isBookedSucess) {
                    kCustomAlertWithParamAndTarget(@"Message", @"Your appointment hours have been added successfully", nil);
                }else{
                    kCustomAlertWithParamAndTarget(@"Message", @"Your appointment have been submitted successfully", nil);
                }
                
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else{
            
                kCustomAlertWithParamAndTarget(@"Message", @"Your appointment have not been submitted successfully", nil);
            }
            
        } else {
            
            kCustomAlertWithParamAndTarget(@"Message", error.localizedDescription, nil);
            
            NSError *error = nil;
            NSDictionary * jsonObject = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSLog(@"jsonObject :- %@", jsonObject);
        }
    }];

}



#pragma mark textField delegate


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
   
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if ([textField isEqual:_txtStartTime])
    {
        [mydelegate get:[NSString stringWithFormat:@"%@%@", _txtStartTime.text, string] key:@"Start Time"];
    }
    else if ([textField isEqual:_txtEndTime])
    {
        [mydelegate get:[NSString stringWithFormat:@"%@%@", _txtEndTime.text, string] key:@"End Time"];
    }
    return YES;
}


- (IBAction)backBtnClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark PayPalPayment Configuration

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
}
-(NSDecimalNumber *)tenPercent
{
    return [_userRate decimalNumberByMultiplyingBy:(NSDecimalNumber *)[NSDecimalNumber numberWithDouble:0.10]];
}

- (IBAction)acceptAndConfirmPaymentButtonAction:(id)sender {
    
    //--- For new/existing appointment ---
    if (isBookedSucess) {
        
        if ([_txtStartTime.text length] == 0) {
            kCustomAlertWithParamAndTarget(@"Message", @"Please enter start time.", nil);
            return;
        }else if ([_txtEndTime.text length] == 0) {
            kCustomAlertWithParamAndTarget(@"Message", @"Please enter end time.", nil);
            return;
        }
    }
    
    BTDropInViewController *dropInViewController = [[BTDropInViewController alloc]
                                                    initWithAPIClient:self.braintreeClient];
    dropInViewController.delegate = self;
    
    // This is where you might want to customize your view controller (see below)
    
    // The way you present your BTDropInViewController instance is up to you.
    // In this example, we wrap it in a new, modally-presented navigation controller:
    UIBarButtonItem *item = [[UIBarButtonItem alloc]
                             initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                             target:self
                             action:@selector(userDidCancelPayment)];
    dropInViewController.navigationItem.leftBarButtonItem = item;
    UINavigationController *navigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:dropInViewController];
    [self presentViewController:navigationController animated:YES completion:nil];}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
