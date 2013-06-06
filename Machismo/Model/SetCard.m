//
//  SetCard.m
//  Machismo
//
//  Created by Marwan on 6/6/13.
//  Copyright (c) 2013 Marwan. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard


- (int)match:(NSArray *)otherCards
{
    int score = 0;
    if([otherCards count] == 2) {
        int matchedColor = 0, matchedSymbol = 0, matchedShading = 0, matchedNumber = 0;
        for (id otherCard in otherCards) {
            if([otherCard isKindOfClass:[SetCard class]])
            {
                SetCard *otherSetCard = (SetCard *)otherCard;
                matchedColor += ([self.color isEqualToString:otherSetCard.color] ? 1 : 0);
                matchedSymbol += ([self.symbol isEqualToString:otherSetCard.symbol] ? 1 : 0);
                matchedShading += ([self.shading isEqualToString:otherSetCard.shading] ? 1 : 0);
                matchedNumber += ((self.number == otherSetCard.number) ? 1 : 0);
            }
        }
        if(matchedSymbol == 2 || matchedColor == 2 || matchedShading == 2 || matchedNumber == 2) {
            score = 4;
        }
    }
    return score;
}


@synthesize color = _color, symbol = _symbol, shading = _shading;

- (NSString *)color
{
    return _color ? _color : @"?";
}

- (void)setColor:(NSString *)color
{
    if ([[SetCard validColors] containsObject:color]) _color = color;
}

- (NSString *)symbol
{
    return _symbol ? _symbol : @"?";
}

- (void)setSymbol:(NSString *)symbol
{
    if ([[SetCard validSymbols] containsObject:symbol]) _symbol = symbol;
}

- (NSString *)shading
{
    return _shading ? _shading : @"?";
}

- (void)setShading:(NSString *)shading
{
    if ([[SetCard validShadings] containsObject:shading]) _shading = shading;
}

- (void)setNumber:(NSUInteger)number
{
    if (number <= [SetCard maxNumber]) _number = number;
}

- (NSAttributedString *)contents
{
    NSString *cardPlainContents = [[NSString alloc] init];
    cardPlainContents =[cardPlainContents stringByPaddingToLength:self.number withString:self.symbol startingAtIndex:0];
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:cardPlainContents];
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    
    NSRange range = [cardPlainContents rangeOfString:cardPlainContents];
    
    
    [attributes setObject:[UIFont systemFontOfSize:12.0] forKey:NSFontAttributeName];
    
    if([self.color isEqualToString:@"red"]) {
        [attributes setObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
    } else if ([self.color isEqualToString:@"green"]) {
        [attributes setObject:[UIColor greenColor] forKey:NSForegroundColorAttributeName];
    } else if ([self.color isEqualToString:@"purple"]) {
        [attributes setObject:[UIColor purpleColor] forKey:NSForegroundColorAttributeName];
    }
    
    if([self.shading isEqualToString:@"solid"]) {
        [attributes setObject:@-5 forKey:NSStrokeWidthAttributeName];
    } else if ([self.shading isEqualToString:@"open"]) {
        [attributes setObject:@5 forKey:NSStrokeWidthAttributeName];
    } else if ([self.shading isEqualToString:@"stripped"]) {
        [attributes addEntriesFromDictionary:@{
                 NSStrokeWidthAttributeName : @-5,
                 NSStrokeColorAttributeName : attributes[NSForegroundColorAttributeName],
             NSForegroundColorAttributeName : [attributes[NSForegroundColorAttributeName] colorWithAlphaComponent:0.1]
         }];
    }
    
    [title addAttributes:attributes range:range];
    
    return title;
}

+ (NSArray *)validColors
{
    return @[@"red", @"green", @"purple"];
}

+ (NSArray *)validSymbols
{
    return @[@"▲", @"●", @"■"];
}

+ (NSArray *)validShadings
{
    return @[@"solid", @"open", @"striped"];
}

+ (NSUInteger)maxNumber
{
    return 3;
}

@end
