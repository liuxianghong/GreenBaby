//
//  MainViewController.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/3.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    var first : Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()

        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        UIGraphicsBeginImageContext(CGSizeMake(1, 1));
        let context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context,UIColor.mainGreenColor().CGColor);
        CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
        let img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        UINavigationBar.appearance().setBackgroundImage(img, forBarPosition: .Any, barMetrics: .Default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().translucent = false
        UINavigationBar.appearance().backItem?.title = "返回"
        self.tabBar.tintColor = UIColor.mainGreenColor()
        for item in self.tabBar.items!{
            item.setTitleTextAttributes( [NSForegroundColorAttributeName : UIColor.mainGreenColor()] , forState: .Selected)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if first{
            self.performSegueWithIdentifier("loginIdentifier", sender: nil)
            first = false
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
