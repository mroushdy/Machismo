//
//  CardMatchingGame.m
//  Machismo
//
//  Created by Marwan on 6/4/13.
//  Copyright (c) 2013 Marwan. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (readwrite, nonatomic) int score;
@property (strong, nonatomic) NSMutableArray *cards; //of Card
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1
- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtindex:index];
    if(card && !card.isUnplayable)
    {
        if(!card.isFaceup)
        {
            for(Card *otherCard in self.cards)
            {
                if(otherCard.faceUp && !otherCard.unplayable)
                {
                    int matchScore = [card match:@[otherCard]];
                    if(matchScore) {
                        card.Unplayable = YES;
                        otherCard.Unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                    } else {
                        otherCard.faceUp = NO;
                        self.score -= matchScore * MISMATCH_PENALTY;
                    }
                    break;
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.faceUp;
    }
}

- (Card *)cardAtindex:(NSUInteger)index
{
    NSLog(@"a");
    return (index < self.cards.count) ? self.cards[index] : nil;
}

- (id) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    if(self) {
        for (int i=0; i<count; i++) {
            Card *card = [deck drawRandomCard];
            if(card)
            {
                self.cards[i] = card;
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

@end
