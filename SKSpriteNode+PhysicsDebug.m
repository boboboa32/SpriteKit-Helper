//
//  SKSpriteNode+PhysicsDebug.m
//  YoyoMonkey-SK
//
//  Created by Bobo Shone on 13-10-28.
//  Copyright (c) 2013年 MopCat Games. All rights reserved.
//

#import "SKSpriteNode+PhysicsDebug.h"

@implementation SKSpriteNode (PhysicsDebug)

- (UIBezierPath *)rectanglePath {
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGRect rect = CGRectMake(-self.size.width * self.anchorPoint.x,
                             -self.size.height * self.anchorPoint.y,
                             self.size.width,
                             self.size.height);
    CGPathAddRect(path, NULL, rect);
    return [UIBezierPath bezierPathWithCGPath:path];
}

- (UIBezierPath *)circlePath {
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGFloat radius;
    if (self.size.width == self.size.height) {
        radius = self.size.width * 0.5;
    }
    else {
        radius = MIN(self.size.width, self.size.height) * 0.5;
    }
    
    CGRect rect = CGRectMake(-radius * 2 * self.anchorPoint.x,
                             -radius * 2 * self.anchorPoint.y,
                             radius * 2,
                             radius * 2);
    
    CGPathAddRoundedRect(path, NULL, rect, radius, radius);
    return [UIBezierPath bezierPathWithCGPath:path];
}

- (void)debugPhysicsWithPath:(UIBezierPath *)path {
#ifdef SKDebug
    if (!self.physicsBody) {
        return;
    }
    
    SKColor *rectColor;
    if (self.physicsBody.dynamic) {
        rectColor = skColor4(0, 255, 0, 0.5);
    }
    else {
        rectColor = skColor4(255, 0, 0, 0.5);
    }
    
    SKShapeNode *debugNode = [SKShapeNode node];
    debugNode.path = path.CGPath;
    debugNode.fillColor = rectColor;
    debugNode.lineWidth = 0.1;
    [self addChild:debugNode];
#endif
}


@end
