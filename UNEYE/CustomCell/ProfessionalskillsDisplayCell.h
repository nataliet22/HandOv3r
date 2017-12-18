//
//  ProfessionalskillsDisplayCell.h
//  HandOv3r
//
//  Created by Satya Kumar on 4/12/17.
//  Copyright © 2017 Satya Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProfessionalskillsDisplayCellDelegate <NSObject>
@required
- (void)getCheckMarkIndex:(NSString *)text key:(NSString *)key;
@end

@interface ProfessionalskillsDisplayCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *areaOFSkillLbl
;
@property (weak, nonatomic) IBOutlet UILabel *areaOFSkillRateLbl;
@property (weak, nonatomic) IBOutlet UIButton *areaOFSkillCheckBoxBtn;

@property (nonatomic, weak) id <ProfessionalskillsDisplayCellDelegate> mydelegate;

@end
