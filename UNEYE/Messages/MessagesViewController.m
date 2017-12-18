//
//  MessagesViewController.m
//  UNEYE
//
//  Created by Satya Kumar on 10/03/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import "MessagesViewController.h"
#import "SendMessageViewController.h"
#import "CustomCell.h"

@interface MessagesViewController (){

    NSMutableArray *messagesListArray;
    
    NSMutableDictionary *messageThreadDetailDict;
}
@property (weak, nonatomic) IBOutlet UIView *messageTitle_View;
@property (weak, nonatomic) IBOutlet UITableView *messageListTableView;

@end

@implementation MessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (IS_IPHONE_6) {
        _messageTitle_View.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addConstraints:[NSLayoutConstraint
                                   constraintsWithVisualFormat:@"H:[_messageTitle_View(==140)]-|"
                                   options:NSLayoutFormatDirectionLeadingToTrailing
                                   metrics:nil
                                   views:NSDictionaryOfVariableBindings(_messageTitle_View)]];
    }else if (IS_IPHONE_6P) {
        _messageTitle_View.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addConstraints:[NSLayoutConstraint
                                   constraintsWithVisualFormat:@"H:[_messageTitle_View(==160)]-|"
                                   options:NSLayoutFormatDirectionLeadingToTrailing
                                   metrics:nil
                                   views:NSDictionaryOfVariableBindings(_messageTitle_View)]];
    }
    
    [self getAllMessages];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getAllMessages];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark get All User Messages
-(void)getAllMessages
{
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable){
        kCustomAlertWithParamAndTarget(@"Message", @"Internet connection not available.", nil);
        return;
    }
    
    [kAppDelegete showHUDVIEW:self.view];
    
    NSLog(@"User data :- %@", [CommonUtility sharedInstance].userDictionary);
    
    [[IQWebService service] getAllMessagesWithUserId:[[[CommonUtility sharedInstance].userDictionary objectForKey:@"user"]valueForKey:@"uid"] CompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
      
        //---- Hide HUD View ---
        [kAppDelegete removeHUDVIEW];
        
        NSUInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
        
        if (!error && statusCode == 200) {
            
            NSError *error = nil;
            NSMutableArray * jsonObject = (NSMutableArray *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSLog(@"jsonObject :- %@", jsonObject);
            
            messagesListArray = jsonObject;
            [_messageListTableView reloadData];
            
        }
        else {
            
            kCustomAlertWithParamAndTarget(@"Message", error.localizedDescription, nil);
        }
    }];
}

#pragma mark get All Threads Of Messages
-(void)getAllThreadsOfMessages:(NSDictionary *)messageThreadDict
{
    
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable){
        kCustomAlertWithParamAndTarget(@"Message", @"Internet connection not available.", nil);
        return;
    }
    
    [kAppDelegete showHUDVIEW:self.view];
    
    [[IQWebService service] getAllMessagesForThisThread:[messageThreadDict valueForKey:@"thread_id"] CompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //---- Hide HUD View ---
        [kAppDelegete removeHUDVIEW];
        
        NSUInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
        
        if (!error && statusCode == 200) {
            
            NSError *error = nil;
            NSMutableArray * jsonObject = (NSMutableArray *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSLog(@"All Message Treads list jsonObject :- %@", jsonObject);
            
            messageThreadDetailDict = [jsonObject firstObject];
            
            [self performSegueWithIdentifier:@"sendmessage" sender:nil];
            
        }
        else {
            
            kCustomAlertWithParamAndTarget(@"Message", error.localizedDescription, nil);
        }
    }];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"sendmessage"]){
    
        SendMessageViewController *objSendMessageViewController = (SendMessageViewController *)[segue destinationViewController];
        objSendMessageViewController.messageThreadDetailDict = messageThreadDetailDict;
    }
        
}


#pragma mark tableview delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [messagesListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *MyIdentifier;
    MyIdentifier = @"customCell";
    CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault
                                 reuseIdentifier:MyIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([[[[[messagesListArray objectAtIndex:indexPath.row] valueForKey:@"messages"] firstObject] valueForKey:@"messagesdetail"] valueForKey:@"name"]) {
        
        cell.lblTitle.text = [[[[[messagesListArray objectAtIndex:indexPath.row] valueForKey:@"messages"] firstObject] valueForKey:@"messagesdetail"] valueForKey:@"name"];
    }else{
        
        cell.lblTitle.text = @"";
    }
    
    if ([[[[[messagesListArray objectAtIndex:indexPath.row] valueForKey:@"messages"] firstObject] valueForKey:@"messagesdetail"] valueForKey:@"body"]) {
        
        cell.lblDetailText.text = [[[[[messagesListArray objectAtIndex:indexPath.row] valueForKey:@"messages"] firstObject] valueForKey:@"messagesdetail"] valueForKey:@"body"];
    }else{
        
        cell.lblDetailText.text = @"";
    }
    
    cell.userImageView.layer.cornerRadius = 40;
    [cell.userImageView setClipsToBounds:YES];
    
    if ([[[[[[messagesListArray objectAtIndex:indexPath.row] valueForKey:@"messages"] firstObject] valueForKey:@"messagesdetail"] valueForKey:@"picture"] length] > 0) {
        
        [cell.userImageView loadImage:[[[[[messagesListArray objectAtIndex:indexPath.row] valueForKey:@"messages"] firstObject] valueForKey:@"messagesdetail"] valueForKey:@"picture"]];
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self getAllThreadsOfMessages:[messagesListArray objectAtIndex:indexPath.row]];
}

@end
