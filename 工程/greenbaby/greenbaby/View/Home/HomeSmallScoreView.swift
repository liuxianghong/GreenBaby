//
//  HomeSmallScoreView.swift
//  greenbaby
//
//  Created by 刘向宏 on 16/1/14.
//  Copyright © 2016年 刘向宏. All rights reserved.
//

import UIKit

class HomeSmallScoreView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var contanstView : UIView!
    @IBOutlet weak var scoreImageView : UIImageView!
    @IBOutlet weak var scoreLabel : UILabel!
    let initAngle : CGFloat = -90
    var maxScore : Float = 10
    var score : Float! = 0{
        willSet{
            guard let value = newValue else{
                return
            }
            scoreLabel.text = "\(value)"
            doScore(value)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSBundle.mainBundle().loadNibNamed("HomeSmallScoreView", owner: self, options: nil)
        self.addSubview(contanstView)
        self.backgroundColor = UIColor.clearColor()
        self.contanstView.backgroundColor = UIColor.clearColor()
        scoreLabel.text = "0"
        contanstView.frame = self.bounds
        //self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "gesClick"))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contanstView.frame = self.bounds
        doScore(score)
    }
    
    func doScore(sc : Float){
        let path = UIBezierPath(arcCenter: CGPointMake(self.scoreImageView.frame.size.width/2, self.scoreImageView.frame.size.height/2), radius: self.scoreImageView.frame.size.width/2, startAngle: CGFloat(self.initAngle) * CGFloat(M_PI/180.0), endAngle: (CGFloat(-sc) * (360) / CGFloat(maxScore) + (self.initAngle)) * CGFloat(M_PI/180.0), clockwise: false)
        path.addLineToPoint(CGPointMake(self.scoreImageView.frame.size.width/2, self.scoreImageView.frame.size.height/2))
        path.closePath()
        let shape = CAShapeLayer()
        shape.path = path.CGPath;
        self.scoreImageView.layer.mask = shape;
    }

}
