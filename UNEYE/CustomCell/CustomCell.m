//
//  CustomCell.m
//  UNEYE
//
//  Created by Satya Kumar on 18/03/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

//@synthesize mydelegate;

- (void)awakeFromNib {
    // Initialization code
    //[self configureUI];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark configure initial UI
-(void)configureUI{
    
//    UIColor *color = [UIColor darkGrayColor];
//    
//    //--- Sales Reps Detail ---
//    //--- configure Corporate officer Name text field ---
//    [CommonUtility setLeftPadding:_txtCorporateofficerName imageName:@"" width:20];
//    _txtCorporateofficerName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Corporate officer Name" attributes:@{NSForegroundColorAttributeName: color}];
//    
//    //--- configure Corporate officer Email text field ---
//    [CommonUtility setLeftPadding:_txtCorporateofficerEmail imageName:@"" width:20];
//    _txtCorporateofficerEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Corporate officer Email" attributes:@{NSForegroundColorAttributeName: color}];
//    
//    //--- configure Billing Admin Name text field ---
//    [CommonUtility setLeftPadding:_txtBillingAdminName imageName:@"" width:20];
//    _txtBillingAdminName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Billing Admin Name" attributes:@{NSForegroundColorAttributeName: color}];
//    
//    //--- configure Billing Admin Email text field ---
//    [CommonUtility setLeftPadding:_txtBillingAdminEmail imageName:@"" width:20];
//    _txtBillingAdminEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Billing Admin Email" attributes:@{NSForegroundColorAttributeName: color}];
}

//#pragma mark textField delegate
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    
//    if ([textField isEqual:_txtCorporateofficerName]) {
//        [mydelegate get:[NSString stringWithFormat:@"%@%@", _txtCorporateofficerName.text, string] key:@"CorporateOfficerName"];
//    }else if ([textField isEqual:_txtCorporateofficerEmail]) {
//        [mydelegate get:[NSString stringWithFormat:@"%@%@", _txtCorporateofficerEmail.text, string] key:@"CorporateOfficerEmail"];
//    }else if ([textField isEqual:_txtBillingAdminName]) {
//        [mydelegate get:[NSString stringWithFormat:@"%@%@", _txtBillingAdminName.text, string] key:@"BillingAdminName"];
//    }else if ([textField isEqual:_txtBillingAdminEmail]) {
//        [mydelegate get:[NSString stringWithFormat:@"%@%@", _txtBillingAdminEmail.text, string] key:@"BillingAdminEmail"];
//    }
//    
//    return YES;
//}

@end
