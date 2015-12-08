//
//  LeaderboardTableViewCell.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/8.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class LeaderboardTableViewCell: UITableViewCell {

    @IBOutlet weak var numberLabel : UILabel!
    @IBOutlet weak var headImageView : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var addressLabel : UILabel!
    @IBOutlet weak var moneyImageView : UIImageView!
    @IBOutlet weak var moneyLabel : UILabel!
    @IBOutlet weak var scoreLabel : UILabel!
    var isLastWeek : Bool? = false{
        willSet{
            guard let value = newValue else{
                return
            }
            self.moneyLabel.hidden = !value
            self.moneyImageView.hidden = !value
        }
    }
    
    var number : Int? = 1{
        willSet{
            guard let value = newValue else{
                return
            }
            self.numberLabel.text = "\(value)"
            if value < 4{
                self.numberLabel.textColor = UIColor.mainGreenColor()
                self.moneyLabel.textColor = UIColor.rgbColor(0xffa401)
                self.scoreLabel.textColor = UIColor.rgbColor(0x00cfe6)
                self.moneyImageView.highlighted = true
            }
            else
            {
                self.numberLabel.textColor = UIColor.darkGrayColor()
                self.moneyLabel.textColor = UIColor.darkGrayColor()
                self.scoreLabel.textColor = UIColor.darkGrayColor()
                self.moneyImageView.highlighted = false
            }
            if value == 5{
                isMe = true
            }
        }
    }
    
    var isMe : Bool? = false{
        willSet{
            guard let value = newValue else{
                return
            }
            if value{
                self.contentView.backgroundColor = UIColor.rgbColor(0xd9d9d9)
            }
            else
            {
                self.contentView.backgroundColor = UIColor.whiteColor()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.headImageView.layer.cornerRadius = 49/2;
        self.headImageView.layer.masksToBounds = true;
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
