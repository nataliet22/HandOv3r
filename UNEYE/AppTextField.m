//
//  AppTextField.m
//  UNEYE
//
//  Created by Satya Kumar on 13/08/15.
//  Copyright (c) 2015 Satya Kumar. All rights reserved.
//


#import "AppTextField.h"
#import "Constant.h"
#import "CommonUtility.h"

@implementation AppTextField
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    [self setBackgroundColor:[UIColor whiteColor]];
    self.textColor=[UIColor blackColor];
    self.layer.cornerRadius=3.0;
    [CommonUtility setLeftPadding:self imageName:@"" width:5];
    if(self.placeholder!=nil)
    [self placeHolderTextField:self textForPlaceHolder:self.placeholder];
}

-(void)placeHolderTextField:(UITextField *)textField textForPlaceHolder:(NSString *)text
{
    UIColor *color = [UIColor whiteColor];
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName: color}];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
