//
//  ForumThreadsTableViewController.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/17.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class ForumThreadsTableViewController: UITableViewController ,ForumThreadsDetailVCDelegate{

    @IBOutlet weak var titleLabel : UILabel!
    
    var dic : NSDictionary!
    var first : Bool = true
    var tableViewArray = [Dictionary<String,AnyObject>]()
    let maxIdex = 10
    var page = 1
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.estimatedRowHeight = 220.0;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        titleLabel.text = dic["groupName"] as? String
        
        var frame = self.tableView.tableHeaderView?.frame
        frame?.size.height = 58.0
        self.tableView.tableHeaderView?.frame = frame!
        
        self.tableView.tableFooterView = UIView();
        
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { () -> Void in
            self.page = 1
            self.loadData()
            
        })
        
        self.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { () -> Void in
            self.page++
            self.loadData()
        })
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if first {
            first = false
            self.tableView.mj_header.beginRefreshing()
        }
        self.tableView.reloadData()
    }
    
    func loadData(){
        let userId = NSUserDefaults.standardUserDefaults().objectForKey("userId")
        let dic : Dictionary<String,AnyObject> = ["condition" : ["groupId" : self.dic["groupId"]!,"userId" : userId!],"currentPage": page,"pageSize": maxIdex]
        ForumRequest.GetForumThreadsInGroupPageWithParameters(dic, success: { (object) -> Void in
            print(object)
            let dic:NSDictionary = object as! NSDictionary
            let state = dic["state"] as! Int
            if state == 0{
                if self.page == 1{
                    self.tableViewArray = dic["data"] as! Array<Dictionary<String,AnyObject>>
                }
                else{
                    self.tableViewArray.appendContentsOf(dic["data"] as! Array<Dictionary<String,AnyObject>>)
                }
                if dic["data"]?.count < self.maxIdex{
                    self.tableView.mj_footer.endRefreshingWithNoMoreData()
                }
                else{
                    self.tableView.mj_footer.endRefreshing()
                }
            }
            else{
//                let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
//                hud.mode = .Text
//                if let hudStr = dic["data"] as? String{
//                    hud.detailsLabelText = hudStr
//                }
//                else{
//                    hud.detailsLabelText = dic["description"] as? String
//                }
//                
//                hud.hide(true, afterDelay: 1.5)
                self.tableView.mj_footer.endRefreshing()
            }
            self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()
            
            }) { (error : NSError!) -> Void in
                print(error)
                let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                hud.mode = .Text
                hud.detailsLabelText = error.domain
                hud.hide(true, afterDelay: 1.5)
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshing()
        }
    }
    
    @IBAction func publishClick(){
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didPraiseOrCommplate(index: Int, dic: [String : AnyObject]) {
        if tableViewArray.count > index{
            if tableViewArray[index]["threadId"] as! Int == dic["threadId"] as! Int{
                tableViewArray[index] = dic
            }
        }
        
    }

    func emptyDataSetShouldAllowScroll(scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSetShouldAllowTouch(scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "暂无帖子")
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.tableViewArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("forumThreadsCell", forIndexPath: indexPath) as! ForumThreadsTableViewCell

        // Configure the cell...
        cell.dataDic = tableViewArray[indexPath.row]

        return cell
    }


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.performSegueWithIdentifier("ForumThreadsDetail", sender: indexPath)
    }

    /*
    // Override to support conditional editing of the table view.
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ForumThreadsDetail"{
            let vc = segue.destinationViewController as! ForumThreadsDetailViewController
            let indexPath = sender as! NSIndexPath
            vc.dic = self.tableViewArray[indexPath.row]
            vc.index = indexPath.row
            vc.forumThreadsDetailVCDelegate = self
        }
        if segue.identifier == "ForumPublish"{
            let vc = segue.destinationViewController as! ForumPublishTableViewController
            vc.groupId = self.dic["groupId"]!
        }
        
        
    }
    

}
