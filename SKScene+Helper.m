
#import "SKScene+Helper.h"

@implementation SKScene (Helper)

- (CGSize)winSize {
    return self.frame.size;
}

- (CGFloat)centerX {
    return CGRectGetMidX(self.frame);
}

- (CGFloat)centerY {
    return CGRectGetMidY(self.frame);
}

@end
