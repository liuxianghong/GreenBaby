//
//  ThreadsTableViewController.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/18.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class ThreadsTableViewController: UITableViewController,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource {

    var first : Bool = true
    var tableViewArray = [Dictionary<String,AnyObject>]()
    let maxIdex = 10
    var page = 1
    var type = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.estimatedRowHeight = 220.0;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        self.tableView.tableFooterView = UIView();
        
        self.title = type == 0 ? "我的发布" : "我的回复"
        
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData(){
        
        let userId = NSUserDefaults.standardUserDefaults().objectForKey("userId")
        let dicP : Dictionary<String,AnyObject> = ["userId" : userId!]
        let bo = type == 0 ? true : false
        
        let dic : Dictionary<String,AnyObject> = ["condition" : dicP,"currentPage": page,"pageSize": maxIdex]
        ForumRequest.GetMyThreadPageWithParameters(dic, post: bo,success: { (object) -> Void in
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
        return tableViewArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("forumThreadsCell", forIndexPath: indexPath) as! ForumThreadsTableViewCell

        // Configure the cell...

        cell.dataDic = tableViewArray[indexPath.row]
        return cell
    }


    /*
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
