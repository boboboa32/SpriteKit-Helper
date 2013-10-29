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

- (UIBezierPath *)edgePathFromPoint:(CGPoint)p1 toPoint:(CGPoint)p2 {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, p1.x, p1.y);
    CGPathAddLineToPoint(path, NULL, p2.x, p2.y);
    return [UIBezierPath bezierPathWithCGPath:path];
}

- (void)debugPhysicsWithPath:(UIBezierPath *)path {
    [self debugPhysicsWithPath:path bodyType:kSKPhysicsBodyTypeShape];
}

- (void)debugPhysicsWithPath:(UIBezierPath *)path
                    bodyType:(SKPhysicsBodyType)bodyType {
#if SKDebug
    if (!self.physicsBody) {
        return;
    }
    
    SKShapeNode *debugNode = [SKShapeNode node];
    debugNode.path = path.CGPath;
    debugNode.lineWidth = 0.1;
    
    SKColor *color;

    if (bodyType == kSKPhysicsBodyTypeShape) {
        if (self.physicsBody.dynamic) {
            color = skColor4(0, 255, 0, 0.5);
        }
        else {
            color = skColor4(255, 0, 0, 0.5);
        }
        
        debugNode.fillColor = color;
    }
    else {
        color = skColor4(255, 0, 0, 0.5);
        
        debugNode.strokeColor = color;
    }
    
    [self addChild:debugNode];
#endif
}

- (void)debugPhysicsWithRectanglePath {
    [self debugPhysicsWithPath:[self rectanglePath]];
}

- (void)debugPhysicsWithCirclePath {
    [self debugPhysicsWithPath:[self circlePath]];
}

- (void)debugPhysicsWithEdgePathFromPoint:(CGPoint)p1 toPoint:(CGPoint)p2 {
    [self debugPhysicsWithPath:[self edgePathFromPoint:p1 toPoint:p2]
                      bodyType:kSKPhysicsBodyTypeEdge];
}

@end
