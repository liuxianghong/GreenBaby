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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
