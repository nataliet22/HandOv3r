//
//  SendMessageViewController.m
//  UNEYE
//
//  Created by Satya Kumar on 04/07/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import "SendMessageViewController.h"

@interface SendMessageViewController ()<UITextFieldDelegate>
{
    
    NSMutableArray *arrayMesages;
}
@property (weak, nonatomic) IBOutlet UITableView *tableViewChat;
@property (weak, nonatomic) IBOutlet UITextField *tfMessage;
@property (weak, nonatomic) IBOutlet AsyncImageView *recepientImageView;

@end

@implementation SendMessageViewController

@synthesize messageThreadDetailDict, recipientId, recipientPic;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"messageThreadDetailDict :- %@", messageThreadDetailDict);
    
    //[_tableViewChat setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgimage"]]];
    _tableViewChat.estimatedRowHeight = 50;
    _tableViewChat.rowHeight = UITableViewAutomaticDimension;
    
    arrayMesages = [NSMutableArray new];
    [arrayMesages addObjectsFromArray:[messageThreadDetailDict valueForKey:@"messagesdetail"]];
    
    _recepientImageView.layer.cornerRadius = 20.0;
    _recepientImageView.layer.masksToBounds = YES;
    
    if (recipientPic) {
        [_recepientImageView loadImage:recipientPic];
        recipientPic = @"";
    }else{
    
        if ([[[messageThreadDetailDict valueForKey:@"messagesdetail"] firstObject] valueForKey:@"picture"]) {
            [_recepientImageView loadImage:[[[messageThreadDetailDict valueForKey:@"messagesdetail"] firstObject] valueForKey:@"picture"]];
        }
    }
}

- (IBAction)backBtnClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)send:(id)sender {
    
    if (![_tfMessage.text isEqualToString:@""]) {
        
        [_tfMessage resignFirstResponder];
        
        if ([recipientId length] > 0) {
            //--- Call for a message ---
            NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"newsub", @"subject",
                                   _tfMessage.text, @"body", recipientId, @"recipient", nil];
            
            [self sendMessage:param];
            //recipientId = @"";
            
        }else{
        
            //--- Call for within Thread of message ---
            if ([[[messageThreadDetailDict valueForKey:@"messagesdetail"] firstObject] valueForKey:@"user"]) {
                NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"newsub", @"subject",
                                       _tfMessage.text, @"body", [messageThreadDetailDict valueForKey:@"thread_id"], @"thread_id", [[[messageThreadDetailDict valueForKey:@"messagesdetail"] firstObject] valueForKey:@"user"], @"recipient", nil];
                
                [self sendMessage:param];
            }
        }
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return arrayMesages.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *userId = [[[CommonUtility sharedInstance].userDictionary valueForKey:@"user"] valueForKey:@"uid"];
    
    NSString *sender = [[arrayMesages objectAtIndex:indexPath.row] valueForKey:@"user"];
    
    if ([sender isEqualToString:userId]) {
        UITableViewCell *cellRight = [tableView dequeueReusableCellWithIdentifier:@"right"];
        UILabel *label = [cellRight viewWithTag:2];
        label.layer.borderWidth = 1.0;
        label.layer.borderColor = [UIColor orangeColor].CGColor;
        label.layer.cornerRadius = 4.0;
        label.text = [NSString stringWithFormat:@"%@", [[arrayMesages objectAtIndex:indexPath.row] valueForKey:@"body"]];
        label.clipsToBounds = YES;
        
        if (indexPath.row == [arrayMesages count] - 1) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // code here
                NSIndexPath *path = [NSIndexPath indexPathForRow:[arrayMesages count] - 1 inSection:0];
                [tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            });
        }

        return cellRight;
    }
    else {
        
        UITableViewCell *cellleft = [tableView dequeueReusableCellWithIdentifier:@"left"];
        UILabel *label = [cellleft viewWithTag:2];
        label.layer.borderWidth = 1.0;
        label.layer.borderColor = [UIColor orangeColor].CGColor;
        label.layer.cornerRadius = 4.0;
        label.text = [NSString stringWithFormat:@"  %@", [[arrayMesages objectAtIndex:indexPath.row] valueForKey:@"body"]];
        label.clipsToBounds = YES;
        
        if (indexPath.row == [arrayMesages count] - 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // code here
                NSIndexPath *path = [NSIndexPath indexPathForRow:[arrayMesages count] - 1 inSection:0];
                [tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            });

        }

        return cellleft;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark get All Threads Of Messages
-(void)sendMessage:(NSDictionary *)messageThreadDict
{
    
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable){
        kCustomAlertWithParamAndTarget(@"Message", @"Internet connection not available.", nil);
        return;
    }
    
    [kAppDelegete showHUDVIEW:self.view];
    
    [[IQWebService service] sendMessageWithinThread:messageThreadDict CompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //---- Hide HUD View ---
        [kAppDelegete removeHUDVIEW];
        
        NSUInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
        
        if (!error && statusCode == 200) {
            
            NSError *error = nil;
            NSMutableArray * jsonObject = (NSMutableArray *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSLog(@"All Message Treads list jsonObject :- %@", jsonObject);
            
            if ([[jsonObject valueForKey:@"result"] isEqualToString:@"success"]) {
                [arrayMesages addObject:[jsonObject valueForKey:@"messagesdetail"]];
                [_tableViewChat reloadData];
                _tfMessage.text = @"";
            }
            
            //---- Check current Message Thread ----
            if ([recipientId length] > 0 && [[jsonObject valueForKey:@"result"] isEqualToString:@"success"]) {
                //recipientId = @"";
            }
        }
        else {
            
            kCustomAlertWithParamAndTarget(@"Message", error.localizedDescription, nil);
        }
        
    }];
}

@end
