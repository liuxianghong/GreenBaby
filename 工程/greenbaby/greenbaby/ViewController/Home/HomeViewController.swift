//
//  HomeViewController.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/3.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var backView : UIView!
    @IBOutlet var headImageView : UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.backView.backgroundColor = UIColor.mainGreenColor()
        
        headImageView.layer.cornerRadius = 45.0/2;
        headImageView.layer.masksToBounds = true;
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func shareClicked(sender: UIButton) {
        
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
