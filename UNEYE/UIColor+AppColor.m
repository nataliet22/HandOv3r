//
//  UIColor+AppColor.m
//  UNEYE
//
//  Created by Satya Kumar on 27/08/15.
//  Copyright (c) 2015 Satya Kumar. All rights reserved.
//

#import "UIColor+AppColor.h"

@implementation UIColor (AppColor)

+(UIColor *)appDarkBuleColor
{
    return [UIColor colorWithRed:30.0/255.0 green:174.0/255.0 blue:215.0/255.0 alpha:1.0];
}

+(UIColor *)appLightBuleColor
{
    return [UIColor colorWithRed:142.0/255.0 green:214.0/255.0 blue:235.0/255.0 alpha:1.0];
}

+(UIColor *)appSelectedCellColor
{
    return [UIColor colorWithRed:237.0/255.0 green:249.0/255.0 blue:252.0/255.0 alpha:1.0];
}

+(UIColor *)appGrayColor
{
    return [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
}

+(UIColor *)appWhiteColor
{
    return [UIColor whiteColor];
}

+(UIColor *)appDarkGrayColor
{
    return [UIColor darkGrayColor];
}

@end
