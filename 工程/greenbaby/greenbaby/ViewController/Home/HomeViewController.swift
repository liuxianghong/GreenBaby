//
//  HomeViewController.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/3.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var addDeviceButton : UIButton!
    @IBOutlet weak var backView : UIView!
    @IBOutlet weak var headImageView : UIImageView!
    @IBOutlet weak var scoreView : HomeScoreView!
    @IBOutlet weak var scoreDistanceView : HomeSmallScoreView!
    @IBOutlet weak var scorePostureView : HomeSmallScoreView!
    @IBOutlet weak var scoreTimeView : HomeSmallScoreView!
    @IBOutlet weak var threeScoreBackView : UIView!
    @IBOutlet weak var scoreViewConstraint : NSLayoutConstraint!
    @IBOutlet weak var scoreViewTopConstraint : NSLayoutConstraint!
    @IBOutlet weak var threeScoreViewWidthConstraint : NSLayoutConstraint!
    @IBOutlet weak var threeScoreBackViewHeightConstraint : NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.backView.backgroundColor = UIColor.mainGreenColor()
        
        addDeviceButton.hidden = true
        
        headImageView.layer.cornerRadius = 45.0/2;
        headImageView.layer.masksToBounds = true;
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.view.updateConstraints()
        var threeScoreViewWidth = UIImage(named: "img_bj_home_s_0")!.size.width
        scoreViewConstraint.constant = UIImage(named: "img_bj_home_0")!.size.width
        var threeScoreNeedMoveHeight = scoreViewConstraint.constant/8
        if self.view.frame.size.width<350{
            self.scoreView.clipsToBounds = false
            let scale : CGFloat = self.view.frame.size.height > 500 ? 0.8 : 0.7
            self.scoreView.transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale)
            threeScoreBackViewHeightConstraint.constant = threeScoreBackViewHeightConstraint.constant - scoreViewConstraint.constant*(1-scale)
            threeScoreNeedMoveHeight = threeScoreNeedMoveHeight*(1-scale)
            scoreViewTopConstraint.constant = scoreViewTopConstraint.constant - scoreViewConstraint.constant*(1-scale)/2
            threeScoreViewWidth = threeScoreViewWidth*scale
        }
        else
        {
            scoreViewTopConstraint.constant = scoreViewTopConstraint.constant + 5
            threeScoreBackViewHeightConstraint.constant = threeScoreBackViewHeightConstraint.constant - threeScoreNeedMoveHeight
        }
        threeScoreViewWidthConstraint.constant = threeScoreViewWidth
        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        scoreView.score = 35
        scoreDistanceView.score = 35
        scorePostureView.score = 35
        scoreTimeView.score = 35
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func shareClicked(sender: UIButton) {
//        scoreView.score = scoreView.score + 10
//        scoreDistanceView.score = scoreDistanceView.score + 10
//        scorePostureView.score = scorePostureView.score + 10
//        scoreTimeView.score = scoreTimeView.score + 10
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
