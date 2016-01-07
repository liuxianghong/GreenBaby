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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func reflushClick(sender : UIButton){
        let hud = MBProgressHUD.showHUDAddedTo(imageView, animated: true)
        hud.dimBackground = true
        hud.hide(true, afterDelay: 1.5)
        hud.color = UIColor.clearColor()
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
