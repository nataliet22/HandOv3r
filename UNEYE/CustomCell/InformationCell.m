//
//  InformationCell.m
//  UNEYE
//
//  Created by AppTech_Mac1 on 4/8/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import "InformationCell.h"
#import "IQKeyboardManager.h"

@implementation InformationCell

@synthesize mydelegate;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    dictTypeOfCare = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[[NSMutableArray alloc] initWithObjects:@"",@"",@"", nil], @"typeofcare",
                      [[NSMutableArray alloc] initWithObjects:@"",@"",@"", nil], @"subCategoryTypeofcare",
                      nil];
    [self configureUI];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark configure initial UI
-(void)configureUI{
    
    UIColor *color = [UIColor darkGrayColor];

    //--- configure text field ---
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_txtName imageName:@"user-icon" width:47];
        _txtName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Name" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_txtName imageName:@"user-icon" width:60];
        _txtName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Name" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_txtName imageName:@"user-icon" width:55];
        _txtName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Name" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    //--- configure Age text field ---
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_txtAge imageName:@"age" width:47];
        _txtAge.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Age" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_txtAge imageName:@"age" width:60];
        _txtAge.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Age" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_txtAge imageName:@"age" width:55];
        _txtAge.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Age" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    //--- configure postCode text field ---
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_postCode imageName:@"postcode" width:47];
        _postCode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"PostCode" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_postCode imageName:@"postcode" width:60];
        _postCode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"PostCode" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_postCode imageName:@"postcode" width:55];
        _postCode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"PostCode" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    //--- configure Email text field ---
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_txtEmail imageName:@"email" width:47];
        _txtEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_txtEmail imageName:@"email" width:60];
        _txtEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_txtEmail imageName:@"email" width:55];
        _txtEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    //--- configure Password text field ---
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_txtPassword imageName:@"password" width:47];
        _txtPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_txtPassword imageName:@"password" width:60];
        _txtPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_txtPassword imageName:@"password" width:55];
        _txtPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    }

    //--- configure Confirm Password text field ---
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_txtConfirmPassword imageName:@"password" width:47];
        _txtConfirmPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Confirm Password" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_txtConfirmPassword imageName:@"password" width:60];
        _txtConfirmPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Confirm Password" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_txtConfirmPassword imageName:@"password" width:55];
        _txtConfirmPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Confirm Password" attributes:@{NSForegroundColorAttributeName: color}];
    }

    [CommonUtility setRightPadding:_lookingFor imageName:@"drop_btn" width:50];
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    
    //--- configure Gender text field ---
    
    UIBarButtonItem *buttonflexibleGender = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *buttonDoneGender = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    buttonDoneGender.tag = 0;
    [toolbar setItems:[NSArray arrayWithObjects:buttonflexibleGender,buttonDoneGender, nil]];
    
    //--- Gender ---
    [CommonUtility setRightPadding:_txtGender imageName:@"drop_btn" width:50];
    
    _txtGender.inputAccessoryView = toolbar;
    _txtGender.isOptionalDropDown = NO;
    [_txtGender setItemList:[NSArray arrayWithObjects:@"Female", @"Male", nil]];
    [_txtGender setDropDownMode:IQDropDownModeDateTimePicker];
    [[CommonUtility sharedInstance] addScreenDataInfo:@"Female" key:gender];
    
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_txtGender imageName:@"gender" width:47];
        _txtGender.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Gender" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_txtGender imageName:@"gender" width:60];
        _txtGender.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Gender" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_txtGender imageName:@"gender" width:55];
        _txtGender.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Gender" attributes:@{NSForegroundColorAttributeName: color}];
    }
    

    UIToolbar *toolbarlookingFor = [[UIToolbar alloc] init];
    [toolbarlookingFor setBarStyle:UIBarStyleBlackTranslucent];
    [toolbarlookingFor sizeToFit];
    
    UIBarButtonItem *buttonflexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *buttonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    buttonDone.tag = 11;
    [toolbarlookingFor setItems:[NSArray arrayWithObjects:buttonflexible,buttonDone, nil]];
    _lookingFor.inputAccessoryView = toolbarlookingFor;
    _lookingFor.isOptionalDropDown = NO;
    _lookingFor.tag = 11;
    [_lookingFor setItemList:[NSArray arrayWithObjects:@"Babysitting",@"Tutoring",@"Coaching", nil]];
    [_lookingFor setDropDownMode:IQDropDownModeDateTimePicker];
    
    [[CommonUtility sharedInstance] addScreenDataInfo:[self setTypeOfCareItem:@"0" text:@"Babysitting" key:@"typeofcare"] key:@"field_typeofcare"];
    
    //_lookingFor.delegate = self;
    
    //--- configure lookingFor text field ---
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_lookingFor imageName:@"looking-for" width:47];
        _lookingFor.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Looking For" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_lookingFor imageName:@"looking-for" width:60];
        _lookingFor.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Looking For" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_lookingFor imageName:@"looking-for" width:55];
        _lookingFor.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Looking For" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    //--- configure sub Categories text field ---
    UIToolbar *toolbarsubCategories = [[UIToolbar alloc] init];
    [toolbarsubCategories setBarStyle:UIBarStyleBlackTranslucent];
    [toolbarsubCategories sizeToFit];
    
    UIBarButtonItem *buttonflexibleSubCat = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *buttonDoneSubCat = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    buttonDoneSubCat.tag = 21;
    [toolbarsubCategories setItems:[NSArray arrayWithObjects:buttonflexibleSubCat,buttonDoneSubCat, nil]];
    
    //--- Sub Categories of Type Of Care ---
    [CommonUtility setRightPadding:_subCategories imageName:@"drop_btn" width:50];
    
    _subCategories.inputAccessoryView = toolbarsubCategories;
    _subCategories.isOptionalDropDown = NO;
    _subCategories.tag = 21;
    [_subCategories setItemList:[NSArray arrayWithObjects:@"Babysitter",@"Nanny",@"Special Needs Friend", @"Pet Sitter", @"House Sitter",@"Special Occassion Helper", nil]];
    [_subCategories setDropDownMode:IQDropDownModeDateTimePicker];
    
    [[CommonUtility sharedInstance] addScreenDataInfo:[self setTypeOfCareItem:@"0" text:@"Babysitter" key:@"subCategoryTypeofcare"] key:subCategoriesKey];
    
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_subCategories imageName:@"looking-for" width:47];
        _subCategories.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Looking For" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_subCategories imageName:@"looking-for" width:60];
        _subCategories.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Looking For" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_subCategories imageName:@"looking-for" width:55];
        _subCategories.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Looking For" attributes:@{NSForegroundColorAttributeName: color}];
    }

    //--- configure looking For Coaching ---
    [CommonUtility setRightPadding:_lookingForCoaching imageName:@"drop_btn" width:50];
    
    UIToolbar *toolbarlookingForCoaching = [[UIToolbar alloc] init];
    [toolbarlookingForCoaching setBarStyle:UIBarStyleBlackTranslucent];
    [toolbarlookingForCoaching sizeToFit];
    
    UIBarButtonItem *buttonDoneCoaching = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    buttonDoneCoaching.tag = 12;
    [toolbarlookingForCoaching setItems:[NSArray arrayWithObjects:buttonflexible,buttonDoneCoaching, nil]];
    _lookingForCoaching.inputAccessoryView = toolbarlookingForCoaching;
    _lookingForCoaching.isOptionalDropDown = NO;
    _lookingForCoaching.tag = 12;
    [_lookingForCoaching setItemList:[NSArray arrayWithObjects:@"Coaching",@"Tutoring",@"Babysitting", nil]];
    [_lookingForCoaching setDropDownMode:IQDropDownModeDateTimePicker];
    
    [[CommonUtility sharedInstance] addScreenDataInfo:[self setTypeOfCareItem:@"1" text:@"Coaching" key:@"typeofcare"] key:@"field_typeofcare"];
    
    //_lookingFor.delegate = self;
    //--- configure lookingFor text field ---
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_lookingForCoaching imageName:@"looking-for" width:47];
        _lookingForCoaching.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Looking For" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_lookingForCoaching imageName:@"looking-for" width:60];
        _lookingForCoaching.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Looking For" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_lookingForCoaching imageName:@"looking-for" width:55];
        _lookingForCoaching.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Looking For" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    //--- configure sub Categories text field ---
    UIToolbar *toolbarcoachingSubCategories = [[UIToolbar alloc] init];
    [toolbarcoachingSubCategories setBarStyle:UIBarStyleBlackTranslucent];
    [toolbarcoachingSubCategories sizeToFit];
    
    UIBarButtonItem *buttonDoneCoachingSubCat = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    buttonDoneCoachingSubCat.tag = 22;
    [toolbarcoachingSubCategories setItems:[NSArray arrayWithObjects:buttonflexibleSubCat,buttonDoneCoachingSubCat, nil]];
    
    //--- Sub Categories of Type Of Care ---
    [CommonUtility setRightPadding:_coachingSubCategories imageName:@"drop_btn" width:50];
    
    _coachingSubCategories.inputAccessoryView = toolbarcoachingSubCategories;
    _coachingSubCategories.isOptionalDropDown = NO;
    _coachingSubCategories.tag = 22;
    
    NSArray *activityArray = [[NSArray alloc] initWithObjects:@"Netball", @"Swimming", @"Chess",@"AFL",@"Athletics - Sprinter",@"Athletics - Cross-Country",@"Long-Distance",@"Badminton",@"Ballet",@"Baseball",@"Basketball",@"Beach Volleyball",@"Bowling",@"Canoeing",@"Cricket",@"Dancing",@"Fishing",@"Football",@"Golf",@"Gymnastics",@"Hockey",@"Horseback Riding",@"Karate",@"Kayaking",@"Netball",@"Pilates",@"Ping Pong",@"Roller Skating",@"Rollerblading",@"Rowing",@"Rugby Union",@"Rugby League",@"Sailing",@"Skateboarding",@"Skiing",@"Snow Boarding",@"Soccer",@"Softball",@"Swimming",@"Tennis",@"Touch Football", nil];
    
    [_coachingSubCategories setItemList:activityArray];
    [_coachingSubCategories setDropDownMode:IQDropDownModeDateTimePicker];
    
    [[CommonUtility sharedInstance] addScreenDataInfo:[self setTypeOfCareItem:@"1" text:@"Netball" key:@"subCategoryTypeofcare"] key:subCategoriesKey];
    
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_coachingSubCategories imageName:@"looking-for" width:47];
        _coachingSubCategories.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Looking For" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_coachingSubCategories imageName:@"looking-for" width:60];
        _coachingSubCategories.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Looking For" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_coachingSubCategories imageName:@"looking-for" width:55];
        _coachingSubCategories.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Looking For" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    //--- configure looking For Tutoring ---
    [CommonUtility setRightPadding:_lookingForTutor imageName:@"drop_btn" width:50];
    
    UIToolbar *toolbarlookingForTutor = [[UIToolbar alloc] init];
    [toolbarlookingForTutor setBarStyle:UIBarStyleBlackTranslucent];
    [toolbarlookingForTutor sizeToFit];
    
    UIBarButtonItem *buttonDoneTutor = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    buttonDoneTutor.tag = 13;
    [toolbarlookingForTutor setItems:[NSArray arrayWithObjects:buttonflexible,buttonDoneTutor, nil]];
    _lookingForTutor.inputAccessoryView = toolbarlookingForTutor;
    _lookingForTutor.isOptionalDropDown = NO;
    _lookingForTutor.tag = 13;
    [_lookingForTutor setItemList:[NSArray arrayWithObjects:@"Tutoring",@"Coaching",@"Babysitting", nil]];
    [_lookingForTutor setDropDownMode:IQDropDownModeDateTimePicker];
    
    [[CommonUtility sharedInstance] addScreenDataInfo:[self setTypeOfCareItem:@"2" text:@"Tutoring" key:@"typeofcare"] key:@"field_typeofcare"];
    
    //_lookingFor.delegate = self;
    //--- configure lookingFor text field ---
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_lookingForTutor imageName:@"looking-for" width:47];
        _lookingForTutor.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Looking For" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_lookingForTutor imageName:@"looking-for" width:60];
        _lookingForTutor.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Looking For" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_lookingForTutor imageName:@"looking-for" width:55];
        _lookingForTutor.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Looking For" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    //--- configure sub Categories text field ---
    
    UIToolbar *toolbartutoringSubCategories = [[UIToolbar alloc] init];
    [toolbartutoringSubCategories setBarStyle:UIBarStyleBlackTranslucent];
    [toolbartutoringSubCategories sizeToFit];
    
    UIBarButtonItem *buttonDoneCoachingSubCattutor = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    buttonDoneCoachingSubCattutor.tag = 23;
    [toolbartutoringSubCategories setItems:[NSArray arrayWithObjects:buttonflexibleSubCat,buttonDoneCoachingSubCattutor, nil]];
    
    //--- Sub Categories of Type Of Care ---
    [CommonUtility setRightPadding:_tutoringSubCategories imageName:@"drop_btn" width:50];
    
    _tutoringSubCategories.inputAccessoryView = toolbartutoringSubCategories;
    _tutoringSubCategories.isOptionalDropDown = NO;
    _tutoringSubCategories.tag = 23;
    [_tutoringSubCategories setItemList:[NSArray arrayWithObjects:@"Primary",@"Secondary",@"Tertiary", @"Language", @"Community Studies", @"Technical", @"Others", nil]];
    [_tutoringSubCategories setDropDownMode:IQDropDownModeDateTimePicker];
    
    [[CommonUtility sharedInstance] addScreenDataInfo:[self setTypeOfCareItem:@"2" text:@"Primary" key:@"subCategoryTypeofcare"] key:subCategoriesKey];
    
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_tutoringSubCategories imageName:@"looking-for" width:47];
        _tutoringSubCategories.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Looking For" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_tutoringSubCategories imageName:@"looking-for" width:60];
        _tutoringSubCategories.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Looking For" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_tutoringSubCategories imageName:@"looking-for" width:55];
        _tutoringSubCategories.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Looking For" attributes:@{NSForegroundColorAttributeName: color}];
    }

    //--- configure txtExperience text field ---
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_txtExperience imageName:@"exoerience" width:47];
        _txtExperience.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Experience" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_txtExperience imageName:@"exoerience" width:60];
        _txtExperience.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Experience" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_txtExperience imageName:@"exoerience" width:55];
        _txtExperience.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Experience" attributes:@{NSForegroundColorAttributeName: color}];
    }

    //--- configure rate text field ---
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_rate imageName:@"rate" width:47];
        _rate.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Rate p/h" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_rate imageName:@"rate" width:60];
        _rate.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Rate p/h" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_rate imageName:@"rate" width:55];
        _rate.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Rate p/h" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    //--- configure txtQualification text field ---
    
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_txtQualification imageName:@"study" width:47];
        _txtQualification.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Qualifications" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_txtQualification imageName:@"study" width:60];
        _txtQualification.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Qualifications" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_txtQualification imageName:@"study" width:55];
        _txtQualification.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Qualifications" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    //--- configure addEmail text field ---
    
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_addPayPalEmail imageName:@"email" width:47];
        _addPayPalEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Add PayPal Email" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_addPayPalEmail imageName:@"email" width:60];
        _addPayPalEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Add PayPal Email" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_addPayPalEmail imageName:@"email" width:55];
        _addPayPalEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Add PayPal Email" attributes:@{NSForegroundColorAttributeName: color}];
    }

}
#pragma mark textView delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSLog(@"TextView Text :- %@", [NSString stringWithFormat:@"%@%@", textView.text, text]);
    
    NSString *newString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    [mydelegate get:newString key:AboutKey];
    
    if ([text isEqualToString:@"\n"]) {
        NSLog(@"Return pressed, do whatever you like here");
        return NO;
    }
    
    return YES;
}
-(void)textField:(nonnull IQDropDownTextField*)textField didSelectItem:(nullable NSString*)item
{
    NSString *indexStr;
    IQDropDownTextField *subCatDropDown;
    
    if ([textField isEqual:_lookingFor]) {
        subCatDropDown = _subCategories;
        indexStr = @"0";
        
    }else if ([textField isEqual:_lookingForCoaching]) {
        subCatDropDown = _coachingSubCategories;
        indexStr = @"1";
        
    }else if ([textField isEqual:_lookingForTutor]) {
        subCatDropDown = _tutoringSubCategories;
        indexStr = @"2";
    }
    
    //--- Remove null --
    if ([item length] == 0) {
        item = @"";
    }
    
    if([item isEqualToString:@"Babysitting"])
    {
        [[CommonUtility sharedInstance] addScreenDataInfo:[self setTypeOfCareItem:indexStr text:item key:@"typeofcare"] key:field_typeofcare];
        
        [subCatDropDown setItemList:[NSArray arrayWithObjects:@"Babysitter",@"Nanny",@"Special Needs Friend", @"Pet Sitter", @"House Sitter", nil]];
        [[CommonUtility sharedInstance] addScreenDataInfo:[self setTypeOfCareItem:indexStr text:subCatDropDown.itemList.firstObject key:@"subCategoryTypeofcare"] key:subCategoriesKey];
    }
    else if ([item isEqualToString:@"Coaching"])
    {
        [[CommonUtility sharedInstance] addScreenDataInfo:[self setTypeOfCareItem:indexStr text:item key:@"typeofcare"] key:field_typeofcare];
        
        NSArray *activityArray = [[NSArray alloc] initWithObjects:@"Netball", @"Swimming", @"Chess",@"AFL",@"Athletics - Sprinter",@"Athletics - Cross-Country",@"Long-Distance",@"Badminton",@"Ballet",@"Baseball",@"Basketball",@"Beach Volleyball",@"Bowling",@"Canoeing",@"Cricket",@"Dancing",@"Fishing",@"Football",@"Golf",@"Gymnastics",@"Hockey",@"Horseback Riding",@"Karate",@"Kayaking",@"Netball",@"Pilates",@"Ping Pong",@"Roller Skating",@"Rollerblading",@"Rowing",@"Rugby Union",@"Rugby League",@"Sailing",@"Skateboarding",@"Skiing",@"Snow Boarding",@"Soccer",@"Softball",@"Swimming",@"Tennis",@"Touch Football", nil];
        
        NSArray *sortedArray = [activityArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        
        [subCatDropDown setItemList:sortedArray];
        [[CommonUtility sharedInstance] addScreenDataInfo:[self setTypeOfCareItem:indexStr text:subCatDropDown.itemList.firstObject key:@"subCategoryTypeofcare"] key:subCategoriesKey];
    }
    else if ([item isEqualToString:@"Tutoring"])
    {
        [[CommonUtility sharedInstance] addScreenDataInfo:[self setTypeOfCareItem:indexStr text:item key:@"typeofcare"] key:field_typeofcare];
        [subCatDropDown setItemList:[NSArray arrayWithObjects:@"Primary",@"Secondary",@"Tertiary", @"Language", @"Community Studies", @"Technical", @"Others", nil]];
        [[CommonUtility sharedInstance] addScreenDataInfo:[self setTypeOfCareItem:indexStr text:subCatDropDown.itemList.firstObject key:@"subCategoryTypeofcare"] key:subCategoriesKey];
    }
    
   /*
    if([item isEqualToString:@"Babysitting"])
    {
    
    [[CommonUtility sharedInstance] addScreenDataInfo:item key:field_typeofcare];
    [_subCategories setItemList:[NSArray arrayWithObjects:@"Babysitter",@"Nanny",@"Special Needs Friend", @"Pet Sitter", @"House Sitter", nil]];
    [[CommonUtility sharedInstance] addScreenDataInfo:_subCategories.itemList.firstObject key:subCategoriesKey];
    }
    else if ([item isEqualToString:@"Coaching"])
    {
    
    [[CommonUtility sharedInstance] addScreenDataInfo:item key:field_typeofcare];
    
    NSArray *activityArray = [[NSArray alloc] initWithObjects:@"Netball", @"Swimming", @"Chess",@"AFL",@"Athletics– Sprinter",@"Athletics – Cross-Country",@"Long-Distance",@"Badminton",@"Ballet",@"Baseball",@"Basketball",@"Beach Volleyball",@"Bowling",@"Canoeing",@"Cricket",@"Dancing",@"Fishing",@"Football",@"Golf",@"Gymnastics",@"Hockey",@"Horseback Riding",@"Karate",@"Kayaking",@"Netball",@"Pilates",@"Ping Pong",@"Roller Skating",@"Rollerblading",@"Rowing",@"Rugby Union",@"Rugby League",@"Sailing",@"Skateboarding",@"Skiing",@"Snow Boarding",@"Soccer",@"Softball",@"Swimming",@"Tennis",@"Touch Football", nil];
    
    NSArray *sortedArray = [activityArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    [_subCategories setItemList:sortedArray];
    [[CommonUtility sharedInstance] addScreenDataInfo:_subCategories.itemList.firstObject key:subCategoriesKey];
    }
    else if ([item isEqualToString:@"Tutoring"])
    {
    [[CommonUtility sharedInstance] addScreenDataInfo:item key:field_typeofcare];
    [_subCategories setItemList:[NSArray arrayWithObjects:@"Primary",@"Secondary",@"Tertiary", @"Language", @"Community Studies", @"Technical", @"Others", nil]];
    [[CommonUtility sharedInstance] addScreenDataInfo:_subCategories.itemList.firstObject key:subCategoriesKey];
    }
    */
    
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"About Me"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"About Me";
        textView.textColor = [UIColor lightGrayColor];
    }
    [textView resignFirstResponder];
}

