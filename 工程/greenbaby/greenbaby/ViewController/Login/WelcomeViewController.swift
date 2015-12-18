//
//  WelcomeViewController.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/3.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit


class WXLoginModel{
    var userName : String! = ""
    var iconURL : String! = ""
}

class WelcomeViewController: UIViewController ,UMSocialUIDelegate{

    @IBOutlet weak var wxinButton : UIButton!
    
    var wxLoginModel = WXLoginModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.mainGreenColor()
        wxinButton.backgroundColor = UIColor.mainGreenColor()
        wxinButton.layer.borderColor = UIColor.whiteColor().CGColor
        wxinButton.layer.borderWidth = 1.0
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func missClicked(sender: UIButton) {
        self.dismissViewControllerAnimated(true) { () -> Void in
        }
    }
    
    @IBAction func wxinClicked(sender: UIButton) {
        
        
        let snsPlatform = UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToWechatSession)
        snsPlatform.needLogin = true
        UMSocialControllerService.defaultControllerService().socialUIDelegate = self
        UMHelp.loginUMSocialSnsPlatform(snsPlatform, vc: self, server: UMSocialControllerService.defaultControllerService(), isPresent: true) { (response :UMSocialResponseEntity! ) -> Void in
        
            if (response.responseCode == UMSResponseCodeSuccess) {
                
                let snsAccountDictionary = UMSocialAccountManager.socialAccountDictionary() as NSDictionary
                let snsAccount = snsAccountDictionary.valueForKey(UMShareToWechatSession)
                
                NSLog("username is %@, uid is %@, token is %@ url is %@",snsAccount!.userName,snsAccount!.usid,snsAccount!.accessToken,snsAccount!.iconURL);
                
               self.wxLoginModel.userName = snsAccount!.userName
                self.wxLoginModel.iconURL = snsAccount!.iconURL
                
                let hud = MBProgressHUD.showHUDAddedTo(self.view.window, animated: true)
                let dic = ["type": 0,"wxId": (snsAccount?.openId)! as String]
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
                        let binded = dicdata["binded"] as! Int
                        NSUserDefaults.standardUserDefaults().setObject(dicdata["headImage"], forKey: "headImage")
                        NSUserDefaults.standardUserDefaults().setObject(userId, forKey: "userId")
                        NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "userName")
                        NSUserDefaults.standardUserDefaults().setObject(gold, forKey: "gold")
                        NSUserDefaults.standardUserDefaults().synchronize()
                        if binded == 0{
                            self.performSegueWithIdentifier("wxinIdentifier", sender: 2)
                        }
                        else{
                            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                            })
                        }
                        hud.hide(true)
                    }else if state == 4{
                        self.performSegueWithIdentifier("wxinIdentifier", sender: 3)
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
        
        
        //self.performSegueWithIdentifier("wxinIdentifier", sender: 1)
    }
    
    func didFinishGetUMSocialDataInViewController(response: UMSocialResponseEntity!) {
        NSLog("SnsInformation is %@",response.data);
    }
    
    @IBAction func phoneClicked(sender: UIButton) {
        self.performSegueWithIdentifier("wxinIdentifier", sender: 1)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "wxinIdentifier"{
            let vc:LoginViewController = segue.destinationViewController as! LoginViewController
            vc.type = sender as! Int
            vc.wxLoginModel = self.wxLoginModel
        }
    }


}
