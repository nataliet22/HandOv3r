//
//  CalenderViewController.h
//  UNEYE
//
//  Created by Satya Kumar on 18/03/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface CalenderViewController : BaseViewController<JTCalendarDelegate>

@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;

@property (strong, nonatomic) JTCalendarManager *calendarManager;

@end
