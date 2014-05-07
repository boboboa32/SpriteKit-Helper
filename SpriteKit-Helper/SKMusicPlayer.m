//
//  MusicPlayer.m
//  YoyoMonkey-SK
//
//  Created by scnfex on 10/24/13.
//  Copyright (c) 2013 MopCat Games. All rights reserved.
//

#import "SKMusicPlayer.h"

@import AVFoundation;

@interface SKMusicPlayer () 

@property (nonatomic, strong) AVAudioPlayer *musicPlayer;
@property (nonatomic, assign) BOOL musicEnabled;
@property (nonatomic, assign) BOOL soundEnabled;

@end

@implementation SKMusicPlayer

+ (instancetype)musicPlayer {
    static SKMusicPlayer *_backgroundMusicPlayer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _backgroundMusicPlayer = [SKMusicPlayer new];
    });
    return _backgroundMusicPlayer;
}

- (id)init {
    self = [super init];
    if (self) {
        _musicEnabled = YES;
        _soundEnabled = YES;
    }
    return self;
}

- (void)playWithMusicName:(NSString *)fileName
                musicType:(NSString *)fileType {
    [self stop];
    
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

- (void)enableMusic:(BOOL)enabled {
    if (self.musicEnabled != enabled) {
        self.musicEnabled = enabled;
        
        if (!self.musicEnabled) {
            [self.musicPlayer pause];
        }
        else {
            [self.musicPlayer play];
        }
    }
}

- (void)enableSound:(BOOL)enabled {
    if (self.soundEnabled != enabled) {
        self.soundEnabled = enabled;
    }
}

- (void)playSoundEffectWithFile:(NSString *)file inNode:(SKNode *)node {
    [self playSoundEffectWithFile:file inNode:node completion:nil];
}

- (void)playSoundEffectWithFile:(NSString *)file inNode:(SKNode *)node completion:(void (^)())block {
    if (self.soundEnabled) {
        [node runAction:[SKAction playSoundFileNamed:file waitForCompletion:NO] completion:block];
    }
}

@end
