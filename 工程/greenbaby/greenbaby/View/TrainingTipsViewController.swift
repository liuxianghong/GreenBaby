//
//  TrainingTipsViewController.swift
//  greenbaby
//
//  Created by 刘向宏 on 16/3/17.
//  Copyright © 2016年 刘向宏. All rights reserved.
//

import UIKit

class TrainingTipsViewController: UIViewController {
    @IBOutlet weak var imageView : UIImageView!
    var type = 0
    let cellImage = ["img_juli","img_fuyang","img_yaobai","img_qingxie"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        imageView.image = UIImage(named: cellImage[type])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.dismissViewControllerAnimated(false) { () -> Void in
            
        }
    }
}
