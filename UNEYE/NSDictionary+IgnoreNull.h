//
//  NSDictionary+IgnoreNull.h
//  UNEYE
//
//  Created by Satya Kumar on 13/05/15.
//  Copyright (c) 2015 Satya Kumar All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (IgnoreNull)
-(id)valueForKeyOrNull:(NSString *)key;
@end
