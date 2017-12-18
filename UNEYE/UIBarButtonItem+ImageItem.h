//
//  UIBarButtonItem+ImageItem.h
//  UNEYE
//
//  Created by Satya Kumar on 2/4/14.
//  Copyright (c) 2014 Apptech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ImageItem)

+ (UIBarButtonItem*)barLeftItemWithImage:(UIImage*)image target:(id)target action:(SEL)action;
+ (UIBarButtonItem*)barRightItemWithImage:(UIImage*)image target:(id)target action:(SEL)action;
+(UIBarButtonItem *)barButtonWithImage:(UIImage *)image withTitle:(NSString *)title target:(id)target action:(SEL)action;
@end
