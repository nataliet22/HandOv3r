//
//  ConfirmationViewController.m
//  UNEYE
//
//  Created by AppTech_Mac1 on 4/18/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import "ConfirmationViewController.h"
#import "PaymentViewController.h"

@interface ConfirmationViewController () <CalenderPopUpViewControllerDelegate>{

    NSString *selectedDateInYYYYMMDD;
}

@end

@implementation ConfirmationViewController 
@synthesize searchType, isFromBookingList;
@synthesize imageView, bookBtn;
@synthesize selectedUserDict;
@synthesize additional_requirements_str;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageView.layer.cornerRadius = 60;
    [self.imageView setClipsToBounds:YES];
  
    if (selectedUserDict[@"Picture"] != nil || ![selectedUserDict[@"Picture"] isEqualToString:@""])
    {
        [self.imageView loadImage:selectedUserDict[@"Picture"]];
        //self.detailLbl.text = @"Sitter details as follows";
    }
    else if ([searchType isEqualToString:@"tutor"])
    {
        [self.imageView setImage:[UIImage imageNamed:@"tutor_option"] forState:UIControlStateNormal];
        //self.detailLbl.text = @"Tutor details as follows";
    }
    else if ([searchType isEqualToString:@"coach"])
    {
        [self.imageView setImage:[UIImage imageNamed:@"coach_option"] forState:UIControlStateNormal];
        //self.detailLbl.text = @"Coach details as follows";
    }
    
    //[self.detailLbl updateConstraints];
    
    if ([bookBtn.currentTitle isEqualToString:@"ADD TIME"]) {
        _confirmationLbl.hidden = YES;
    }else{
    
        _confirmationLbl.hidden = NO;
    }
    
    self.nameLabel.text = selectedUserDict[@"Name"];
    
    selectedDateInYYYYMMDD = _selectedAppointmentData[@"date"];
    
    NSDate *tempSelectedDate = [[self dateFormatter] dateFromString:_selectedAppointmentData[@"date"]];
    NSString *tempSelectedDateStr = [[self dateFormatterAsDDMMYYYY] stringFromDate:tempSelectedDate];
    
    //self.dateLabel.text = _selectedAppointmentData[@"date"];
    self.dateLabel.text = tempSelectedDateStr;
    self.timeLabel.text = _selectedAppointmentData[@"time"];
    
    //---- Change Booking button text accordingly ---
    if (isFromBookingList) {
        //[self.bookBtn setTitle:@"ADD MORE TIME" forState:UIControlStateNormal];
        self.confirmationLbl.hidden = YES;
        self.calenderBtn.hidden = YES;
        self.calenderHeaderLbl.hidden = YES;
        self.interViewBtn.hidden = YES;
        self.bookBtn.hidden = YES;
        self.addMoreTimeBtn.hidden = NO;
        
        _confirmationLbl.hidden = YES;
        
        if ([selectedUserDict[@"rate"] length] > 0) {
            
            NSString *rateLblStr = [NSString stringWithFormat:@"%@", selectedUserDict[@"rate"]];
            self.rateLabel.text = [NSString stringWithFormat:@"$ %0.2f", [rateLblStr floatValue]];
        }else{
            
            self.rateLabel.text = @"";
        }
        
    }else{
    
        self.confirmationLbl.hidden = NO;
        self.calenderBtn.hidden = NO;
        self.calenderHeaderLbl.hidden = NO;
        self.interViewBtn.hidden = NO;
        self.bookBtn.hidden = NO;
        self.addMoreTimeBtn.hidden = YES;
        
        _confirmationLbl.hidden = NO;
        
        if ([[self calculateTotalAmount] floatValue] > 0) {
            self.rateLabel.text = [NSString stringWithFormat:@"$ %@", [self calculateTotalAmount]];
        }else{
            
            self.rateLabel.text = @"";
        }
    }

}

