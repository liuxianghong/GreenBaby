//
//  ChangeSexViewController.swift
//  greenbaby
//
//  Created by 刘向宏 on 16/4/4.
//  Copyright © 2016年 刘向宏. All rights reserved.
//

import UIKit

class ChangeSexViewController: UIViewController {

    @IBOutlet var manButton : UIButton!
    @IBOutlet var womanButton : UIButton!
    var sex = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        manButton.layer.borderWidth = 1.0
        manButton.layer.borderColor = UIColor.mainGreenColor().CGColor
        womanButton.layer.borderWidth = 1.0
        womanButton.layer.borderColor = UIColor.mainGreenColor().CGColor
        
        if UserInfo.CurrentUser().sex == 0{
            manClicked(manButton)
        }
        else{
            womanClicked(womanButton)
            sex = "1"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func manClicked(sender: UIButton) {
        sex = "0"
        manButton.selected = true
        womanButton.selected = false
    }
    
    @IBAction func womanClicked(sender: UIButton) {
        sex = "1"
        manButton.selected = false
        womanButton.selected = true
    }
    
    
    @IBAction func saveClick(){
        
        let hud = MBProgressHUD.showHUDAddedTo(self.view.window, animated: true)
        
        let userId = UserInfo.CurrentUser()?.userId
        let dic :NSDictionary = ["userId": userId!,"sex": sex]
        LoginRequest.UpdateEndUserWithParameters(dic, success: { (object) -> Void in
            let dic:NSDictionary = object as! NSDictionary
            let state:Int = dic["state"] as! Int
            if state == 0{
                hud.mode = .Text
                hud.detailsLabelText = "修改成功"
                hud.hide(true, afterDelay: 1.5)
                self.navigationController?.popViewControllerAnimated(true)
                UserInfo.CurrentUser().sex = Int(self.sex)
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
