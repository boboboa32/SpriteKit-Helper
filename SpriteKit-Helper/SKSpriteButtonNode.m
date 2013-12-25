//
//  SKButtonNode.m
//  Happy Animal Puzzle SK
//
//  Created by scnfex on 9/30/13.
//  Copyright (c) 2013 MopCat Games. All rights reserved.
//

#import "SKSpriteButtonNode.h"

@interface SKSpriteButtonNode () {
    void (^_block)(SKSpriteButtonNode *buttonNode);
    void (^_pressingBlock)(SKSpriteButtonNode *buttonNode);
    void (^_highlightedBlock)(SKSpriteButtonNode *buttonNode, BOOL highlighted);
}

@property (nonatomic) SKTexture *normalTexture;
@property (nonatomic) SKTexture *selectedTexture;
@property (nonatomic) SKTexture *highlightedTexture;

@property (nonatomic) BOOL isSelected;
@property (nonatomic) BOOL isHighlighted;

@end


@implementation SKSpriteButtonNode

+ (instancetype)buttonNodeWithNormalTexture:(SKTexture *)normalTexture
                         highlightedTexture:(SKTexture *)highlightedTexture
                                      block:(void(^)(id buttonNode, BOOL highlighted))block {
    return [[self alloc] initWithNormalTexture:normalTexture
                            highlightedTexture:highlightedTexture
                                         block:block];
}

- (instancetype)initWithNormalTexture:(SKTexture *)normalTexture
                   highlightedTexture:(SKTexture *)highlightedTexture
                                block:(void(^)(id buttonNode, BOOL highlighted))block {
    self = [super initWithTexture:normalTexture];
    if (self) {
        self.normalTexture = normalTexture;
        self.highlightedTexture = highlightedTexture;
        self.highlightedBlock = block;
        self.userInteractionEnabled = YES;
    }
    return self;
}

+ (instancetype)buttonNodeWithNormalTexture:(SKTexture *)normalTexture
                            selectedTexture:(SKTexture *)selectedTexture
                                     block:(void(^)(id buttonNode))block {
    return [[self alloc] initWithNormalTexture:normalTexture
                               selectedTexture:selectedTexture
                                 pressingBlock:nil
                                      endBlock:block];
}

- (instancetype)initWithNormalTexture:(SKTexture *)normalTexture
                      selectedTexture:(SKTexture *)selectedTexture
                        pressingBlock:(void(^)(id buttonNode))pressingBlock
                             endBlock:(void(^)(id buttonNode))endBlock {
    self = [super initWithTexture:normalTexture];
    if (self) {
        self.normalTexture = normalTexture;
        self.selectedTexture = selectedTexture;
        self.block = endBlock;
        self.pressingBlock = pressingBlock;
        self.userInteractionEnabled = YES;
    }
    return self;
}

+ (instancetype)buttonNodeWithNormalTexture:(SKTexture *)normalTexture
                            selectedTexture:(SKTexture *)selectedTexture
                              pressingBlock:(void(^)(id buttonNode))pressingBlock
                                   endBlock:(void(^)(id buttonNode))endBlock {
    return [[self alloc] initWithNormalTexture:normalTexture
                               selectedTexture:selectedTexture
                                 pressingBlock:pressingBlock
                                      endBlock:endBlock];
}

- (instancetype)initWithBackgroundTexture:(SKTexture *)backgroundTexture
                                  labelNode:(SKLabelNode *)labelNode
                                      block:(void(^)(id buttonNode))block {
    SKSpriteButtonNode *button = [SKSpriteButtonNode buttonNodeWithNormalTexture:backgroundTexture
                                                                 selectedTexture:nil
                                                                           block:block];
    labelNode.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    labelNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    labelNode.position = skp0;
    [button addChild:labelNode];
    return button;
}

+ (instancetype)buttonWithBackgroundTexture:(SKTexture *)backgroundTexture
                                  labelNode:(SKLabelNode *)labelNode
                                      block:(void(^)(id buttonNode))block {
    return [[self alloc] initWithBackgroundTexture:backgroundTexture
                                         labelNode:labelNode
                                             block:block];
}


#pragma mark - Private 

- (void)setNormalTexture:(SKTexture *)normalTexture {
    if (normalTexture != _normalTexture) {
        _normalTexture = normalTexture;
    }
}

- (void)setSelectedTexture:(SKTexture *)selectedTexture {
    if (selectedTexture != _selectedTexture) {
        _selectedTexture = selectedTexture;
    }
}

- (void)setBlock:(void(^)(id sender))block
{
    _block = [block copy];
}

- (void)setPressingBlock:(void(^)(id sender))block {
    _pressingBlock = [block copy];
}

- (void)setHighlightedBlock:(void(^)(id sender, BOOL b))block {
    _highlightedBlock = [block copy];
}

- (void)pressing {
    if (_pressingBlock) {
        _pressingBlock(self);
    }
}

- (void)selected {
    self.isSelected = YES;
    
    if (self.selectedTexture) {
        [self setTexture:self.selectedTexture];
    }
    else {
        self.colorBlendFactor = 0.25f;
        self.color = [SKColor blackColor];
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
	if( _block )
		_block(self);
}

- (void)highlighted {
    if (self.highlightedTexture) {
        self.isHighlighted = !self.isHighlighted;
        
        if (self.isHighlighted) {
            [self setTexture:self.highlightedTexture];
        }
        else {
            [self setTexture:self.normalTexture];
        }
        
        if (_highlightedBlock) {
            _highlightedBlock(self, self.isHighlighted);
        }
    }
}

#pragma mark - Touch Event

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.hidden || self.parent.hidden) {
        return;
    }
    
    [self selected];
    [self pressing];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self unSelected];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.isSelected) {
        [self unSelected];
        [self activate];
        
        [self highlighted];
    }
}

@end
