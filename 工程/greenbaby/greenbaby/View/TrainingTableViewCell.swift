//
//  TrainingTableViewCell.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/12.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class TrainingTableViewCell: UITableViewCell {

    @IBOutlet weak var NameLabel : UILabel!
    
    @IBOutlet weak var sliderLeftLabel : UILabel!
    @IBOutlet weak var sliderRightLabel : UILabel!
    @IBOutlet weak var sliderValueLabel : UILabel!
    
    @IBOutlet weak var sliderBackView : UIView!
    @IBOutlet weak var scoreLable : UILabel!
    
    @IBOutlet weak var sliderConstraint : NSLayoutConstraint!
    @IBOutlet weak var detailSeeButton : UIButton!
    
    @IBOutlet weak var sliderValueView : UIView!
    
    var type = 0{
        willSet{
            if newValue == 0{
                self.sliderLeftLabel.text = "0cm"
                self.sliderRightLabel.text = "35cm"
            }
            else if newValue == 1{
                self.sliderLeftLabel.text = "0°"
                self.sliderRightLabel.text = "90°"
            }
            else if newValue == 2{
                self.sliderLeftLabel.text = "0°"
                self.sliderRightLabel.text = "90°"
            }
            else if newValue == 3{
                self.sliderLeftLabel.text = "0°"
                self.sliderRightLabel.text = "90°"
            }
        }
    }
    var layoutValue : CGFloat = 0
    var model = TrainingViewModel(){
        willSet{
            if newValue.training == nil{
                self.sliderValueLabel.text = String(0)
                layoutValue = 0
                return;
            }
            else{
                if type == 0{
                    self.sliderValueLabel.text = String(newValue.training.distance)
                    layoutValue = CGFloat(Float(newValue.training.distance!)/35.0)
                }
                else if type == 1{
                    self.sliderValueLabel.text = String(newValue.training.pitch)
                    layoutValue = CGFloat(Float(newValue.training.pitch!)/90.0)
                }
                else if type == 2{
                    self.sliderValueLabel.text = String(newValue.training.yaw)
                    layoutValue = CGFloat(Float(newValue.training.yaw!)/90.0)
                }
                else if type == 3{
                    self.sliderValueLabel.text = String(newValue.training.roll)
                    layoutValue = CGFloat(Float(newValue.training.roll!)/90.0)
                }
            }
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.sliderConstraint.constant = self.sliderBackView.frame.width - 1 - self.sliderBackView.frame.width * layoutValue
        print(self.sliderConstraint.constant,self.sliderBackView.frame.width)
    }
    
    @IBAction func detailClick(){
        myViewController()?.tabBarController!.performSegueWithIdentifier("detailSeeIdentifier", sender: type)
    }
    
    func myViewController() -> UIViewController?{
        var responder = (self as UIResponder).nextResponder()
        while responder != nil{
            if responder!.isKindOfClass(UIViewController.classForCoder()){
                return responder as? UIViewController
            }
            responder = responder!.nextResponder()!
        }
        return nil
    }

}
