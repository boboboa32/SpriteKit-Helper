//
//  MusicPlayer.h
//  YoyoMonkey-SK
//
//  Created by scnfex on 10/24/13.
//  Copyright (c) 2013 MopCat Games. All rights reserved.
//

#import "SKHelper.h"

@interface SKMusicPlayer : NSObject

/**
 *  control music playing, such as background music
 */
@property (nonatomic) BOOL musicAvaliable;

/**
 *  control sound effect playing
 */
@property (nonatomic) BOOL soundAvaliable;

+ (instancetype)musicPlayer;

/**
 *  Play music file
 *
 *  @param fileName such as 'backgroudMuic'
 *  @param fileType such as 'mp3'
 */
- (void)playWithMusicName:(NSString *)fileName
                musicType:(NSString *)fileType;

/**
 *  Stop playing music, can't resume
 */
- (void)stop;

/**
 *  Pause playing
 */
- (void)pause;

/**
 *  resume playing
 */
- (void)resume;

/**
 *  Play sound effect
 *
 *  @param file whole file name, such as 'hit.wav'
 *  @param node node to play, use SKScene
 */
- (void)playSoundEffectWithFile:(NSString *)file inNode:(SKNode *)node;

/**
 *  @param block run block after playing sound
 */
- (void)playSoundEffectWithFile:(NSString *)file inNode:(SKNode *)node completion:(void (^)())block;

@end
