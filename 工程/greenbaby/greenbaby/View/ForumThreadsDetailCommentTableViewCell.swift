//
//  ForumThreadsDetailCommentTableViewCell.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/17.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class ForumThreadsDetailCommentTableViewCell: UITableViewCell {

    @IBOutlet weak var headImageView : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var addressLabel : UILabel!
    @IBOutlet weak var timeLabel : UILabel!
    @IBOutlet weak var titleLabel : UILabel!
    
    var dataDic : NSDictionary! {
        willSet{
            guard let value = newValue else{
                return
            }
            if value.count > 0{
                self.nameLabel.text = value["memberName"] as? String
                self.titleLabel.text = value["comment"] as? String
                self.addressLabel.text = value["location"] as? String
                if value["memberHeadImage"] != nil{
                    let url = NSURL(string: (value["memberHeadImage"] as! String).toResourceSeeURL())
                    self.headImageView.sd_setImageWithURL(url, placeholderImage: nil)
                }
                let time = value["commentTime"] as! NSTimeInterval
                let timeDate = NSDate(timeIntervalSince1970: time/1000)
                let format = NSDateFormatter()
                format.dateFormat = "yyyy-MM-dd"
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
