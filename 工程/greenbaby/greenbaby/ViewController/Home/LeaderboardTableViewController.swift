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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        var frame = self.tableView.tableHeaderView?.frame
        frame?.size.height = 50.0
        self.tableView.tableHeaderView?.frame = frame!
        
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { () -> Void in
            self.tableView.mj_header.endRefreshing()
        })
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
        self.tableView.reloadData()
    }
    
    @IBAction func lastWeekClick(sendr : UIButton){
        thisWeekView.hidden = true
        lastWeekView.hidden = false
        thisWeekButton.selected = false
        lastWeekButton.selected = true
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 9
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LeaderboardCell", forIndexPath: indexPath) as! LeaderboardTableViewCell

        // Configure the cell...
        cell.isLastWeek = thisWeekView.hidden
        cell.number = indexPath.row+1
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
