//
//  AddMoreTypeOfCareTableViewCell.m
//  UNEYE
//
//  Created by Satya on 03/09/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import "AddMoreTypeOfCareTableViewCell.h"

@implementation AddMoreTypeOfCareTableViewCell

@synthesize mydelegate;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    arrTypeOfCare = [[NSMutableArray alloc] initWithObjects:@"",@"",@"", nil];
    [self configureUI];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark configure initial UI
-(void)configureUI{
    
    UIColor *color = [UIColor darkGrayColor];
    
    [CommonUtility setRightPadding:_txtRequired imageName:@"drop_btn" width:50];
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    UIBarButtonItem *buttonflexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *buttonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    buttonDone.tag = 0;
    [toolbar setItems:[NSArray arrayWithObjects:buttonflexible,buttonDone, nil]];
    
    //--- Type of required for sitter
    _txtRequired.inputAccessoryView = toolbar;
    _txtRequired.isOptionalDropDown = NO;
    [_txtRequired setItemList:[NSArray arrayWithObjects:@"Type of care", @"Babysitter",@"Nanny",@"Special Needs Friend",@"Pet Sitter",@"House Sitter",@"Special Occassion Helper", nil]];
    [_txtRequired setDropDownMode:IQDropDownModeDateTimePicker];
    
    [arrTypeOfCare replaceObjectAtIndex:0 withObject:@"Type of care"];
    [[CommonUtility sharedInstance] addScreenDataInfo:[arrTypeOfCare componentsJoinedByString:@","] key:field_typeofcare];
    
    //--- configure Required text field ---
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_txtRequired imageName:@"required" width:47];
        _txtRequired.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Type of Care" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_txtRequired imageName:@"required" width:60];
        _txtRequired.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Type of Care" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_txtRequired imageName:@"required" width:55];
        _txtRequired.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Type of Care" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    //--- Type of required for coach
    UIToolbar *toolbarcaoch = [[UIToolbar alloc] init];
    [toolbarcaoch setBarStyle:UIBarStyleBlackTranslucent];
    [toolbarcaoch sizeToFit];
    UIBarButtonItem *caochButtonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    caochButtonDone.tag = 1;
    [toolbarcaoch setItems:[NSArray arrayWithObjects:buttonflexible,caochButtonDone, nil]];
    
    _txtCaochRequired.inputAccessoryView = toolbarcaoch;
    _txtCaochRequired.isOptionalDropDown = NO;
    
    NSArray *activityArray = [[NSArray alloc] initWithObjects:@"Netball", @"Swimming", @"Chess",@"AFL",@"Athletics - Sprinter",@"Athletics - Cross - Country",@"Long - Distance",@"Badminton",@"Ballet",@"Baseball",@"Basketball",@"Beach Volleyball",@"Bowling",@"Canoeing",@"Cricket",@"Dancing",@"Fishing",@"Football",@"Golf",@"Gymnastics",@"Hockey",@"Horseback Riding",@"Karate",@"Kayaking",@"Netball",@"Pilates",@"Ping Pong",@"Roller Skating",@"Rollerblading",@"Rowing",@"Rugby Union",@"Rugby League",@"Sailing",@"Skateboarding",@"Skiing",@"Snow Boarding",@"Soccer",@"Softball",@"Swimming",@"Tennis",@"Touch Football", nil];
    
    NSArray *sortedArray = [activityArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    NSMutableArray *allSortedActivity = [[NSMutableArray alloc] initWithObjects:@"Area of skill", nil];
    [allSortedActivity addObjectsFromArray:sortedArray];
    
    [_txtCaochRequired setItemList:allSortedActivity];
    [_txtCaochRequired setDropDownMode:IQDropDownModeDateTimePicker];
    
    [arrTypeOfCare replaceObjectAtIndex:1 withObject:@"Area of skill"];
    [[CommonUtility sharedInstance] addScreenDataInfo:[arrTypeOfCare componentsJoinedByString:@","] key:field_typeofcare];
    
    //--- configure Required text field ---
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_txtCaochRequired imageName:@"required" width:47];
        _txtCaochRequired.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Type of Care" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_txtCaochRequired imageName:@"required" width:60];
        _txtCaochRequired.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Type of Care" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_txtCaochRequired imageName:@"required" width:55];
        _txtCaochRequired.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Type of Care" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    //--- Type of required for Tutor
    UIToolbar *toolbartutor = [[UIToolbar alloc] init];
    [toolbartutor setBarStyle:UIBarStyleBlackTranslucent];
    [toolbartutor sizeToFit];
    UIBarButtonItem *tutorButtonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    tutorButtonDone.tag = 2;
    [toolbartutor setItems:[NSArray arrayWithObjects:buttonflexible,tutorButtonDone, nil]];
    
    _txtTutorRequired.inputAccessoryView = toolbartutor;
    _txtTutorRequired.isOptionalDropDown = NO;
    //[_txtTutorRequired setItemList:[NSArray arrayWithObjects:@"Area of study", @"Primary",@"Secondary",@"Tertiary", @"Language", @"Community Studies", @"Technical", @"Others", nil]];
    
    [_txtTutorRequired setItemList:[NSArray arrayWithObjects:@"Area of study", @"Aboriginal Studies",
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
                                    @"Voice Coach", nil]];
    
    [_txtTutorRequired setDropDownMode:IQDropDownModeDateTimePicker];
    
    [arrTypeOfCare replaceObjectAtIndex:2 withObject:@"Area of study"];
    [[CommonUtility sharedInstance] addScreenDataInfo:[arrTypeOfCare componentsJoinedByString:@","] key:field_typeofcare];
    
    //--- configure Required text field ---
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_txtTutorRequired imageName:@"required" width:47];
        _txtTutorRequired.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Type of Care" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_txtTutorRequired imageName:@"required" width:60];
        _txtTutorRequired.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Type of Care" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_txtTutorRequired imageName:@"required" width:55];
        _txtTutorRequired.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Type of Care" attributes:@{NSForegroundColorAttributeName: color}];
    }

}

