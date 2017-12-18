//
//  NewEnrollQuestPracticeContactDetailCell.h
//  UNEYE
//
//  Created by Satya Kumar on 17/03/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTextField.h"
#import "CommonUtility.h"

@protocol AdditionalfamilymemebercellDelegate <NSObject>
@required
//- (void)get:(NSString *)text key:(NSString *)key parentkey:(NSString *)parentkey;
- (void)get:(NSString *)key value:(NSString *)value parentkey:(NSString *)parentkey index:(NSString *)index;
@end

@interface Additionalfamilymemebercell : UITableViewCell

@property (nonatomic, weak) id <AdditionalfamilymemebercellDelegate> mydelegate;

@property (weak, nonatomic) IBOutlet MyTextField *txtName;
@property (weak, nonatomic) IBOutlet MyTextField *txtAge;
@property (weak, nonatomic) IBOutlet MyTextField *txtRequirements;
@property (weak, nonatomic) IBOutlet AsyncImageView *videoThumpBtn;
@property (weak, nonatomic) IBOutlet UILabel *lblAddMoreMem;
@property (weak, nonatomic) IBOutlet UILabel *lblVideoIntro;
@property (weak, nonatomic) IBOutlet UIButton *btnAddMoreMem;

@end
