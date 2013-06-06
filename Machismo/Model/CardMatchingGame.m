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
@property (readwrite, strong, nonatomic) NSString *flipMessage;
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
            self.flipMessage = [@[@"Flipped", card.contents] componentsJoinedByString:@" "];
            NSMutableArray *cardsFacedUp = [[NSMutableArray alloc] init];
            for(Card *otherCard in self.cards)
            {
                if(otherCard.faceUp && !otherCard.unplayable)
                {
                    [cardsFacedUp addObject:otherCard]; //add flipped cards to array to match
                    if(self.gameMode == 3) { //match three cards
                        if(cardsFacedUp.count == 2) { //wait till two other cards are flipped
                            int matchScore = [card match:cardsFacedUp];
                            if(matchScore) {
                                card.Unplayable = YES;
                                for(Card *matchedCard in cardsFacedUp) { //loop over matched cards
                                    matchedCard.unplayable = YES;
                                    self.score += matchScore * MATCH_BONUS;
                                }
                            } else {
                                card.faceUp = NO;
                                for(Card *mismatchedCard in cardsFacedUp) { //no match loop over mis-matched cards
                                    mismatchedCard.faceUp = NO;
                                    self.score -= MISMATCH_PENALTY;
                                }
                            }
                        }
                    } else { //match two cards only
                        int matchScore = [card match:cardsFacedUp];
                        if(matchScore) {
                            card.Unplayable = YES;
                            otherCard.Unplayable = YES;
                            self.score += matchScore * MATCH_BONUS;
                            self.flipMessage = [@[@"Matched", card.contents, @"with", otherCard.contents, @"."] componentsJoinedByString:@" "];
                        } else {
                            otherCard.faceUp = NO;
                            self.score -= MISMATCH_PENALTY;
                            self.flipMessage = [@[card.contents, @"and", otherCard.contents, @"don't match."] componentsJoinedByString:@" "];
                        }
                        break;
                    }
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.faceUp;
    }
}

- (Card *)cardAtindex:(NSUInteger)index
{
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
