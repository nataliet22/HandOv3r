//
//  AddEventPopUpViewController.h
//  UNEYE
//
//  Created by Satya on 23/08/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTextField.h"
#import "CommonUtility.h"

@protocol AddEventPopUpViewControllerDelegate <NSObject>
@required
- (void)submitEventData:(NSMutableDictionary *)eventdata;
@end


@interface AddEventPopUpViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *popUpView;
@property (nonatomic, weak) id <AddEventPopUpViewControllerDelegate> mydelegate;

@property (weak, nonatomic) IBOutlet MyTextField *eventName;
@property (weak, nonatomic) IBOutlet MyTextField *eventVanue;
@property (weak, nonatomic) IBOutlet MyTextField *eventDate;
@property (weak, nonatomic) IBOutlet MyTextField *eventTime;



- (void)showInView:(UIView *)aView animated:(BOOL)animated;

@end
