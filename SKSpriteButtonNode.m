

#import "SKSpriteButtonNode.h"

@interface SKSpriteButtonNode () {
    SKTexture *normalTexture_;
    SKTexture *selectedTexture_;
    void (^block_)(id sender);
}

@property (nonatomic, strong) SKTexture *normalTexture;
@property (nonatomic, strong) SKTexture *selectedTexture;
@property (nonatomic) BOOL isSelected;

@end


@implementation SKSpriteButtonNode

- (void)setNormalTexture:(SKTexture *)normalTexture {
    if (normalTexture != normalTexture_) {
        normalTexture_ = normalTexture;
    }
}

- (void)setSelectedTexture:(SKTexture *)selectedTexture {
    if (selectedTexture != selectedTexture_) {
        selectedTexture_ = selectedTexture;
    }
}

- (void)setBlock:(void(^)(id sender))block
{
    block_ = [block copy];
}

- (void)selected {
    self.isSelected = YES;
    
    if (self.selectedTexture) {
        [self setTexture:self.selectedTexture];
    }
    else {
        self.colorBlendFactor = 0.25f;
        self.color = [UIColor blackColor];
    }
}

- (void)unSelected {
    self.isSelected = NO;
    
    if (self.selectedTexture) {
        [self setTexture:self.normalTexture];
    }
    else {
        self.colorBlendFactor = 0.0f;
    }
}

-(void) activate
{
	if( block_ )
		block_(self);
}

- (instancetype)initWithNormalTexture:(SKTexture *)normalTexture
                      selectedTexture:(SKTexture *)selectedTexture
                               block:(void(^)(id sender))block {
    self = [super initWithTexture:normalTexture];
    if (self) {
        self.normalTexture = normalTexture;
        self.selectedTexture = selectedTexture;
        self.block = block;
        self.userInteractionEnabled = YES;
    }
    return self;
}

+ (instancetype)buttonNodeWithNormalTexture:(SKTexture *)normalTexture
                            selectedTexture:(SKTexture *)selectedTexture
                                     block:(void(^)(id sender))block {
    return [[self alloc] initWithNormalTexture:normalTexture
                               selectedTexture:selectedTexture
                                        block:block];
}

#pragma mark - Touch Event

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self selected];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self unSelected];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self unSelected];
    [self activate];
}

@end
