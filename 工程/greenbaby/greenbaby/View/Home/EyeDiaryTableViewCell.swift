//
//  EyeDiaryTableViewCell.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/28.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class EyeDiaryTableViewCell: UITableViewCell ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var createTimeLabel : UILabel!
    @IBOutlet weak var cdistanceScoreLabel : UILabel!
    @IBOutlet weak var postureScoreLabel : UILabel!
    @IBOutlet weak var timeScoreLabel : UILabel!
    @IBOutlet weak var totalScoreLabel : UILabel!
    
    @IBOutlet weak var cdistanceScoreTypeLabel : UILabel!
    @IBOutlet weak var postureScoreTypeLabel : UILabel!
    @IBOutlet weak var timeScoreTypeLabel : UILabel!
    @IBOutlet weak var totalScoreTypeLabel : UILabel!
    
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var collectionViewConstraint : NSLayoutConstraint!
    
    var imageArray : NSArray = NSArray()
    
    var dataDic : NSDictionary! {
        willSet{
            guard let value = newValue else{
                return
            }
            if value.count > 0{
                self.cdistanceScoreLabel.text = String(value["distanceScore"] as! Float)
                self.postureScoreLabel.text = String(value["postureScore"] as! Float)
                self.timeScoreLabel.text = String(value["timeScore"] as! Float)
                self.totalScoreLabel.text = String(value["totalScore"] as! Float)
                let time = value["createTime"] as! NSTimeInterval
                let timeDate = NSDate(timeIntervalSince1970: time/1000)
                let format = NSDateFormatter()
                format.dateFormat = "yyyy-MM-dd | hh:mm"
                createTimeLabel.text = format.stringFromDate(timeDate)
                imageArray = value["images"] as! NSArray
                if imageArray.count == 0 {
                    collectionViewConstraint.constant = 0
                }
                else if imageArray.count == 1{
                    collectionViewConstraint.constant = (UIScreen.mainScreen().bounds.size.width - 10 - 67 - 15)/2+10
                }
                else {
                    collectionViewConstraint.constant = (UIScreen.mainScreen().bounds.size.width - 10 - 67 - 20)/3+10
                }
                collectionView.reloadData()
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.backgroundColor = UIColor.clearColor()
        //eyeImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "imageClick"))
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func imageClick(){
        //myViewController()?.performSegueWithIdentifier("imageSee", sender: eyeImageView.image)
    }
    
    @IBAction func shareClicked(sender: UIButton) {
        myViewController()?.tabBarController?.performSegueWithIdentifier("shareIdentifier", sender: UIImage.imageWith(self))
    }
    
    func myViewController() -> UIViewController?{
        var responder = (self as UIResponder).nextResponder()
        while responder != nil{
            if responder!.isKindOfClass(UIViewController.classForCoder()){
                return responder as? UIViewController
            }
            responder = responder!.nextResponder()!
        }
        return nil
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count>3 ? 3 : imageArray.count
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("imageCell", forIndexPath: indexPath) as! ImageCollectionViewCell
        if let imageName = imageArray[indexPath.row] as? String{
            let url = NSURL(string: imageName.toResourceSeeURL())
            cell.imageView.sd_setImageWithURL(url, placeholderImage: nil)
        }
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(indexPath)
        myViewController()?.performSegueWithIdentifier("imageSee", sender: (imageArray[indexPath.row] as! String).toResourceSeeURL())
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
