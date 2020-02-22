//
//  ViewController.h
//  Recorder
//
//  Created by xiaoming on 15/3/2.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)recordClick:(id)sender;

- (IBAction)playClick:(id)sender;

- (IBAction)photoClick:(id)sender;

@end

