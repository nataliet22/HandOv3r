//
//  InvoicesViewController.m
//  UNEYE
//
//  Created by Satya Kumar on 18/03/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import "InvoicesViewController.h"
#import "CustomCell.h"

@interface InvoicesViewController (){

    NSMutableDictionary *invoiceDataDict;
}

@property (weak, nonatomic) IBOutlet UIView *invoicesTitle_View;
@property (weak, nonatomic) IBOutlet UITableView *invoicesTableview;

@end

@implementation InvoicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    if (IS_IPHONE_6) {
//        _invoicesTitle_View.translatesAutoresizingMaskIntoConstraints = NO;
//        [self.view addConstraints:[NSLayoutConstraint
//                                   constraintsWithVisualFormat:@"H:[_invoicesTitle_View(==140)]-|"
//                                   options:NSLayoutFormatDirectionLeadingToTrailing
//                                   metrics:nil
//                                   views:NSDictionaryOfVariableBindings(_invoicesTitle_View)]];
//    }else if (IS_IPHONE_6P) {
//        _invoicesTitle_View.translatesAutoresizingMaskIntoConstraints = NO;
//        [self.view addConstraints:[NSLayoutConstraint
//                                   constraintsWithVisualFormat:@"H:[_invoicesTitle_View(==160)]-|"
//                                   options:NSLayoutFormatDirectionLeadingToTrailing
//                                   metrics:nil
//                                   views:NSDictionaryOfVariableBindings(_invoicesTitle_View)]];
//    }
    
    [self getAllInvoicesApiCall];
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
-(void)getAllInvoicesApiCall
{
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable){
        kCustomAlertWithParamAndTarget(@"Message", @"Internet connection not available.", nil);
        return;
    }
    
    [kAppDelegete showHUDVIEW:self.view];
    
    [[IQWebService service]getAllInvoicesWithCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
       
                [kAppDelegete removeHUDVIEW];
        
                NSUInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
                if (!error && statusCode == 200) {
        
                    NSError *error = nil;
                    NSMutableDictionary * jsonObject = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                    NSLog(@"jsonObject :- %@", jsonObject);
                    
                    invoiceDataDict = jsonObject;
                    [_invoicesTableview reloadData];
                    
                }
                else {
                    
                        kCustomAlertWithParamAndTarget(@"Message", error.localizedDescription, nil);
                    
                        NSError *error = nil;
                        NSDictionary * jsonObject = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                        NSLog(@"jsonObject :- %@", jsonObject);
                }
    }];
    
}
#pragma mark tableview delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[invoiceDataDict valueForKey:@"results"] count];
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
    
    cell.accessoryImageView.hidden = YES;
    cell.btnMessage.hidden = YES;
    cell.btnCancelOrBook.hidden = YES;
    
    if ([[[invoiceDataDict valueForKey:@"results"] objectAtIndex:indexPath.row] valueForKey:@"booked_user_name"]) {
        
        cell.lblTitle.text = [[[invoiceDataDict valueForKey:@"results"] objectAtIndex:indexPath.row] valueForKey:@"booked_user_name"];
    }else{
        
        cell.lblTitle.text = @"";
    }

    
    NSString *appointmentDate;
    if ([[[invoiceDataDict valueForKey:@"results"] objectAtIndex:indexPath.row] valueForKey:@"datetime"]) {
        NSArray *temp = [[[[invoiceDataDict valueForKey:@"results"] objectAtIndex:indexPath.row] valueForKey:@"datetime"] componentsSeparatedByString:@"to"];
        appointmentDate = [temp firstObject];
    }else{
        
        appointmentDate = @"";
    }
    
    cell.lblDetailText.text = appointmentDate;
    
    cell.userImageView.layer.cornerRadius = 40;
    [cell.userImageView setClipsToBounds:YES];
    
    if ([[[[invoiceDataDict valueForKey:@"results"] objectAtIndex:indexPath.row] valueForKey:@"Picture"] length] > 0) {
        
        [cell.userImageView loadImage:[[[invoiceDataDict valueForKey:@"results"] objectAtIndex:indexPath.row] valueForKey:@"Picture"]];
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    //--- Get Booking Detail ---
//    NSString *invoiceId = [[[invoiceDataDict valueForKey:@"results"] objectAtIndex:indexPath.row] valueForKey:@"nid"];
//    [self getInvoiceDetail:invoiceId];
}

#pragma mark Invoice Detail API
-(void)getInvoiceDetail:(NSString *)invoiceId{
    
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable){
        kCustomAlertWithParamAndTarget(@"Message", @"Internet connection not available.", nil);
        return;
    }
    
    [kAppDelegete showHUDVIEW:self.view];
    
    [[IQWebService service] getInvoiceDetail:invoiceId CompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //---- Hide HUD View ---
        [kAppDelegete removeHUDVIEW];
        
        NSUInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
        if (!error && statusCode == 200) {
            
            //--- Get login token ---
            NSError *error = nil;
            NSDictionary * jsonObject = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSLog(@"jsonObject :- %@", jsonObject);
            
        }else {
            
            kCustomAlertWithParamAndTarget(@"Message", error.localizedDescription, nil);
        }
    }];
}

@end
