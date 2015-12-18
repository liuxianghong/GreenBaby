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
    var wxLoginModel = WXLoginModel()
    
    var countDownTimer : NSTimer!
    var code : String!
    var timeCount : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = type != 1 ? "绑定手机号" : "登录"
        if type == 1{
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
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        if countDownTimer != nil {
            countDownTimer.invalidate()
            countDownTimer = nil;
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        let recordTime = NSUserDefaults.standardUserDefaults().objectForKey("LastTimeGetCapthaTime") as? Int
        if recordTime != nil
        {
            let nowTime = NSDate().timeIntervalSince1970
            let interval = Int(nowTime) - recordTime!
            if interval >= 60{
                self.codeButton.enabled = true
            }
            else{
                self.codeButton.enabled = false
                self.codeButton.titleLabel?.font = UIFont.systemFontOfSize(11)
                timeCount = 60 - interval
                self.codeButton.setTitle("\(timeCount)秒后重发", forState: .Disabled)
                
                countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "countDown", userInfo: nil, repeats: true)
            }
        }
    }
    
    func countDown(){
        timeCount--
        if timeCount > 0{
            self.codeButton.setTitle("\(timeCount)秒后重发", forState: .Disabled)
        }
        else{
            self.codeButton.enabled = true
            self.codeButton.titleLabel?.font = UIFont.systemFontOfSize(14)
            self.codeButton.setTitle("获取验证码", forState: .Normal)
            countDownTimer.invalidate()
            countDownTimer = nil;
        }
    }
    
    @IBAction func jumpOutClicked(sender: AnyObject) {
        self.performSegueWithIdentifier("moreInformationIdentifier", sender: nil)
//        if type == 3{
//            self.performSegueWithIdentifier("moreInformationIdentifier", sender: nil)
//        }
//        else{
//            self.dismissViewControllerAnimated(true, completion: { () -> Void in
//            })
//        }
    }
    
    @IBAction func codeClicked(sender: AnyObject) {
        let hud = MBProgressHUD.showHUDAddedTo(self.view.window, animated: true)
        if !self.phoneNumberTextField.text!.checkTel() {
            hud.mode = .Text
            hud.detailsLabelText = "请输入正确的手机号码"
            hud.hide(true, afterDelay: 1.5)
            return
        }
        let dic = ["mobile": self.phoneNumberTextField.text!]
        print(dic)
        self.codeButton.setTitle("发送中", forState: .Normal)
        LoginRequest.GetAuthCodeWithParameters(dic, type: 0, success: { (object) -> Void in
            print(object)
            let dic:NSDictionary = object as! NSDictionary
            let state:Int = dic["state"] as! Int
            if state == 0{
                
                let nowTime = Int(NSDate().timeIntervalSince1970)
                NSUserDefaults.standardUserDefaults().setObject(nowTime, forKey: "LastTimeGetCapthaTime")
                NSUserDefaults.standardUserDefaults().synchronize()
                
                self.timeCount = 60;
                self.codeButton.enabled = false
                self.codeButton.titleLabel?.font = UIFont.systemFontOfSize(11)
                self.codeButton.setTitle("\(self.timeCount)秒后重发", forState: .Disabled)
                
                self.countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "countDown", userInfo: nil, repeats: true)
                hud.hide(true)
            }else{
                hud.mode = .Text
                hud.detailsLabelText = dic["description"] as! String
                hud.hide(true, afterDelay: 1.5)
            }
            
            
            }, failure: { (error : NSError!) -> Void in
                hud.mode = .Text
                hud.detailsLabelText = error.domain
                self.codeButton.setTitle("获取验证码", forState: .Normal)
                hud.hide(true, afterDelay: 1.5)
        })
    }
    
    @IBAction func nextClicked(sender: AnyObject) {
        if type != 1{
            let hud = MBProgressHUD.showHUDAddedTo(self.view.window, animated: true)
            if !self.phoneNumberTextField.text!.checkTel() {
                hud.mode = .Text
                hud.detailsLabelText = "请输入正确的手机号码"
                hud.hide(true, afterDelay: 1.5)
                return
            }
            
            if self.codeTextField.text!.isEmpty {
                hud.mode = .Text
                hud.detailsLabelText = "请输入验证码"
                hud.hide(true, afterDelay: 1.5)
                return
            }
            let userId = NSUserDefaults.standardUserDefaults().objectForKey("userId")
            let dic :NSDictionary = ["mobile": self.phoneNumberTextField.text!,"vCode" : self.codeTextField.text!,"userId" : userId!]
            print(dic)
            LoginRequest.BindmobileWithParameters(dic, success: { (object) -> Void in
                print(object)
                let dic:NSDictionary = object as! NSDictionary
                let state:Int = dic["state"] as! Int
                if state == 0{
                    self.performSegueWithIdentifier("moreInformationIdentifier", sender: nil)
//                    if self.type == 2{
//                        self.dismissViewControllerAnimated(true, completion: { () -> Void in
//                        })
//                    }
//                    else{
//                        self.performSegueWithIdentifier("moreInformationIdentifier", sender: nil)
//                    }
                }
                }, failure: { (error : NSError!) -> Void in
                    hud.mode = .Text
                    hud.detailsLabelText = error.domain
                    hud.hide(true, afterDelay: 1.5)
            })
            
            
        }
        else {
            let hud = MBProgressHUD.showHUDAddedTo(self.view.window, animated: true)
            let dic = ["type": 0,"mobile": self.phoneNumberTextField.text!,"vCode" : self.codeTextField.text!]
            print(dic)
            LoginRequest.UserLoginWithParameters(dic, success: { (object : AnyObject!) -> Void in
                print(object)
                let dic:NSDictionary = object as! NSDictionary
                let state:Int = dic["state"] as! Int
                if state == 0{
                    let dicdata:NSDictionary = dic["data"] as! NSDictionary
                    let userId = String(dicdata["userId"] as! Int)
                    let userName = dicdata["userName"] as! String
                    let gold = dicdata["gold"] as! Int
                    NSUserDefaults.standardUserDefaults().setObject(userId, forKey: "userId")
                    NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "userName")
                    NSUserDefaults.standardUserDefaults().setObject(gold, forKey: "gold")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    self.dismissViewControllerAnimated(true, completion: { () -> Void in
                    })
                    hud.hide(true)
                }
                else{
                    hud.mode = .Text
                    hud.detailsLabelText = dic["description"] as! String
                    hud.hide(true, afterDelay: 1.5)
                }
                
                }) { (error : NSError!) -> Void in
                    print(error)
                    hud.mode = .Text
                    hud.detailsLabelText = error.domain
                    hud.hide(true, afterDelay: 1.5)
            }
        }
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "moreInformationIdentifier"{
            let vc = segue.destinationViewController as! CompleteMaterialTableViewController
            vc.wxLoginModel = self.wxLoginModel
        }
    }
    

}
