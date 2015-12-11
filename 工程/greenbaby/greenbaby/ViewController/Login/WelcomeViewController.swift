//
//  WelcomeViewController.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/3.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController ,UMSocialUIDelegate{

    @IBOutlet weak var wxinButton : UIButton!
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
        
        UMSocialDataService.defaultDataService().requestSnsInformation(UMShareToWechatSession) { (response : UMSocialResponseEntity!) -> Void in
            NSLog("SnsInformation is %@",response.data)
        }
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
                
            }
        }
        
        
            
            
            
        
        //self.performSegueWithIdentifier("wxinIdentifier", sender: 1)
    }
    
    func didFinishGetUMSocialDataInViewController(response: UMSocialResponseEntity!) {
        NSLog("SnsInformation is ")
    }
    
    @IBAction func phoneClicked(sender: UIButton) {
        self.performSegueWithIdentifier("wxinIdentifier", sender: 2)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "wxinIdentifier"{
            let vc:LoginViewController = segue.destinationViewController as! LoginViewController
            vc.type = sender as! Int
        }
    }


}
