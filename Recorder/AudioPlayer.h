//
//  AudioPlayer.h
//  Recorder
//
//  Created by xiaoming on 15/3/2.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface AudioPlayer : NSObject
{
    NSString *filePath;
}

@property (strong, nonatomic)AVAudioPlayer *audioPlayer;
- (id)initWithFilePath:(NSString *)path;

- (BOOL)play;

- (void)pause;

- (void)stop;
@end
