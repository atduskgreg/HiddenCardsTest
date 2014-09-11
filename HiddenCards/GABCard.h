//
//  GABCard.h
//  HiddenCards
//
//  Created by Greg Borenstein on 9/1/14.
//  Copyright (c) 2014 Greg Borenstein. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GABCard : SKSpriteNode{
    SKTexture* backTexture;
    SKTexture* frontTexture;
    BOOL faceUp;
    SKLabelNode* debugLabel;
}
-(id) initWithImageNamed:(NSString *)name;
-(void) flip;
-(BOOL) isCoveredByTouches:(NSSet*)touches;
-(void) updatePosition:(CGPoint)point;

@end
