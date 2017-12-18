//
//  SendMessageViewController.h
//  UNEYE
//
//  Created by Satya Kumar on 04/07/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendMessageViewController : UIViewController

@property (weak, nonatomic) NSDictionary *messageThreadDetailDict;

@property (weak, nonatomic) NSString *recipientId;
@property (weak, nonatomic) NSString *recipientPic;

@end
