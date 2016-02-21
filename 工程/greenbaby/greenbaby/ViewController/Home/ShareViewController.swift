//
//  ShareViewController.swift
//  greenbaby
//
//  Created by 刘向宏 on 16/2/17.
//  Copyright © 2016年 刘向宏. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {
    var shareImage : UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func frindsClick(sender : AnyObject){
        shareImage([UMShareToWechatSession])
    }
    
    @IBAction func pengyouquanClick(sender : AnyObject){
        shareImage([UMShareToWechatTimeline])
    }
    
    @IBAction func taptouch(sender : AnyObject){
        self.dismissViewControllerAnimated(false, completion: nil)
    }

    func shareImage(platformTypes : [String]){
        UMHelp.postSNSWithTypes(platformTypes, content: "123", image: shareImage!, presentedController: self) { (response : UMSocialResponseEntity!) -> Void in
            print(response.responseCode)
            if (response.responseCode == UMSResponseCodeSuccess) {
                NSLog("分享成功！");
            }
            else{
            }
            self.dismissViewControllerAnimated(false, completion: nil)
        }
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
