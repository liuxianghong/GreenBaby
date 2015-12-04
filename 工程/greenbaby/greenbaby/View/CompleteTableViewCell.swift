//
//  CompleteTableViewCell.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/3.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class CompleteTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var valueLabel : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        valueLabel.layer.cornerRadius = 4
        valueLabel.layer.masksToBounds = true
        valueLabel.layer.borderWidth = 1.0 / UIScreen.mainScreen().scale
        valueLabel.layer.borderColor = UIColor.lightGrayColor().CGColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
