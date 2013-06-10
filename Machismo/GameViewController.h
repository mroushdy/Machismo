//
//  GameViewController.h
//  Machismo
//
//  Created by Marwan on 6/6/13.
//  Copyright (c) 2013 Marwan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"
#import "Deck.h"

@interface GameViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;

- (void)updateUI;

-(void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card animate:(bool)animate; //abstract
-(Deck *)createDeck; //abstract
@property (nonatomic) NSUInteger gameMode; //abstract
@property (nonatomic) NSUInteger startingCardCount; //abstract
@property (nonatomic) NSString *reusableCellIdentifier; //abstract
@end
