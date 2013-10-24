//
//  MusicPlayer.h
//  YoyoMonkey-SK
//
//  Created by scnfex on 10/24/13.
//  Copyright (c) 2013 MopCat Games. All rights reserved.
//

#import <Foundation/Foundation.h>

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
 *  Play sound effect
 *
 *  @param file whole file name, such as 'hit.wav'
 */
- (void)playSoundEffectWithFile:(NSString *)file;

@end
