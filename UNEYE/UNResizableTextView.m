//
//  UNResizableTextView.m
//
//  Created by Satya Kumar on 25.07.14.
//

#import "UNResizableTextView.h"

@implementation UNResizableTextView
- (void) updateConstraints {
    // calculate contentSize manually (ios7 doesn't calculate it before viewDidAppear, and we'll get here before)
    CGSize contentSize = [self sizeThatFits:CGSizeMake(self.frame.size.width, CGFLOAT_MAX)];
    
    // set the height constraint to change textView height
    [self.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight) {
            constraint.constant = contentSize.height;
            *stop = YES;
        }
    }];
    
    [super updateConstraints];
}
@end
