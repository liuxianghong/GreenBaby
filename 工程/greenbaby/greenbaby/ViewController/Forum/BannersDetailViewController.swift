//
//  BannersDetailViewController.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/17.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class BannersDetailViewController: UIViewController {

    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var titleLabel : UILabel!
    //@IBOutlet weak var constLabel : UILabel!
    @IBOutlet weak var webView : UIWebView!
    var dic : NSDictionary!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webView.backgroundColor = UIColor.whiteColor()
        self.titleLabel.text = dic["title"] as? String
        //self.constLabel.text = ""
        let url = NSURL(string: (dic["thumbnail"] as! String).toResourceSeeURL())
        self.imageView.sd_setImageWithURL(url, placeholderImage: nil)
        let dicBanner : Dictionary<String,AnyObject> = ["id":dic["id"]!]
        BannersRequest.GetBannersDetailWithParameters(dicBanner, success: { (object) -> Void in
            print(object)
            let dic:NSDictionary = object as! NSDictionary
            let state = dic["state"] as! Int
            if state == 0{
                let dataDic = dic["data"] as! NSDictionary
                let content = dataDic["content"] as! String
                self.webView.loadHTMLString(content, baseURL: nil)
                //self.constLabel.text = content
            }
            }) { (error : NSError!) -> Void in
                print(error)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
