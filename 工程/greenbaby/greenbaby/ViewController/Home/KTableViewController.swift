//
//  KTableViewController.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/28.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class KTableViewController: UITableViewController {

    @IBOutlet weak var headView : UIView!
    @IBOutlet weak var typeTimeButton : UIButton!
    @IBOutlet weak var timeDayButton : UIButton!
    weak var typeButton : UIButton!
    var dataType = 1
    weak var timeButton : UIButton!
    var timeType = 1
    var dataDic = [Int : KChartViewModel]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        var height:CGFloat = 120.0
        if self.view.frame.size.width<350{
            height = height * 0.8
            self.headView.clipsToBounds = false
            self.headView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 0.8)
        }
        
        var frame = self.tableView.tableHeaderView?.frame
        frame?.size.height = height
        self.tableView.tableHeaderView?.frame = frame!
        frame?.size.height = 176
        self.tableView.tableFooterView?.frame = frame!
        
        typeClick(typeTimeButton)
        timeClick(timeDayButton)
        
        /*"userId": 用户ID,
        "dataType": 数据类型, 1:用眼距离 2:用眼时间 3:姿势
        "timeType": 时间类型 1:日 2:周 3:月 4:年
        */
        loadData(1, ttype: 1)
        
    }
    
    
    func loadData(dtype : Int , ttype : Int){
        if self.dataDic[dtype * 10 + ttype] != nil{
            return
        }
        let dic = ["userId" : UserInfo.CurrentUser().userId! , "dataType" : dataType,"timeType" : timeType]
        DeviceRequest.GetCandlestickChartsWithParameters(dic, success: { (object) -> Void in
            print(object)
            let state = object["state"] as? Int
            if state == 0{
                if let array = object["data"] as? [[String : AnyObject]]{
                    self.dataDic[dtype * 10 + ttype] = KChartViewModel(type: dtype, time: ttype, dic: array)
                }
            }
            self.tableView.reloadData()
            }) { (error : NSError!) -> Void in
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func typeClick(sender : UIButton){
        if typeButton != nil{
            typeButton.selected = false
        }
        typeButton = sender
        typeButton.selected = true
        dataType = typeButton.tag
        loadData(dataType ,ttype: timeType)
        self.tableView.reloadData()
    }
    
    @IBAction func timeClick(sender : UIButton){
        if timeButton != nil{
            timeButton.selected = false
        }
        timeButton = sender
        timeButton.selected = true
        timeType = timeButton.tag
        loadData(dataType ,ttype: timeType)
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 1{
            return 1
        }
        if dataType == 3{
            return 3
        }
        else{
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 1{
            return 25
        }
        return 170
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 1{
            let cell = tableView.dequeueReusableCellWithIdentifier("KBottomIndentifier", forIndexPath: indexPath)
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("KChartIndentifier", forIndexPath: indexPath) as! KChartTableViewCell

        // Configure the cell...
        if let model = self.dataDic[self.dataType * 10 + self.timeType]{
            cell.chartView.viewModel = KChartViewModel(type: model.chartType, time: model.timeType, dic: model.dataDicArray)
            cell.chartView.viewModel.subType = indexPath.row + 1
            print(indexPath.row + 1)
            cell.chartView.setNeedsDisplay()
        }
        else{
            cell.chartView.viewModel = KChartViewModel(type: dataType, time: timeType, dic: nil)
            cell.chartView.viewModel.subType = indexPath.row + 1
            print(indexPath.row + 1)
            cell.chartView.setNeedsDisplay()
        }
        
        var valueKey = "   "
        if dataType == 3{
            if indexPath.row == 0{
                valueKey = "俯仰（0 ~ 90）"
            }
            else if indexPath.row == 1{
                valueKey = "摇摆（0 ~ 90）"
            }
            else if indexPath.row == 2{
                valueKey = "倾斜（0 ~ 90）"
            }
        }
        cell.nameLabel.text = valueKey

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