#pragma mark textField delegate
- (void)hideKeyBoard{

    [_txtName resignFirstResponder];
    [_txtAge resignFirstResponder];
    [_postCode resignFirstResponder];
    [_txtEmail resignFirstResponder];
    [_txtPassword resignFirstResponder];
    [_txtConfirmPassword resignFirstResponder];
    [_lookingFor resignFirstResponder];
    [_txtExperience resignFirstResponder];
    [_rate resignFirstResponder];
    [_txtQualification resignFirstResponder];
    [_addPayPalEmail resignFirstResponder];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([textField isEqual:_txtName])
    {
        [mydelegate get:newString key:@"name"];
    }
    else if ([textField isEqual:_txtAge])
    {
        [mydelegate get:newString key:@"field_age"];
    }
    else if ([textField isEqual:_postCode])
    {
        [mydelegate get:newString key:@"field_postcode"];
    }
    else if ([textField isEqual:_txtEmail])
    {
        [mydelegate get:newString key:@"mail"];
    }
    else if ([textField isEqual:_txtPassword])
    {
        [mydelegate get:newString key:@"pass"];
    }
    else if ([textField isEqual:_txtConfirmPassword])
    {
        [mydelegate get:newString key:@"confirmPass"];
    }
    else if ([textField isEqual:_txtExperience])
    {
        [mydelegate get:newString key:@"field_experience"];
    }
    else if ([textField isEqual:_rate])
    {
        [mydelegate get:newString key:@"field_rate"];
    }
    else if ([textField isEqual:_addPayPalEmail])
    {
        [mydelegate get:newString key:@"field_paypal"];
    }
    return YES;
}

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

