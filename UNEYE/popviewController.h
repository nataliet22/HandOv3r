//
//  popviewController.h
//  Seek
//
//  Created by Satya Kumar on 14/05/16.
//  Copyright © 2016 AppTech_Mac1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol EducationsCustomCellDelegate <NSObject>
@required
//- (void)reloaddata;
- (void)getSelectedItems:(NSMutableDictionary *)items;
@end

@interface popviewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    
    NSMutableArray *itemsImageArr;
    NSMutableArray *itemsTitleArr;
    
    NSMutableDictionary *selectedItemIndex;
    
    NSMutableDictionary *items;
    NSMutableDictionary *selectedQualificationItems;
}

@property (nonatomic, weak) id <EducationsCustomCellDelegate> mydelegate;

@property (weak, nonatomic) IBOutlet UIView *popUpView;
@property (weak, nonatomic) IBOutlet UITableView *optionsTableView;

@property (weak, nonatomic) NSString *selectionType;

- (void)showInView:(UIView *)aView animated:(BOOL)animated arrayItemTitles:(NSMutableArray *)arrayItemTitles arrayItemImages:(NSMutableArray *)arrayItemImages;
-(void)setItems:(NSMutableArray *)arrayItemTitles arrayItemImages:(NSMutableArray *)arrayItemImages;

@end
