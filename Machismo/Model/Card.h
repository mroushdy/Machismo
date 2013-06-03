//
//  Card.h
//  Machismo
//
//  Created by Marwan on 6/3/13.
//  Copyright (c) 2013 Marwan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter = isFaceup) bool faceUp;
@property (nonatomic, getter = isUnplayable) bool unplayable;
- (int) match:(Card *)card;
@end
