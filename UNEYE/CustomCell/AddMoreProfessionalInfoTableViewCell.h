//
//  AddMoreProfessionalInfoTableViewCell.h
//  HandOv3r
//
//  Created by Satya on 06/11/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddMoreProfessionalInfoTableViewCellDelegate <NSObject>
@required
- (void)get:(NSString *)text key:(NSString *)key;
@optional
- (void)getSubCategories:(NSString *)text key:(NSString *)key index:(NSInteger)index;
@end

@interface AddMoreProfessionalInfoTableViewCell : UITableViewCell

@property (nonatomic, weak) id <AddMoreProfessionalInfoTableViewCellDelegate> mydelegate;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *txtTypeOfCare;
@property (weak, nonatomic) IBOutlet MyTextField *txtTypeOfCareRate;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *txtAreaOfSkill;
@property (weak, nonatomic) IBOutlet MyTextField *txtAreaOfSkillRate;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *txtStudyLevel;
@property (weak, nonatomic) IBOutlet MyTextField *txtStudyLevelRate;
@property (weak, nonatomic) IBOutlet UIButton *addMoreBtn;
@property (weak, nonatomic) IBOutlet UILabel *lblAddmore;

@end
