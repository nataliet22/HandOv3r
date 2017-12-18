//
//  BookingsViewController.m
//  UNEYE
//
//  Created by Satya Kumar on 10/03/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import "BookingsViewController.h"
#import "CustomCell.h"
#import "SendMessageViewController.h"
#import "ConfirmationViewController.h"

@interface BookingsViewController (){

    NSString *recipientId;
    NSString *recipientPic;
    
    NSDictionary *bookingDetailDict;
}
@property (weak, nonatomic) IBOutlet UIView *bookingTitle_View;
@property (strong,nonatomic) NSMutableArray *bookingDataArray;
@property (weak, nonatomic) IBOutlet UITableView *bookingTableView;
@end

@implementation BookingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _bookingDataArray = [NSMutableArray new];
    // Do any additional setup after loading the view.
    
    if (IS_IPHONE_6) {
        _bookingTitle_View.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addConstraints:[NSLayoutConstraint
                                   constraintsWithVisualFormat:@"H:[_bookingTitle_View(==140)]-|"
                                   options:NSLayoutFormatDirectionLeadingToTrailing
                                   metrics:nil
                                   views:NSDictionaryOfVariableBindings(_bookingTitle_View)]];
    }else if (IS_IPHONE_6P) {
        _bookingTitle_View.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addConstraints:[NSLayoutConstraint
                                   constraintsWithVisualFormat:@"H:[_bookingTitle_View(==160)]-|"
                                   options:NSLayoutFormatDirectionLeadingToTrailing
                                   metrics:nil
                                   views:NSDictionaryOfVariableBindings(_bookingTitle_View)]];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getAllBookings];
    
}

#pragma mark web services
-(void)getAllBookings {
    
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable){
        kCustomAlertWithParamAndTarget(@"Message", @"Internet connection not available.", nil);
        return;
    }
    
    [kAppDelegete showHUDVIEW:self.view];
    
   
    [[IQWebService service]getBookingsWithcompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
      
        //---- Hide HUD View ---
        [kAppDelegete removeHUDVIEW];
        
        NSUInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
        if (!error && statusCode == 200) {
            
            //--- Get login token ---Json error :- (null)
            NSError *error = nil;
            NSMutableArray * jsonObject = (NSMutableArray *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSLog(@"jsonObject :- %@", jsonObject);
            
            if ([_bookingDataArray count] > 0 && [[jsonObject valueForKey:@"results"] count] > 0) {
                [_bookingDataArray removeAllObjects];
            }
            
            [_bookingDataArray addObjectsFromArray:[jsonObject valueForKey:@"results"]];
            
            [self reloadTableWithFilter];
            
        } else {
            
            kCustomAlertWithParamAndTarget(@"Message", error.localizedDescription, nil);
        }

    }];
    
}

-(void)cancelBooking:(NSString *)bookingid param:(NSDictionary *)param{
    
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable){
        kCustomAlertWithParamAndTarget(@"Message", @"Internet connection not available.", nil);
        return;
    }
    
    [kAppDelegete showHUDVIEW:self.view];
    
    [[IQWebService service] cancelBooking:bookingid parameters:param CompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //---- Hide HUD View ---
        [kAppDelegete removeHUDVIEW];
        
        NSUInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
        if (!error && statusCode == 200) {
            
            //--- Get login token ---Json error :- (null)
            NSError *error = nil;
            NSMutableArray * jsonObject = (NSMutableArray *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSLog(@"jsonObject :- %@", jsonObject);
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:
                                      @"nid like %@", [jsonObject valueForKey:@"nid"]];
            NSArray *filteredArr = [_bookingDataArray filteredArrayUsingPredicate:predicate];
            
            NSLog(@"firstObject :- %@", [filteredArr firstObject]);
            NSLog(@"firstObject Index:- %lu", (unsigned long)[_bookingDataArray indexOfObject:[filteredArr firstObject]]);
            
            NSInteger indexofDict = [_bookingDataArray indexOfObject:[filteredArr firstObject]];
            NSMutableDictionary *tempDict = [NSMutableDictionary dictionaryWithDictionary:[filteredArr firstObject]];
            [tempDict setValue:@"closed" forKey:@"Status"];
            
            [_bookingDataArray replaceObjectAtIndex:indexofDict withObject:tempDict];
            
            [self reloadTableWithFilter];
            
        } else {
            
            kCustomAlertWithParamAndTarget(@"Message", error.localizedDescription, nil);
        }
    }];
}

-(void)getBookingDetail:(NSString *)bookingId{
    
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable){
        kCustomAlertWithParamAndTarget(@"Message", @"Internet connection not available.", nil);
        return;
    }
    
    [kAppDelegete showHUDVIEW:self.view];
    
    [[IQWebService service] getBookingDetail:bookingId CompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //---- Hide HUD View ---
        [kAppDelegete removeHUDVIEW];
        
        NSUInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
        if (!error && statusCode == 200) {
            
            //--- Get login token ---
            NSError *error = nil;
            NSDictionary * jsonObject = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSLog(@"jsonObject :- %@", jsonObject);
            
            bookingDetailDict = [[jsonObject valueForKey:@"results"] firstObject];
            
            [self performSegueWithIdentifier:@"updatebooking" sender:nil];
            
        }else {
            
            kCustomAlertWithParamAndTarget(@"Message", error.localizedDescription, nil);
        }
    }];
}

