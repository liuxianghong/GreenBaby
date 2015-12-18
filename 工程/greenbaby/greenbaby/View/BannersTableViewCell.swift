//
//  BannersTableViewCell.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/17.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class BannersTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var thumbnailImage : UIImageView!
    @IBOutlet weak var timeLabel : UILabel!
    var dataDic : NSDictionary! {
        willSet{
            guard let value = newValue else{
                return
            }
            if value.count > 0{
                self.nameLabel.text = value["title"] as? String
                let url = NSURL(string: (value["thumbnail"] as! String).toResourceSeeURL())
                self.thumbnailImage.sd_setImageWithURL(url, placeholderImage: nil)
                let time = value["createTime"] as! NSTimeInterval
                let timeDate = NSDate(timeIntervalSince1970: time/1000)
                let format = NSDateFormatter()
                format.dateFormat = "yyyy.MM.dd   HH:mm"
                timeLabel.text = format.stringFromDate(timeDate)
            }
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

}
