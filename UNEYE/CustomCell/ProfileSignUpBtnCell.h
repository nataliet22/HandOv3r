//
//  ProfileSignUpBtnCell.h
//  UNEYE
//
//  Created by AppTech_Mac1 on 4/8/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProfileSignUpBtnCellDelegate <NSObject>
@required
- (void)signUpForm;
@end

@interface ProfileSignUpBtnCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@property (nonatomic, weak) id <ProfileSignUpBtnCellDelegate> mydelegate;

- (IBAction)signUpBtnClicked:(id)sender;

@end
