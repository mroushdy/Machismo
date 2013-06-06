//
//  GameViewController.m
//  Machismo
//
//  Created by Marwan on 6/6/13.
//  Copyright (c) 2013 Marwan. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController


- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI
{
    UIImage *cardBackImage = [UIImage imageNamed:@"cardback.png"];
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtindex:[self.cardButtons indexOfObject:cardButton]];
        
        [self setCardTitle:card.contents forButton:cardButton]; //could be nsstring || nsmattributed string
        
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
}

- (void)setCardTitle:(id)title forButton:(UIButton *)cardButton
{
    if([title isKindOfClass:[NSString class]]) {
        [cardButton setTitle:title forState:UIControlStateSelected];
        [cardButton setTitle:title forState:UIControlStateSelected|UIControlStateDisabled];
    } else if ([title isKindOfClass:[NSAttributedString class]]) {
        [cardButton setAttributedTitle:title forState:UIControlStateSelected];
        [cardButton setAttributedTitle:title forState:UIControlStateSelected|UIControlStateDisabled];
    }
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips %d" , self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

- (IBAction)deal:(id)sender {
    self.game = nil;
    self.flipCount = 0;
    [self updateUI];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self updateUI];
}


@end
