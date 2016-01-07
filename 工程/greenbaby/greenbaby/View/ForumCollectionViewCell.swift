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
    @IBOutlet weak var imageBackView : UIView!
    
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
        //imageView.backgroundColor = UIColor.greenColor()
        
        //添加边框
        imageBackView.layer.borderColor = UIColor.mainGreenColor().CGColor;
        imageBackView.layer.borderWidth = 2.0
        
        imageView.layer.masksToBounds = true
        imageBackView.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageBackView.setNeedsUpdateConstraints()
        imageBackView.updateConstraintsIfNeeded()
        imageBackView.setNeedsLayout()
        imageBackView.layoutIfNeeded()
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageBackView.layer.cornerRadius = imageBackView.frame.size.width/2
    }
}
