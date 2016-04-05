//
//  EyeDiaryTableViewController.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/11.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class EyeDiaryTableViewController: UITableViewController {

    var first : Bool = true
    let maxIdex = 10
    var page = 1
    var tableViewArray = [[String : AnyObject]]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.estimatedRowHeight = 300.0;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
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
        let condition = ["userId" : UserInfo.CurrentUser().userId!]
        let dic = ["condition" : condition , "currentPage" : page,"pageSize" : maxIdex]
        DeviceRequest.GetEyeDiariesWithParameters(dic, success: { (object) -> Void in
            print(object)
            let dic:NSDictionary = object as! NSDictionary
            let state = dic["state"] as! Int
            if state == 0{
                if let array = object["data"] as? [[String : AnyObject]]{
                    if self.page == 1{
                        self.tableViewArray = dic["data"] as! Array<Dictionary<String,AnyObject>>
                    }
                    else{
                        self.tableViewArray.appendContentsOf(dic["data"] as! Array<Dictionary<String,AnyObject>>)
                    }
                    if array.count < self.maxIdex{
                        self.tableView.mj_footer.endRefreshingWithNoMoreData()
                    }
                    else{
                        self.tableView.mj_footer.endRefreshing()
                    }
                }
                else{
                    self.tableView.mj_footer.endRefreshing()
                }
            }
            else{
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

//    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 307
//    }
//    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 307
//    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("eyeDiaryIdentifier", forIndexPath: indexPath) as! EyeDiaryTableViewCell

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "imageSee"{
            let vc = segue.destinationViewController as! ImageSeeViewController
            if let image = sender as? UIImage{
                vc.image = image
            }
            else if let imageUrl = sender as? String{
                vc.imageUrl = imageUrl
            }
            
        }
    }


}
