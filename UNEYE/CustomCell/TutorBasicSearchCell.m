//
//  TutorBasicSearchCell.m
//  UNEYE
//
//  Created by AppTech_Mac1 on 4/12/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import "TutorBasicSearchCell.h"

@implementation TutorBasicSearchCell
{
    NSMutableDictionary *items;
}
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
        [CommonUtility setLeftPadding:_postCode imageName:@"postcode" width:47];
        _postCode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Postcode" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_postCode imageName:@"postcode" width:60];
        _postCode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Postcode" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_postCode imageName:@"postcode" width:55];
        _postCode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Postcode" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    //--- configure Lavel Of Study text field ---
    [CommonUtility setRightPadding:_lavelOfStudy imageName:@"drop_btn" width:50];
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    
    UIBarButtonItem *buttonflexibleLvlStd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *buttonDoneLvlStd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    buttonDoneLvlStd.tag = 0;
    [toolbar setItems:[NSArray arrayWithObjects:buttonflexibleLvlStd,buttonDoneLvlStd, nil]];
    
    //NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"QualificationList" ofType:@"plist"];
    
    //--- New Qualification List ---
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Qualifications2" ofType:@"plist"];
    items = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    
    _lavelOfStudy.inputAccessoryView = toolbar;
    _lavelOfStudy.isOptionalDropDown = NO;
    
    //[_lavelOfStudy setItemList:items.allKeys.reverseObjectEnumerator.allObjects];
    
    NSArray *moreStudyLavel =  [NSArray arrayWithObjects:@"Aboriginal Studies",
                                 @"Accounting - Tertiary",
                                 @"Agriculture",
                                 @"Ancient History",
                                 @"Arabic Language",
                                 @"Arts - Tertiary",
                                 @"Bengali Language",
                                 @"Biology",
                                 @"Business Studies",
                                 @"Cantonese Language",
                                 @"Chemistry",
                                 @"Clarinet",
                                 @"Commerce - Tertiary",
                                 @"Communications - Tertiary",
                                 @"Community and Family Studies",
                                 @"Computer Science - Tertiary",
                                 @"Dance",
                                 @"Dentistry - Tertiary",
                                 @"Design and Technology(DT)",
                                 @"Drama",
                                 @"Drums",
                                 @"Earth and Environmental Science",
                                 @"Economics",
                                 @"Education - Tertiary",
                                 @"Engineering - Tertiary",
                                 @"Engineering Studies",
                                 @"English - Primary",
                                 @"English (Advanced)",
                                 @"English (Standard)",
                                 @"English Language",
                                 @"Environmental Science - Tertiary",
                                 @"Finance - Tertiary",
                                 @"Flute",
                                 @"Food Technology",
                                 @"French Language",
                                 @"Geography",
                                 @"German Language",
                                 @"Guitar - Bass",
                                 @"Guitar - Classical",
                                 @"Guitar - Electric",
                                 @"Hindi Language",
                                 @"History - Tertiary",
                                 @"History Extension",
                                 @"HSC English Extension 1",
                                 @"HSC English Extension 2",
                                 @"Industrial Technology",
                                 @"Information Processes and Technology",
                                 @"Italian Language",
                                 @"Japanese Language",
                                 @"Keyboard",
                                 @"Law - Tertiary",
                                 @"Legal Studies",
                                 @"Mandarin Language",
                                 @"Marketing - Tertiary",
                                 @"Mathematics",
                                 @"Mathematics - Primary",
                                 @"Mathematics Extension 1",
                                 @"Mathematics Extension 2",
                                 @"Mathematics General",
                                 @"Medicine - Tertiary",
                                 @"Modern History",
                                 @"Music - Tertiary",
                                 @"Music 1",
                                 @"Music 2",
                                 @"Music Extension",
                                 @"Personal Development, Health and Physical Education (PDHPE)",
                                 @"Pharmacy - Tertiary",
                                 @"Physics",
                                 @"Physiotherapy - Tertiary",
                                 @"Piano",
                                 @"Preliminary English Extension",
                                 @"Quantitative Finance - Tertiary",
                                 @"Recorder",
                                 @"Russian Language",
                                 @"Science - General",
                                 @"Science - Tertiary",
                                 @"Senior Science",
                                 @"Society and Culture",
                                 @"Software Design and Development",
                                 @"Software Development - Tertiary",
                                 @"Spanish Language",
                                 @"Statistics - Tertiary ",
                                 @"Studies of Religion I",
                                 @"Studies of Religion II",
                                 @"Textiles and Design",
                                 @"Veterinary Science - Tertiary",
                                 @"Violin",
                                 @"Visual Arts",
                                 @"Voice Coach", nil];
    
    NSMutableArray *allStudyLavels = [[NSMutableArray alloc] initWithArray:items.allKeys.reverseObjectEnumerator.allObjects];
    [allStudyLavels addObjectsFromArray:moreStudyLavel];
    [_lavelOfStudy setItemList:allStudyLavels];
    
    [_lavelOfStudy setDropDownMode:IQDropDownModeDateTimePicker];
    //[[CommonUtility sharedInstance] addScreenDataInfo:@"Primary Education" key:searchPrimaryEducation];
    [[CommonUtility sharedInstance] addScreenDataInfo:@"Aboriginal Studies" key:searchSubTypeofcare];
    _lavelOfStudy.delegate = self;
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_lavelOfStudy imageName:@"study" width:47];
        _lavelOfStudy.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Lavel Of Study" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_lavelOfStudy imageName:@"study" width:60];
        _lavelOfStudy.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Lavel Of Study" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_lavelOfStudy imageName:@"study" width:55];
        _lavelOfStudy.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Lavel Of Study" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    //--- configure Area Of Study text field ---
    [CommonUtility setRightPadding:_areaOfStudy imageName:@"drop_btn" width:50];
    
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_areaOfStudy imageName:@"study" width:47];
        _areaOfStudy.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Area Of Study" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_areaOfStudy imageName:@"study" width:60];
        _areaOfStudy.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Area Of Study" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_areaOfStudy imageName:@"study" width:55];
        _areaOfStudy.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Area Of Study" attributes:@{NSForegroundColorAttributeName: color}];
    }

    
    UIBarButtonItem *buttonflexibleAreaStd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *buttonDoneAreaStd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    buttonDoneLvlStd.tag = 1;
    [toolbar setItems:[NSArray arrayWithObjects:buttonflexibleAreaStd, buttonDoneAreaStd, nil]];
    
    _areaOfStudy.inputAccessoryView = toolbar;
    _areaOfStudy.isOptionalDropDown = NO;
    [_areaOfStudy setItemList:[NSArray arrayWithArray:[items valueForKey:@"Primary Education"]]];
    [_areaOfStudy setDropDownMode:IQDropDownModeDateTimePicker];
    //[[CommonUtility sharedInstance] addScreenDataInfo:[[items valueForKey:@"Primary Education"] firstObject] key:searchPrimaryEducation];
    [[CommonUtility sharedInstance] addScreenDataInfo:@"Aboriginal Studies" key:searchSubTypeofcare];
    _areaOfStudy.delegate = self;
    
    [_areaOfStudy setItemList:moreStudyLavel];
    
    
    
    //--- configure Date text field ---
    [CommonUtility setRightPadding:_date imageName:@"drop_btn" width:50];
    
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_date imageName:@"date" width:47];
        _date.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Date" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_date imageName:@"date" width:60];
        _date.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Date" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_date imageName:@"date" width:55];
        _date.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Date" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    //--- configure Time text field ---
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_time imageName:@"time" width:47];
        _time.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Time" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_time imageName:@"time" width:60];
        _time.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Time" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_time imageName:@"time" width:55];
        _time.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Time" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    [CommonUtility setRightPadding:_time imageName:@"drop_btn" width:50];
    
    UIBarButtonItem *buttonflexibleTime = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *buttonDoneTime = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    buttonDoneTime.tag = 2;
    [toolbar setItems:[NSArray arrayWithObjects:buttonflexibleTime,buttonDoneTime, nil]];
    
    _time.inputAccessoryView = toolbar;
    
    UIDatePicker *timePicker = [[UIDatePicker alloc] init];
    timePicker.frame = CGRectMake(0, CGRectGetMaxY(self.frame)-200, self.frame.size.width, 200.0f);
    timePicker.datePickerMode = UIDatePickerModeCountDownTimer;
    [timePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    
    [_time setInputView:timePicker];
}

