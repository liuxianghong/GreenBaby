//
//  ForumCollectionViewCell.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/14.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class ForumCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var imageView : UIImageView!
    
    var dataDic : NSDictionary! {
        willSet{
            guard let value = newValue else{
                return
            }
            if value.count > 0{
                self.nameLabel.text = value["groupName"] as? String
                let url = NSURL(string: (value["groupIcon"] as! String).toResourceSeeURL())
                self.imageView.sd_setImageWithURL(url, placeholderImage: nil)
            }
        }
    }
    
    var isAll : Bool! = false {
        willSet{
            guard let value = newValue else{
                return
            }
            if value{
                self.nameLabel.text = "更多话题"
                self.imageView.image = UIImage(named: "huati_gengduo")
                self.nameLabel.textColor = UIColor.mainGreenColor()
            }
            else
            {
                self.nameLabel.textColor = UIColor.blackColor()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.clearColor()
        imageView.backgroundColor = UIColor.greenColor()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.size.width/2;
        imageView.layer.masksToBounds = true;
    }
}
