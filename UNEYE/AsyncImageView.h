//
//  AsyncImageView.h
//  UNEYE
//
//  Created by Satya Kumar on 10/03/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@class HFHAppDelegate;

@interface AsyncImageView : UIButton {
@private
	NSURLConnection *connection;
	NSMutableData   *imageData;
	AppDelegate *delegate;
	NSMutableArray *arrayForURL;

	//ProgressBar
	UIProgressView *progressView;
	
	float totalfilesize;
	int filesizereceived;
	float filepercentage;
	BOOL isImage;
}

-(void)loadBackgroundImage:(NSString *)url;
-(void)loadImage:(NSString *)url;
-(void)abort;

@end