#pragma mark relaad table with filter
-(void)reloadTableWithFilter{

    //---- Fillter Active bookings ----
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Status = %@", @"active"];
    NSArray *filteredArr = [_bookingDataArray filteredArrayUsingPredicate:predicate];
    
    if ([_bookingDataArray count] > 0) {
        [_bookingDataArray removeAllObjects];
    }
    
    [_bookingDataArray addObjectsFromArray:filteredArr];
    
    NSLog(@"_bookingDataArray reloadTableWithFilter :- %@", _bookingDataArray);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.bookingTableView reloadData];
        
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"messagefrombooking"]) {
        
        SendMessageViewController *objSendMessageViewController = (SendMessageViewController *)[segue destinationViewController];
        objSendMessageViewController.recipientId = recipientId;
        objSendMessageViewController.recipientPic = recipientPic;
    }else if ([segue.identifier isEqualToString:@"updatebooking"]){
    
        ConfirmationViewController *objConfirmationViewController = (ConfirmationViewController *)[segue destinationViewController];
        objConfirmationViewController.isFromBookingList = YES;
        
        NSString *userProfilePic = [bookingDetailDict valueForKey:@"picture_bookeduser"];
        if ([userProfilePic length] == 0) {
            userProfilePic = @"";
        }
        
        NSMutableDictionary *selectedDict = [NSMutableDictionary dictionaryWithDictionary:@{@"Name" : [bookingDetailDict valueForKey:@"name_bookeduser"], @"booked_user" : [bookingDetailDict valueForKey:@"booked user"], @"Picture" : userProfilePic, @"rate" : [bookingDetailDict valueForKey:@"rate"], @"nid" : [bookingDetailDict valueForKey:@"nid"]}];
  
        NSString *dateStr = [[[bookingDetailDict valueForKey:@"date"] componentsSeparatedByString:@"to"] firstObject];
        
        NSString *date = [[dateStr componentsSeparatedByString:@" "] firstObject];
        
        //--- Truncate last blank space ---
        NSString *value = [[dateStr substringToIndex:[dateStr length] - 1] substringFromIndex:0];

        NSString *time = [[value componentsSeparatedByString:@" "] lastObject];
        
        objConfirmationViewController.selectedUserDict = selectedDict;
        objConfirmationViewController.selectedAppointmentData =  [NSMutableDictionary dictionaryWithDictionary:@{ @"date" : date, @"time" : time}];
        objConfirmationViewController.additional_requirements_str = [bookingDetailDict valueForKey:@"additional requirements"];
        [objConfirmationViewController.bookBtn setTitle:@"ADD TIME" forState:UIControlStateNormal];
    }
}


#pragma mark tableview delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _bookingDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *MyIdentifier;
    MyIdentifier = @"customCell";
    CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault
                                 reuseIdentifier:MyIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.accessoryImageView.hidden = YES;
    
    cell.btnMessage.hidden = NO;
    cell.btnCancelOrBook.hidden = NO;
    
    cell.btnMessage.tag =  indexPath.row;
    cell.btnCancelOrBook.tag =  indexPath.row;
    
    [cell.btnMessage addTarget:self action:@selector(messageBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnCancelOrBook addTarget:self action:@selector(cancelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([_bookingDataArray[indexPath.row] valueForKey:@"name_bookeduser"]) {
    
        cell.lblTitle.text = [_bookingDataArray[indexPath.row] valueForKey:@"name_bookeduser"];
    }else{
    
        cell.lblTitle.text = @"";
    }
        
    NSString *appointmentDate;
    if ([_bookingDataArray[indexPath.row] valueForKey:@"date"]) {
        NSArray *temp = [[_bookingDataArray[indexPath.row] valueForKey:@"date"] componentsSeparatedByString:@"to"];
        appointmentDate = [temp firstObject];
    }else{
    
        appointmentDate = @"";
    }
    
    NSString *appointmentType = @"";
    
    if ([[_bookingDataArray[indexPath.row] valueForKey:@"appointment_type"] isKindOfClass:[NSString class]]) {
        if ([[_bookingDataArray[indexPath.row] valueForKey:@"appointment_type"] length] > 0) {
            
            if ([[_bookingDataArray[indexPath.row] valueForKey:@"appointment_type"] isEqualToString:@"interview"]) {
                appointmentType = [NSString stringWithFormat:@"Type : %@", @"Interview"];
            }else{
            
                 appointmentType = [NSString stringWithFormat:@"Type : %@", @"Booking"];
            }
        }else{
            appointmentType = @"";
        }
    }
    
    cell.lblDetailText.text = [NSString stringWithFormat:@"%@\n%@", appointmentDate, appointmentType];
    
    cell.userImageView.layer.cornerRadius = 40;
    [cell.userImageView setClipsToBounds:YES];
    
    [cell.userImageView loadImage:[_bookingDataArray[indexPath.row] valueForKey:@"picture_bookeduser"]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //--- Get Booking Detail ---
    NSString *bookingId = [_bookingDataArray[indexPath.row] valueForKey:@"nid"];
    [self getBookingDetail:bookingId];
}


-(void)messageBtnClicked:(id)sender{

    UIButton *button = (UIButton *)sender;
    recipientId = [[_bookingDataArray objectAtIndex:button.tag] valueForKey:@"booked user"];
    recipientPic = [[_bookingDataArray objectAtIndex:button.tag] valueForKey:@"picture_bookeduser"];
    [self performSegueWithIdentifier:@"messagefrombooking" sender:nil];
}

-(void)cancelBtnClicked:(id)sender{
    
    UIButton *button = (UIButton *)sender;
    NSString *bookingid = [[_bookingDataArray objectAtIndex:button.tag] valueForKey:@"nid"];
    
    NSDictionary *param = @{@"type" : @"appointment", @"field_status" : @"closed"};

    [self cancelBooking:bookingid param:param];
}

@end
