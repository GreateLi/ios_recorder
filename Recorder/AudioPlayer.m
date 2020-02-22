//
//  AudioPlayer.m
//  Recorder
//
//  Created by xiaoming on 15/3/2.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "AudioPlayer.h"


@implementation AudioPlayer
- (id)initWithFilePath:(NSString *)path
{
    self = [super init];
    if(self)
    {
        filePath = path;
        NSError *error = nil;
        NSURL *url = [[NSURL alloc]initWithString:filePath];
        self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
        
        [url release];
        if(error)
        {
            NSLog(@"AudioPlayer error:%@",error.localizedDescription);
        }
    }
    return self;
}

- (BOOL)play
{
    if(filePath)
    {
        if(!self.audioPlayer.playing)
        {
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerRepeat) userInfo:nil repeats:YES];
            [self.audioPlayer prepareToPlay];
            [self.audioPlayer play];
        }
    }
    return NO;
}

- (void)pause
{
    if(self.audioPlayer.isPlaying)
    {
        [self.audioPlayer pause];
    }
}

- (void)stop
{
    if(self.audioPlayer.isPlaying)
    {
        [self.audioPlayer stop];
    }
}

- (void)timerRepeat
{
    [self.audioPlayer updateMeters];
    
    NSLog(@"%f",[self.audioPlayer averagePowerForChannel:0]);
}
@end
