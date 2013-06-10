//
//  CardGameViewController.m
//  Machismo
//
//  Created by Marwan on 6/3/13.
//  Copyright (c) 2013 Marwan. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "PlayingCardCollectionViewCell.h"

@interface CardGameViewController ()


@end

@implementation CardGameViewController //playing card controller

-(Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (NSUInteger)startingCardCount
{
    return 22;
}

- (NSUInteger)gameMode
{
    return 2;
}

- (NSString *)reusableCellIdentifier
{
    return @"PlayingCard";
}

-(void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card animate:(bool)animate
{
    if([cell isKindOfClass:[PlayingCardCollectionViewCell class]]){
        PlayingCardView *playingCardView = ((PlayingCardCollectionViewCell *)cell).PlayingCardView;
        if([card isKindOfClass:[PlayingCard class]]) {
            PlayingCard *playingCard = (PlayingCard *)card;
            playingCardView.rank = playingCard.rank;
            playingCardView.suit = playingCard.suit;
            if(animate){
                [UIView transitionWithView:playingCardView
                                  duration:0.5
                                   options:UIViewAnimationOptionTransitionFlipFromLeft
                                animations:^{
                                    playingCardView.faceUp = playingCard.faceUp;
                                }
                                completion:NULL];
            } else {
                playingCardView.faceUp = playingCard.faceUp;
            }
            playingCardView.alpha = playingCard.isUnplayable ? 0.3 :1.0;
        }
    }
}

@end
