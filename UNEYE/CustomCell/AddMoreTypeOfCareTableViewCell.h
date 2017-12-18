//
//  AddMoreTypeOfCareTableViewCell.h
//  UNEYE
//
//  Created by Satya on 03/09/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddMoreTypeOfCareTableViewCellDelegate <NSObject>
@required
- (void)get:(NSString *)text key:(NSString *)key;
@optional
- (void)getSubCategories:(NSString *)text key:(NSString *)key index:(NSInteger)index;

@end


@interface AddMoreTypeOfCareTableViewCell : UITableViewCell{

    NSMutableArray *arrTypeOfCare;
}

@property (weak, nonatomic) IBOutlet IQDropDownTextField *txtRequired;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *txtCaochRequired;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *txtTutorRequired;

@property (nonatomic, weak) id <AddMoreTypeOfCareTableViewCellDelegate> mydelegate;
@property (weak, nonatomic) IBOutlet UIView *basicInfoVw;
@property (weak, nonatomic) IBOutlet UIButton *addMoreBtn;
@property (weak, nonatomic) IBOutlet UILabel *lblAddmore;

@end
