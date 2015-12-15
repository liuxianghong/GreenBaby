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