- (NSString *)calculateTotalAmount{

    float totalAmount = 0.0;
    
    NSMutableArray *allProfessionalSkills = [selectedUserDict valueForKey:selectedSubTypeofcare];
    
    for (int i = 0; i < allProfessionalSkills.count; i++) {
        
        if(i > 0){
        
            //i = i - 1;
        }
            
                
        NSMutableDictionary *dict = [allProfessionalSkills objectAtIndex:i];
        if ([[dict valueForKey:[NSString stringWithFormat:@"%d", i]] isEqualToString:@"checked"]) {
            
            totalAmount = totalAmount + [[dict valueForKey:@"rate"] floatValue];
        }
    }
    
    return [NSString stringWithFormat:@"%0.2f", totalAmount];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bookOrAddMoreTimeBtnClicked:(id)sender {
    
    [self performSegueWithIdentifier:@"paymentscreenseque" sender:nil];
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"paymentscreenseque"])
    {
        PaymentViewController *PaymentVC = (PaymentViewController *)segue.destinationViewController;

        PaymentVC.searchType = searchType;
        PaymentVC.selectedUserDict = selectedUserDict;
        PaymentVC.selectedAppointmentData = _selectedAppointmentData;
        PaymentVC.additional_requirements_str = additional_requirements_str;
       
        //--- For Adding more additional time within any appointment ---
        if (isFromBookingList){ //([bookBtn.currentTitle isEqualToString:@"ADD MORE TIME"]) {
            PaymentVC.isBookedSucess = YES;
        }else{
            
            PaymentVC.isBookedSucess = NO;
        }
    }
    
}
- (IBAction)updateCalender:(id)sender
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    CalenderPopUpViewController *objCalenderPopUpViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"CalenderPopUpViewController"];
    objCalenderPopUpViewController.mydelegate = self;
    [objCalenderPopUpViewController.calendarManager setDate:[[self dateFormatter]dateFromString:_selectedAppointmentData[@"date"]]];
    [objCalenderPopUpViewController resignFirstResponder];
    [objCalenderPopUpViewController showInView:self.view animated:YES];
    
    [self addChildViewController:objCalenderPopUpViewController];
    
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

- (IBAction)backBtnClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    CalenderPopUpViewController *objCalenderPopUpViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"CalenderPopUpViewController"];
    objCalenderPopUpViewController.mydelegate = self;
    
    [objCalenderPopUpViewController resignFirstResponder];
    [objCalenderPopUpViewController showInView:self.view animated:YES];
    
    [self addChildViewController:objCalenderPopUpViewController];

}

- (void)getSelectedItems:(NSString *)selectedDate
{
    if (selectedDate != nil) {
        
        selectedDateInYYYYMMDD = selectedDate;
        
        NSDate *tempSelectedDate = [[self dateFormatter] dateFromString:selectedDate];
        NSString *tempSelectedDateStr = [[self dateFormatterAsDDMMYYYY] stringFromDate:tempSelectedDate];
        
        self.dateLabel.text = tempSelectedDateStr;
        
        [_selectedAppointmentData setValue:selectedDate forKey:@"date"];
    }
}

- (IBAction)interviewBtnClicked:(id)sender {
    
    [self interViewScheduleAPICall];
}

- (void)interViewScheduleAPICall {
    
    
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable){
        kCustomAlertWithParamAndTarget(@"Message", @"Internet connection not available.", nil);
        return;
    }
    
    [kAppDelegete showHUDVIEW:self.view];
    
    NSInteger totalprice = [self.rateLabel.text integerValue];
    
    //NSInteger totalprice = [self.totalAmountTextField.text integerValue];
    
    //NSString *appointmentDate = [NSString stringWithFormat:@"%@ %@", _dateLabel.text, _timeLabel.text];
    NSString *appointmentDate = [NSString stringWithFormat:@"%@ %@", selectedDateInYYYYMMDD, _timeLabel.text];
    NSString *totalAmout = [NSString stringWithFormat:@"%ld", (long)totalprice];
    
    if ([additional_requirements_str length] == 0) {
        additional_requirements_str = @"";
    }
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                      @"Booking", @"title",
                      @"appointment", @"type",
                      @"interview", @"appointment_type",
                      [selectedUserDict valueForKey:@"uid"], @"booked_user",
                      appointmentDate, @"start",
                      totalAmout, @"amount",
                      @"", @"end",
                      @"", @"paypal",
                      additional_requirements_str, @"additional_requirements",
                      nil];
    
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
               
                kCustomAlertWithParamAndTarget(@"Message", @"Your appointment have been submitted successfully", nil);
                
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else{
                
                //kCustomAlertWithParamAndTarget(@"Message", @"Your appointment have not been submitted successfully", nil);
                kCustomAlertWithParamAndTarget(@"Message", @"Your appointment have been submitted successfully", nil);
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            
        } else {
            
            kCustomAlertWithParamAndTarget(@"Message", error.localizedDescription, nil);
            
            NSError *error = nil;
            NSDictionary * jsonObject = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSLog(@"jsonObject :- %@", jsonObject);
        }
    }];
    
}


@end
