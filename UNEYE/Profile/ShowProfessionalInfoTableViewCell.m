//
//  ShowProfessionalInfoTableViewCell.m
//  HandOv3r
//
//  Created by Satya Kumar on 4/20/17.
//  Copyright © 2017 Satya Kumar. All rights reserved.
//

#import "ShowProfessionalInfoTableViewCell.h"

@implementation ShowProfessionalInfoTableViewCell

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
    //--- Sub Categories of Type Of Care ---
    [CommonUtility setRightPadding:_txtTypeOfCare imageName:@"drop_btn" width:50];
    
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
    
    //--- configure rate for Type of care text field ---
    _txtTypeOfCareRate.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Rate p/h" attributes:@{NSForegroundColorAttributeName: color}];
    
    if(IS_IPHONE_5)
    {
        [CommonUtility setLeftPadding:_txtTypeOfCareRate imageName:@"rate" width:47];
    }
    else if (IS_IPHONE_6P)
    {
        [CommonUtility setLeftPadding:_txtTypeOfCareRate imageName:@"rate" width:60];
    }
    else
    {
        [CommonUtility setLeftPadding:_txtTypeOfCareRate imageName:@"rate" width:56];
    }
    
}

@end
