//
//  CalenderCell.h
//  UNEYE
//
//  Created by AppTech_Mac1 on 4/8/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTextField.h"
#import "CommonUtility.h"


@protocol CalendercellDelegate <NSObject>
@required
- (void)get:(NSString *)text key:(NSString *)key;
- (void)selectedDates:(NSMutableArray *)dateArray key:(NSString *)key;
@end

@interface CalenderCell : UITableViewCell<JTCalendarDelegate>{
    
    NSMutableDictionary *_eventsByDate;
    NSMutableArray *_datesSelected;
}

@property (weak, nonatomic) IBOutlet AsyncImageView *videoThumpBtn;

@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;

@property (strong, nonatomic) JTCalendarManager *calendarManager;
@property (strong, nonatomic) MyTextField *dummyTextField;

@property (nonatomic, weak) id <CalendercellDelegate> mydelegate;

@end
