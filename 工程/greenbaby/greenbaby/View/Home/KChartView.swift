//
//  KChartView.swift
//  greenbaby
//
//  Created by 刘向宏 on 16/1/8.
//  Copyright © 2016年 刘向宏. All rights reserved.
//

import UIKit

struct KChartModel {
    let value : CGFloat
    let x : String
}

class KChartViewModel : NSObject {
    init(type : Int , time : Int ,dic : [[String : AnyObject]]?){
        if dic != nil{
            dataDicArray = dic!
        }
        else{
            dataDicArray = [[String : AnyObject]]()
        }
        chartType = type
        timeType = time
        
        if chartType == 1{
            maxValue = 40
            minValue = 25
            maxBestValue = 35
            minBestValue = 30
        }
        else if chartType == 2{
//            maxValue = 60
//            minValue = 0
//            maxBestValue = 45
//            minBestValue = 30
            maxValue = 90
            minValue = 0
            maxBestValue = 60
            minBestValue = 30
        }
        else if chartType == 3{
            maxValue = 60
            minValue = -10
            maxBestValue = 45
            minBestValue = 0
        }
    }
    var maxValue = 35
    var minValue = 20
    var maxBestValue = 30
    var minBestValue = 25
    var chartType = 0
    var timeType = 0
    var subType = 0
    var dataDicArray = [[String : AnyObject]]()
    
    func getDataArray() -> [String : KChartModel]{
        var valueKey = "distance"
        if chartType == 2{
            valueKey = "time"
        }
        else if chartType == 3{
            if subType == 1{
                valueKey = "pitch"
            }
            else if subType == 2{
                valueKey = "yaw"
            }
            else if subType == 3{
                valueKey = "roll"
            }
        }
        print(subType)
        print(valueKey)
        
        var chartModels = [String : KChartModel]()
        chartModels = [String : KChartModel]()
        var tt = 0
        var ystring = ""
        for dic in dataDicArray{
            
            let calendar = NSCalendar.currentCalendar()
            if timeType == 2{
                let formote = "yyyy-w"
                let form = NSDateFormatter()
                form.dateFormat = formote
                let dd = form.dateFromString(dic["y"] as! String)
                let week = calendar.components(.WeekOfYear, fromDate: dd!, toDate: NSDate(), options: .WrapComponents).weekOfYear
                tt = 12 - week
            }
            else if timeType == 1{
                let formote = "yyyy-MM-dd"
                let form = NSDateFormatter()
                form.dateFormat = formote
                let dd = form.dateFromString(dic["y"] as! String)
                let week = calendar.components(.Day, fromDate: dd!, toDate: NSDate(), options: .WrapComponents).day
                print(week)
                tt = 12 - week
            }
            else if timeType == 3{
                let formote = "yyyy-MM"
                let form = NSDateFormatter()
                form.dateFormat = formote
                let dd = form.dateFromString(dic["y"] as! String)
                let week = calendar.components(.Month, fromDate: dd!, toDate: NSDate(), options: .WrapComponents).month
                print(week)
                tt = 12 - week
            }
            else if timeType == 4{
                let formote = dic["y"] as! String
                tt = 2015 - Int(formote)!
            }
            if tt < 0 || tt > 11{
                continue
            }
            if timeType != 4{
                ystring = "\(tt)"
            }
            chartModels["\(tt++)"] = KChartModel(value: dic[valueKey] as! CGFloat, x: ystring)
            print(dic[valueKey])
        }
        return chartModels
    }
}

class KChartView: UIView {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    var viewModel = KChartViewModel(type: 0, time: 0, dic: nil)
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        let topBegin:CGFloat = 15
        let bottomBegin:CGFloat = 15
        let leftBegin:CGFloat = 20
        let rectHeght = rect.size.height
        let rectCHeght = rectHeght - topBegin - bottomBegin
        let rectWidth = rect.size.width
        let rectCWidth = rectWidth - leftBegin - 8
        
