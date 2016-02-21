//
//  ChangeNameViewController.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/18.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class ChangeNameViewController: UIViewController {

    @IBOutlet weak var nameField : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.nameField.text = UserInfo.CurrentUser()?.userName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func saveClick(){
        
        let hud = MBProgressHUD.showHUDAddedTo(self.view.window, animated: true)
        
        if self.nameField.text!.isEmpty {
            hud.mode = .Text
            hud.detailsLabelText = "请输入昵称"
            hud.hide(true, afterDelay: 1.5)
            return
        }
        
        let userId = UserInfo.CurrentUser()?.userId
        let dic :NSDictionary = ["userId": userId!,"nickName": nameField.text!]
        LoginRequest.UpdateEndUserWithParameters(dic, success: { (object) -> Void in
            let dic:NSDictionary = object as! NSDictionary
            let state:Int = dic["state"] as! Int
            if state == 0{
                hud.mode = .Text
                hud.detailsLabelText = "修改成功"
                hud.hide(true, afterDelay: 1.5)
                self.navigationController?.popViewControllerAnimated(true)
                UserInfo.CurrentUser().userName = self.nameField.text
                NSUserDefaults.standardUserDefaults().synchronize()
            }else{
                hud.mode = .Text
                hud.detailsLabelText = dic["description"] as! String
                hud.hide(true, afterDelay: 1.5)
            }
            }) { (error:NSError!) -> Void in
                hud.mode = .Text
                hud.detailsLabelText = error.domain
                hud.hide(true, afterDelay: 1.5)
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
