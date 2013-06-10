//
//  GameViewController.m
//  Machismo
//
//  Created by Marwan on 6/6/13.
//  Copyright (c) 2013 Marwan. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController () <UICollectionViewDataSource>

@property (nonatomic) BOOL removeUnplayableCards;
@end

@implementation GameViewController

@synthesize game = _game;

-(CardMatchingGame *)game
{
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.startingCardCount usingDeck:[self createDeck]];
    _game.gameMode = self.gameMode; //two card game mode;
    return _game;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.game.numberOfCards;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.reusableCellIdentifier forIndexPath:indexPath];
    Card *card = [self.game cardAtindex:indexPath.item];
    [self updateCell:cell usingCard:card animate:NO];
    return cell;
}

-(void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card animate:(bool)animate {} //abstract

-(Deck *)createDeck {return nil;} //abstract


- (void)updateUI
{
    for(UICollectionViewCell *cell in [self.cardCollectionView visibleCells])
    {
        NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
        Card *card = [self.game cardAtindex:indexPath.item];
        
        //remove cards from game if it is a set game
        BOOL cardGotDeleted = NO;
        if (self.removeUnplayableCards) {
                if (card.isUnplayable) {
                    [self.game removeCardAtIndex:indexPath.item];
                    [self.cardCollectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:indexPath.item inSection:0]]];
                    cardGotDeleted = YES;
                }
        }
        if(!cardGotDeleted) [self updateCell:cell usingCard:card animate:NO];
        
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d" , self.game.score];
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips %d" , self.flipCount];
}


- (IBAction)flipCard:(UITapGestureRecognizer *)gesture {
    CGPoint tapLocation = [gesture locationInView:self.cardCollectionView];
    NSIndexPath *indexPath = [self.cardCollectionView indexPathForItemAtPoint:tapLocation];
    if(indexPath) {
        
        
        [self.game flipCardAtIndex:indexPath.item];
        self.flipCount++;
        
            
            Card *card = [self.game cardAtindex:indexPath.item];
            UICollectionViewCell *cell = [self.cardCollectionView cellForItemAtIndexPath:indexPath];
            [self updateCell:cell usingCard:card animate:YES];
        
        
        [self updateUI];
    }
}

- (IBAction)deal:(id)sender {
    self.game = nil;
    self.flipCount = 0;
    [self.cardCollectionView reloadData];
    [self updateUI];
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	[self updateUI];
}


@end
