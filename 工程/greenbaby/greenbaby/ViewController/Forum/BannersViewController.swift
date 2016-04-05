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
    var tableViewArray = [Dictionary<String,AnyObject>]()
    let maxIdex = 10
    var page = 1
    var first = true
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.bransView.dataArray = dataArray
        bransView.delegate = self
        
        self.tableView.tableFooterView = UIView()
        
        var frame = self.tableView.tableHeaderView?.frame
        frame?.size.height = 456 / 720 * self.view.frame.size.width
        self.tableView.tableHeaderView?.frame = frame!
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData(){
        let dic = ["currentPage": page,"pageSize": 10]
        BannersRequest.GetBannersPageWithParameters(dic, success: { (object) -> Void in
            print(object)
            let dic:NSDictionary = object as! NSDictionary
            self.bannersState = dic["state"] as! Int
            if self.bannersState == 0{
                if self.page == 1{
                    self.tableViewArray = dic["data"] as! Array<Dictionary<String,AnyObject>>
                }
                else{
                    self.tableViewArray.appendContentsOf(dic["data"] as! Array<Dictionary<String,AnyObject>>)
                }
                if dic["data"]?.count < self.maxIdex{
                    self.tableView.mj_footer.endRefreshingWithNoMoreData()
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
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshing()
        }
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
