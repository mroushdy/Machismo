//
//  CardGameViewController.m
//  Machismo
//
//  Created by Marwan on 6/3/13.
//  Copyright (c) 2013 Marwan. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()

@end

@implementation CardGameViewController

@synthesize game = _game;

-(CardMatchingGame *)game
{
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[[PlayingCardDeck alloc] init]];
    _game.gameMode = 2; //two card game mode;
    return _game;
}

@end
