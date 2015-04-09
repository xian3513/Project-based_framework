//
//  SelectView.m
//  test01
//
//  Created by kt on 14/12/31.
//  Copyright (c) 2014年 kt. All rights reserved.
//

#import "SelectView.h"

@implementation SelectView
{
   
}

- (void)select {
    _isSelect = YES;
    [self setNeedsDisplay];
}
-(void)setIsSelect:(BOOL)isSelect
{
    _isSelect = isSelect;
    [self setNeedsDisplay];
}
-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        _isSelect = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    NSInteger lineWidth = 1.5;
    NSInteger r = rect.size.height/2-11*lineWidth;
   
    CGPoint center = CGPointMake(rect.size.width/2,  rect.size.height/2);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, lineWidth);//线的宽度
    CGContextAddArc(context, center.x, center.y, r, 0, 2*M_PI, 0); //添加一个圆
          if(_isSelect)
        {
            UIColor*aColor = [UIColor colorWithRed:23.0/255.0 green:126.0/255.0 blue:251.0/255.0 alpha:1];
            CGContextSetStrokeColorWithColor(context, aColor.CGColor);
            CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
            CGContextDrawPath(context, kCGPathFillStroke);
            [self drawLine:r width:rect.size.width];
        }
        else
        {
            UIColor*aColor = [UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1];
            CGContextSetStrokeColorWithColor(context, aColor.CGColor);
            CGContextStrokePath(context);
        }
  
   
}
-(void)drawLine:(NSInteger)r width:(NSInteger)width
{
    UIColor *lineColor = [UIColor colorWithRed:254/255.0 green:254/255.0 blue:254/255.0 alpha:1.0];
    CGFloat pace = (r+1)*2/5;
    CGFloat lineWith = ((r+1)*0.1)<1?1:(r+1)*0.1;
    NSLog(@"pace:%f,lineWith:%f",pace,lineWith);
     CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, lineWith);
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextMoveToPoint(context, pace+width/2-r, width/2);
    CGContextAddLineToPoint(context, 2*pace+width/2-r, width/2+pace);
    CGContextAddLineToPoint(context, 1.4*pace+width/2, 1.4*pace+width/2-r);
    CGContextStrokePath(context);
}

@end
