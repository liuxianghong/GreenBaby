//
//  CompleteValueTableViewController.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/3.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class CompleteValueTableViewController: UITableViewController {

    var type = 0
    let tableViewArray : NSArray = [["视力信息",["当前视力（度）","全部视力"]],["用眼时间",["当前用眼时间（小时）","全部时间"]],["年龄",["当前年龄（岁）","全部年龄"]],["省份",["当前省份","全部省份"]],["城市",["当前城市","全部城市"]]]
    var pid : String = ""
    var tableViewDataArray : NSArray!
    var completeMaterialModel : CompleteMaterialModel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let arry = tableViewArray[type] as! NSArray
        self.title = arry[0] as? String
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        LoginRequest.GetConfigWithParameters(pid, type: type, success: { (object) -> Void in
            let dic:NSDictionary = object as! NSDictionary
            let state:Int = dic["state"] as! Int
            if state == 0{
                let dicdata:NSArray = dic["data"] as! NSArray
                self.tableViewDataArray = dicdata
                hud.hide(true)
                self.tableView.reloadData()
            }else{
                hud.mode = .Text
                hud.detailsLabelText = dic["description"] as! String
                hud.hide(true, afterDelay: 1.5)
            }
            }) { (error:NSError!) -> Void in
                hud.mode = .Text
                hud.detailsLabelText = error.domain
                hud.hide(true, afterDelay: 1.5)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        let arry = tableViewArray[type] as! NSArray
        let arry2 = arry[1]  as! NSArray
        return arry2.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0
        {
            return 1
        }
        if tableViewDataArray == nil{
            return 0
        }
        return tableViewDataArray.count
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let arry = tableViewArray[type] as! NSArray
        let arry2 = arry[1]  as! NSArray
        return arry2[section] as? String
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("valueIdentifier", forIndexPath: indexPath)

        // Configure the cell...
        if indexPath.section == 0{
            cell.textLabel?.text = self.completeMaterialModel.value
        }
        else{
            let dic : NSDictionary = self.tableViewDataArray[indexPath.row] as! NSDictionary
            
            cell.textLabel?.text = dic["value"] as? String
        }
        

        return cell
    }


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 0{
            self.navigationController?.popViewControllerAnimated(true)
        }
        else{
            let dic : NSDictionary = self.tableViewDataArray[indexPath.row] as! NSDictionary
            completeMaterialModel.value = dic["value"] as? String
            completeMaterialModel.id = String(dic["id"] as! Int)
            self.navigationController?.popViewControllerAnimated(true)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
