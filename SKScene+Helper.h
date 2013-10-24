//
//  SKScene+Helper.h
//  Happy Animal Puzzle SK
//
//  Created by scnfex on 9/30/13.
//  Copyright (c) 2013 MopCat Games. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKScene (Helper)

/**
 *  @return center x of scene
 */
- (CGFloat)centerX;

/**
 *  @return center y of scene
 */
- (CGFloat)centerY;

/**
 *  for physics debug
 *  called after all initializaion
 *  will draw a green trasparent rect on dynamic physics body
 *  and red trasparent rect on static physics body
 */
- (void)debugPhysics;

@end
