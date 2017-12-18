//
//  NSDictionary+IgnoreNull.m
//  UNEYE
//
//  Created by Satya Kumar on 13/05/15.
//  Copyright (c) 2015 Satya Kumar All rights reserved.
//

#import "NSDictionary+IgnoreNull.h"

@implementation NSDictionary (IgnoreNull)
-(id)valueForKeyOrNull:(NSString *)key
{
    id obj= [self valueForKey:key];
    return [obj isEqual:[NSNull null]]?@"":obj;
}
@end
