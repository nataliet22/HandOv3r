//
//  CameraControllerHandler.h
//  UNEYE
//
//  Created by Satya Kumar on 13/04/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CameraControllerHandlerDelegate <NSObject>
@required
- (void)getImage:(UIImage *)image vedioUrl:(NSURL *)vedioUrl key:(NSString *)key;
@end

@interface CameraControllerHandler : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>{

    BOOL isProfileFlag;
}

@property (nonatomic, weak) id <CameraControllerHandlerDelegate> mydelegate;

//-- Camera Open --
-(void)openCamera:(BOOL)isProfile;
@end
