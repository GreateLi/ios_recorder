//
//  ViewController.m
//  Recorder
//
//  Created by xiaoming on 15/3/2.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "ViewController.h"
#import "Recorder.h"
#import "AudioPlayer.h"

@interface ViewController ()
{
    Recorder *recorder;
    AudioPlayer *player;
    UIImagePickerController *picker;

}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    picker = [[UIImagePickerController alloc]init];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)recordClick:(id)sender {
    UIButton *bt = (UIButton *)sender;
    if([bt.titleLabel.text isEqualToString:@"录音"])
    {
        [bt setTitle:@"停止" forState:UIControlStateNormal];
        recorder = [[Recorder alloc]init];
        [recorder startRec];
    }
    else
    {
        [bt setTitle:@"录音" forState:UIControlStateNormal];
        [recorder stopRec];
    }
    
}

- (IBAction)playClick:(id)sender {
    UIButton *bt = (UIButton *)sender;
    if([bt.titleLabel.text isEqualToString:@"播放"])
    {
        [bt setTitle:@"停止" forState:UIControlStateNormal];
        player = [[AudioPlayer alloc]initWithFilePath:recorder.filePath];
        [player play];
    }
    else
    {
        [bt setTitle:@"播放" forState:UIControlStateNormal];
        [player stop];
    }
}

- (IBAction)photoClick:(id)sender {
    //调用相机
    //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机，不可用将sourceType设定为相片库
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    //sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
    //sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //图片库
    //sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; //保存的相片
    
    picker.delegate = self;
    //        picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = sourceType;
    picker.modalPresentationStyle = UIModalPresentationCurrentContext;
//    [self presentViewController:picker animated:YES completion:NULL];//进入照相界面
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)pickers
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image= [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    if (pickers.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
    else if(pickers.sourceType == UIImagePickerControllerSourceTypePhotoLibrary)
    {
    }
    self.imageView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
