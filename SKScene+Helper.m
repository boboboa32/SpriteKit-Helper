//
//  SKScene+Helper.m
//  Happy Animal Puzzle SK
//
//  Created by scnfex on 9/30/13.
//  Copyright (c) 2013 MopCat Games. All rights reserved.
//

#import "SKScene+Helper.h"

@import QuartzCore;

@implementation SKScene (Helper)

- (CGFloat)centerX {
    return CGRectGetMidX(self.frame);
}

- (CGFloat)centerY {
    return CGRectGetMidY(self.frame);
}

- (void)debugPhysics {
    for (SKSpriteNode *node in self.children) {
        if (node.physicsBody) {
            SKColor *rectColor;
            if (node.physicsBody.dynamic) {
                rectColor = skColor4(0, 255, 0, 255*0.5);
            }
            else {
                rectColor = skColor4(255, 0, 0, 255*0.5);
            }
            
            SKSpriteNode *debugNode = [SKSpriteNode spriteNodeWithColor:rectColor
                                                                   size:node.frame.size];
            [node addChild:debugNode];
        }
    }
}

@end