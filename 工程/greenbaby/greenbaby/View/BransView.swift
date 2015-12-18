//
//  BransView.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/17.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

@objc protocol BransViewDelegate{
    func didClickIndex(index:Int, tag:NSDictionary)
}

class BransView: UIView {
    
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var pageControl : UIPageControl!
    @IBOutlet weak var contanstView : UIView!

    weak var delegate : BransViewDelegate?
    var imageViewArray : Array<UIImageView> = Array()
    var labelArray : Array<UILabel> = Array()
    var dataArray : NSArray! = NSArray() {
        didSet{
            layoutScroll()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSBundle.mainBundle().loadNibNamed("BransView", owner: self, options: nil)
        self.addSubview(contanstView)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "gesClick"))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contanstView.frame = self.bounds
        self.layoutScroll()
    }
    
    func gesClick(){
        let tag : Int = Int((self.scrollView.contentOffset.x+1) / self.frame.size.width)
        print(tag)
        if delegate != nil{
            let dic = dataArray[tag] as! NSDictionary
            delegate?.didClickIndex(tag, tag: dic)
        }
    }
    
    func layoutScroll(){
        for view in self.scrollView.subviews{
            view.removeFromSuperview()
        }
        pageControl.numberOfPages = dataArray.count
        for (var i = 0 ;i < dataArray.count ; i++){
            var imageView : UIImageView! = nil
            if imageViewArray.count <= i{
                imageView = UIImageView()
                imageView.tag = i
                imageViewArray.append(imageView)
            }
            else
            {
                imageView = imageViewArray[i]
            }
            var labelView : UILabel! = nil
            if labelArray.count <= i{
                labelView = UILabel()
                labelView.textColor = UIColor.whiteColor()
                labelView.font = UIFont.systemFontOfSize(7)
                labelView.tag = i
                labelArray.append(labelView)
            }
            else
            {
                labelView = labelArray[i]
            }
            
            let dic = dataArray[i] as! NSDictionary
            labelView.text = dic["title"] as? String
            let url = NSURL(string: (dic["thumbnail"] as! String).toResourceSeeURL())
            imageView.sd_setImageWithURL(url, placeholderImage: nil)
            labelView.sizeToFit()
            labelView.frame = CGRect(x: self.frame.size.width * CGFloat(i)+(self.frame.size.width-labelView.frame.size.width)/2, y: self.frame.size.height-10-labelView.frame.size.height, width: labelView.frame.size.width, height: labelView.frame.size.height)
            imageView.frame = CGRect(x: self.frame.size.width * CGFloat(i), y: 0, width: self.frame.size.width, height: self.frame.size.height)
            
            
            self.scrollView.addSubview(imageView)
            self.scrollView.addSubview(labelView)
        }
        self.scrollView.contentSize = CGSize(width: self.frame.size.width * CGFloat(dataArray.count), height: self.frame.size.height)
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
