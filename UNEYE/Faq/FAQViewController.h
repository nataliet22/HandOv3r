//
//  FAQViewController.h
//  UNEYE
//
//  Created by Satya Kumar on 19/03/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "UNResizableTextView.h"

@interface FAQViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIScrollView *faqScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *faqUserGuideImageVw;
@property (weak, nonatomic) IBOutlet UNResizableTextView *faqUserGuideTextVw;

@end
