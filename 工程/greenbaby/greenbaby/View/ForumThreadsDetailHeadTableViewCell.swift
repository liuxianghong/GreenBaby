//
//  ForumThreadsDetailHeadTableViewCell.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/17.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class ForumThreadsDetailHeadTableViewCell: UITableViewCell, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var headImageView : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var addressLabel : UILabel!
    @IBOutlet weak var timeLabel : UILabel!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var goodButton : UIButton!
    @IBOutlet weak var commentButton : UIButton!
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var collectionViewConstraint : NSLayoutConstraint!
    var imageArray : NSArray = NSArray()
    
    var dataDic : NSDictionary! {
        willSet{
            guard let value = newValue else{
                return
            }
            if value.count > 0{
                self.nameLabel.text = value["posterName"] as? String
                self.titleLabel.text = value["title"] as? String
                //self.addressLabel.text = value["title"] as? String
                self.commentButton.setTitle("\(value["commentCount"] as! Int)", forState: .Normal)
                self.goodButton.setTitle("\(value["praiseCount"] as! Int)", forState: .Normal)
                let url = NSURL(string: (value["posterHeadImage"] as! String).toResourceSeeURL())
                self.headImageView.sd_setImageWithURL(url, placeholderImage: nil)
                let time = value["postTime"] as! NSTimeInterval
                let timeDate = NSDate(timeIntervalSince1970: time/1000)
                let format = NSDateFormatter()
                format.dateFormat = "yyyy-MM-dd"
                timeLabel.text = format.stringFromDate(timeDate)
                imageArray = value["threadImages"] as! NSArray
                if imageArray.count == 0 {
                    collectionViewConstraint.constant = 0
                }
                else if imageArray.count == 1{
                    collectionViewConstraint.constant = (UIScreen.mainScreen().bounds.size.width - 10 - 10 - 15)/2+10
                }
                else {
                    collectionViewConstraint.constant = (UIScreen.mainScreen().bounds.size.width - 10 - 10 - 20)/3+10
                }
                collectionView.reloadData()
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.collectionView.backgroundColor = UIColor.whiteColor()
        
        headImageView.layer.cornerRadius = 21;
        headImageView.layer.masksToBounds = true;
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("imageCell", forIndexPath: indexPath) as! ImageCollectionViewCell
        let url = NSURL(string: (imageArray[indexPath.row] as! String).toResourceSeeURL())
        cell.imageView.sd_setImageWithURL(url, placeholderImage: nil)
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(indexPath)
        
    }
    
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let height = collectionView.frame.size.height - 15
        return CGSize(width: height, height: height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 5, 5, 5)
    }

}
