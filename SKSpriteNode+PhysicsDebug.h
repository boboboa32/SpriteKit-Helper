//
//  SKSpriteNode+PhysicsDebug.h
//  YoyoMonkey-SK
//
//  Created by Bobo Shone on 13-10-28.
//  Copyright (c) 2013年 MopCat Games. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef enum {
    kSKPhysicsBodyTypeShape = 0,
    kSKPhysicsBodyTypeEdge,
} SKPhysicsBodyType;

@interface SKSpriteNode (PhysicsDebug)


/**
 *  Debug physics with custom path with colored shape
 *  Use it when finish setup physics body with body's path
 *  Disable debug by setting |SKDebug| to 0 in 'SKHelper.h'
 *
 *  @param path     physics body's path
 *  @param bodyType body type
 */
- (void)debugPhysicsWithPath:(UIBezierPath *)path
                    bodyType:(SKPhysicsBodyType)bodyType;

/**
 *  Same with [self debugPhysicsWithPath:path bodyType:kSKPhysicsBodyTypeShape]
 */
- (void)debugPhysicsWithPath:(UIBezierPath *)path;

/**
 *  Debug physics with rectangle path of sprite
 */
- (void)debugPhysicsWithRectanglePath;

/**
 *  Debug physics with circle path of sprite
 */
- (void)debugPhysicsWithCirclePath;

/**
 *  Debug physics with edge path between two points
 */
- (void)debugPhysicsWithEdgePathFromPoint:(CGPoint)p1 toPoint:(CGPoint)p2;

@end
