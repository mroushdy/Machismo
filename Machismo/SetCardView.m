//
//  SetCardView.m
//  SuperSetCard
//
//  Created by Marwan on 6/8/13.
//  Copyright (c) 2013 Marwan. All rights reserved.
//

#import "SetCardView.h"

@interface SetCardView()
@property (strong, nonatomic) UIBezierPath *path;
@end

@implementation SetCardView


- (UIBezierPath *)path
{
    if(!_path) _path = [[UIBezierPath alloc] init];
    return _path;
}

- (void)setColor:(NSString *)color
{
    _color = color;
    [self setNeedsDisplay];
}

- (void)setSymbol:(NSString *)symbol
{
    _symbol = symbol;
    [self setNeedsDisplay];
}

- (void)setNumber:(NSUInteger)number
{
    _number = number;
    [self setNeedsDisplay];
}

- (void)setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay];
}


#pragma mark - Drawing

#define HEIGHT_WIDTH_RATIO 2
#define MIN_MARGIN 0.1
#define INNER_PADDING 0.05 //percentage
- (void)drawRect:(CGRect)rect
{
    //create new path
    self.path = [[UIBezierPath alloc] init];
    
    CGFloat boundsWidth = self.bounds.size.width;
    CGFloat boundsHeight = self.bounds.size.width;
    
    CGFloat width = ((1 - MIN_MARGIN*2 - INNER_PADDING*2)*boundsWidth)/3;
    CGFloat height = (1 - MIN_MARGIN*2)*boundsHeight;
    
    //make sure that the drawing ratio is correct
    if(height>HEIGHT_WIDTH_RATIO*width) {
        height = width * HEIGHT_WIDTH_RATIO;
    } else {
        width =  height / HEIGHT_WIDTH_RATIO;
    }
    
    //get starting position to draw
    CGFloat yOffset = (boundsHeight - height)/2;
    CGFloat xOffset = (boundsWidth - width*self.number - boundsWidth*INNER_PADDING*(self.number-1))/2;
    
    if(self.faceUp) {
        UIBezierPath *borderPath = [UIBezierPath bezierPathWithRect:rect];
        [[self getColor] setStroke];
        borderPath.lineWidth = self.bounds.size.width * 0.04; //line width still needs to be a percentage
        [borderPath stroke];
    }
    
    for(int i=0; i<self.number; i++)
    {
        //set first boundary
        CGRect drawingBounds;
        drawingBounds.origin = CGPointMake(xOffset, yOffset);
        drawingBounds.size = CGSizeMake(width, height);
        
        // Draw
        if([self.symbol isEqualToString:@"diamond"]) [self drawDiamond:drawingBounds];
        if([self.symbol isEqualToString:@"squiggle"]) [self drawSquiggle:drawingBounds];
        if([self.symbol isEqualToString:@"oval"]) [self drawOval:drawingBounds];

        //offset shape
        xOffset = xOffset + width + boundsWidth*INNER_PADDING;
    
    }
    [self applyShading];
    
    
}


#define STRIPES_ANGLE -8
#define STRIPES_OFFSET 0.05 //as ratio of view height
#define SYMBOL_LINE_WIDTH 0.02; //as ratio of view width
- (void)applyShading
{
    //apply color
    UIColor *color = [self getColor];
    
    if([self.shading isEqualToString:@"solid"])
    {
        [color setFill];
        [self.path fill];
    } else {
        
        //set stroke
        [color setStroke];
        self.path.lineWidth=self.bounds.size.width / 2 * SYMBOL_LINE_WIDTH; //line width still needs to be a percentage
        [self.path stroke];
        
        if([self.shading isEqualToString:@"stripped"])
        {
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSaveGState(context);
            [self.path addClip];
            UIBezierPath *stripes = [[UIBezierPath alloc] init];
            CGPoint start = self.bounds.origin;
            CGPoint end = start;
            CGFloat dy = self.bounds.size.height * STRIPES_OFFSET;
            end.x += self.bounds.size.width;
            start.y += dy * STRIPES_ANGLE;
            for (int i = 0; i < 1.1 / STRIPES_OFFSET; i++) {
                [stripes moveToPoint:start];
                [stripes addLineToPoint:end];
                start.y += dy;
                end.y += dy;
            }
            stripes.lineWidth = self.bounds.size.width / 4 * SYMBOL_LINE_WIDTH;
            [stripes stroke];
            CGContextRestoreGState(UIGraphicsGetCurrentContext());
        } else if([self.shading isEqualToString:@"outlined"]) {
            [[UIColor clearColor] setFill];
        }
    }
}

- (UIColor *)getColor
{
    if ([self.color isEqualToString:@"red"]) return [UIColor redColor];
    if ([self.color isEqualToString:@"green"]) return [UIColor greenColor];
    if ([self.color isEqualToString:@"purple"]) return [UIColor purpleColor];
    return nil;
}


#define SQUIGGLE_FACTOR 0.8
- (void)drawSquiggle:(CGRect)bounds
{
    
    CGPoint point = bounds.origin;
    
    CGFloat dx = bounds.size.width / 2.4;
    CGFloat dy = bounds.size.height / 2.6;
    CGFloat dsqx = dx * SQUIGGLE_FACTOR;
    CGFloat dsqy = dy * SQUIGGLE_FACTOR;
    
    point.x = point.x + bounds.size.width / 2;
    point.y = point.y + bounds.size.height / 2;
    
    [self.path moveToPoint:CGPointMake(point.x - dx, point.y - dy)];
    
    [self.path addQuadCurveToPoint:CGPointMake(point.x + dx, point.y - dy)
                      controlPoint:CGPointMake(point.x - dsqx, point.y - dy - dsqy)];
    
    [self.path addCurveToPoint:CGPointMake(point.x + dx, point.y + dy)
                 controlPoint1:CGPointMake(point.x + dx + dsqx, point.y - dy + dsqy)
                 controlPoint2:CGPointMake(point.x + dx - dsqx, point.y + dy - dsqy)];
    
    [self.path addQuadCurveToPoint:CGPointMake(point.x - dx, point.y + dy)
                      controlPoint:CGPointMake(point.x + dsqx, point.y + dy + dsqy)];
    
    [self.path addCurveToPoint:CGPointMake(point.x - dx, point.y - dy)
                 controlPoint1:CGPointMake(point.x - dx - dsqx, point.y + dy - dsqy)
                 controlPoint2:CGPointMake(point.x - dx + dsqx, point.y - dy + dsqy)];
    [self.path closePath];


}



- (void)drawDiamond:(CGRect)bounds
{
    [self.path moveToPoint:CGPointMake(bounds.origin.x+(bounds.size.width/2), bounds.origin.y)];
    [self.path addLineToPoint:CGPointMake(bounds.origin.x+bounds.size.width, bounds.origin.y+(bounds.size.height/2))];
    [self.path addLineToPoint:CGPointMake(bounds.origin.x+(bounds.size.width/2), bounds.origin.y+bounds.size.height)];
    [self.path addLineToPoint:CGPointMake(bounds.origin.x, bounds.origin.y+(bounds.size.height/2))];
    [self.path closePath];
}

#define OVAL_WIDTH 0.12
#define OVAL_HEIGHT 0.4
- (void)drawOval:(CGRect)bounds
{
    CGPoint point = bounds.origin;
    CGFloat dx = bounds.size.width;
    CGFloat dy = bounds.size.height;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(point.x, point.y, dx, dy) cornerRadius:0.5*dx];
    [self.path appendPath:path];
}


#pragma mark - Initialization

- (void)setup
{
    // do initialization here
}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

@end
