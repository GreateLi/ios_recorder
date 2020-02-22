//
//  Recorder.h
//  Recorder
//
//  Created by xiaoming on 15/3/2.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface Recorder : NSObject<AVAudioRecorderDelegate>
@property (strong, nonatomic)AVAudioRecorder *recorder;
@property (strong, nonatomic)NSString *filePath;

- (id)init;

- (BOOL)startRec;

- (void)pauseRec;

- (void)stopRec;
@end