#pragma mark textField delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
//    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
//
//    if ([textField isEqual:_txtRequired] || [textField isEqual:_txtCaochRequired] || [textField isEqual:_txtTutorRequired])
//    {
//
//        [mydelegate get:newString key:TypeOfCare];
//    }
    
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark dropdown textField delegate
-(void)doneClicked:(UIBarButtonItem*)button
{
    [self endEditing:YES];
    
    if (button.tag == 0) {
        //[mydelegate get:[self setTypeOfCareItem:@"0" text:[NSString stringWithFormat:@"%@", _txtRequired.selectedItem]] key:field_typeofcare];
        
        [mydelegate getSubCategories:_txtRequired.selectedItem key:@"typeofcare" index:_txtRequired.tag];
    }else if (button.tag == 1) {
       // [mydelegate get:[self setTypeOfCareItem:@"1" text:[NSString stringWithFormat:@"%@", _txtCaochRequired.selectedItem]] key:field_typeofcare];
         [mydelegate getSubCategories:_txtCaochRequired.selectedItem key:@"areaofskill" index:_txtCaochRequired.tag];
    }else if (button.tag == 2) {
        //[mydelegate get:[self setTypeOfCareItem:@"2" text:[NSString stringWithFormat:@"%@", _txtTutorRequired.selectedItem]] key:field_typeofcare];
         [mydelegate getSubCategories:_txtTutorRequired.selectedItem key:@"areaofstudy" index:_txtTutorRequired.tag];
    }
    
    /*,
     @"", ,
     @"", ,*/
}

- (NSString *)setTypeOfCareItem:(NSString *)index text:(NSString *)text{

    NSString *finalText;
    
    [arrTypeOfCare replaceObjectAtIndex:[index intValue] withObject:text];
    finalText = [arrTypeOfCare componentsJoinedByString:@","];
    
    return finalText;
}

@end
