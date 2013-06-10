//
//  SetGameViewController.m
//  Machismo
//
//  Created by Marwan on 6/6/13.
//  Copyright (c) 2013 Marwan. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "SetCardView.h"
#import "SetCardCollectionViewCell.h"

@interface SetGameViewController ()

@end

@implementation SetGameViewController

-(Deck *)createDeck {
    return [[SetCardDeck alloc] init];
}

- (NSUInteger)startingCardCount
{
    return 12;
}

- (NSUInteger)gameMode
{
    return 3;
}

- (BOOL)removeUnplayableCards
{
    return YES;
}

- (NSString *)reusableCellIdentifier
{
    return @"SetCard";
}

- (IBAction)addNewCards:(UIButton *)sender {
    for (int i = 0; i < sender.tag; i++) {
        [self.game drawNewCard];
    }
    [self.cardCollectionView reloadData];
    [self.cardCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:(self.game.numberOfCards - 1) inSection:0]
                                    atScrollPosition:UICollectionViewScrollPositionBottom
                                            animated:YES];
    
}

-(void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card animate:(bool)animate
{
    if([cell isKindOfClass:[SetCardCollectionViewCell class]]){
        SetCardView *setCardView = ((SetCardCollectionViewCell *)cell).SetCardView;
        if([card isKindOfClass:[SetCard class]]) {
            SetCard *setCard = (SetCard *)card;
            setCardView.color = setCard.color;
            setCardView.shading = setCard.shading;
            setCardView.number = setCard.number;
            setCardView.symbol = setCard.symbol;
            setCardView.faceUp = setCard.faceUp;
            setCardView.alpha = setCard.isUnplayable ? 0.3 :1.0;
        }
    }
}


@end
