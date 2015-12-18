//
//  ForumViewController.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/12.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class ForumViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,BransViewDelegate {

    @IBOutlet weak var  collectionView : UICollectionView!
    @IBOutlet weak var  bransView : BransView!
    var bannersState = 1
    var forumGroupState = 1
    var bannersArray : NSArray = NSArray()
    var collectionArray : NSArray = NSArray()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.backgroundColor = UIColor.whiteColor()
        bransView.delegate = self
        
        BannersRequest.GetBannersWithParameters(nil, success: { (object) -> Void in
            print(object)
            let dic:NSDictionary = object as! NSDictionary
            self.bannersState = dic["state"] as! Int
            if self.bannersState == 0{
                self.bannersArray = dic["data"] as! NSArray
                self.bransView.dataArray = self.bannersArray
            }
            }) { (error : NSError!) -> Void in
                print(error)
        }
        
        ForumRequest.GetForumGroupWithParameters("0", success: { (object) -> Void in
            print(object)
            let dic:NSDictionary = object as! NSDictionary
            self.forumGroupState = dic["state"] as! Int
            if self.forumGroupState == 0{
                self.collectionArray = dic["data"] as! NSArray
                self.collectionView.reloadData()
            }
            }) { (error : NSError!) -> Void in
                
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
    // MARK: - BransViewDelegate
    
    func didClickIndex(index: Int, tag: NSDictionary) {
        self.performSegueWithIdentifier("bannersDetail", sender: tag)
    }
    // MARK: - UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionArray.count>6 ? 6 : self.collectionArray.count
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ForumCell", forIndexPath: indexPath) as! ForumCollectionViewCell
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        if indexPath.row == 5 && self.collectionArray.count>6{
            cell.dataDic = ["groupName" : "全部","groupIcon" : "201511271151090640.png"]
            cell.isAll = true
        }
        else{
            let dic = collectionArray[indexPath.row] as! NSDictionary
            cell.dataDic = dic
            cell.isAll = false
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(indexPath)
        if indexPath.row == 5 && self.collectionArray.count>6{
            self.performSegueWithIdentifier("moreForum", sender: nil)
        }
        else
        {
            let userId = NSUserDefaults.standardUserDefaults().objectForKey("userId")
            if userId == nil{
                self.tabBarController?.performSegueWithIdentifier("loginIdentifier", sender: nil)
            }
            else
            {
                let dic = collectionArray[indexPath.row] as! NSDictionary
                self.performSegueWithIdentifier("ForumThreads", sender: dic)
            }
        }
        
    }
    
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = self.view.frame.size.width / 3 - 15
        var height = collectionView.frame.size.height/2 - 5.0
        if width > height {
            height = width
        }
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
        if segue.identifier == "moreForum"{
            let vc = segue.destinationViewController as! MoreForumViewController
            vc.collectionArray = collectionArray
            let width = self.view.frame.size.width / 3 - 10
            var height = collectionView.frame.size.height/2
            if width > height {
                height = width
            }
            vc.csize = CGSize(width: width, height: height)
        }
        else if segue.identifier == "moreBanners"{
            let vc = segue.destinationViewController as! BannersViewController
            vc.dataArray = bransView.dataArray
        }
        else if segue.identifier == "bannersDetail"{
            let vc = segue.destinationViewController as! BannersDetailViewController
            vc.dic = sender as! NSDictionary
        }
        else if segue.identifier == "ForumThreads"{
            let vc = segue.destinationViewController as! ForumThreadsTableViewController
            vc.dic = sender as! NSDictionary
        }
        
        
    }


}
