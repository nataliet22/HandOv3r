//
//  CalenderPopUpViewController.h
//  UNEYE
//
//  Created by Satya Kumar on 30/05/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol CalenderPopUpViewControllerDelegate <NSObject>
@required
//- (void)reloaddata;
- (void)getSelectedItems:(NSString *)selectedDate;
@end

@interface CalenderPopUpViewController : UIViewController<JTCalendarDelegate>{

    NSMutableDictionary *_eventsByDate;
    NSDate *_dateSelected;
}

@property (weak, nonatomic) IBOutlet UIView *popUpView;
@property (nonatomic, weak) id <CalenderPopUpViewControllerDelegate> mydelegate;

@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;

@property (strong, nonatomic) JTCalendarManager *calendarManager;

- (void)showInView:(UIView *)aView animated:(BOOL)animated;

@end