- (NSString *)setTypeOfCareItem:(NSString *)index text:(NSString *)text key:(NSString *)key{
    
    //--- Remove null ---
    if ([text length] == 0) {
        text = @"";
    }
    
    NSString *finalText;
    
    NSMutableArray *arrValue = [dictTypeOfCare valueForKey:key];
    
    [arrValue replaceObjectAtIndex:[index intValue] withObject:text];
    
    finalText = [arrValue componentsJoinedByString:@","];
    
    [dictTypeOfCare setValue:arrValue forKey:key];
    
    NSLog(@"dictTypeOfCare :- %@", dictTypeOfCare);
    NSLog(@"finalText :- %@", finalText);
    
    return finalText;
}

//#pragma mark dropdown textField delegate
//-(void)doneClicked:(UIBarButtonItem*)button
//{
//    [self endEditing:YES];
//    [lastSelectedTextFld endEditing:true];
//    
//    if (button.tag == 0) {
//        [mydelegate get:[NSString stringWithFormat:@"%@", _txtGender.selectedItem] key:gender];
//    }else if (button.tag == 1) {
//         [mydelegate get:[NSString stringWithFormat:@"%@", _lookingFor.selectedItem] key:@"field_typeofcare"];
//    }else if (button.tag == 2) {
//        [mydelegate get:[NSString stringWithFormat:@"%@", _subCategories.selectedItem] key:subCategoriesKey];
//    }
//}

#pragma mark dropdown textField delegate
-(IBAction)qualificationBtnClicked:(id)sender{

    [mydelegate get:@"" key:@"qualification"];
}

@end
