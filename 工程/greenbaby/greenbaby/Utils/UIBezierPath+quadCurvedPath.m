//
//  UIBezierPath+quadCurvedPath.m
//  greenbaby
//
//  Created by 刘向宏 on 16/1/8.
//  Copyright © 2016年 刘向宏. All rights reserved.
//

#import "UIBezierPath+quadCurvedPath.h"

@implementation UIBezierPath (quadCurvedPath)
+ (UIBezierPath *)quadCurvedPathWithPoints:(NSArray *)points
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    NSValue *value = points[0];
    CGPoint p1 = [value CGPointValue];
    [path moveToPoint:p1];
    
    if (points.count == 2) {
        value = points[1];
        CGPoint p2 = [value CGPointValue];
        [path addLineToPoint:p2];
        return path;
    }
    
    for (NSUInteger i = 1; i < points.count; i++) {
        value = points[i];
        CGPoint p2 = [value CGPointValue];
        
        CGPoint midPoint = midPointForPoints(p1, p2);
        [path addQuadCurveToPoint:midPoint controlPoint:controlPointForPoints(midPoint, p1)];
        [path addQuadCurveToPoint:p2 controlPoint:controlPointForPoints(midPoint, p2)];
        
        p1 = p2;
    }
    return path;
}

static CGPoint midPointForPoints(CGPoint p1, CGPoint p2) {
    return CGPointMake((p1.x + p2.x) / 2, (p1.y + p2.y) / 2);
}

static CGPoint controlPointForPoints(CGPoint p1, CGPoint p2) {
    CGPoint controlPoint = midPointForPoints(p1, p2);
    CGFloat diffY = p2.y - controlPoint.y;
    diffY = diffY > 0 ? diffY : -diffY;
    
    if (p1.y < p2.y)
        controlPoint.y += diffY;
    else if (p1.y > p2.y)
        controlPoint.y -= diffY;
    
    return controlPoint;
}
@end
