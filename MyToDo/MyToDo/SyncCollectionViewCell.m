//
//  SyncCollectionViewCell.m
//  MyToDo
//
//  Created by hend elsisi on 4/19/16.
//  Copyright © 2016 hend elsisi. All rights reserved.
//

#import "SyncCollectionViewCell.h"

@implementation SyncCollectionViewCell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
           }
    return self;
}
- (void)awakeFromNib{
    // Initialization code
    [self drawSeparatorLine];
    self.selectorView.layer.borderWidth = 1;
    self.selectorView.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

-(void)drawSeparatorLine{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.separator.bounds];
    [shapeLayer setPosition:self.separator.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [shapeLayer setStrokeColor:[[UIColor blackColor] CGColor]];
    [shapeLayer setLineWidth:1.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:5],
      [NSNumber numberWithInt:1],nil]];//////spaces
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 99, 0);
    CGPathAddLineToPoint(path, NULL, 99,self.separator.bounds.size.height);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    [self.separator.layer addSublayer:shapeLayer];
}

@end
