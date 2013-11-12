//
//  SKButtonNode.h
//  Happy Animal Puzzle SK
//
//  Created by scnfex on 9/30/13.
//  Copyright (c) 2013 MopCat Games. All rights reserved.
//

#import "SKHelper.h"

@interface SKSpriteButtonNode : SKSpriteNode

/**
 *  Create button with textures
 *
 *  @param normalTexture   unselected texture
 *  @param selectedTexture selected texture, can be nil
 *  @param block           run after touch end
 *
 *  @return button node
 */
+ (instancetype)buttonNodeWithNormalTexture:(SKTexture *)normalTexture
                            selectedTexture:(SKTexture *)selectedTexture
                                      block:(void(^)(id buttonNode))block;

/**
 *  Create button with textures and two blocks
 *
 *  @param normalTexture   unselected texture
 *  @param selectedTexture selected texture, can be nil
 *  @param pressingBlock   run after touch began
 *  @param endBlock        run after touch end
 *
 *  @return button node
 */
+ (instancetype)buttonNodeWithNormalTexture:(SKTexture *)normalTexture
                            selectedTexture:(SKTexture *)selectedTexture
                              pressingBlock:(void(^)(id buttonNode))pressingBlock
                                   endBlock:(void(^)(id buttonNode))endBlock;

/**
 *  Create button with a background texture and a label in the center of button
 *
 *  @param backgroundTexture background texture
 *  @param labelNode         label in the center
 *  @param block             run after touch end
 *
 *  @return button node
 */
+ (instancetype)buttonWithBackgroundTexture:(SKTexture *)backgroundTexture
                                  labelNode:(SKLabelNode *)labelNode
                                      block:(void(^)(id buttonNode))block;
@end
