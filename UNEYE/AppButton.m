//
//  AppButton.m
//  UNEYE
//
//  Created by Satya Kumar on 27/08/15.
//  Copyright (c) 2015 Satya Kumar. All rights reserved.
//

#import "AppButton.h"
#import "UIColor+AppColor.h"
@implementation AppButton

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if(self)
        [self initialize];
    return self;
}
-(void)initialize
{
    [self setBackgroundColor:[UIColor clearColor]];
    //[self.layer setCornerRadius:5.0];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
