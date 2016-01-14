//
//  KChartView.swift
//  greenbaby
//
//  Created by 刘向宏 on 16/1/8.
//  Copyright © 2016年 刘向宏. All rights reserved.
//

import UIKit

class KChartView: UIView {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let topBegin:CGFloat = 15
        let bottomBegin:CGFloat = 15
        let leftBegin:CGFloat = 15
        let rectHeght = rect.size.height
        let rectCHeght = rectHeght - topBegin - bottomBegin
        let rectWidth = rect.size.width
        let rectCWidth = rectWidth - leftBegin - 8
        
        
        
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetRGBFillColor(context, 1, 70/255.0, 70/255.0, 1)
        CGContextFillRect(context, CGRectMake(0, topBegin, rect.size.width, rectCHeght/3))
        CGContextSetRGBFillColor(context, 1, 199/255.0, 99/255.0, 1)
        CGContextFillRect(context, CGRectMake(0, topBegin + rectCHeght/3, rect.size.width, rectCHeght/3))
        CGContextSetRGBFillColor(context, 55/255.0, 108/255.0, 214/255.0, 1)
        CGContextFillRect(context, CGRectMake(0, topBegin + rectCHeght/3*2, rect.size.width, rectCHeght/3))
        CGContextStrokePath(context)
        
        CGContextBeginTransparencyLayer(context, nil)
        
        CGContextSetRGBFillColor(context, 1, 1, 1, 1)
        CGContextFillRect(context, rect)
        
        CGContextSetRGBStrokeColor(context, 0.95, 0.95, 0.95, 1)
        CGContextSetLineWidth(context, 1)
        CGContextMoveToPoint(context, leftBegin, topBegin)
        CGContextAddLineToPoint(context, rect.size.width , topBegin)
        CGContextMoveToPoint(context, leftBegin, topBegin + rectCHeght/3)
        CGContextAddLineToPoint(context, rect.size.width, topBegin + rectCHeght/3)
        CGContextMoveToPoint(context, leftBegin, topBegin + rectCHeght/3*2)
        CGContextAddLineToPoint(context, rect.size.width, topBegin + rectCHeght/3*2)
        CGContextMoveToPoint(context, leftBegin, topBegin + rectCHeght)
        CGContextAddLineToPoint(context, rect.size.width, topBegin + rectCHeght)
        CGContextStrokePath(context)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .Center;
        let dic = [NSFontAttributeName : UIFont.systemFontOfSize(10), NSParagraphStyleAttributeName : paragraphStyle,NSForegroundColorAttributeName : UIColor.darkGrayColor()]
        let s60:NSString = "60"
        s60.drawInRect(CGRectMake(0, topBegin + 0-8, 15, 16), withAttributes: dic)
        let s45:NSString = "45"
        s45.drawInRect(CGRectMake(0, topBegin + rectCHeght/3-8, 15, 16), withAttributes: dic)
        let s30:NSString = "30"
        s30.drawInRect(CGRectMake(0, topBegin + rectCHeght/3*2-8, 15, 16), withAttributes: dic)
        let s15:NSString = "15"
        s15.drawInRect(CGRectMake(0, topBegin + rectCHeght-8, 15, 16), withAttributes: dic)
        
        let dic2 = [NSFontAttributeName : UIFont.systemFontOfSize(8), NSParagraphStyleAttributeName : paragraphStyle,NSForegroundColorAttributeName : UIColor.darkGrayColor()]
        var array = [NSValue]()
        for index in 0...12{
            let point = CGPointMake(leftBegin + CGFloat(index)*rectCWidth/12, topBegin + CGFloat(Int(arc4random()) % Int(rectCHeght)));
            array.append(NSValue(CGPoint: point))
            let s:NSString = "\(index)"
            s.drawInRect(CGRectMake(leftBegin + CGFloat(index)*rectCWidth/12 - 8, topBegin + rectCHeght, 16, 16), withAttributes: dic2)
        }
        
        CGContextSetBlendMode(context, .Clear)
        let path = UIBezierPath.quadCurvedPathWithPoints(array)
        path.stroke()
        CGContextAddPath(context, path.CGPath);
        CGContextStrokePath(context);
        CGContextEndTransparencyLayer(context);
    }


}
