//
//  AddMoreProfessionalInfoTableViewCell.m
//  HandOv3r
//
//  Created by Satya on 06/11/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import "AddMoreProfessionalInfoTableViewCell.h"

@implementation AddMoreProfessionalInfoTableViewCell

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

-(void)configureUI{

    UIColor *color = [UIColor darkGrayColor];
    
    //--- configure sub Categories text field ---
    UIToolbar *toolbarsubCategories = [[UIToolbar alloc] init];
    [toolbarsubCategories setBarStyle:UIBarStyleBlackTranslucent];
    [toolbarsubCategories sizeToFit];
    
    UIBarButtonItem *buttonflexibleSubCat = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *buttonDoneSubCat = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    buttonDoneSubCat.tag = 0;
    [toolbarsubCategories setItems:[NSArray arrayWithObjects:buttonflexibleSubCat,buttonDoneSubCat, nil]];
    
    //--- Sub Categories of Type Of Care ---
    [CommonUtility setRightPadding:_txtTypeOfCare imageName:@"drop_btn" width:50];
    
    _txtTypeOfCare.inputAccessoryView = toolbarsubCategories;
    _txtTypeOfCare.isOptionalDropDown = NO;
    [_txtTypeOfCare setItemList:[NSArray arrayWithObjects:@"Type of care",@"Babysitter",@"Nanny",@"Special Needs Friend", @"Pet Sitter", @"House Sitter",@"Special Occassion Helper", nil]];
    [_txtTypeOfCare setDropDownMode:IQDropDownModeDateTimePicker];
    _txtTypeOfCare.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Type of care" attributes:@{NSForegroundColorAttributeName: color}];
    
   // [[CommonUtility sharedInstance] addScreenDataInfo:[self setTypeOfCareItem:@"0" text:@"Babysitter" key:@"subCategoryTypeofcare"] key:subCategoriesKey];
    
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_txtTypeOfCare imageName:@"looking-for" width:47];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_txtTypeOfCare imageName:@"looking-for" width:60];
    }
    else
    {
        [CommonUtility setLeftPadding:_txtTypeOfCare imageName:@"looking-for" width:55];
    }
    
    //--- configure sub Categories text field ---
    UIToolbar *toolbarcoachingSubCategories = [[UIToolbar alloc] init];
    [toolbarcoachingSubCategories setBarStyle:UIBarStyleBlackTranslucent];
    [toolbarcoachingSubCategories sizeToFit];
    
    UIBarButtonItem *buttonDoneCoachingSubCat = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    buttonDoneCoachingSubCat.tag = 1;
    [toolbarcoachingSubCategories setItems:[NSArray arrayWithObjects:buttonflexibleSubCat,buttonDoneCoachingSubCat, nil]];
    
    //--- Sub Categories of Type Of Care ---
    [CommonUtility setRightPadding:_txtAreaOfSkill imageName:@"drop_btn" width:50];
    
    _txtAreaOfSkill.inputAccessoryView = toolbarcoachingSubCategories;
    _txtAreaOfSkill.isOptionalDropDown = NO;
    
    NSArray *activityArray = [[NSArray alloc] initWithObjects:@"Netball", @"Swimming", @"Chess",@"AFL",@"Athletics - Sprinter",@"Athletics - Cross - Country",@"Long-Distance",@"Badminton",@"Ballet",@"Baseball",@"Basketball",@"Beach Volleyball",@"Bowling",@"Canoeing",@"Cricket",@"Dancing",@"Fishing",@"Football",@"Golf",@"Gymnastics",@"Hockey",@"Horseback Riding",@"Karate",@"Kayaking",@"Netball",@"Pilates",@"Ping Pong",@"Roller Skating",@"Rollerblading",@"Rowing",@"Rugby Union",@"Rugby League",@"Sailing",@"Skateboarding",@"Skiing",@"Snow Boarding",@"Soccer",@"Softball",@"Swimming",@"Tennis",@"Touch Football", nil];
    
    NSArray *sortedArray = [activityArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    NSMutableArray *allSortedActivity = [[NSMutableArray alloc] initWithObjects:@"Area of skill", nil];
    [allSortedActivity addObjectsFromArray:sortedArray];
    
    [_txtAreaOfSkill setItemList:allSortedActivity];
    [_txtAreaOfSkill setDropDownMode:IQDropDownModeDateTimePicker];
    _txtAreaOfSkill.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Area of skill" attributes:@{NSForegroundColorAttributeName: color}];

    //[[CommonUtility sharedInstance] addScreenDataInfo:[self setTypeOfCareItem:@"1" text:@"Netball" key:@"subCategoryTypeofcare"] key:subCategoriesKey];
    
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_txtAreaOfSkill imageName:@"looking-for" width:47];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_txtAreaOfSkill imageName:@"looking-for" width:60];
    }
    else
    {
        [CommonUtility setLeftPadding:_txtAreaOfSkill imageName:@"looking-for" width:55];
    }

    //--- configure sub Categories text field ---
    
    UIToolbar *toolbartutoringSubCategories = [[UIToolbar alloc] init];
    [toolbartutoringSubCategories setBarStyle:UIBarStyleBlackTranslucent];
    [toolbartutoringSubCategories sizeToFit];
    
    UIBarButtonItem *buttonDoneCoachingSubCattutor = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    buttonDoneCoachingSubCattutor.tag = 2;
    [toolbartutoringSubCategories setItems:[NSArray arrayWithObjects:buttonflexibleSubCat,buttonDoneCoachingSubCattutor, nil]];
    
    //--- Sub Categories of Type Of Care ---
    [CommonUtility setRightPadding:_txtStudyLevel imageName:@"drop_btn" width:50];
    
    _txtStudyLevel.inputAccessoryView = toolbartutoringSubCategories;
    _txtStudyLevel.isOptionalDropDown = NO;
    //[_txtStudyLevel setItemList:[NSArray arrayWithObjects:@"Area of study",@"Primary",@"Secondary",@"Tertiary", @"Language", @"Community Studies", @"Technical", @"Others", nil]];
    
    [_txtStudyLevel setItemList:[NSArray arrayWithObjects:@"Area of study", @"Aboriginal Studies",
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
    
    [_txtStudyLevel setDropDownMode:IQDropDownModeDateTimePicker];
    _txtStudyLevel.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Area of study" attributes:@{NSForegroundColorAttributeName: color}];

   // [[CommonUtility sharedInstance] addScreenDataInfo:[self setTypeOfCareItem:@"2" text:@"Primary" key:@"subCategoryTypeofcare"] key:subCategoriesKey];
    
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_txtStudyLevel imageName:@"looking-for" width:47];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_txtStudyLevel imageName:@"looking-for" width:60];
    }
    else
    {
        [CommonUtility setLeftPadding:_txtStudyLevel imageName:@"looking-for" width:55];
    }

    
    //--- configure rate for Type of care text field ---
    _txtTypeOfCareRate.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Rate p/h" attributes:@{NSForegroundColorAttributeName: color}];
    _txtAreaOfSkillRate.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Rate p/h" attributes:@{NSForegroundColorAttributeName: color}];
    _txtStudyLevelRate.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Rate p/h" attributes:@{NSForegroundColorAttributeName: color}];

    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_txtTypeOfCareRate imageName:@"rate" width:47];
        [CommonUtility setLeftPadding:_txtAreaOfSkillRate imageName:@"rate" width:47];
        [CommonUtility setLeftPadding:_txtStudyLevelRate imageName:@"rate" width:47];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_txtTypeOfCareRate imageName:@"rate" width:60];
        [CommonUtility setLeftPadding:_txtAreaOfSkillRate imageName:@"rate" width:60];
        [CommonUtility setLeftPadding:_txtStudyLevelRate imageName:@"rate" width:60];    }
    else
    {
        [CommonUtility setLeftPadding:_txtTypeOfCareRate imageName:@"rate" width:56];
        [CommonUtility setLeftPadding:_txtAreaOfSkillRate imageName:@"rate" width:56];
        [CommonUtility setLeftPadding:_txtStudyLevelRate imageName:@"rate" width:56];    }

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([textField isEqual:_txtTypeOfCareRate])
    {
         [mydelegate getSubCategories:newString key:@"typeofcarerate" index:_txtTypeOfCareRate.tag];
    }
    else if ([textField isEqual:_txtAreaOfSkillRate])
    {
         [mydelegate getSubCategories:newString key:@"areaofskillrate" index:_txtAreaOfSkillRate.tag];
    }
    else if ([textField isEqual:_txtStudyLevelRate])
    {
        [mydelegate getSubCategories:newString key:@"areaofstudyrate" index:_txtStudyLevelRate.tag];
    }
    
    return YES;
}


