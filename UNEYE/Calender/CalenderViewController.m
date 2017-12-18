//
//  CalenderViewController.m
//  UNEYE
//
//  Created by Satya Kumar on 18/03/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import "CalenderViewController.h"

@interface CalenderViewController (){

    NSMutableDictionary *_eventsByDate;
    NSMutableArray *_datesSelected;
}

@end

@implementation CalenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _calendarManager = [JTCalendarManager new];
    _calendarManager.delegate = self;
    
//    // Generate random events sort by date using a dateformatter for the demonstration
//    [self createRandomEvents];
    
    [_calendarManager setMenuView:_calendarMenuView];
    [_calendarManager setContentView:_calendarContentView];
    [_calendarManager setDate:[NSDate date]];
    
    _datesSelected = [NSMutableArray new];
    
    [self initCalenderView];
    
//    //--- Get all available dates from API --
//    [self getAllBookings];
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    //--- Get all events from API --
    [self getAllEvents];
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

#pragma mark - IBActions
- (IBAction)addEvent:(id)sender {
    
    [self performSegueWithIdentifier:@"addeventsegue" sender:nil];
    
}

-(void)submitEvent{

    
}

#pragma mark - Load Calender View
- (void)initCalenderView{

//    _calendarManager = [JTCalendarManager new];
//    _calendarManager.delegate = self;
    
    // Generate random events sort by date using a dateformatter for the demonstration
    //[self createRandomEvents];
    
    [_calendarManager setMenuView:_calendarMenuView];
    [_calendarManager setContentView:_calendarContentView];
    [_calendarManager setDate:[NSDate date]];
    
    _datesSelected = [NSMutableArray new];
    
}


#pragma mark - CalendarManager delegate
// Exemple of implementation of prepareDayView method
// Used to customize the appearance of dayView
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    // Today
    if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor blueColor];
        dayView.dotView.backgroundColor = [UIColor clearColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Selected date
    else if([self isInDatesSelected:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:184.0/255.0 blue:64.0/255.0 alpha:1.0]; //[UIColor redColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Other month
    else if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor lightGrayColor];
    }
    // Another day of the current month
    else{
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor blackColor];
    }
    
    if([self haveEventForDay:dayView.date]){
        dayView.dotView.hidden = NO;
    }
    else{
        dayView.dotView.hidden = YES;
    }
    
//    if([self haveEventForDay:dayView.date]){
//        dayView.dotView.hidden = YES;
//        dayView.circleView.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:184.0/255.0 blue:64.0/255.0 alpha:1.0];
//    }
//    else{
//        dayView.dotView.hidden = YES;
//        //dayView.circleView.backgroundColor = [UIColor clearColor];
//    }
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    if([self isInDatesSelected:dayView.date]){
        [_datesSelected removeObject:dayView.date];
        
        [UIView transitionWithView:dayView
                          duration:.3
                           options:0
                        animations:^{
                            [_calendarManager reload];
                            //dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
                        } completion:nil];
    }
    else{
        [_datesSelected addObject:dayView.date];
        
        dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
        [UIView transitionWithView:dayView
                          duration:.3
                           options:0
                        animations:^{
                            [_calendarManager reload];
                            dayView.circleView.transform = CGAffineTransformIdentity;
                        } completion:nil];
    }
    
    
    // Load the previous or next page if touch a day from another month
    
    if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        if([_calendarContentView.date compare:dayView.date] == NSOrderedAscending){
            [_calendarContentView loadNextPageWithAnimation];
        }
        else{
            [_calendarContentView loadPreviousPageWithAnimation];
        }
    }
}

#pragma mark - Date selection

- (BOOL)isInDatesSelected:(NSDate *)date
{
    for(NSDate *dateSelected in _datesSelected){
        if([_calendarManager.dateHelper date:dateSelected isTheSameDayThan:date]){
            return YES;
        }
    }
    
    return NO;
}

#pragma mark - Fake data

// Used only to have a key for _eventsByDate
- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd";
    }
    
    return dateFormatter;
}

- (BOOL)haveEventForDay:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    
    if(_eventsByDate[key] && [_eventsByDate[key] count] > 0){
        return YES;
    }
    
    return NO;
    
}

- (void)createRandomEvents
{
    _eventsByDate = [NSMutableDictionary new];
    
    for(int i = 0; i < 30; ++i){
        // Generate 30 random dates between now and 60 days later
        NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];
        
        // Use the date as key for eventsByDate
        NSString *key = [[self dateFormatter] stringFromDate:randomDate];
        
        if(!_eventsByDate[key]){
            _eventsByDate[key] = [NSMutableArray new];
        }
        
        [_eventsByDate[key] addObject:randomDate];
    }
}

