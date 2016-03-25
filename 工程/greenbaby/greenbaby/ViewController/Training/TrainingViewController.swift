//
//  TrainingViewController.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/12.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

class TrainingViewModel : NSObject{
    var training : Training!
    var image : UIImage!
    func distanceScore() -> Float {
        if training == nil {
            return 0
        }
        return Float(training.distance!) / 40 * 60
    }
    
    func pitchScore() -> Float {
        if training == nil {
            return 0
        }
        return (90 - Float(training.pitch!)) / 90 * 10
    }
    
    func rollScore() -> Float {
        if training == nil {
            return 0
        }
        return (90 - Float(training.roll!)) / 90 * 10
    }
    
    func yawScore() -> Float {
        if training == nil {
            return 0
        }
        return (90 - Float(training.yaw!)) / 90 * 10
    }
    
    func totalScore() -> Float {
        return distanceScore() + rollScore() + yawScore() + pitchScore()
    }
}

class TrainingViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,NSURLConnectionDelegate ,NSURLConnectionDataDelegate{

    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var buttonView : UIView!
    
    @IBOutlet weak var sliderBackView : UIView!
    @IBOutlet weak var sliderView : UIView!
    @IBOutlet weak var sliderConstraint : NSLayoutConstraint!
    @IBOutlet weak var beginButton : UIButton!
    
    @IBOutlet weak var scoreLabel : UILabel!
    @IBOutlet weak var tableView : UITableView!
    var connection : NSURLConnection!
    var receivedData : NSMutableData!
    var viewModel = TrainingViewModel()
    let cellData = ["用眼距离","俯仰","摇摆","倾斜"]
    let cellImage = ["icon_juli","icon_fuyang","icon_yaobai","icon_qinxie"]
    
    var isTraining = false
    var isReplay = false
    var hud : MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sliderView.layer.cornerRadius = 4;
        sliderView.layer.masksToBounds = true;
        
