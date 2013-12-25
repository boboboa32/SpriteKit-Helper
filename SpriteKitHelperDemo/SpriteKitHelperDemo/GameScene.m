//
//  MyScene.m
//  SpriteKitHelperDemo
//
//  Created by scnfex on 12/24/13.
//  Copyright (c) 2013 Bobo Shone. All rights reserved.
//

#import "GameScene.h"

static NSString *kRockName                  = @"rock";
static NSString *kBackgroundName            = @"background";
static NSString *kMonkeyFlyAnimationKey     = @"MonkeyFly";
static NSString *kMonkeyDieAnimationKey     = @"MonkeyDie";
static NSString *kMonkeyMoveDirectionKey    = @"MonkeyMoveDirection";

static const uint32_t kCategoryBitMaskMonkey    = 0x1 << 0;
static const uint32_t kCategoryBitMaskRock      = 0x1 << 1;

enum ZPosition {
    kZPositionBackground = 0,
    kZPositionObject
    };

enum MoveDirection {
    kMoveDirectionNone = 0,
    kMoveDirectionLeft,
    kMoveDirectionRight
    };

typedef enum {
    kGameStateRunning = 0,
    kGameStateGameOver
} GameState;

@interface GameScene () <SKPhysicsContactDelegate, UIAlertViewDelegate>

@property (nonatomic) SKSpriteNode *monkey;
@property (nonatomic) int backgroundNum;

@property (nonatomic) float rockSpeed;
@property (nonatomic) float backgroundSpeed;
@property (nonatomic) float monkeySpeed;

@property (nonatomic) GameState gameState;

@end

@implementation GameScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        [[SKMusicPlayer musicPlayer] playWithMusicName:@"bg" musicType:@"mp3"];
        
        [self startGame];
    }
    return self;
}

- (void)update:(NSTimeInterval)currentTime {
    if (self.gameState != kGameStateRunning) {
        return;
    }
    
    [self enumerateChildNodesWithName:kRockName usingBlock:^(SKNode *node, BOOL *stop) {
        node.position = skp(node.position.x, node.position.y - self.rockSpeed);
        if (node.position.y < -50) {
            [node removeFromParent];
        }
    }];
    
    [self enumerateChildNodesWithName:kBackgroundName usingBlock:^(SKNode *node, BOOL *stop) {
        node.position = skp(node.position.x, node.position.y - self.backgroundSpeed);
        
        SKSpriteNode *background = (SKSpriteNode *)node;
        if (background.position.y <= -(background.size.height*0.5 - self.size.height) &&
            background.position.y > -background.size.height*0.5) {
            if (self.backgroundNum < 2) {
                SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"bg"];
                background.position = skp(self.centerX, background.size.height*0.5 + self.size.height);
                [self addChild:background];
                background.name = kBackgroundName;
                background.zPosition = kZPositionBackground;
                self.backgroundNum++;
            }
        }
        else if (background.position.y <= -background.size.height*0.5) {
            [background removeFromParent];
            self.backgroundNum--;
        }
    }];
    
    int direction = [[self.monkey.userData objectForKey:kMonkeyMoveDirectionKey] intValue];
    if (direction == kMoveDirectionLeft) {
        self.monkey.position = skp(MAX(self.monkey.position.x - self.monkeySpeed, self.monkey.size.width*0.5),
                                   self.monkey.position.y);
    }
    else if (direction == kMoveDirectionRight) {
        self.monkey.position = skp(MIN(self.monkey.position.x + self.monkeySpeed, self.size.width - self.monkey.size.width*0.5),
                                   self.monkey.position.y);
    }
}

#pragma mark - Private 

- (void)initGameConfig {
    self.rockSpeed = 2;
    self.backgroundSpeed = 0.5;
    self.monkeySpeed = 3;
    
    self.physicsWorld.gravity = CGVectorMake(0, 0);
    self.physicsWorld.contactDelegate = self;
}