-(void)getAllAvailableDates:(NSArray *)availableDatesArray{

    _eventsByDate = [NSMutableDictionary new];
    
    for (NSDictionary *itemDict in availableDatesArray) {
        
        NSString *availDateStr = [itemDict valueForKey:@"date"];
        NSArray *tempArr = [availDateStr componentsSeparatedByString:@"to"];
        
//        NSRange range = NSMakeRange(0,1);
//        NSString *finalDateStr = [[NSString stringWithFormat:@"%@", [tempArr firstObject]] stringByReplacingCharactersInRange:range withString:@""];
        
        NSString *finalDateStr = [NSString stringWithFormat:@"%@", [tempArr firstObject]];
        
        NSDate *date = [[NSDate alloc] init];
        
        //2016-08-24 16:43:12 +0000
        //08/24/2016 17:25
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
        
        date = [dateFormatter dateFromString:finalDateStr];
       
        // Use the date as key for eventsByDate
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *key = [dateFormatter stringFromDate:date];
        
        if(!_eventsByDate[key]){
            _eventsByDate[key] = [NSMutableArray new];
        }
        
        [_eventsByDate[key] addObject:date];
        
        [_datesSelected addObject:date];
    }
    
    //[self initCalenderView];
    
//    [_calendarManager setMenuView:_calendarMenuView];
//    [_calendarManager setContentView:_calendarContentView];
//    [_calendarManager setDate:[NSDate date]];
    
    [_calendarManager reload];
    
    /*Issue at API side :- 
     
     2017-06-05 19:14:09.712 UNEYE[1755:156928] 21/06/2017
     2017-06-05 19:14:09.712 UNEYE[1755:156928] event paramDict :- {
     date = "21/06/2017 15:12";
     "field_venue" = NNN;
     title = CCCC;
     type = event;
     }
     2017-06-05 19:14:09.714 UNEYE[1755:156928] Json error :- (null)
     2017-06-05 19:14:09.715 UNEYE[1755:156928] urlString :- http://162.208.11.30/sitter/apiv1/node
     2017-06-05 19:14:10.558 UNEYE[1755:156928] jsonObject :- {
     nid = 94;
     uri = "http://162.208.11.30/sitter/apiv1/node/94";
     }
     2017-06-05 19:14:10.561 UNEYE[1755:156928] urlString :- http://162.208.11.30/sitter/apiv1/events
     2017-06-05 19:14:11.108 UNEYE[1755:156928] jsonObject :- {
     metadata =     {
     "current_page" = 0;
     "display_end" = 4;
     "display_start" = 1;
     "items_per_page" = 10;
     "total_pages" = 1;
     "total_results" = 4;
     };
     results =     (
     {
     "Post date" = "06/05/2017 - 19:14";
     Type = event;
     date = "1970-01-01 05:30:00 to 2017-06-05 13:44:10";
     nid = 94;
     title = CCCC;
     venue = NNN;
     },
     {
     "Post date" = "06/05/2017 - 18:57";
     Type = event;
     date = "1970-01-01 05:30:00 to 2017-06-05 13:27:43";
     nid = 93;
     title = bbbb;
     venue = yyyy;
     },
     {
     "Post date" = "06/05/2017 - 18:46";
     Type = event;
     date = "1970-01-01 05:30:00 to 2017-06-05 13:16:34";
     nid = 92;
     title = "My event14";
     venue = AAAAA;
     },
     {
     "Post date" = "06/04/2017 - 15:41";
     Type = event;
     date = "2017-06-06 19:10:00 to 2017-06-04 10:11:13";
     nid = 89;
     title = "babysitting ";
     venue = "Mosman ";
     }
     );
     }

     
     */
}

#pragma mark web services
#pragma mark get All Bookings web services
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
            
            //2016-08-24 16:43:12 +0000
            [self getAllAvailableDates:[jsonObject valueForKey:@"results"]];
            
        } else {
            
            kCustomAlertWithParamAndTarget(@"Message", error.localizedDescription, nil);
        }
    }];
}

#pragma mark get All Events web services
-(void)getAllEvents {
    
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable){
        kCustomAlertWithParamAndTarget(@"Message", @"Internet connection not available.", nil);
        return;
    }
    
    [kAppDelegete showHUDVIEW:self.view];
    
    
    [[IQWebService service]getAllEventCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //---- Hide HUD View ---
        [kAppDelegete removeHUDVIEW];
        
        NSUInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
        if (!error && statusCode == 200) {
            
            //--- Get login token ---Json error :- (null)
            NSError *error = nil;
            NSMutableArray * jsonObject = (NSMutableArray *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSLog(@"jsonObject :- %@", jsonObject);
            
            //2016-08-24 16:43:12 +0000
            [self getAllAvailableDates:[jsonObject valueForKey:@"results"]];
            
        } else {
            
            kCustomAlertWithParamAndTarget(@"Message", error.localizedDescription, nil);
        }
    }];
}

@end