        if self.view.frame.size.width<350{
            self.buttonView.clipsToBounds = false
            self.buttonView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 0.8)
        }
        
        self.tableView.tableFooterView = UIView()
        self.scoreLabel.text = "0"
    }
    
    func loadDeviceIP(){
        let dic = ["userId" : UserInfo.CurrentUser().userId!]
        DeviceRequest.GetDeviceIpWithParameters(dic, success: { (object) -> Void in
            print(object)
            let state = object["state"] as? Int
            if state == 0{
                if let dicData = object["data"] as? [String : AnyObject]{
                    if let ip = dicData["ip"] as? String{
                        UserInfo.CurrentGBUser().ip = ip
                        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
                    }
                }
            }
            }) { (error : NSError!) -> Void in
                
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        if UserInfo.CurrentGBUser() != nil {
            loadDeviceIP()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func beginClick(sender : UIButton){
        if UserInfo.CurrentGBUser() == nil {
            self.tabBarController?.performSegueWithIdentifier("loginIdentifier", sender: nil)
            return
        }
        
        //self.ip = "192.168.1.138"
        if connection != nil{
            connection.cancel()
            connection = nil
        }
        UserInfo.CurrentGBUser().ip = "123"
        if !UserInfo.CurrentGBUser().ip!.isEmpty{
            print(UserInfo.CurrentGBUser().ip)
        }
        else{
            return
        }
        beginButton.selected = true
        isTraining = true
        hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        netWorkVideo()
    }

    @IBAction func stopClick(sender : UIButton?){
        beginButton.selected = false
        isTraining = false
        if connection != nil {
            connection.cancel()
            connection = nil
        }
        isReplay = false
    }
    
    @IBAction func seebackClick(sender : UIButton?){
        if UserInfo.CurrentGBUser() == nil {
            return
        }
        if UserInfo.CurrentGBUser().training == nil {
            let huds = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            huds.mode = .Text
            huds.detailsLabelText = "没有回放数据"
            huds.hide(true, afterDelay: 1.5)
            return
        }
        stopClick(nil)
        viewModel.training = nil
        isReplay = true
        replay()
    }
    
    func replay() {
        if isReplay {
            if viewModel.training == nil {
                viewModel.training = UserInfo.CurrentGBUser().training
            }
            else{
                viewModel.training = viewModel.training.next
            }
            if viewModel.training != nil {
                self.imageView.image = UIImage(data: viewModel.training.image!)
                self.tableView.reloadData()
                self.scoreLabel.text = String(format: "%.1f", viewModel.totalScore())
            }
            else{
                return
            }
            
            if viewModel.training.timedisplay == nil {
                return
            }
            self.performSelector("replay", withObject: nil, afterDelay: NSTimeInterval(viewModel.training.timedisplay!))
        }
    }
    
    
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let height = tableView.frame.size.height/4
        return height<45 ? 45 : height
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TrainingCell", forIndexPath: indexPath) as! TrainingTableViewCell
        
        // Configure the cell...
        cell.NameLabel.text = cellData[indexPath.row]
        cell.type = indexPath.row
        cell.model = viewModel
        cell.detailSeeButton.setBackgroundImage(UIImage(named: cellImage[indexPath.row]), forState: .Normal)
        return cell
    }
    
    func netWorkVideo(){
        UserInfo.CurrentGBUser().ip = "192.168.1.138"
        let urls = "http://192.168.1.138:8081" //andy修改此处
        let url = NSURL(string: urls)
        let request = NSURLRequest(URL: url!, cachePolicy: .ReloadIgnoringLocalCacheData, timeoutInterval: 20)
        if let user = UserInfo.CurrentGBUser(){
            user.lastTraining = nil
            user.training = nil
            Training.MR_truncateAll()
            NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
        }
        connection = NSURLConnection(request: request, delegate: self)
        connection!.start()
        
    }
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        print(error)
        if hud != nil {
            hud.mode = .Text
            hud.detailsLabelText = error.localizedDescription
            hud.hide(true, afterDelay: 1.5)
            hud = nil
        }
        isTraining = false
        self.beginButton.selected = false
    }
    
    
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        if hud != nil {
            hud.hide(true)
            hud = nil
        }
        if let httpRespone = response as? NSHTTPURLResponse{
            //print(httpRespone.allHeaderFields)
            if let Distance = httpRespone.allHeaderFields["Distance"] as? String,let pitch = httpRespone.allHeaderFields["pitch"] as? String,let roll = httpRespone.allHeaderFields["roll"] as? String,let yaw = httpRespone.allHeaderFields["yaw"] as? String,let time = httpRespone.allHeaderFields["X-Timestamp"] as? String{
                viewModel.training = Training.MR_createEntity()
                viewModel.training.distance = Double(Distance)!
                viewModel.training.pitch = Double(pitch)!
                viewModel.training.roll = Double(roll)!
                viewModel.training.yaw = Double(yaw)!
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
                viewModel.training.time = dateFormatter.dateFromString(time)
            }
        }
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        //print(data)
        if receivedData == nil{
            receivedData = NSMutableData()
        }
        receivedData.appendData(data)
        let beginRange = receivedData.rangeOfData(DeviceRequest.beginData(), options: .Backwards, range: NSMakeRange(0, receivedData.length))
        let beginLocation = beginRange.location
        let endRange = receivedData.rangeOfData(DeviceRequest.endData(), options: .Backwards, range: NSMakeRange(0, receivedData.length))
        let endLocation = endRange.location + endRange.length
        if receivedData.length >= endLocation && beginLocation >= 0{
            let imageRange = NSMakeRange(beginLocation, endLocation - beginLocation)
            let imageData = receivedData.subdataWithRange(imageRange)
            let receivedImage = UIImage(data: imageData)
            if receivedImage != nil{
                self.imageView.image = receivedImage
                print(viewModel)
                viewModel.image = receivedImage
                if let user = UserInfo.CurrentGBUser(){
                    viewModel.training.image = imageData
                    if user.training == nil{
                        user.training = viewModel.training
                        user.lastTraining = viewModel.training
                    }
                    else{
                        let dateP = user.lastTraining?.time
                        let dateN = viewModel.training.time
                        let time = dateN!.timeIntervalSinceDate(dateP!)
                        user.lastTraining?.timedisplay = time
                        user.lastTraining?.next = viewModel.training
                        user.lastTraining = viewModel.training
                    }
                    NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
                }
                self.tableView.reloadData()
                self.scoreLabel.text = String(format: "%.1f", viewModel.totalScore())
            }
            let scendData = receivedData.subdataWithRange(NSMakeRange(endLocation, receivedData.length - endLocation))
            receivedData = NSMutableData(data: scendData)
        }
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        print("connectionDidFinishLoading")
        if hud != nil {
            hud.hide(true)
            hud = nil
        }
        isTraining = false
        self.beginButton.selected = false
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }


}
