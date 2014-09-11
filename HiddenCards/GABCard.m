//
//  GABCard.m
//  HiddenCards
//
//  Created by Greg Borenstein on 9/1/14.
//  Copyright (c) 2014 Greg Borenstein. All rights reserved.
//

#import "GABCard.h"

@implementation GABCard



-(id) initWithImageNamed:(NSString *)name
{
    frontTexture = [SKTexture textureWithImageNamed:name];
    backTexture = [SKTexture textureWithImageNamed:@"card_back"];
    self = [super initWithTexture:backTexture];
    self.size = CGSizeMake(137.5, 192.5);
    self.name = @"card";
    
    faceUp  = false;
    
    debugLabel = [[SKLabelNode alloc] init];
    debugLabel.name = @"posDebug";
    debugLabel.fontSize = 20;
    debugLabel.fontColor = [UIColor redColor];
    debugLabel.text = [[NSString alloc]initWithFormat:@"%i,%i", 0,0];
    
    [self addChild:debugLabel];
    
    NSLog(@"w:%f h:%f", self.size.width, self.size.height);
    
    SKShapeNode* tapRect = [SKShapeNode node];
    tapRect.name = @"tap hat";
    tapRect.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.size.width, 40)].CGPath;
    tapRect.position = CGPointMake(-self.size.width/2, self.size.height/2);
    tapRect.fillColor = [UIColor redColor];
    tapRect.hidden = YES;
    [self addChild:tapRect];
    

    return self;
}

-(void) updatePosition:(CGPoint)point
{
    debugLabel.text =[[NSString alloc]initWithFormat:@"%i,%i", (int)point.x,(int)point.y];
    super.position = point;
}

-(BOOL) isCoveredByTouches:(NSSet*)touches
{
    BOOL result = false;
        
    NSLog(@"%i", touches.count);
    for(UITouch* touch in touches){
        [self addChild:[self debugCircle:[touch locationInNode:self]]];
    }
    
    return result;
}

-(SKShapeNode*) debugCircle:(CGPoint)p {
    SKShapeNode *circle = [[SKShapeNode alloc] init];
    CGMutablePathRef circlePath = CGPathCreateMutable();
    CGPathAddArc(circlePath, NULL, p.x, p.y, 20, 0, M_PI*2, NO);
    circle.position = p;
    circle.path = circlePath;
    return circle;
}

-(void) flip
{
    faceUp = !faceUp;

    if(faceUp){
        self.texture = frontTexture;
    } else {
        self.texture = backTexture;
    
    }
}


@end
