//
//  CaptureViewController.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/28.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class CaptureViewController: UIViewController {

    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var rflushButton : UIButton!
    @IBOutlet weak var timeLabel : UILabel!
    var hud : MBProgressHUD!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        reflushClick(rflushButton)
    }
    
    func loadData(){
        let dic = ["userId" : UserInfo.CurrentUser().userId!]
        DeviceRequest.RemoteCaptureWithParameters(dic, success: { (object) -> Void in
            print(object)
            let state = object["state"] as? Int
            if state == 0{
                if let dic = object["data"] as? [String : AnyObject]{
                    if let imageUrl = dic["imageUrl"] as? String{
                        self.imageView.sd_setImageWithURL(NSURL(string: imageUrl.toResourceSeeURL()), completed: { (image : UIImage!, error : NSError!, type : SDImageCacheType, url : NSURL!) -> Void in
                            let time = dic["createTime"] as! NSTimeInterval
                            let timeDate = NSDate(timeIntervalSince1970: time/1000)
                            let format = NSDateFormatter()
                            format.dateFormat = "yyyy-MM-dd | hh:mm"
                            self.timeLabel.text = format.stringFromDate(timeDate)
                            self.hud.hide(true)
                            self.hud = nil
                        })
                        return
                    }
                }
            }
            self.hud.hide(true)
            self.hud = nil
            }) { (error : NSError!) -> Void in
                self.hud.mode = .Text
                self.hud.detailsLabelText = error.domain
                self.hud.hide(true, afterDelay: 1.5)
                self.hud = nil
                
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func reflushClick(sender : UIButton){
        if hud != nil{
            return
        }
        hud = MBProgressHUD.showHUDAddedTo(imageView, animated: true)
        hud.dimBackground = true
        hud.color = UIColor.clearColor()
        self.loadData()
    }
    
    @IBAction func imageSeeClick(sender : AnyObject){
        self.performSegueWithIdentifier("imageSee", sender: self.imageView.image)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "imageSee"{
            let vc = segue.destinationViewController as! ImageSeeViewController
            vc.image = sender as! UIImage
        }
    }


}
