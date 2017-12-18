//
//  FAQViewController.m
//  HandOv3r
//
//  Created by Satya Kumar on 19/03/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import "FAQViewController.h"

@interface FAQViewController ()

@end

@implementation FAQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //<i>Italic</i><p> <del>Deleted</del><p>List<ul><li>Coffee</li><li type='square'>Tea</li></ul><br><a href='URL'>Link </a>

    NSString *htmlString = @"<b>Is HandOv3r a nanny/tutor/coach agency?</b><br>No, HandOv3r is a mobile app that facilitates a <u>network</u> of workers at the ease of your finger. We do not screen job seekers or make bookings on your behalf, nor take commissions from the job seekers hard-earned dollars.<br><br><b>As a job seeker, how can I enhance my profile?</b><br>We highly recommend uploading a <u>video introduction</u> to give job providers an insight into your brilliant personality and skills! Ensure you write as many skills as you can think of in your “About Me” section, including but not limited to cooking skills, languages spoken, subject marks, ATAR, the school you attend(ed), the university you attend(ed), your experience, hours spent at home if pet sitter, and hobbies!<br>It is essential you <u>update your calendar (availability) frequently</u>, as job providers rely on this to find persons available for their requests!<br><br><b>How does HandOv3r ensure trustworthy and safety people are signed up?</b><br><br>It is ultimately your responsibility to check the person’s background. It is our aim to target responsible, safe workers who will provide the best service to you and your family! We recommend seeking a <u>police check, crosschecking references</u> and <u>interviewing</u> with a new person.<br><br><b>Are the sitters, tutors and/or coaches verified by HandOv3r?</b><br>No, it is at your discretion to choose the appropriate person that suits your needs. Hopefully your <u>mutual connections</u> can provide a helping hand, on top of the persons profile description and experience! We do not take any responsibility for an individuals actions. Please report immediately any aggressive or unwarranted behaviour.<br><br><b>Does it Cost?</b><br>HandOv3r is <u>100% free</u> for job seekers. We charge the job provider an additional <u>10% to the total payment</u>, which covers merchant fees and updates to ensure you are using an accessible platform with a network of workers for your specific needs!<br>Failure to provide payment through HandOv3r will result in immediate termination from the app.<br><br><b>Is this an affordable option?</b><br>We have built HandOv3r to be the best at <u>connecting families, individuals and pet owners</u> with workers who suit their needs, including payment terms. Please don’t hesitate to contact other local members to potentially join together to share the cost of a sitter, tutor or coach!";
    
    //htmlString = [htmlString stringByAppendingString:@"<style>body{font-family:'YOUR_FONT_HERE'; font-size:'SIZE';}</style>"];
    
    htmlString = [htmlString stringByAppendingString:[NSString stringWithFormat:@"<style>body{font-family: '%@'; font-size:%fpx;}</style>",_faqUserGuideTextVw.font.fontName,_faqUserGuideTextVw.font.pointSize]];
    
    /*Example:
     
     htmlString = [htmlString stringByAppendingString:[NSString stringWithFormat:@"<style>body{font-family: '%@'; font-size:%fpx;}</style>",_myLabel.font.fontName,_myLabel.font.pointSize]];
     */
    NSAttributedString *attributedString = [[NSAttributedString alloc]
                                            initWithData: [htmlString dataUsingEncoding:NSUnicodeStringEncoding]
                                            options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                            documentAttributes: nil
                                            error: nil
                                            ];
    _faqUserGuideTextVw.attributedText = attributedString;
    
    [_faqUserGuideTextVw updateConstraints];
    
    if (IS_IPHONE_5 || IS_IPHONE_SE){
        
        _faqUserGuideTextVw.frame = CGRectMake(_faqUserGuideTextVw.frame.origin.x, _faqUserGuideTextVw.frame.origin.y, _faqUserGuideTextVw.frame.size.width, 568.0);
        _faqScrollView.contentSize = CGSizeMake(_faqScrollView.bounds.size.width, CGRectGetMaxY(_faqUserGuideTextVw.frame) + 468);
    }else{
        
        _faqScrollView.contentSize = CGSizeMake(_faqScrollView.bounds.size.width, CGRectGetMaxY(_faqUserGuideTextVw.frame));
    }
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

-(void)viewDidLayoutSubviews
{
    // The scrollview needs to know the content size for it to work correctly
    
    if (IS_IPHONE_5 || IS_IPHONE_SE){
    
        _faqScrollView.contentSize = CGSizeMake(_faqScrollView.bounds.size.width, CGRectGetMaxY(_faqUserGuideTextVw.frame) + 468);
    }else{
    
        _faqScrollView.contentSize = CGSizeMake(_faqScrollView.bounds.size.width, CGRectGetMaxY(_faqUserGuideTextVw.frame));
    }
    
}

@end
