//
//  TrainingViewController.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/12.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class TrainingViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var buttonView : UIView!
    
    @IBOutlet weak var sliderBackView : UIView!
    @IBOutlet weak var sliderView : UIView!
    @IBOutlet weak var sliderConstraint : NSLayoutConstraint!
    @IBOutlet weak var beginButton : UIButton!
    
    @IBOutlet weak var scoreLabel : UILabel!
    @IBOutlet weak var tableView : UITableView!
    var ip = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sliderView.layer.cornerRadius = 4;
        sliderView.layer.masksToBounds = true;
        
        if self.view.frame.size.width<350{
            self.buttonView.clipsToBounds = false
            self.buttonView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 0.8)
        }
        
        self.tableView.tableFooterView = UIView()
    }
    
    func loadDeviceIP(){
        let dic = ["userId" : UserInfo.CurrentUser().userId!]
        DeviceRequest.GetDeviceIpWithParameters(dic, success: { (object) -> Void in
            print(object)
            let state = object["state"] as? Int
            if state == 0{
                if let dicData = object["data"] as? [String : AnyObject]{
                    if let ip = dicData["ip"] as? String{
                        self.ip = ip
                    }
                }
            }
            }) { (error : NSError!) -> Void in
                
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        loadDeviceIP()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func beginClick(sender : UIButton){
        beginButton.selected = !beginButton.selected
        if !self.ip.isEmpty{
            let url = "http://\(self.ip):8081"
            imageView.sd_setImageWithURL(NSURL(string: url), completed: { (image : UIImage!, error : NSError!, type : SDImageCacheType, url : NSURL!) -> Void in
                
            })
        }
    }

    @IBAction func stopClick(sender : UIButton){
        beginButton.selected = false
    }
    
    @IBAction func seebackClick(sender : UIButton){
        beginButton.selected = false
    }
    
    
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let height = tableView.frame.size.height/4
        return height<45 ? 45 : height
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TrainingCell", forIndexPath: indexPath) as! TrainingTableViewCell
        
        // Configure the cell...
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
