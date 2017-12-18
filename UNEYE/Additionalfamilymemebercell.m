//
//  NewEnrollQuestPracticeContactDetailCell.m
//  UNEYE
//
//  Created by Satya Kumar on 17/03/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import "Additionalfamilymemebercell.h"

@implementation Additionalfamilymemebercell

@synthesize mydelegate;

- (void)awakeFromNib {
    // Initialization code
    [self configureUI];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark configure initial UI
-(void)configureUI{
    
    UIColor *color = [UIColor darkGrayColor];
    
    //--- Legal Practice Detail ---
    //--- configure Practice Street Address text field ---
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

    //--- configure City text field ---
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
    
    //--- configure State text field ---
    if(IS_IPHONE_5)
    {
    [CommonUtility setLeftPadding:_txtRequirements imageName:@"required" width:47];
    _txtRequirements.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Requirements" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_txtRequirements imageName:@"required" width:60];
        _txtRequirements.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Requirements" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        [CommonUtility setLeftPadding:_txtRequirements imageName:@"required" width:55];
        _txtRequirements.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Requirements" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
}

#pragma mark textField delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([textField isEqual:_txtName]) {
        
        [mydelegate get:familyMemberNameKey value:newString parentkey:femilymember index:[NSString stringWithFormat:@"%ld", self.tag-1]];
        
    }else if ([textField isEqual:_txtAge]) {
        
        [mydelegate get:familyMemberAgeKey value:newString parentkey:femilymember index:[NSString stringWithFormat:@"%ld", self.tag-1]];
        
    }else if ([textField isEqual:_txtRequirements]) {
    
        [mydelegate get:familyMemberRequirementsKey value:newString parentkey:femilymember index:[NSString stringWithFormat:@"%ld", self.tag-1]];
    }
    
    
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
