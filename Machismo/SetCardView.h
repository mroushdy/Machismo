//
//  SetCardView.h
//  SuperSetCard
//
//  Created by Marwan on 6/8/13.
//  Copyright (c) 2013 Marwan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCardView : UIView

@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *shading;
@property (nonatomic) NSUInteger number;

@property (nonatomic) BOOL faceUp;

@end