- (void)dateChanged:(UIDatePicker*)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *currentTime = [dateFormatter stringFromDate:sender.date];
    NSLog(@"%@", currentTime);
    
    _time.text = currentTime;
}

#pragma mark textField delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
//    MyTextField *txtFld = (MyTextField *)textField;
//    if (txtFld == _date)
//    {
//        [_date resignFirstResponder];
//        [mydelegate get:@"" key:searchDate];
//    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([textField isEqual:_postCode])
    {
        [mydelegate get:newString key:@"Postcode"];
    }
    
    return YES;
}

#pragma mark dropdown textField delegate
-(void)doneClicked:(UIBarButtonItem*)button
{
    [self endEditing:YES];
    
       // [mydelegate get:[NSString stringWithFormat:@"%@", _areaOfStudy.selectedItem] key:_lavelOfStudy.selectedItem];
        [mydelegate get:[NSString stringWithFormat:@"%@", _areaOfStudy.selectedItem] key:_areaOfStudy.selectedItem];
        [mydelegate get:_time.text key:searchTime];
}

-(void)textField:(IQDropDownTextField *)textField didSelectItem:(NSString *)item
{
    
    if ([textField isEqual:_areaOfStudy]) {
        return;
    }
    
    _areaOfStudy.enabled = YES;
    
    if ([item isEqualToString:items.allKeys.firstObject])
    {
        [_areaOfStudy setItemList:[NSArray arrayWithArray:[items valueForKey:items.allKeys.firstObject]]];

    }else if ([item isEqualToString:items.allKeys[1]])
    {
        [_areaOfStudy setItemList:[NSArray arrayWithArray:[items valueForKey:items.allKeys[1]]]];

        
    }else if ([item isEqualToString:items.allKeys[2]])
    {
        [_areaOfStudy setItemList:[NSArray arrayWithArray:[items valueForKey:items.allKeys[2]]]];

        
    }else if ([item isEqualToString:items.allKeys[3]])
    {
        [_areaOfStudy setItemList:[NSArray arrayWithArray:[items valueForKey:items.allKeys[3]]]];

        
    }else if ([item isEqualToString:items.allKeys[4]])
    {
        [_areaOfStudy setItemList:[NSArray arrayWithArray:[items valueForKey:items.allKeys[4]]]];

     }else if ([item isEqualToString:items.allKeys[5]])
    {
        [_areaOfStudy setItemList:[NSArray arrayWithArray:[items valueForKey:items.allKeys[5]]]];
        
        
    }else if ([item isEqualToString:items.allKeys.lastObject])
    {
        [_areaOfStudy setItemList:[NSArray arrayWithArray:[items valueForKey:items.allKeys.lastObject]]];

    }else{
    
        _areaOfStudy.enabled = NO;
         [_areaOfStudy setItemList:[NSArray arrayWithObjects:@"Area Of Study", nil]];
    }

}
-(void)textField:(IQDropDownTextField *)textField didSelectDate:(NSDate *)date
{
    
    
}

-(IBAction)dateBtnClicked:(id)sender{
    
    [mydelegate get:@"" key:searchDate];
}

@end
