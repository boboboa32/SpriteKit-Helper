
#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>


#define skp(x,y) CGPointMake(x,y)
#define skpEquals CGPointEqualToPoint
#define skColor4(r, g, b, a) [SKColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a/255.f]
#define skColor3(r, g, b) skColor4(r, g, b, 255.f)

static inline CGPoint skpNormalize(CGPoint pt) {
    if (pt.x == 0 && pt.y == 0)
        return CGPointZero;
    float m = sqrtf(pt.x * pt.x + pt.y * pt.y);
    return CGPointMake(pt.x/m, pt.y/m);
}

static inline float skpMagnitude(CGPoint pt) {
    if (pt.x == 0 && pt.y == 0)
        return 0;
    return sqrtf(pt.x * pt.x + pt.y * pt.y);
}

static inline CGPoint skpAdd(CGPoint pt1, CGPoint pt2) {
    return CGPointMake(pt1.x + pt2.x, pt1.y + pt2.y);
}

static inline CGPoint skpSubtract(CGPoint pt1, CGPoint pt2) {
    return CGPointMake(pt1.x - pt2.x, pt1.y - pt2.y);
}

static inline CGPoint skpMultiply(CGPoint pt, float scalar) {
    return CGPointMake(pt.x * scalar, pt.y * scalar);
}

static inline float skpDistance(CGPoint pt1, CGPoint pt2) {
    float dx = pt1.x-pt2.x;
    float dy = pt1.y-pt2.y;
    return sqrt(dx*dx + dy*dy);
}