        let maxBestTop = rectCHeght - rectCHeght / CGFloat(viewModel.maxValue - viewModel.minValue) * CGFloat(viewModel.maxBestValue - viewModel.minValue)
        let minBestTop = rectCHeght - rectCHeght / CGFloat(viewModel.maxValue - viewModel.minValue) * CGFloat(viewModel.minBestValue - viewModel.minValue) - maxBestTop
        
        
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetRGBFillColor(context, 1, 70/255.0, 70/255.0, 1)
        CGContextFillRect(context, CGRectMake(0, topBegin, rect.size.width, maxBestTop))
        CGContextSetRGBFillColor(context, 1, 199/255.0, 99/255.0, 1)
        CGContextFillRect(context, CGRectMake(0, topBegin + maxBestTop, rect.size.width, minBestTop))
        CGContextSetRGBFillColor(context, 55/255.0, 108/255.0, 214/255.0, 1)
        CGContextFillRect(context, CGRectMake(0, topBegin + maxBestTop + minBestTop, rect.size.width, rectHeght - (topBegin + maxBestTop + minBestTop)))
        CGContextStrokePath(context)
        
        CGContextBeginTransparencyLayer(context, nil)
        
        CGContextSetRGBFillColor(context, 1, 1, 1, 1)
        CGContextFillRect(context, rect)
        
        CGContextSetRGBStrokeColor(context, 0.95, 0.95, 0.95, 1)
        CGContextSetLineWidth(context, 1)
        CGContextMoveToPoint(context, leftBegin, topBegin)
        CGContextAddLineToPoint(context, rect.size.width , topBegin)
        CGContextMoveToPoint(context, leftBegin, topBegin + maxBestTop)
        CGContextAddLineToPoint(context, rect.size.width, topBegin + maxBestTop)
        CGContextMoveToPoint(context, leftBegin, topBegin + maxBestTop + minBestTop)
        CGContextAddLineToPoint(context, rect.size.width, topBegin + maxBestTop + minBestTop)
        CGContextMoveToPoint(context, leftBegin, topBegin + rectCHeght)
        CGContextAddLineToPoint(context, rect.size.width, topBegin + rectCHeght)
        CGContextStrokePath(context)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .Center;
        let dic = [NSFontAttributeName : UIFont.systemFontOfSize(10), NSParagraphStyleAttributeName : paragraphStyle,NSForegroundColorAttributeName : UIColor.darkGrayColor()]
        let s60:NSString = String(viewModel.maxValue)
        s60.drawInRect(CGRectMake(0, topBegin + 0-8, leftBegin, 16), withAttributes: dic)
        let s45:NSString = String(viewModel.maxBestValue)
        s45.drawInRect(CGRectMake(0, topBegin + maxBestTop-8, leftBegin, 16), withAttributes: dic)
        let s30:NSString = String(viewModel.minBestValue)
        s30.drawInRect(CGRectMake(0, topBegin + maxBestTop + minBestTop-8, leftBegin, 16), withAttributes: dic)
        let s15:NSString = String(viewModel.minValue)
        s15.drawInRect(CGRectMake(0, topBegin + rectCHeght-8, leftBegin, 16), withAttributes: dic)
        
        let dic2 = [NSFontAttributeName : UIFont.systemFontOfSize(7), NSParagraphStyleAttributeName : paragraphStyle,NSForegroundColorAttributeName : UIColor.darkGrayColor()]
        var array = [NSValue]()
        let arr = self.viewModel.getDataArray()
        for index in 0...12{
            if let model = arr["\(index)"]{
                let point = CGPointMake(leftBegin + CGFloat(index)*rectCWidth/12, topBegin + rectCHeght - (model.value - CGFloat(viewModel.minValue)) / CGFloat(viewModel.maxValue - viewModel.minValue) * rectCHeght);
                array.append(NSValue(CGPoint: point))
            }
            var s:NSString = "\(index)"
            if viewModel.timeType == 4{
                s = "\(2015+index)"
            }
            s.drawInRect(CGRectMake(leftBegin + CGFloat(index)*rectCWidth/12 - 10, topBegin + rectCHeght, 20, 16), withAttributes: dic2)
        }
        
        CGContextSetBlendMode(context, .Clear)
        if arr.count > 0{
            let path = UIBezierPath.quadCurvedPathWithPoints(array)
            path.stroke()
            CGContextAddPath(context, path.CGPath);
        }
        CGContextStrokePath(context);
        CGContextEndTransparencyLayer(context);
    }


}
