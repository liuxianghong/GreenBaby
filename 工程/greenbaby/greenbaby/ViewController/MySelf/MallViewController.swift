//
//  MallViewController.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/18.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class MallViewController: UIViewController {

    @IBOutlet weak var copyButton : UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.copyButton.layer.borderWidth = 1/2.0
        self.copyButton.layer.borderColor = UIColor.rgbColor(0xe53051).CGColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func copyButtonClick(){
        
        let hud = MBProgressHUD.showHUDAddedTo(self.view , animated: true)
        hud.labelText = "复制成功"
        hud.mode = .Text
        hud.hide(true, afterDelay: 1.5)
        let pasteboard = UIPasteboard.generalPasteboard()
        pasteboard.string = "lvbaobaoshangcheng"
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
