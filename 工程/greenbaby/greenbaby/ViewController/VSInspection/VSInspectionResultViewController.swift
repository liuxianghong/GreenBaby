//
//  VSInspectionResultViewController.swift
//  greenbaby
//
//  Created by 刘向宏 on 16/1/5.
//  Copyright © 2016年 刘向宏. All rights reserved.
//

import UIKit

class VSInspectionResultViewController: UIViewController {

    var index = 0
    let resutArray = [0.1,0.12,0.15,0.2,0.25,0.3,0.4,0.5,0.6,0.8,1.0,1.2,1.5,2.0]
    @IBOutlet weak var scoreLabel : UILabel!
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var imageLabel : UILabel!
    @IBOutlet weak var sepLabel : UILabel!
    let typeArray = [["bq_good","视力健康","请继续保持良好用眼习惯，注意眼部保健"],["bq_yiban","轻度近视","请坚持使用绿宝宝机器人，建立标准姿势，科学用眼，努力恢复视力健康"],["bq_no","近视","请坚持使用绿宝宝机器人，建立标准姿势，科学用眼，防止进一步恶化，如眼部有不适情况请及时就医"]]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let score = resutArray[index]
        scoreLabel.text = "\(score)"
        var type = 0
        if score > 1.0{
        }
        else if score < 0.8{
            type = 2
        }
        else{
            type = 1
        }
        imageView.image = UIImage(named: typeArray[type][0])
        imageLabel.text = typeArray[type][1]
        sepLabel.text =  "您的视力为\(score)\n" + typeArray[type][2]
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
