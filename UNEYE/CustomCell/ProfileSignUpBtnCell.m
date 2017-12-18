//
//  ProfileSignUpBtnCell.m
//  UNEYE
//
//  Created by AppTech_Mac1 on 4/8/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import "ProfileSignUpBtnCell.h"

@implementation ProfileSignUpBtnCell

@synthesize mydelegate;

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (IBAction)signUpBtnClicked:(id)sender
{
    [mydelegate signUpForm];
}

@end
