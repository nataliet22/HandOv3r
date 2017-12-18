//
//  JobSeekerViewController.h
//  UNEYE
//
//  Created by AppTech_Mac1 on 4/6/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InformationCell.h"
#import "CalenderCell.h"
#import "ProfileSignUpBtnCell.h"
#import "RSDatePickerController.h"

@interface JobSeekerViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate, InformationCellDelegate, CalendercellDelegate, ProfileSignUpBtnCellDelegate,IQDropDownTextFieldDelegate,RSDatePickerDelegate>

- (IBAction)backBtnClick:(id)sender;

@end
