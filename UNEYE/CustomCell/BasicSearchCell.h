//
//  BasicSearchCell.h
//  UNEYE
//
//  Created by AppTech_Mac1 on 4/11/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTextField.h"
#import "CommonUtility.h"

@protocol BasicSearchCellDelegate <NSObject>
@required

- (void)get:(NSString *)text key:(NSString *)key;

@end

@interface BasicSearchCell : UITableViewCell

@property (nonatomic, weak) id <BasicSearchCellDelegate> mydelegate;

@property (weak, nonatomic) IBOutlet MyTextField *postCode;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *required;
@property (weak, nonatomic) IBOutlet MyTextField *date;
@property (weak, nonatomic) IBOutlet MyTextField *txtTime;

@end
