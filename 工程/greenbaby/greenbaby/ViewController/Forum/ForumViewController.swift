//
//  ForumViewController.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/12.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class ForumViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var  collectionView : UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.backgroundColor = UIColor.whiteColor()
        
        BannersRequest.GetBannersWithParameters(nil, success: { (object) -> Void in
            print(object)
            }) { (error : NSError!) -> Void in
                print(error)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        collectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ForumCell", forIndexPath: indexPath) as! ForumCollectionViewCell
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(indexPath)
    }
    
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = self.view.frame.size.width / 3 - 10
        var height = collectionView.frame.size.height/2
        if width > height {
            height = width
        }
        return CGSize(width: width, height: height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
