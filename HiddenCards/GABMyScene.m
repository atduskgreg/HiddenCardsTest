//
//  GABMyScene.m
//  HiddenCards
//
//  Created by Greg Borenstein on 9/1/14.
//  Copyright (c) 2014 Greg Borenstein. All rights reserved.
//

#import "GABMyScene.h"

@implementation GABMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        cards = [[NSMutableArray alloc]init];
        
        GABCard *card = [[GABCard alloc ] initWithImageNamed:@"putin_card"];
        card.position = CGPointMake(200,400);
        [self addChild:card];
        
        [cards addObject:card];
        
        GABCard *card2 = [[GABCard alloc ] initWithImageNamed:@"putin_card"];
        card2.position = CGPointMake(300,400);
        [self addChild:card2];
        [cards addObject:card2];
        
        debugTouches = [[NSMutableArray alloc] init];
        self.name = @"background";
    }
    return self;
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    for(UITouch* touch in touches){
        CGPoint location = [touch locationInNode:self];
        SKNode* touchedNode = [self nodeAtPoint:location];
        
        if(![touchedNode isEqual:self] && [touchedNode respondsToSelector:@selector(updatePosition:)]){
            //touchedNode.position = location;
            [(GABCard*)touchedNode updatePosition:location];
            touchedNode.zPosition = 15;
        }
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    int numTouchesOffCard = 0;
    NSMutableArray* offCardTouches = [[NSMutableArray alloc]init];
    
    
    BOOL cardCovered = false;
    GABCard* coveredCard;
    for(UITouch* touch in touches){
        
        CGPoint location = [touch locationInNode:self];
        SKNode* touchedNode = [self nodeAtPoint:location];
        NSLog(@"touchesBegan: %@", touchedNode.name);
        
        if([touchedNode isEqual:self]){
            numTouchesOffCard++;
            NSLog(@"%f,%f", location.x, location.y);
            [offCardTouches addObject:touch];
            
        }
        
        if([touchedNode.name isEqualToString:@"tap hat"]){
            cardCovered = true;
            coveredCard = (GABCard*)(touchedNode.parent);
        }
        
//        if(touch.tapCount > 1 && [touchedNode respondsToSelector:@selector(flip)]){
//            [(GABCard*)touchedNode flip];
//        }
        
        if(touch.tapCount == 1){
            if(![touchedNode isEqual:self]){
                [touchedNode runAction:[SKAction scaleTo:1.2 duration:0.2]];
            }

        }
    }
    
    if(cardCovered){
        [coveredCard flip];
    }
    
    
    [self removeChildrenInArray:debugTouches];
    [debugTouches removeAllObjects];

    NSLog(@"n: %i", offCardTouches.count);
    if(offCardTouches.count > 1){
        for(UITouch* touch in offCardTouches){
            SKShapeNode* dCircle = [self debugCircle:[touch locationInNode:self]];
            [debugTouches addObject:dCircle];
            [self addChild:dCircle];
        }
        
    }
}

-(SKShapeNode*) debugCircle:(CGPoint)p {
    SKShapeNode *circle = [[SKShapeNode alloc] init];
    CGMutablePathRef circlePath = CGPathCreateMutable();
    CGPathAddArc(circlePath, NULL, p.x, p.y, 20, 0, M_PI*2, NO);
    circle.position = p;
    circle.path = circlePath;
    return circle;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    BOOL cardCovered = false;
    GABCard* coveredCard;
    for(UITouch* touch in touches){
        CGPoint location = [touch locationInNode:self];
        SKNode* touchedNode = [self nodeAtPoint:location];
        NSLog(@"touchesEnded: %@", touchedNode.name);

        if([touchedNode.name isEqualToString:@"tap hat"]){
            cardCovered = true;
            coveredCard = (GABCard*)(touchedNode.parent);
        }
        
        if(![touchedNode isEqual:self]){
            [touchedNode runAction:[SKAction scaleTo:1.0 duration:0.1]];
            touchedNode.zPosition = 0;
        }

    }
    
    if(cardCovered){
        [coveredCard flip];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */

}

@end
