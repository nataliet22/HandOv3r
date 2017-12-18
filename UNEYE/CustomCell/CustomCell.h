//
//  CustomCell.h
//  UNEYE
//
//  Created by Satya Kumar on 18/03/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTextField.h"
#import "CommonUtility.h"

//@protocol CustomCellDelegate <NSObject>
//@required
//- (void)get:(NSString *)text key:(NSString *)key;
//@end

@interface CustomCell : UITableViewCell

//@property (nonatomic, weak) id <CustomCellDelegate> mydelegate;

@property (weak, nonatomic) IBOutlet AsyncImageView *userImageView;
@property (weak, nonatomic) IBOutlet UIButton *btnMessage;
@property (weak, nonatomic) IBOutlet UIButton *btnCancelOrBook;
@property (weak, nonatomic) IBOutlet UIImageView *accessoryImageView;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDetailText;

@end
