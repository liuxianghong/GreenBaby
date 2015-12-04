//
//  LoginViewController.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/3.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var phoneNumberTextField : UITextField!
    @IBOutlet weak var codeTextField : UITextField!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var codeButton : UIButton!
    @IBOutlet weak var nextButton : UIButton!
    var type : Int = 1
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = type == 1 ? "绑定手机号" : "登录"
        if type == 2{
            self.navigationItem.rightBarButtonItem = nil
            titleLabel.text = "手机号码"
            nextButton.setTitle("登录", forState: .Normal)
        }
        self.navigationItem.backBarButtonItem = UIBarButtonItem();
        self.navigationItem.backBarButtonItem?.title = "返回"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func jumpOutClicked(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { () -> Void in
        }
    }
    
    @IBAction func nextClicked(sender: AnyObject) {
        if type == 1{
            self.performSegueWithIdentifier("moreInformationIdentifier", sender: nil)
        }
        else {
            self.dismissViewControllerAnimated(true) { () -> Void in
            }
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        segue.destinationViewController.navigationItem.backBarButtonItem?.title = "返回"
    }
    

}
