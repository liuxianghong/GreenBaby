//
//  BannersViewController.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/17.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class BannersViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,BransViewDelegate {

    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var bransView : BransView!
    var dataArray : NSArray!
    var bannersState = 1
    var tableViewArray = NSArray()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.bransView.dataArray = dataArray
        bransView.delegate = self
        
        self.tableView.tableFooterView = UIView()
        
        BannersRequest.GetBannersNoPageWithParameters(nil, success: { (object) -> Void in
            print(object)
            let dic:NSDictionary = object as! NSDictionary
            self.bannersState = dic["state"] as! Int
            if self.bannersState == 0{
                self.tableViewArray = dic["data"] as! NSArray
                self.tableView.reloadData()
            }
            }) { (error : NSError!) -> Void in
                print(error)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - BransViewDelegate
    
    func didClickIndex(index: Int, tag: NSDictionary) {
        self.performSegueWithIdentifier("bannersDetail", sender: tag)
    }

    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableViewArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BannersCellIdentifier", forIndexPath: indexPath) as! BannersTableViewCell
        
        // Configure the cell...
        cell.dataDic = self.tableViewArray[indexPath.row] as! NSDictionary
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.performSegueWithIdentifier("bannersDetail", sender: self.tableViewArray[indexPath.row])
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "bannersDetail"{
            let vc = segue.destinationViewController as! BannersDetailViewController
            vc.dic = sender as! NSDictionary
        }
    }


}
