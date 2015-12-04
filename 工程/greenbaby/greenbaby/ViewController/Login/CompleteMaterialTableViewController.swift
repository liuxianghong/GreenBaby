//
//  CompleteMaterialTableViewController.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/3.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class CompleteMaterialTableViewController: UITableViewController {
    
    var tableViewArray : NSArray = [["视力信息"," 3.5/0.03"],["平均每天读写时间（小时）"," 4"],["年龄（岁）"," 7"],["省份"," 广东"],["城市"," 深圳"]]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        var frame = self.tableView.tableFooterView?.frame
        frame?.size.height = 90.0
        self.tableView.tableFooterView?.frame = frame!
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem();
        self.navigationItem.backBarButtonItem?.title = "返回"
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func manClicked(sender: UIButton) {
        print("111111")
    }
    
    @IBAction func womanClicked(sender: UIButton) {
        print("222222")
    }
    
    @IBAction func nextClicked(sender: UIButton) {
        self.dismissViewControllerAnimated(true) { () -> Void in
        }
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableViewArray.count+1
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 85
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == tableViewArray.count{
            let cell:CompleteMaterialSexTableViewCell = tableView.dequeueReusableCellWithIdentifier("sexIdentifier", forIndexPath: indexPath) as! CompleteMaterialSexTableViewCell
            return cell
        }
        else
        {
            let cell:CompleteTableViewCell = tableView.dequeueReusableCellWithIdentifier("customIdentifier", forIndexPath: indexPath) as! CompleteTableViewCell
            
            // Configure the cell...
            let array : NSArray = tableViewArray[indexPath.row] as! NSArray
            cell.nameLabel.text = array[0] as? String
            cell.valueLabel.text = (array[1] as! String)
            return cell
        }

    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row != tableViewArray.count{
            self.performSegueWithIdentifier("CompleteValueIdentifier", sender: indexPath.row)
        }
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
        if segue.identifier == "CompleteValueIdentifier"{
            let vc : CompleteValueTableViewController = segue.destinationViewController as! CompleteValueTableViewController
            vc.type = sender as! Int
        }
    }


}
