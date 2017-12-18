//
//  SearchResultCell.h
//  UNEYE
//
//  Created by AppTech_Mac1 on 4/15/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol SearchResultCellDelegate <NSObject>
//@required

//- (void)get:(NSString *)text key:(NSString *)key;

//@end

@interface SearchResultCell : UITableViewCell

//@property (nonatomic, weak) id <SearchResultCellDelegate> mydelegate;
@property (weak, nonatomic) IBOutlet AsyncImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *userPostCodeLbl;
@property (weak, nonatomic) IBOutlet UILabel *userRateLbl;
@property (weak, nonatomic) IBOutlet UIImageView *referenceImageview;

@end
