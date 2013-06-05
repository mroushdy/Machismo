//
//  PlayingCard.m
//  Machismo
//
//  Created by Marwan on 6/3/13.
//  Copyright (c) 2013 Marwan. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit; // because we provide setter AND getter

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    if([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards lastObject];
        if([otherCard.suit isEqualToString:self.suit]){
            score = 1;
        } else if(otherCard.rank == self.rank) {
            score = 4;
        }
    } else if([otherCards count] == 2) {
        int matchedSuits = 0;
        int matchedRanks = 0;
        for (PlayingCard *otherCard in otherCards) {
            matchedSuits += ([self.suit isEqualToString:otherCard.suit] ? 1 : 0);
            matchedRanks += ((self.rank == otherCard.rank) ? 1 : 0);
        }
        if(matchedSuits == 2) {
            score = 4;
        }
        if(matchedRanks == 2) {
            score = 8;
        }
    }
    return score;
}

+ (NSArray *)validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

- (void)setSuit:(NSString *)suit
{
    if ([@[@"♥",@"♦",@"♠",@"♣"] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank { return [self rankStrings].count-1; }

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end