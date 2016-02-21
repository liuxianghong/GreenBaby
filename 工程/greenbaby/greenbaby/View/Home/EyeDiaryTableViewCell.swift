//
//  EyeDiaryTableViewCell.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/28.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class EyeDiaryTableViewCell: UITableViewCell {

    @IBOutlet weak var eyeImageView : UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        eyeImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "imageClick"))
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func imageClick(){
        myViewController()?.performSegueWithIdentifier("imageSee", sender: eyeImageView.image)
    }
    
    @IBAction func shareClicked(sender: UIButton) {
        myViewController()?.tabBarController?.performSegueWithIdentifier("shareIdentifier", sender: UIImage.imageWith(self))
    }
    
    func myViewController() -> UIViewController?{
        var responder = (self as UIResponder).nextResponder()
        while responder != nil{
            if responder!.isKindOfClass(UIViewController.classForCoder()){
                return responder as? UIViewController
            }
            responder = responder!.nextResponder()!
        }
        return nil
    }

}
