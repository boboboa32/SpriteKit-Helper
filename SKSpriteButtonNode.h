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
                                      block:(void(^)(SKSpriteButtonNode *buttonNode))block;

+ (instancetype)buttonNodeWithNormalTexture:(SKTexture *)normalTexture
                            selectedTexture:(SKTexture *)selectedTexture
                              pressingBlock:(void(^)(SKSpriteButtonNode *buttonNode))pressingBlock
                                   endBlock:(void(^)(SKSpriteButtonNode *buttonNode))endBlock;

@end
