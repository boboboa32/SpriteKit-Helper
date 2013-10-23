//
//  SKButtonNode.h
//  Happy Animal Puzzle SK
//
//  Created by scnfex on 9/30/13.
//  Copyright (c) 2013 MopCat Games. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKSpriteButtonNode : SKSpriteNode

+ (instancetype)buttonNodeWithNormalTexture:(SKTexture *)normalTexture
                            selectedTexture:(SKTexture *)selectedTexture
                                      block:(void(^)(id buttonNode))block;

+ (instancetype)buttonNodeWithNormalTexture:(SKTexture *)normalTexture
                            selectedTexture:(SKTexture *)selectedTexture
                              pressingBlock:(void(^)(id buttonNode))pressingBlock
                                   endBlock:(void(^)(id buttonNode))endBlock;

/*
 * @backgroundTexture   background texture for the button
 * @labelNode           label node on top of background texture and in the center
 */
+ (instancetype)buttonWithBackgroundTexture:(SKTexture *)backgroundTexture
                                  labelNode:(SKLabelNode *)labelNode
                                      block:(void(^)(id buttonNode))block;
@end
