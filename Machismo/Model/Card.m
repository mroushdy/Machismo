//
//  Card.m
//  Machismo
//
//  Created by Marwan on 6/3/13.
//  Copyright (c) 2013 Marwan. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int) match:(NSArray *)otherCards
{
    int score = 0;
    for(Card *otherCard in otherCards) {
        if([otherCard.contents isEqualToString:self.contents])
        {
            score = 1;
        }
    }
    return score;
}

@end
