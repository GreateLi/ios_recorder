//
//  Recorder.m
//  Recorder
//
//  Created by xiaoming on 15/3/2.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "Recorder.h"

@implementation Recorder
- (id)init
{
    self = [super init];
    if(self)
    {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        
        NSError *err = nil;
        
        [audioSession setCategory :AVAudioSessionCategoryPlayback error:&err];
        NSError *error = nil;
        NSURL *fileURL = [[NSURL alloc]initWithString:[self getCacheDirectory]];
        self.recorder = [[AVAudioRecorder alloc]initWithURL:fileURL settings:[Recorder getAudioRecorderSettingDict] error:&error];
        self.recorder.delegate = self;
        if(error)
        {
            NSLog(@"Recorder error:%@",error.localizedDescription);
        }
    }
    return self;
}

- (BOOL)startRec
{
    if(!self.recorder.recording)
    {
        [self.recorder prepareToRecord];
        return [self.recorder record];
    }
    return NO;
}

- (void)pauseRec
{
    [self.recorder pause];
}

- (void)stopRec
{
    [self.recorder stop];
}

/**
	获取缓存路径
	@returns 缓存路径
 */
- (NSString*)getCacheDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [NSString stringWithFormat:@"%@/%@",[[paths objectAtIndex:0]stringByAppendingPathComponent:@"Voice"],[Recorder getCurrentTimeString]];
    NSFileManager *manager = [[NSFileManager alloc]init];
    if (![manager fileExistsAtPath:path]) {
        NSError *error = nil;
        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"creat error : %@",error.description);
        }
    }
    path = [path stringByAppendingPathExtension:@"wav"];
    self.filePath = path;
    return path;
}

/**
	获取录音设置
	@returns 录音设置
 */
+ (NSDictionary*)getAudioRecorderSettingDict
{
    NSDictionary *recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   [NSNumber numberWithFloat: 8000.0],AVSampleRateKey, //采样率
                                   [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
                                   [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,//采样位数 默认 16
                                   [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,//通道的数目
                                   //                                   [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey,//大端还是小端 是内存的组织方式
                                   //                                   [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,//采样信号是整数还是浮点数
                                   //                                   [NSNumber numberWithInt: AVAudioQualityMedium],AVEncoderAudioQualityKey,//音频编码质量
                                   nil];
    return [recordSetting autorelease];
}

/**
	生成当前时间字符串
	@returns 当前时间字符串
 */
+ (NSString*)getCurrentTimeString
{
    NSDateFormatter *dateformat=[[[NSDateFormatter  alloc]init]autorelease];
    [dateformat setDateFormat:@"yyyyMMddHHmmss"];
    return [dateformat stringFromDate:[NSDate date]];
}

#pragma mark - AVAudioRecorderDelegate
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
}

/* if an error occurs while encoding it will be reported to the delegate. */
- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error
{
    
}
@end
