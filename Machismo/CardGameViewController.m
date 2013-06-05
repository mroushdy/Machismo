//
//  CardGameViewController.m
//  Machismo
//
//  Created by Marwan on 6/3/13.
//  Copyright (c) 2013 Marwan. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (nonatomic) bool gameRunning;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipMessageLabel;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameMode;
@end

@implementation CardGameViewController

-(CardMatchingGame *)game
{
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[[PlayingCardDeck alloc] init]];
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)setGameRunning:(bool)gameRunning
{
    _gameRunning = gameRunning;
    if(_gameRunning) {
        self.gameMode.userInteractionEnabled = NO;
    } else {
        self.gameMode.userInteractionEnabled = YES;
    }
}

- (void)updateUI
{
    UIImage *cardBackImage = [UIImage imageNamed:@"cardback.png"];
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtindex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceup;
        cardButton.enabled = !card.unplayable;
        cardButton.alpha = (card.unplayable ? 0.3 : 1);
        if (!card.isFaceup) {
            [cardButton setImage:cardBackImage
                        forState:UIControlStateNormal];
        } else {
            [cardButton setImage:nil forState:UIControlStateNormal];
        }
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d" , self.game.score];
    self.flipMessageLabel.text = self.game.flipMessage;
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips %d" , self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    [self updateUI];
    self.flipCount++;
    if(!self.gameRunning) self.gameRunning = YES;
}

- (IBAction)deal:(id)sender {
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[[PlayingCardDeck alloc] init]];
    [self updateUI];
    self.flipsLabel.text = @"Flips: 0";
    self.gameRunning = NO;
}


- (IBAction)changeGameMode:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl*) sender;
    if([segmentedControl selectedSegmentIndex] == 0) {
        self.game.gameMode = 2; //Two card match
    } else {
        self.game.gameMode = 3; //Three card match
    }
}

@end
