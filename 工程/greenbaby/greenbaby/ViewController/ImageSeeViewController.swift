//
//  ImageSeeViewController.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/28.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class ImageSeeViewController: UIViewController {

    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var downLoadButton : UIButton!
    var image : UIImage!
    var imageUrl : String!
    var hud : MBProgressHUD!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if image != nil{
            imageView.image = image
        }
        else if imageUrl != nil{
            imageView.sd_setImageWithURL(NSURL(string: imageUrl))
        }
        else{
            imageView.image = nil
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.dismissViewControllerAnimated(false) { () -> Void in
            
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .Default
    }
    
    @IBAction func downClick(sender : UIButton){
        if imageView.image == nil{
            return;
        }
        hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        UIImageWriteToSavedPhotosAlbum(imageView.image!, self, "image:didFinishSavingWithError:contextInfo:", nil)
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject){
        
        hud.mode = .Text
        if error != nil {
            hud.detailsLabelText = "保存失败，\(error!.localizedDescription)"
        }
        else{
            hud.detailsLabelText = "保存成功"
        }
        hud.hide(true, afterDelay: 1.5)
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
