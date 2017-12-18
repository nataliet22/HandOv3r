//
//  ThemeManager.m
//  LifeBio
//
//  Created by Iftekhar Mac Pro on 9/12/13.
//  Copyright (c) 2013 Apptech. All rights reserved.
//

#import "HUDManager.h"
#import "MBProgressHUD.h"

NSString* const PleaseWait = @"Please wait";

static MBProgressHUD *aHUD;

@implementation HUDManager

+(void)showHUDWithText:(NSString*)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        
        if (aHUD == nil)
            aHUD = [[MBProgressHUD alloc] initWithWindow:window];
        
        [aHUD setRemoveFromSuperViewOnHide:YES];
        [aHUD setLabelText:text];
        [window addSubview:aHUD];
        [aHUD show:YES];
    });
}

+(void)hideHUD
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [aHUD hide:YES];
    });
}

+(void)hideHUDWithDelay:(NSInteger)delay
{
    [aHUD hide:YES afterDelay:delay];
}


@end

