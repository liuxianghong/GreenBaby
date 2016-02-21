//
//  LeaderboardTableViewController.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/8.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class LeaderboardTableViewController: UITableViewController {

    @IBOutlet weak var thisWeekView : UIView!
    @IBOutlet weak var lastWeekView : UIView!
    @IBOutlet weak var thisWeekButton : UIButton!
    @IBOutlet weak var lastWeekButton : UIButton!
    var lastWeekData : [[String : AnyObject]] = []
    var thisWeekData : [[String : AnyObject]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        var frame = self.tableView.tableHeaderView?.frame
        frame?.size.height = 50.0
        self.tableView.tableHeaderView?.frame = frame!
        self.tableView.tableFooterView = UIView()
        
        thisWeekClick(thisWeekButton)
        loadData(true)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.mj_header.beginRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func thisWeekClick(sendr : UIButton){
        thisWeekView.hidden = false
        lastWeekView.hidden = true
        thisWeekButton.selected = true
        lastWeekButton.selected = false
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { () -> Void in
            self.loadData(false)
        })
        self.tableView.reloadData()
    }
    
    @IBAction func lastWeekClick(sendr : UIButton){
        thisWeekView.hidden = true
        lastWeekView.hidden = false
        thisWeekButton.selected = false
        lastWeekButton.selected = true
        self.tableView.mj_header = nil
        self.tableView.reloadData()
        self.loadData(true)
    }
    
    @IBAction func shareClicked(sender: UIButton) {
        self.tabBarController?.performSegueWithIdentifier("shareIdentifier", sender: UIImage.imageWith(self.view))
    }
    
    func loadData(lastWeek : Bool){
        var condition = [String:AnyObject]()
        if lastWeek{
            condition["lastWeek"] = 1
        }
        let dic = ["currentPage" : 1,"condition" : condition]
        DeviceRequest.GetRankingWithParameters(dic, success: { (object) -> Void in
            print(object)
            if self.tableView.mj_header != nil{
                self.tableView.mj_header.endRefreshing()
            }
            
            let state = object["state"] as! Int
            if state == 0{
                if let data = object["data"] as? [[String : AnyObject]]{
                    if lastWeek{
                        self.lastWeekData = data
                    }
                    else{
                        self.thisWeekData = data
                    }
                }
            }
            self.tableView.reloadData()
            }) { (error : NSError!) -> Void in
                if self.tableView.mj_header != nil{
                    self.tableView.mj_header.endRefreshing()
                }
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if thisWeekButton.selected{
            return thisWeekData.count
        }
        return lastWeekData.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LeaderboardCell", forIndexPath: indexPath) as! LeaderboardTableViewCell

        // Configure the cell...
        cell.isLastWeek = thisWeekView.hidden
        if thisWeekButton.selected{
            cell.data = thisWeekData[indexPath.row]
        }
        else{
            cell.data = lastWeekData[indexPath.row]
        }

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
