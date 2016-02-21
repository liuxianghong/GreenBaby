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
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var addressLabel : UILabel!
    @IBOutlet weak var scoreView : HomeScoreView!
    @IBOutlet weak var scoreDistanceView : HomeSmallScoreView!
    @IBOutlet weak var scorePostureView : HomeSmallScoreView!
    @IBOutlet weak var scoreTimeView : HomeSmallScoreView!
    @IBOutlet weak var threeScoreBackView : UIView!
    @IBOutlet weak var scoreViewConstraint : NSLayoutConstraint!
    @IBOutlet weak var scoreViewTopConstraint : NSLayoutConstraint!
    @IBOutlet weak var threeScoreViewWidthConstraint : NSLayoutConstraint!
    @IBOutlet weak var threeScoreBackViewHeightConstraint : NSLayoutConstraint!
    @IBOutlet weak var rankLabel : UILabel!
    @IBOutlet weak var rankTotalLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.backView.backgroundColor = UIColor.mainGreenColor()
        
        addDeviceButton.hidden = false
        scoreView.hidden = true
        threeScoreBackView.hidden = true
        
        scoreDistanceView.maxScore = 60
        scorePostureView.maxScore = 30
        scoreTimeView.maxScore = 10
        scoreView.score = 0
        scoreDistanceView.score = 0
        scorePostureView.score = 0
        scoreTimeView.score = 0
        
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
        if let str = UserInfo.CurrentUser().headImage{
            let url = NSURL(string: str.toResourceSeeURL())
            headImageView.sd_setImageWithURL(url, placeholderImage: nil)
        }
        nameLabel.text = UserInfo.CurrentUser().userName
        addressLabel.text = UserInfo.CurrentUser().city
        self.loadScore()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func shareClicked(sender: UIButton) {
        self.tabBarController?.performSegueWithIdentifier("shareIdentifier", sender: UIImage.imageWith(self.backView))
    }
    
    @IBAction func addClick(sender : AnyObject){
        if UserInfo.CurrentUser().userId == nil{
            self.tabBarController?.performSegueWithIdentifier("loginIdentifier", sender: nil)
        }
        else{
            if let mobile = UserInfo.CurrentUser().mobile{
                if !mobile.isEmpty{
                    self.performSegueWithIdentifier("addDeviceIdentifier", sender: nil)
                    return
                }
            }
            self.tabBarController?.performSegueWithIdentifier("bindPoneIndentifier", sender: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scoreHide(bo : Bool){
        addDeviceButton.hidden = !bo
        scoreView.hidden = bo
        threeScoreBackView.hidden = bo
    }
    
    func loadScore() {
        if let userid = UserInfo.CurrentUser().userId{
            let dic = ["userId" : userid]
            DeviceRequest.GetHomePageScoreWithParameters(dic, success: { (object) -> Void in
                print(object)
                let state = object["state"] as! Int
                if state == 0{
                    if let data = object["data"] as? [String : AnyObject]{
                        self.scoreHide(false)
                        self.scoreView.score = data["totalScore"] as! Float
                        self.scoreDistanceView.score = data["distanceScore"] as! Float
                        self.scorePostureView.score = data["postureScore"] as! Float
                        self.scoreTimeView.score = data["timeScore"] as! Float
                        
                        if let rank = data["rank"] as? Int{
                            let rankString = NSMutableAttributedString(string: "当前排名")
                            rankString.appendAttributedString(NSAttributedString(string: "\(rank)", attributes: [NSFontAttributeName : UIFont.systemFontOfSize(14)]))
                            self.rankLabel.attributedText = rankString
                            if let count = data["count"] as? Int{
                                let countString = NSMutableAttributedString(string: "您已经击败")
                                countString.appendAttributedString(NSAttributedString(string: "\(rank*100/count)%", attributes: [NSFontAttributeName : UIFont.systemFontOfSize(14),NSForegroundColorAttributeName : UIColor.rgbColor(0xfff000)]))
                                countString.appendAttributedString(NSAttributedString(string: "的人，继续加油哦～"))
                                self.rankTotalLabel.attributedText = countString
                            }
                        }
                        
                    }
                }
                }) { (error : NSError!) -> Void in
                    
            }
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
