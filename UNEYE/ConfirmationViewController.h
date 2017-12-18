//
//  ConfirmationViewController.h
//  UNEYE
//
//  Created by AppTech_Mac1 on 4/18/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmationViewController : UIViewController

- (IBAction)backBtnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *calenderBtn;
@property (weak, nonatomic) IBOutlet UILabel *calenderHeaderLbl;

@property (weak, nonatomic) NSString *searchType;
@property (nonatomic) BOOL isFromBookingList;

@property (weak, nonatomic) IBOutlet AsyncImageView *imageView;
@property (strong, nonatomic) NSMutableDictionary *selectedUserDict;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) NSMutableDictionary *selectedAppointmentData;
@property (strong, nonatomic) NSString *additional_requirements_str;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *confirmationLbl;
@property (weak, nonatomic) IBOutlet UIButton *bookBtn;
@property (weak, nonatomic) IBOutlet UIButton *interViewBtn;
@property (weak, nonatomic) IBOutlet UIButton *addMoreTimeBtn;


@end
