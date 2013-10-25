//
//  SKSpriteNode+Helper.h
//  YoyoMonkey-SK
//
//  Created by scnfex on 10/25/13.
//  Copyright (c) 2013 MopCat Games. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>


@interface SKSpriteNode (Helper)

/**
 *  Caculate rectangle body path
 *
 *  @return path of rectangle body
 */
- (CGPathRef)rectanglePath;


/**
 *  Caculate circle body path
 *
 *  @return path of circle body
 */
- (CGPathRef)circlePath;

/**
 *  Debug physics with path with colored shape
 *  Use it when finish setup physics body with body's path
 *  Disable debug by setting |SKDebug| to 0 in 'SKHelper.h'
 *  
 *  @param path physicas body's path
 */
- (void)debugPhysicsWithPath:(CGPathRef)path;

@end
