//
//  MySelfTableViewController.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/8.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class MySelfTableViewController: UITableViewController {

    @IBOutlet weak var headConstraint : NSLayoutConstraint!
    @IBOutlet weak var headBConstraint : NSLayoutConstraint!
    @IBOutlet weak var headBBConstraint : NSLayoutConstraint!
    
    @IBOutlet weak var headImageView : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var addressLabel : UILabel!
    @IBOutlet weak var moneyLabel : UILabel!
    @IBOutlet weak var loginButton : UIButton!
    @IBOutlet weak var swithButton : UIButton!
    
    var headHeight:CGFloat = 165.0
    @IBOutlet weak var headView : UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationItem.backBarButtonItem = UIBarButtonItem();
        self.navigationItem.backBarButtonItem?.title = "返回"
        headView.backgroundColor = UIColor.mainGreenColor()
        
        self.tableView.backgroundColor = UIColor.whiteColor()
        
        
        
        headHeight = self.view.frame.size.height/4;
        if headHeight < 500/4{
            headConstraint.constant = 40
            headBConstraint.constant = 5
            headBBConstraint.constant = 8
        }
        self.headImageView.layer.cornerRadius = headConstraint.constant/2;
        self.headImageView.layer.masksToBounds = true;
        
        var frame = self.tableView.tableHeaderView?.frame
        frame?.size.height = headHeight
        self.tableView.tableHeaderView?.frame = frame!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        let userId = NSUserDefaults.standardUserDefaults().objectForKey("userId")
        if userId != nil{
            self.loginButton.hidden = true
            self.nameLabel.hidden = false
            self.addressLabel.hidden = false
            
            self.nameLabel.text = NSUserDefaults.standardUserDefaults().objectForKey("userName") as? String
            let gold = NSUserDefaults.standardUserDefaults().objectForKey("gold") as! Int
            self.moneyLabel.text = "\(gold)"
            if NSUserDefaults.standardUserDefaults().objectForKey("headImage") != nil{
                headImageView.sd_setImageWithURL(NSURL(string: (NSUserDefaults.standardUserDefaults().objectForKey("headImage") as! String).toResourceSeeURL()))
            }
        }
        else
        {
            self.loginButton.hidden = false
            self.nameLabel.hidden = true
            self.addressLabel.hidden = true
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func loginClick(sendr : UIButton){
        self.performSegueWithIdentifier("loginIdentifier", sender: nil)
    }
    
    @IBAction func switchClick(sendr : UIButton){
        sendr.selected = !sendr.selected
    }
    
    @IBAction func inforMationSeeClick(){
        let userId = NSUserDefaults.standardUserDefaults().objectForKey("userId")
        if userId != nil{
            self.performSegueWithIdentifier("UserSeeIdentifier", sender: nil)
        }
    }
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1{
            return 8
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let height = (self.view.frame.size.height - headHeight - 8 - 20 - 49)/9
        return height;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 1 && indexPath.row == 3{
            let avc = UIAlertController(title: "提示", message: "确定要退出吗？", preferredStyle: .Alert)
            let action = UIAlertAction(title: "确定", style: .Destructive, handler: { (UIAlertAction) -> Void in
                self.loginClick(self.loginButton)
            })
            let action2 = UIAlertAction(title: "取消", style: .Cancel, handler: { (UIAlertAction) -> Void in
            })
            avc.addAction(action)
            avc.addAction(action2)
            self.presentViewController(avc, animated: true, completion: { () -> Void in
                
            })
        }
        else if indexPath.section == 0{
            if indexPath.row <= 1{
                let userId = NSUserDefaults.standardUserDefaults().objectForKey("userId")
                if userId == nil{
                    self.loginClick(self.loginButton)
                }
                else{
                    self.performSegueWithIdentifier("ThreadsIdentifier", sender: indexPath.row)
                }
            }
            
        }
    }
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
        if segue.identifier == "ThreadsIdentifier"{
            let vc = segue.destinationViewController as! ThreadsTableViewController
            vc.type = sender as! Int
        }
    }


}
