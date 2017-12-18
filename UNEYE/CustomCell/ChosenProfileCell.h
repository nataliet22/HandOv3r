//
//  ChosenProfileCell.h
//  UNEYE
//
//  Created by AppTech_Mac1 on 4/16/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface ChosenProfileCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *aboutMeLabel;
@property (weak, nonatomic) IBOutlet UILabel *experienceLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *referenceCheckMarkImageView;
@property (weak, nonatomic) IBOutlet UIImageView *mututalConUser1;
@property (weak, nonatomic) IBOutlet UIImageView *mututalConUser2;
@property (weak, nonatomic) IBOutlet UIImageView *mututalConUser3;
@property (weak, nonatomic) IBOutlet AsyncImageView *videoPreviewButton;
@property (weak, nonatomic) IBOutlet UIButton *requestButton;

@end
