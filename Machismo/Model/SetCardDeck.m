//
//  SetCardDeck.m
//  Machismo
//
//  Created by Marwan on 6/6/13.
//  Copyright (c) 2013 Marwan. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (id)init {
    
    self = [super init];
    
    if (self) {
        for (int i = 1; i <= [SetCard maxNumber]; i++) {
            for (NSString *color in [SetCard validColors]) {
                for (NSString *symbol in [SetCard validSymbols]) {
                    for (NSString *shading in [SetCard validShadings]) {
                        SetCard *card = [[SetCard alloc] init];
                        card.number = i;
                        card.color = color;
                        card.symbol = symbol;
                        card.shading = shading;
                        [self addCard:card atTop:YES];
                    }
                }
            }
        }
    }
    return self;
}

@end
