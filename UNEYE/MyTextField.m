//
//  MyTextField.m
//  UNEYE
//
//  Created by Satya Kumar on 07/08/15.
//  Copyright (c) 2015 Satya Kumar. All rights reserved.
//

#import "MyTextField.h"
#import "UIColor+AppColor.h"
#import "CommonUtility.h"
//#import "ASValuePopUpView.h"

@implementation MyTextField

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
    [self setBackgroundColor:[UIColor clearColor]];
    self.textColor=[UIColor appDarkGrayColor];
    if(self.placeholder!=nil)
        [self placeHolderTextField:self textForPlaceHolder:self.placeholder];
    
    UIView *view = [[UIView alloc]init];
    [view setBackgroundColor:[UIColor clearColor]];
    [self insertSubview:view atIndex:0];
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0.6]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
   
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
   
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self layoutIfNeeded];
    [self updateConstraints];
}

-(void)placeHolderTextField:(UITextField *)textField textForPlaceHolder:(NSString *)text
{
    UIColor *color = [UIColor darkGrayColor];
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName: color}];
}

-(void)showToolTipWithMessage:(NSString*)message
{

}

@end
