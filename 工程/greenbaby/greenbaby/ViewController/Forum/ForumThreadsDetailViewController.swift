//
//  ForumThreadsDetailViewController.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/17.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class ForumThreadsDetailViewController: UIViewController,UITextViewDelegate ,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource{

    var dic : [String : AnyObject]!
    var goodNumber : Int = 0
    var commentNumber : Int = 0
    var dataDic : NSDictionary! = NSDictionary()
    var commentsArray : NSArray! = NSArray()
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var inputTextView : UIView!
    @IBOutlet weak var inputField : UITextView!
    @IBOutlet weak var constraint : NSLayoutConstraint!
    @IBOutlet weak var inputConstraint : NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.estimatedRowHeight = 220.0;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.tableFooterView = UIView();
        
        inputField.layer.borderWidth = 1/UIScreen.mainScreen().scale
        inputField.layer.borderColor = UIColor.lightGrayColor().CGColor
        inputField.layer.masksToBounds = true
        inputField.layer.cornerRadius = 4;
        
        inputField.text = " "
        inputConstraint.constant = inputField.contentSize.height
        inputField.text = ""
        
        goodNumber = dic["praiseCount"] as! Int
        commentNumber = dic["commentCount"] as! Int
        //当键盘出来的时候通过通知来获取键盘的信息
        //注册为键盘的监听着
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: "keyNotification:", name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData(true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        let center = NSNotificationCenter.defaultCenter()
        center.removeObserver(self, name: UIKeyboardWillChangeFrameNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData(show : Bool){
        var hud : MBProgressHUD! = nil
        if show{
            hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        }
        
        
        let userId = NSUserDefaults.standardUserDefaults().objectForKey("userId")
        let dicP : Dictionary<String,AnyObject> = ["forumId" : self.dic["threadId"]!,"userId" : userId!,"showThread": true,"showComment": true]
        ForumRequest.GetForumThreadsDetailWithParameters(dicP, success: { (object) -> Void in
            print(object)
            let dicd:NSDictionary = object as! NSDictionary
            let state:Int = dicd["state"] as! Int
            if state == 0{
                self.dataDic = dicd["data"] as! NSDictionary
                if self.dataDic["comments"] != nil{
                    self.commentsArray = self.dataDic["comments"] as! NSArray
                    self.tableView.reloadData()
                }
                
                if show{
                    hud.hide(true)
                }
                
            }else{
                if show{
                    hud.mode = .Text
                    hud.detailsLabelText = dicd["description"] as! String
                    hud.hide(true, afterDelay: 1.5)
                }
                
            }
            }) { (error : NSError!) -> Void in
                if show{
                    hud.mode = .Text
                    hud.detailsLabelText = error.domain
                    hud.hide(true, afterDelay: 1.5)
                }
                
        }
    }
    
    @IBAction func goodClick(){
        
        self.upDateGood(true)
    }
    
    @IBAction func upDateGood(bo : Bool){
        
        let userId = NSUserDefaults.standardUserDefaults().objectForKey("userId")
        let dicP : Dictionary<String,AnyObject> = ["forumId" : self.dic["threadId"]!,"userId" : userId!]
        ForumRequest.UpdateForumPraiseWithParameters(dicP, success: { (object) -> Void in
            print(object)
            let dicd:NSDictionary = object as! NSDictionary
            let state:Int = dicd["state"] as! Int
            let data = dicd["data"] as! Int
            if state == 0{
                if data == 0{
                    self.goodNumber++
                }
                else{
                    self.goodNumber--
                }
                self.dic["praiseCount"] = self.goodNumber
                self.tableView.reloadData()
            }else{
            }
            }) { (error : NSError!) -> Void in
        }
    }
    
    @IBAction func sendClick(){
        
        if self.inputField.text!.isEmpty{
            return
        }
        self.inputField.resignFirstResponder()
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        let userId = NSUserDefaults.standardUserDefaults().objectForKey("userId")
        let dicP : Dictionary<String,AnyObject> = ["forumId" : self.dic["threadId"]!,"userId" : userId!,"submit": true,"location": "武汉","comment" : self.inputField.text!]
        ForumRequest.UpdateForumCommentWithParameters(dicP, success: { (object) -> Void in
            print(object)
            let dicd:NSDictionary = object as! NSDictionary
            let state:Int = dicd["state"] as! Int
            if state == 0{
                hud.mode = .Text
                hud.detailsLabelText = "评论成功"
                hud.hide(true, afterDelay: 1.5)
                self.inputField.text = ""
                self.inputConstraint.constant = self.inputField.contentSize.height
                self.commentNumber++
                self.dic["commentCount"] = self.commentNumber
                self.loadData(false)
            }else{
                hud.mode = .Text
                hud.detailsLabelText = dicd["description"] as! String
                hud.hide(true, afterDelay: 1.5)
            }
            }) { (error : NSError!) -> Void in
                hud.mode = .Text
                hud.detailsLabelText = error.domain
                hud.hide(true, afterDelay: 1.5)
        }
    }

    func keyNotification(notification : NSNotification){
        let rect = (notification.userInfo!["UIKeyboardFrameEndUserInfoKey"] as! NSValue).CGRectValue()
        let r1 = self.view.convertRect(rect, fromView: self.view.window)
        dispatch_after(dispatch_time(0, 0), dispatch_get_main_queue()) { () -> Void in
            
            
            let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey]?.doubleValue
            self.constraint.constant = self.view.frame.size.height - r1.origin.y
            self.view.setNeedsUpdateConstraints()
            UIView.animateWithDuration(duration!, animations: { () -> Void in
                
                self.view.layoutIfNeeded()
                let curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey]?.integerValue
                UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: curve!)!)
                
                
            })
        }
        
    }
    
    // MARK: - UITextFieldDelegate
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool{
        if inputConstraint.constant != textView.contentSize.height{
            inputConstraint.constant = textView.contentSize.height
            self.view.needsUpdateConstraints()
            self.view.setNeedsLayout()
        }
        
        return true
    }
    
    // MARK: - UITextFieldDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if !scrollView.isEqual(inputField){
            self.inputField.resignFirstResponder()
        }
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0{
            return 1
        }
        return 1+commentsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCellWithIdentifier("ForumThreadsDetailHeadTableViewCell", forIndexPath: indexPath) as! ForumThreadsDetailHeadTableViewCell
            
            // Configure the cell...
            cell.dataDic = dic as NSDictionary//dic
            return cell
        }
        
        else if indexPath.section == 1 && indexPath.row == 0{
            let cell = tableView.dequeueReusableCellWithIdentifier("ForumThreadsDetailCommentHeadTableViewCell", forIndexPath: indexPath) as! ForumThreadsDetailCommentHeadTableViewCell
            
            // Configure the cell...
            var commentCount = dataDic["commentCount"]
            if commentCount == nil{
                commentCount = dic["commentCount"]!
            }
            cell.numberLable.text = "评论（\(commentCount as! Int)）"
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("ForumThreadsDetailCommentTableViewCell", forIndexPath: indexPath) as! ForumThreadsDetailCommentTableViewCell
            
            // Configure the cell...
            let commentsDic = commentsArray[indexPath.row-1] as! NSDictionary
            cell.dataDic = commentsDic
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.groupTableViewBackgroundColor()
        return view
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
