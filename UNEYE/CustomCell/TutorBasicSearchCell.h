//
//  TutorBasicSearchCell.h
//  UNEYE
//
//  Created by AppTech_Mac1 on 4/12/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTextField.h"
#import "CommonUtility.h"

@protocol TutorBasicSearchCellDelegate <NSObject>
@required

- (void)get:(NSString *)text key:(NSString *)key;

@end

@interface TutorBasicSearchCell : UITableViewCell <IQDropDownTextFieldDelegate>

@property (nonatomic, weak) id <TutorBasicSearchCellDelegate> mydelegate;

@property (weak, nonatomic) IBOutlet MyTextField *postCode;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *lavelOfStudy;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *areaOfStudy;
@property (weak, nonatomic) IBOutlet MyTextField *date;
@property (weak, nonatomic) IBOutlet MyTextField *time;

@end
