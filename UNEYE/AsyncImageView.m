//
//  AsyncImageView.m
//  UNEYE
//
//  Created by Satya Kumar on 10/03/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import "AsyncImageView.h"
#import "AppDelegate.h"
NSMutableDictionary * dictionary;
@implementation AsyncImageView

-(void)loadImage:(NSString *)url {

	if( nil==arrayForURL){
		arrayForURL =[[NSMutableArray alloc] initWithObjects:nil];
	}
	delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
		if (url!=nil)
        {
		if([delegate.dictionaryForImageCacheing objectForKey:url])
		{
            if(isImage)
            {
                [self setImage:[UIImage imageWithData:[delegate.dictionaryForImageCacheing valueForKey:url]] forState:UIControlStateNormal];
                [self setImage:[UIImage imageWithData:[delegate.dictionaryForImageCacheing valueForKey:url]] forState:UIControlStateHighlighted];
            }
            else
            {
                [self setBackgroundImage:[UIImage imageWithData:[delegate.dictionaryForImageCacheing valueForKey:url]] forState:UIControlStateNormal];
                [self setBackgroundImage:[UIImage imageWithData:[delegate.dictionaryForImageCacheing valueForKey:url]] forState:UIControlStateHighlighted];
                
            }
			[self setBackgroundImage:[UIImage imageWithData:[delegate.dictionaryForImageCacheing valueForKey:url]] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageWithData:[delegate.dictionaryForImageCacheing valueForKey:url]] forState:UIControlStateHighlighted];
            
		} else
        {
			//ProgressBar
			progressView = [[UIProgressView alloc] initWithProgressViewStyle: UIProgressViewStyleDefault];
            progressView.frame = CGRectMake(CGRectGetMaxX(self.frame)/2, self.bounds.size.height/2, 20, 20);
            progressView.progressTintColor = [UIColor lightGrayColor];
            progressView.progress = 0.00;
			//ProgressBar
			[arrayForURL addObject:url];

			if (connection !=nil) {

				connection =nil;
			}
			
			imageData = [[NSMutableData alloc] initWithCapacity:0];
            
            [NSThread detachNewThreadSelector:@selector(loadimagedata:) toTarget:self withObject:url];
		}
	}
}

-(void)loadBackgroundImage:(NSString *)url
{
    isImage = YES;
    [self loadImage:url];
}

-(void) loadimagedata:(NSString *)sender
{
    UIActivityIndicatorView *indicator=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];

    indicator.frame = CGRectMake(CGRectGetMaxX(self.frame)/2, self.bounds.size.height/2, 20, 20);
    
    if (self.tag!=999) {
       
        [self addSubview:indicator];
        [indicator startAnimating];
    }
    
    
    NSData *tempImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:sender]];
    
    if (tempImageData != nil)
    {
        if(isImage)
        {
            [self setImage:[UIImage imageWithData:tempImageData] forState:UIControlStateNormal];
            [self setImage:[UIImage imageWithData:tempImageData] forState:UIControlStateHighlighted];
        }
        else
        {
            [self setBackgroundImage:[UIImage imageWithData:tempImageData] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageWithData:tempImageData] forState:UIControlStateHighlighted];

        }
         [delegate.dictionaryForImageCacheing setObject:tempImageData forKey:sender] ;
    }

    [indicator stopAnimating];
    [indicator removeFromSuperview];
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	//ProgressBar
	// Displays the progres bar and label
	[self addSubview:progressView];
	// Gets the total data size
	totalfilesize = [response expectedContentLength];
	//ProgressBar
	[imageData setLength:0];
}
 
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)nsdata {
	//ProgressBar
	filesizereceived += [nsdata length];
	filepercentage = (float)filesizereceived/(float)totalfilesize;
	progressView.progress = filepercentage;
	//ProgressBar
	
	[imageData appendData:nsdata];	
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[self abort];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	[progressView removeFromSuperview];
	self.contentMode = UIViewContentModeScaleAspectFit;
	self.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);

	[self abort];
}

-(void)abort
{
	if(connection != nil){
		[connection cancel];
		connection = nil;
		
        progressView=nil;
	}
	if(imageData != nil)
    {
		imageData = nil;
	}
    
    [self setBackgroundImage:nil forState:UIControlStateNormal];
    [self setImage:nil forState:UIControlStateNormal];
}


@end
