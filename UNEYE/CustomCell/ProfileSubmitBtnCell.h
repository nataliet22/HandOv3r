//
//  ProfileSubmitBtnCell.h
//  UNEYE
//
//  Created by Satya Kumar on 19/03/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProfileSubmitBtnCellDelegate <NSObject>
@required
- (void)submitForm;
@end

@interface ProfileSubmitBtnCell : UITableViewCell

@property (nonatomic, weak) id <ProfileSubmitBtnCellDelegate> mydelegate;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end
