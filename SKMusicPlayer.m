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
@property (nonatomic) SKNode *soundPlayNode;

@end

@implementation SKMusicPlayer

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
        
        self.soundPlayNode = [SKNode node];
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

- (void)playSoundEffectWithFile:(NSString *)file {
    if (self.soundAvaliable) {
        [self.soundPlayNode runAction:[SKAction playSoundFileNamed:file waitForCompletion:NO]];
    }
}

@end
