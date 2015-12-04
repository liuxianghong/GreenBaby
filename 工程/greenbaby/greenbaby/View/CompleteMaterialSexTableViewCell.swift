//
//  CompleteMaterialSexTableViewCell.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/3.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class CompleteMaterialSexTableViewCell: UITableViewCell {

    @IBOutlet var manButton : UIButton!
    @IBOutlet var womanButton : UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        manButton.layer.borderWidth = 1.0
        manButton.layer.borderColor = UIColor.mainGreenColor().CGColor
        womanButton.layer.borderWidth = 1.0
        womanButton.layer.borderColor = UIColor.mainGreenColor().CGColor
    }
    
    @IBAction func manClicked(sender: UIButton) {
        manButton.selected = true
        womanButton.selected = false
    }
    
    @IBAction func womanClicked(sender: UIButton) {
        manButton.selected = false
        womanButton.selected = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