#pragma mark dropdown textField delegate
-(void)doneClicked:(UIBarButtonItem*)button
{
    [self endEditing:YES];
    
    if (button.tag == 0) {
        
        [mydelegate getSubCategories:_txtTypeOfCare.selectedItem key:@"typeofcare" index:_txtTypeOfCare.tag];
    }else if (button.tag == 1) {
        
        [mydelegate getSubCategories:_txtAreaOfSkill.selectedItem key:@"areaofskill" index:_txtAreaOfSkill.tag];
    }else if (button.tag == 2) {
        
        [mydelegate getSubCategories:_txtStudyLevel.selectedItem key:@"areaofstudy" index:_txtStudyLevel.tag];
    }
    
}

/*
#pragma mark dropdown textField delegate
-(void)doneClicked:(UIBarButtonItem*)button
{
    [self endEditing:YES];
 
    if (button.tag == 0) {
        [mydelegate get:[NSString stringWithFormat:@"%@", _txtGender.selectedItem] key:gender];
        
    }else if (button.tag == 11) {
        
        [mydelegate get:[self setTypeOfCareItem:@"0" text:[NSString stringWithFormat:@"%@", _lookingFor.selectedItem] key:@"typeofcare"] key:field_typeofcare];
        
    }else if (button.tag == 12) {
        
        [mydelegate get:[self setTypeOfCareItem:@"1" text:[NSString stringWithFormat:@"%@", _lookingForCoaching.selectedItem] key:@"typeofcare"] key:field_typeofcare];
        
    }else if (button.tag == 13) {
        
        [mydelegate get:[self setTypeOfCareItem:@"2" text:[NSString stringWithFormat:@"%@", _lookingForTutor.selectedItem] key:@"typeofcare"] key:field_typeofcare];
        
    }else if (button.tag == 21) {
        
        [mydelegate get:[self setTypeOfCareItem:@"0" text:[NSString stringWithFormat:@"%@", _subCategories.selectedItem] key:@"subCategoryTypeofcare"] key:subCategoriesKey];
        
    }else if (button.tag == 22) {
        
        [mydelegate get:[self setTypeOfCareItem:@"1" text:[NSString stringWithFormat:@"%@", _coachingSubCategories.selectedItem] key:@"subCategoryTypeofcare"] key:subCategoriesKey];
    }else if (button.tag == 23) {
        
        [mydelegate get:[self setTypeOfCareItem:@"2" text:[NSString stringWithFormat:@"%@", _tutoringSubCategories.selectedItem] key:@"subCategoryTypeofcare"] key:subCategoriesKey];
    }
    
}
*/

@end
