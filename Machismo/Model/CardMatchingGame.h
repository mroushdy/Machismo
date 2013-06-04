//
//  CardMatchingGame.h
//  Machismo
//
//  Created by Marwan on 6/4/13.
//  Copyright (c) 2013 Marwan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

//designated initializer
- (id) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtindex:(NSUInteger)index;

@property (readonly, nonatomic) int score;

@end
