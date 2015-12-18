//
//  UserSeeTableViewController.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/18.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class UserSeeTableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var headImageView : UIImageView!
    @IBOutlet weak var sexLabel : UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.tableFooterView = UIView()
        
        if NSUserDefaults.standardUserDefaults().objectForKey("headImage") != nil{
            headImageView.layer.cornerRadius = 55/2;
            headImageView.layer.masksToBounds = true;
            headImageView.sd_setImageWithURL(NSURL(string: (NSUserDefaults.standardUserDefaults().objectForKey("headImage") as! String).toResourceSeeURL()))
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.nameLabel.text = NSUserDefaults.standardUserDefaults().objectForKey("userName") as? String
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 0 && indexPath.row == 0{
            let actionVC = UIAlertController(title: "", message: "修改头像", preferredStyle: .ActionSheet)
            let actionNew = UIAlertAction(title: "拍照", style: .Default, handler: { (UIAlertAction) -> Void in
                if UIImagePickerController.isSourceTypeAvailable(.Camera){
                    self.showImagePickVC(.Camera)
                }
            })
            let actionAdd = UIAlertAction(title: "相册", style: .Default, handler: { (UIAlertAction) -> Void in
                if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary){
                    self.showImagePickVC(.PhotoLibrary)
                }
            })
            let actionCancel = UIAlertAction(title: "取消", style: .Cancel, handler: { (UIAlertAction) -> Void in
            })
            actionVC.addAction(actionNew)
            actionVC.addAction(actionAdd)
            actionVC.addAction(actionCancel)
            self.presentViewController(actionVC, animated: true, completion: { () -> Void in
            })
        }
    }
    
    func showImagePickVC(sourceType: UIImagePickerControllerSourceType){
        let imagePickerController:UIImagePickerController = UIImagePickerController()
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = true;
        imagePickerController.sourceType = sourceType;
        self.presentViewController(imagePickerController, animated: true) { () -> Void in
            
        }
    }
    
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        picker.dismissViewControllerAnimated(true) { () -> Void in
            let hud = MBProgressHUD.showHUDAddedTo(self.view.window, animated: true)
            hud.labelText = "正在上传"
            let image:UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
            [FileRequest .UploadImage(image, success: { (object) -> Void in
                print(object)
                let dic:NSDictionary = object as! NSDictionary
                let state:Int = dic["state"] as! Int
                if state == 0{
                    let dicdata:NSDictionary = dic["data"] as! NSDictionary
                    let imageName = dicdata["name"] as! String
                    
                    let userId = NSUserDefaults.standardUserDefaults().objectForKey("userId")!
                    let dic :NSDictionary = ["userId": userId,"headImage": imageName]
                    LoginRequest.UpdateEndUserWithParameters(dic, success: { (object) -> Void in
                        let dic:NSDictionary = object as! NSDictionary
                        let state:Int = dic["state"] as! Int
                        if state == 0{
                            hud.mode = .Text
                            hud.labelText = "修改成功"
                            hud.hide(true, afterDelay: 1.5)
                            self.headImageView.image = image
                            NSUserDefaults.standardUserDefaults().setObject(imageName, forKey: "headImage")
                            NSUserDefaults.standardUserDefaults().synchronize()
                        }else{
                            hud.mode = .Text
                            hud.labelText = dic["description"] as! String
                            hud.hide(true, afterDelay: 1.5)
                        }
                        }) { (error:NSError!) -> Void in
                            hud.mode = .Text
                            hud.labelText = error.domain
                            hud.hide(true, afterDelay: 1.5)
                    }
                }
                else{
                    hud.labelText = "上传失败";
                }
                hud.mode = .Text
                hud.hide(true, afterDelay: 1.5)
                }, failure: { (NSError error) -> Void in
                    print(error)
                    hud.mode = .Text
                    hud.labelText = error.domain;
                    hud.hide(true, afterDelay: 1.5)
            })]
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
