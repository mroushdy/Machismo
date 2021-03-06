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

@property (nonatomic) int numberOfCards;

- (void)removeCardAtIndex:(NSUInteger)index;

//designated initializer
- (id) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtindex:(NSUInteger)index;

- (void)drawNewCard;

@property (readonly, nonatomic) int score;

@property (nonatomic) int gameMode;

@property (readonly, strong, nonatomic) NSString *flipMessage;

@end
