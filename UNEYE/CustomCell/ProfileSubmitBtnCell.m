//
//  ProfileSubmitBtnCell.m
//  UNEYE
//
//  Created by Satya Kumar on 19/03/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import "ProfileSubmitBtnCell.h"

@implementation ProfileSubmitBtnCell

@synthesize mydelegate;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (IBAction)submitBtnClicked:(id)sender
{
    [mydelegate submitForm];
}

@end
