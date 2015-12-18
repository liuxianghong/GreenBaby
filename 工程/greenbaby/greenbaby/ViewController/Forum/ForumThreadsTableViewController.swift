//
//  ForumThreadsTableViewController.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/17.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class ForumThreadsTableViewController: UITableViewController {

    @IBOutlet weak var titleLabel : UILabel!
    
    var dic : NSDictionary!
    var first : Bool = true
    var tableViewArray : NSArray = NSArray()
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
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        let userId = NSUserDefaults.standardUserDefaults().objectForKey("userId")
        let dicP : Dictionary<String,AnyObject> = ["groupId" : self.dic["groupId"]!,"userId" : userId!]
        ForumRequest.GetForumThreadsInGroupWithParameters(dicP, success: { (object) -> Void in
            print(object)
            let dic:NSDictionary = object as! NSDictionary
            let state:Int = dic["state"] as! Int
            if state == 0{
                self.tableViewArray = dic["data"] as! NSArray
                self.tableView.reloadData()
                hud.hide(true)
            }else{
                hud.mode = .Text
                hud.detailsLabelText = dic["description"] as! String
                hud.hide(true, afterDelay: 1.5)
            }
            }) { (error : NSError!) -> Void in
                hud.mode = .Text
                hud.detailsLabelText = error.domain
                hud.hide(true, afterDelay: 1.5)
        }
    }
    
    @IBAction func publishClick(){
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
        return self.tableViewArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("forumThreadsCell", forIndexPath: indexPath) as! ForumThreadsTableViewCell

        // Configure the cell...
        cell.dataDic = tableViewArray[indexPath.row] as! NSDictionary

        return cell
    }


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.performSegueWithIdentifier("ForumThreadsDetail", sender: self.tableViewArray[indexPath.row])
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
            vc.dic = sender as! NSDictionary
        }
        if segue.identifier == "ForumPublish"{
            let vc = segue.destinationViewController as! ForumPublishTableViewController
            vc.groupId = self.dic["groupId"]!
        }
        
        
    }
    

}
