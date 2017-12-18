//
//  UIBarButtonItem+ImageItem.m
//  UNEYE
//
//  Created by Satya Kumar on 2/4/14.
//  Copyright (c) 2014 Apptech. All rights reserved.
//

#import "UIBarButtonItem+ImageItem.h"

@implementation UIBarButtonItem (ImageItem)


+(UIBarButtonItem *)barLeftItemWithImage:(UIImage *)image target:(id)target action:(SEL)action
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 50, 30);
    [button setImage:image forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* item = [[self alloc] initWithCustomView:button];
    return item;
}

+(UIBarButtonItem *)barRightItemWithImage:(UIImage *)image target:(id)target action:(SEL)action
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 50, 30);
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    UIBarButtonItem* item = [[self alloc] initWithCustomView:button];
    return item;
}


+(UIBarButtonItem *)barButtonWithImage:(UIImage *)image withTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 30, 30);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0]];
    [button setBackgroundColor:[UIColor clearColor]];
    //[button setBackgroundImage:image forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* item = [[self alloc] initWithCustomView:button];
    return item;

}
@end
