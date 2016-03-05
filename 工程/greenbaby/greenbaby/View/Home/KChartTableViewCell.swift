//
//  KChartTableViewCell.swift
//  greenbaby
//
//  Created by 刘向宏 on 16/1/8.
//  Copyright © 2016年 刘向宏. All rights reserved.
//

import UIKit

class KChartTableViewCell: UITableViewCell {

    @IBOutlet weak var chartView : KChartView!
    @IBOutlet weak var nameLabel : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
