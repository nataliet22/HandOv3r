//
//  ThemeManager.h
//  LifeBio
//
//  Created by Iftekhar Mac Pro on 9/12/13.
//  Copyright (c) 2013 Apptech. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* const PleaseWait;



@interface HUDManager : NSObject

+(void)showHUDWithText:(NSString*)text;

+(void)hideHUD;

+(void)hideHUDWithDelay:(NSInteger)delay;

@end
