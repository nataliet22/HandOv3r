//
//  UIImage+ResizeImage.h
//  ImageFilters
//
//  Created by Satya on 10/28/13.
//  Copyright (c) 2013 IOS DEVELOPER 0125. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ResizeImage)

- (UIImage *)resizeImageToSize:(CGSize)targetSize;

- (UIImage *)croppedImage:(CGRect)bounds;

//- (UIImage *)thumbnailImage:(NSInteger)thumbnailSize transparentBorder:(NSUInteger)borderSize cornerRadius:(NSUInteger)cornerRadius interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage *)resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality;

-(UIImage *)resizeImageToWidth:(int)width andHeight:(int)height;
-(UIImage *)scaleAndRotateWithSize:(CGSize ) newSize;
@end
