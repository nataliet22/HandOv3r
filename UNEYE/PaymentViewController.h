//
//  PaymentViewController.h
//  UNEYE
//
//  Created by AppTech_Mac1 on 4/19/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTextField.h"
#import "CommonUtility.h"
#import "BraintreeCore.h"
#import "BraintreeUI.h"


@protocol PaymentViewControllerDelegate <NSObject>
@required

- (void)get:(NSString *)text key:(NSString *)key;

@end

@interface PaymentViewController : UIViewController<BTDropInViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *endBtn;
@property (nonatomic)  BOOL isBookedSucess;


@property (nonatomic, weak) id < PaymentViewControllerDelegate> mydelegate;

@property (weak, nonatomic) IBOutlet MyTextField *txtStartTime;
@property (weak, nonatomic) IBOutlet MyTextField *txtEndTime;
- (IBAction)backBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *totalAmountTextField;
@property (weak, nonatomic) IBOutlet UITextField *tenPercentAmountTextField;

@property (weak, nonatomic) NSString *searchType;
@property (weak, nonatomic) IBOutlet AsyncImageView *imageView;
@property (weak, nonatomic) NSDictionary *selectedUserDict;
@property (strong, nonatomic) NSMutableDictionary *selectedAppointmentData;
@property (strong, nonatomic) NSString *additional_requirements_str;

@end
