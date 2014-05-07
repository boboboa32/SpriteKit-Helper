//
//  SKButtonNode.m
//  Happy Animal Puzzle SK
//
//  Created by scnfex on 9/30/13.
//  Copyright (c) 2013 MopCat Games. All rights reserved.
//

#import "SKSpriteButtonNode.h"

typedef void (^SKSpriteButtonNodeSelectedBlock)(SKSpriteButtonNode *buttonNode);
typedef void (^SKSpriteButtonNodePressingBlock)(SKSpriteButtonNode *buttonNode);
typedef void (^SKSpriteButtonNodeHighlightedBlock)(SKSpriteButtonNode *buttonNode, BOOL highlighted);

@interface SKSpriteButtonNode ()

@property (nonatomic, strong) SKTexture *normalTexture;
@property (nonatomic, strong) SKTexture *selectedTexture;
@property (nonatomic, strong) SKTexture *highlightedTexture;

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) BOOL isHighlighted;

@property (nonatomic, copy) SKSpriteButtonNodeSelectedBlock selectedBlock;
@property (nonatomic, copy) SKSpriteButtonNodePressingBlock pressingBlock;
@property (nonatomic, copy) SKSpriteButtonNodeHighlightedBlock highlightedBlock;

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
        _normalTexture = normalTexture;
        _highlightedTexture = highlightedTexture;
        _highlightedBlock = block;
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
        _normalTexture = normalTexture;
        _selectedTexture = selectedTexture;
        _selectedBlock = endBlock;
        _pressingBlock = pressingBlock;
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

- (instancetype)initWithColor:(UIColor *)color
                         size:(CGSize)size
                    labelNode:(SKLabelNode *)labelNode
                        block:(void(^)(id buttonNode))block {
    self = [super initWithColor:color size:size];
    if (self) {
        labelNode.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        labelNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        labelNode.position = skp0;
        [self addChild:labelNode];
        
        _selectedBlock = block;
        self.userInteractionEnabled = YES;
    }
    return self;
}

+ (instancetype)buttonNodeWithColor:(UIColor *)color
                               size:(CGSize)size
                          labelNode:(SKLabelNode *)labelNode
                              block:(void(^)(id buttonNode))block; {
    return [[self alloc] initWithColor:color
                                  size:size
                             labelNode:labelNode
                                 block:block];
}

+ (instancetype)buttonWithBackgroundTexture:(SKTexture *)backgroundTexture
                                  labelNode:(SKLabelNode *)labelNode
                                      block:(void(^)(id buttonNode))block {
    return [[self alloc] initWithBackgroundTexture:backgroundTexture
                                         labelNode:labelNode
                                             block:block];
}


#pragma mark - Private

- (void)pressing {
    if (self.pressingBlock) {
        __weak SKSpriteButtonNode *buttonNode = self;
        self.pressingBlock(buttonNode);
    }
}

- (void)selected {
    self.isSelected = YES;
    
    if (self.selectedTexture) {
        [self setTexture:self.selectedTexture];
    }
    else {
        self.alpha = 0.7;
    }
}

- (void)unSelected {
    self.isSelected = NO;
    
    if (self.selectedTexture) {
        [self setTexture:self.normalTexture];
    }
    else {
        self.alpha = 1;
    }
}

-(void) activate {
	if( self.selectedBlock ) {
        __weak SKSpriteButtonNode *buttonNode = self;
        self.selectedBlock(buttonNode);
    }
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
        
        if (self.highlightedBlock) {
            __weak SKSpriteButtonNode *buttonNode = self;
            self.highlightedBlock(buttonNode, self.isHighlighted);
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
