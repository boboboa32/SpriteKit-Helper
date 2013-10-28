//
//  SKSpriteNode+PhysicsDebug.h
//  YoyoMonkey-SK
//
//  Created by Bobo Shone on 13-10-28.
//  Copyright (c) 2013年 MopCat Games. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKSpriteNode (PhysicsDebug)

/**
 *  Caculate rectangle body path
 *
 *  @return path of rectangle body
 */
- (UIBezierPath *)rectanglePath;


/**
 *  Caculate circle body path
 *
 *  @return path of circle body
 */
- (UIBezierPath *)circlePath;

/**
 *  Debug physics with path with colored shape
 *  Use it when finish setup physics body with body's path
 *  Disable debug by setting |SKDebug| to 0 in 'SKHelper.h'
 *
 *  @param path physicas body's path
 */
- (void)debugPhysicsWithPath:(UIBezierPath *)path;

@end
