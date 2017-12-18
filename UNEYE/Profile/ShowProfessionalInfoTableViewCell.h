//
//  ShowProfessionalInfoTableViewCell.h
//  HandOv3r
//
//  Created by Satya Kumar on 4/20/17.
//  Copyright © 2017 Satya Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowProfessionalInfoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet MyTextField *txtTypeOfCare;
@property (weak, nonatomic) IBOutlet MyTextField *txtTypeOfCareRate;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *txtAreaOfSkill;
@property (weak, nonatomic) IBOutlet MyTextField *txtAreaOfSkillRate;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *txtStudyLevel;
@property (weak, nonatomic) IBOutlet MyTextField *txtStudyLevelRate;
@property (weak, nonatomic) IBOutlet UIButton *addMoreBtn;
@property (weak, nonatomic) IBOutlet UILabel *lblAddmore;

@end
