//
//  VSInspectionViewController.swift
//  greenbaby
//
//  Created by 刘向宏 on 16/1/4.
//  Copyright © 2016年 刘向宏. All rights reserved.
//

import UIKit

class VSInspectionViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var VSISPButton : UIButton!
    @IBOutlet weak var EyeChartButton : UIButton!
    @IBOutlet weak var VSISPFrontView : UIView!
    @IBOutlet weak var EyeChartFrontView : UIView!
    @IBOutlet weak var EyeListScrollView : UIScrollView!
    @IBOutlet weak var EyeListImageView : UIImageView!
    @IBOutlet weak var VSISPCView : UIView!
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var collectionViewLayoutConstraint : NSLayoutConstraint!
    @IBOutlet weak var VSISPImageView : UIImageView!
    @IBOutlet weak var VSISPStateImageView1 : UIImageView!
    @IBOutlet weak var VSISPStateImageView2 : UIImageView!
    @IBOutlet weak var VSISPStateImageView3 : UIImageView!
    var height : CGFloat = 0
    var width : CGFloat = 0
    let imageName = "img_"
    var index = 0
    var tagIndex = 0
    var errorIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if self.view.frame.size.width<350{
            let image = EyeListImageView.image!.scaleImage(0.8)
            EyeListImageView.image = image
        }
        
        let image1 = UIImage(named: "img_4.0")
        let image2 = UIImage(named: "icn_right_s")
        width = image1!.size.width
        height = image1!.size.height + image2!.size.height
        collectionViewLayoutConstraint.constant = height
        collectionView.contentInset = UIEdgeInsets(top: 0, left: self.view.frame.size.width/2 - width/2, bottom: 0, right: self.view.frame.size.width/2 - width/2)
        collectionView.userInteractionEnabled = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        index = 0
        errorIndex = 0
        doVSISP()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func VSISPClick(sender : UIButton){
        EyeChartButton.selected = false
        VSISPFrontView.hidden = false
        VSISPButton.selected = true
        EyeChartFrontView.hidden = true
        doAnimation(false)
    }
    
    @IBAction func EyeChartClick(sender : UIButton){
        EyeChartButton.selected = true
        VSISPFrontView.hidden = true
        VSISPButton.selected = false
        EyeChartFrontView.hidden = false
        doAnimation(true)
    }
    
    @IBAction func checkClick(sender : UIButton){
       
        if sender.tag == tagIndex{
            if index >= 13{
                self.performSegueWithIdentifier("VSInspectionResultIndentifier", sender: 13)
                return
            }
            index++
            errorIndex = 0
        }
        else{
            errorIndex++
            if errorIndex == 2{
                self.performSegueWithIdentifier("VSInspectionResultIndentifier", sender: index == 0 ? 0 : index-1)
                return
            }
        }
        doVSISP()
    }
    
    func doVSISP(){
        VSISPStateImageView1.hidden = errorIndex == 0
        let f = 4.0 + Float(index) / 10.0 + 0.1
        var postion = "r"
        let random =  arc4random() % 100;
        print(random)
        if index == 0{
            tagIndex = 2
        }
        else if index == 1{
            if random%2 == 0{
                postion = "u"
                tagIndex = 3
            }
            else{
                postion = "r"
                tagIndex = 2
            }
            
        }
        else if index == 2{
            let randomValue = random%3
            if randomValue == 0{
                postion = "u"
                tagIndex = 3
            }
            else if randomValue == 1{
                postion = "l"
                tagIndex = 1
            }
            else {
                postion = "d"
                tagIndex = 4
            }
            
        }
        else if index == 3{
            let randomValue = random%3
            if randomValue == 0{
                postion = "u"
                tagIndex = 3
            }
            else if randomValue == 1{
                postion = "l"
                tagIndex = 1
            }
            else {
                postion = "r"
                tagIndex = 2
            }
            
        }
        else{
            let randomValue = random%4
            print(randomValue)
            if randomValue == 0{
                postion = "u"
                tagIndex = 3
            }
            else if randomValue == 1{
                postion = "l"
                tagIndex = 1
            }
            else if randomValue == 2{
                postion = "r"
                tagIndex = 2
            }
            else {
                postion = "d"
                tagIndex = 4
            }
        }
        let name = "e_\(f)_\(postion)"
        VSISPImageView.image = UIImage(named: name)
        collectionView.reloadData()
        collectionView.setContentOffset(CGPointMake(width * CGFloat(index) - (self.view.frame.size.width - width)/2, 0), animated: true)
    }
    
    
    
    func doAnimation(bo : Bool){
        UIView.animateWithDuration(0.3) { () -> Void in
            self.EyeListScrollView.alpha = bo ? 1 : 0
            self.VSISPCView.alpha = bo ? 0 : 1
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellIdentifier", forIndexPath: indexPath) as! VSInspectionCollectionViewCell
        let f = 4.0 + Float(indexPath.row) / 10.0
        var name = ""
        cell.imageState.hidden = true
        if indexPath.row == index{
            name = imageName + "\(f)g"
        }
        else if index > indexPath.row{
            name = imageName + "\(f)d"
            cell.imageState.hidden = false
        }
        else{
            name = imageName + "\(f)"
        }
        cell.imageRule.image = UIImage(named: name)
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(indexPath)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "VSInspectionResultIndentifier"{
            let vc = segue.destinationViewController as! VSInspectionResultViewController
            vc.index = sender as! Int
        }
        
    }

}
