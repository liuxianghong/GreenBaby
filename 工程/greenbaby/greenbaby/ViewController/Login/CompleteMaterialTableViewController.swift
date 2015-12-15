//
//  CompleteMaterialTableViewController.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/3.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class CompleteMaterialModel{
    var id : String!
    var value : String!
    init(){
        id = ""
        value = ""
    }
}

class CompleteMaterialTableViewController: UITableViewController {
    var wxLoginModel = WXLoginModel()
    var tableViewArray : NSArray = [["视力信息",CompleteMaterialModel()],["平均每天读写时间（小时）",CompleteMaterialModel()],["年龄（岁）",CompleteMaterialModel()],["省份",CompleteMaterialModel()],["城市",CompleteMaterialModel()]]
    
    var sex = "0"
    var currentCompleteMaterialModel : CompleteMaterialModel!
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
        self.tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func manClicked(sender: UIButton) {
        sex = "0"
    }
    
    @IBAction func womanClicked(sender: UIButton) {
        sex = "1"
    }
    
    @IBAction func nextClicked(sender: UIButton) {
        
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        let eyesight = (tableViewArray[0][1] as! CompleteMaterialModel).id
        let averageTime = (tableViewArray[1][1] as! CompleteMaterialModel).id
        let age = (tableViewArray[2][1] as! CompleteMaterialModel).id
        let provinceId = (tableViewArray[3][1] as! CompleteMaterialModel).id
        let cityId = (tableViewArray[4][1] as! CompleteMaterialModel).id
        if eyesight.isEmpty{
            hud.mode = .Text
            hud.detailsLabelText = "请选择视力范围"
            hud.hide(true, afterDelay: 1.5)
            return;
        }
        
        if averageTime.isEmpty{
            hud.mode = .Text
            hud.detailsLabelText = "请选择用眼时间范围"
            hud.hide(true, afterDelay: 1.5)
            return;
        }
        
        if age.isEmpty{
            hud.mode = .Text
            hud.detailsLabelText = "请选择年龄范围"
            hud.hide(true, afterDelay: 1.5)
            return;
        }
        
        if provinceId.isEmpty{
            hud.mode = .Text
            hud.detailsLabelText = "请选择省份"
            hud.hide(true, afterDelay: 1.5)
            return;
        }
        
        if cityId.isEmpty{
            hud.mode = .Text
            hud.detailsLabelText = "请选择城市"
            hud.hide(true, afterDelay: 1.5)
            return;
        }
        
        let userId = NSUserDefaults.standardUserDefaults().objectForKey("userId")!
        let dic :NSDictionary = ["userId": userId,"nickName": wxLoginModel.userName,"headImage": wxLoginModel.iconURL, "eyesight":eyesight,"averageTime": averageTime,"age": age,"sex": sex,"provinceId":provinceId,"cityId": cityId]
        LoginRequest.UpdateEndUserWithParameters(dic, success: { (object) -> Void in
            let dic:NSDictionary = object as! NSDictionary
            let state:Int = dic["state"] as! Int
            if state == 0{
                hud.hide(true)
                self.dismissViewControllerAnimated(true) { () -> Void in
                }
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
            let completeMaterialModel = (array[1] as! CompleteMaterialModel)
            cell.valueLabel.text = completeMaterialModel.value
            return cell
        }

    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row != tableViewArray.count{
            if indexPath.row == 4{
                let array : NSArray = tableViewArray[3] as! NSArray
                let model = array[1] as! CompleteMaterialModel
                if model.id.isEmpty{
                    let hud = MBProgressHUD.showHUDAddedTo(self.view.window, animated: true)
                    hud.mode = .Text
                    hud.detailsLabelText = "请先选择省份"
                    hud.hide(true, afterDelay: 1.5)
                    return
                }
            }
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
            let array : NSArray = tableViewArray[vc.type] as! NSArray
            vc.completeMaterialModel = (array[1] as! CompleteMaterialModel)
            
            if vc.type == 4{
                let array : NSArray = tableViewArray[3] as! NSArray
                let model = array[1] as! CompleteMaterialModel
                vc.pid = model.id
            }
        }
    }


}
