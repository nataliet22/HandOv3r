//
//  CameraControllerHandler.m
//  UNEYE
//
//  Created by Satya Kumar on 13/04/16.
//  Copyright © 2016 Satya Kumar. All rights reserved.
//

#import "CameraControllerHandler.h"

@implementation CameraControllerHandler

-(void)openCamera:(BOOL)isProfile{

    isProfileFlag = isProfile;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    [picker setDelegate:self];
    picker.allowsEditing = YES;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:picker animated:YES completion:NULL];
    
//    [self.view addSubview:picker.view];
//    [self addChildViewController:picker];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    NSLog(@"type=%@",type);
    
    if ([type isEqualToString:(NSString *)kUTTypeVideo] || [type isEqualToString:(NSString *)kUTTypeMovie])
    {
        NSURL *urlvideo = [info objectForKey:UIImagePickerControllerMediaURL];
        
        [picker dismissViewControllerAnimated:YES completion:^{
            [self.mydelegate getImage:nil vedioUrl:urlvideo key:@"video"];
        }];
    }else{
    
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        
        [picker dismissViewControllerAnimated:YES completion:^{
            
            if (isProfileFlag) {
                [self.mydelegate getImage:chosenImage vedioUrl:nil key:@"profileimage"];
            }else{
            
                [self.mydelegate getImage:chosenImage vedioUrl:nil key:@"image"];
            }
        }];
    }
}

@end
