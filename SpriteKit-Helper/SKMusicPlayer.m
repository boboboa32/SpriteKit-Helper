//
//  MusicPlayer.m
//  YoyoMonkey-SK
//
//  Created by scnfex on 10/24/13.
//  Copyright (c) 2013 MopCat Games. All rights reserved.
//

#import "SKMusicPlayer.h"

@import AVFoundation;

@interface SKMusicPlayer () {
    BOOL musicAvaliable_;
    BOOL soundAvaliable_;
}

@property (nonatomic) AVAudioPlayer *musicPlayer;

@end

@implementation SKMusicPlayer

@synthesize musicAvaliable = musicAvaliable_;
@synthesize soundAvaliable = soundAvaliable_;

+ (instancetype)musicPlayer {
    static SKMusicPlayer *backgroundMusicPlayer_ = nil;
    if (!backgroundMusicPlayer_) {
        backgroundMusicPlayer_ = [SKMusicPlayer new];
    }
    return backgroundMusicPlayer_;
}

- (id)init
{
    self = [super init];
    if (self) {
        musicAvaliable_ = YES;
        soundAvaliable_ = YES;
    }
    return self;
}

- (void)playWithMusicName:(NSString *)fileName
                musicType:(NSString *)fileType {
    if (self.musicPlayer) {
        [self.musicPlayer stop];
        self.musicPlayer = nil;
    }
    
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:fileName withExtension:fileType];

    NSError *error;
    self.musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:&error];
    self.musicPlayer.numberOfLoops = -1;
    [self.musicPlayer prepareToPlay];
    [self.musicPlayer play];
}

- (void)stop {
    if (self.musicPlayer) {
        [self.musicPlayer stop];
        self.musicPlayer = nil;
    }
}

- (void)pause {
    if (self.musicPlayer) {
        [self.musicPlayer pause];
    }
}

- (void)resume {
    if (self.musicPlayer && [self.musicPlayer prepareToPlay]) {
        [self.musicPlayer play];
    }
}

- (void)setMusicAvaliable:(BOOL)musicAvaliable {
    if (musicAvaliable_ != musicAvaliable) {
        musicAvaliable_ = musicAvaliable;
        
        if (!musicAvaliable_) {
            [self.musicPlayer pause];
        }
        else {
            [self.musicPlayer play];
        }
    }
}

- (BOOL)musicAvaliable {
    return musicAvaliable_;
}

- (void)playSoundEffectWithFile:(NSString *)file inNode:(SKNode *)node {
    [self playSoundEffectWithFile:file inNode:node completion:nil];
}

- (void)playSoundEffectWithFile:(NSString *)file inNode:(SKNode *)node completion:(void (^)())block {
    if (self.soundAvaliable) {
        [node runAction:[SKAction playSoundFileNamed:file waitForCompletion:NO] completion:block];
    }
}

@end
