

#import <SpriteKit/SpriteKit.h>

@interface SKSpriteButtonNode : SKSpriteNode

+ (instancetype)buttonNodeWithNormalTexture:(SKTexture *)normalTexture
                            selectedTexture:(SKTexture *)selectedTexture
                                      block:(void(^)(id sender))block;

@end