- (void)createMonkey {
    self.monkey = [SKSpriteNode spriteNodeWithImageNamed:@"spacemonkey_fly_1"];
    self.monkey.position = skp(160, 50);
    [self addChild:self.monkey];
    self.monkey.zPosition = kZPositionObject;
    
    self.monkey.userData = [NSMutableDictionary new];
    
    SKAction *monkeyFly = [SKAction animateWithTextures:@[[SKTexture textureWithImageNamed:@"spacemonkey_fly_1"],
                                                          [SKTexture textureWithImageNamed:@"spacemonkey_fly_2"]]
                                           timePerFrame:0.1f];
    [self.monkey.userData setObject:monkeyFly forKey:kMonkeyFlyAnimationKey];
    SKAction *monkeyDie = [SKAction animateWithTextures:@[[SKTexture textureWithImageNamed:@"spacemonkey_dead_1"],
                                                          [SKTexture textureWithImageNamed:@"spacemonkey_dead_2"]]
                                           timePerFrame:0.5f];
    [self.monkey.userData setObject:monkeyDie forKey:kMonkeyDieAnimationKey];
    
    [self.monkey runAction:[SKAction repeatActionForever:monkeyFly] withKey:kMonkeyFlyAnimationKey];
    
    [self.monkey.userData setObject:[NSNumber numberWithInt:kMoveDirectionNone]
                             forKey:kMonkeyMoveDirectionKey];
    
    CGFloat offsetX = self.monkey.frame.size.width * self.monkey.anchorPoint.x;
    CGFloat offsetY = self.monkey.frame.size.height * self.monkey.anchorPoint.y;
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, 30 - offsetX, 77 - offsetY);
    CGPathAddLineToPoint(path, NULL, 0 - offsetX, 53 - offsetY);
    CGPathAddLineToPoint(path, NULL, 15 - offsetX, 0 - offsetY);
    CGPathAddLineToPoint(path, NULL, 45 - offsetX, 0 - offsetY);
    CGPathAddLineToPoint(path, NULL, 58 - offsetX, 59 - offsetY);
    
    CGPathCloseSubpath(path);
    
    self.monkey.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:path];
    self.monkey.physicsBody.categoryBitMask = kCategoryBitMaskMonkey;
    self.monkey.physicsBody.collisionBitMask = 0;
    self.monkey.physicsBody.contactTestBitMask = kCategoryBitMaskRock;
    [self.monkey debugPhysicsWithPath:[UIBezierPath bezierPathWithCGPath:path]];
}

- (void)gameOver {
    self.gameState = kGameStateGameOver;
    
    [self removeAllActions];
    
    [self.monkey removeActionForKey:kMonkeyFlyAnimationKey];
    SKAction *monkeyDie = [self.monkey.userData objectForKey:kMonkeyDieAnimationKey];
    [self.monkey runAction:monkeyDie withKey:kMonkeyDieAnimationKey];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You are dead!"
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:@"Restart"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)startGame {
    self.gameState = kGameStateRunning;
    
    [self initGameConfig];
    
    [self createMonkey];
    
    SKAction *rockGenerator = [SKAction repeatActionForever:[SKAction sequence:@[[SKAction waitForDuration:2 withRange:2],
                                                                                 [SKAction performSelector:@selector(generateRock)
                                                                                                  onTarget:self]]]];
    [self runAction:rockGenerator];
    
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"bg"];
    background.position = skp(self.centerX, background.size.height*0.5);
    [self addChild:background];
    background.name = kBackgroundName;
    background.zPosition = kZPositionBackground;
    self.backgroundNum = 1;
}

#pragma mark - Selector

- (void)generateRock {
    NSString *rockType = [NSString stringWithFormat:@"asteroid_%d", arc4random()%2+1];
    SKSpriteNode *rock = [SKSpriteNode spriteNodeWithImageNamed:rockType];
    rock.name = kRockName;
    
    float w = rock.size.width;
    float h = rock.size.height;
    rock.position = skp(skRandom(w*0.5, 320 - w*0.5), self.size.height + h*0.5);
    [self addChild:rock];
    
    rock.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:w*0.5];
    rock.physicsBody.categoryBitMask = kCategoryBitMaskRock;
    rock.physicsBody.collisionBitMask = 0;
    rock.physicsBody.contactTestBitMask = kCategoryBitMaskMonkey;
    [rock debugPhysicsWithCirclePath];
}

#pragma mark - Touch Event

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint position = [touch locationInNode:self];
    if (position.x < self.monkey.position.x) {
        [self.monkey.userData setObject:[NSNumber numberWithInt:kMoveDirectionLeft]
                                 forKey:kMonkeyMoveDirectionKey];
    }
    else {
        [self.monkey.userData setObject:[NSNumber numberWithInt:kMoveDirectionRight]
                                 forKey:kMonkeyMoveDirectionKey];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.monkey.userData setObject:[NSNumber numberWithInt:kMoveDirectionNone]
                             forKey:kMonkeyMoveDirectionKey];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.monkey.userData setObject:[NSNumber numberWithInt:kMoveDirectionNone]
                             forKey:kMonkeyMoveDirectionKey];
}

#pragma mark - SKPhysicsContactDelegate

- (void)didBeginContact:(SKPhysicsContact *)contact {
    if (contact.bodyA.categoryBitMask == kCategoryBitMaskMonkey || contact.bodyB.categoryBitMask == kCategoryBitMaskMonkey) {
        [self gameOver];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self removeAllChildren];
    [self startGame];
}

@end
