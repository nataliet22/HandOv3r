//
//  ProfessionalskillsDisplayCell.m
//  HandOv3r
//
//  Created by Satya Kumar on 4/12/17.
//  Copyright © 2017 Satya Kumar. All rights reserved.
//

#import "ProfessionalskillsDisplayCell.h"

@implementation ProfessionalskillsDisplayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)areaOFSkillCheckBoxBtnClicked:(id)sender {
    
    [_mydelegate getCheckMarkIndex:@"checked" key:[NSString stringWithFormat:@"%ld", (long)self.areaOFSkillCheckBoxBtn.tag]];
}

@end
