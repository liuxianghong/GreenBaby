//
//  TrainingViewController.swift
//  greenbaby
//
//  Created by 刘向宏 on 15/12/12.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

import UIKit

struct TrainingViewModel {
    var Distance = 0.0
    var pitch = 0.0
    var roll = 0.0
    var yaw = 0.0
    var time : NSDate!
    var image : UIImage!
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
    var ip = ""
    var connection : NSURLConnection!
    var receivedData : NSMutableData!
    var viewModel = TrainingViewModel()
    let cellData = ["用眼距离","俯仰","摇摆","倾斜"]
    let cellImage = ["icon_juli","icon_fuyang","icon_yaobai","icon_qinxie"]
    
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
    }
    
    func loadDeviceIP(){
        let dic = ["userId" : UserInfo.CurrentUser().userId!]
        DeviceRequest.GetDeviceIpWithParameters(dic, success: { (object) -> Void in
            print(object)
            let state = object["state"] as? Int
            if state == 0{
                if let dicData = object["data"] as? [String : AnyObject]{
                    if let ip = dicData["ip"] as? String{
                        self.ip = ip
                    }
                }
            }
            }) { (error : NSError!) -> Void in
                
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        loadDeviceIP()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func beginClick(sender : UIButton){
        beginButton.selected = !beginButton.selected
        self.ip = "192.168.1.138"
        if connection != nil{
            connection.start()
        }
        else{
            netWorkVideo()
        }
    }

    @IBAction func stopClick(sender : UIButton){
        beginButton.selected = false
        connection.cancel()
    }
    
    @IBAction func seebackClick(sender : UIButton){
        beginButton.selected = false
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
        self.ip = "192.168.1.138"
        if !self.ip.isEmpty{
            let urls = "http://192.168.1.138:8081"
            let url = NSURL(string: urls)
            let request = NSURLRequest(URL: url!)
            connection = NSURLConnection(request: request, delegate: self)
            connection!.start()
        }
    }
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        print(error)
    }
    
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        if let httpRespone = response as? NSHTTPURLResponse{
            //print(httpRespone.allHeaderFields)
            if let Distance = httpRespone.allHeaderFields["Distance"] as? String,let pitch = httpRespone.allHeaderFields["pitch"] as? String,let roll = httpRespone.allHeaderFields["roll"] as? String,let yaw = httpRespone.allHeaderFields["yaw"] as? String,let time = httpRespone.allHeaderFields["X-Timestamp"] as? String{
                viewModel.Distance = Double(Distance)!
                viewModel.pitch = Double(pitch)!
                viewModel.roll = Double(roll)!
                viewModel.yaw = Double(yaw)!
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
                viewModel.time = dateFormatter.dateFromString(time)
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
                    user.addTraining(viewModel);
                }
                self.tableView.reloadData()
            }
            let scendData = receivedData.subdataWithRange(NSMakeRange(endLocation, receivedData.length - endLocation))
            receivedData = NSMutableData(data: scendData)
        }
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        print("connectionDidFinishLoading")
    }
    
////每接收一段数据就会调用此函数
//-(void)connection:(NSURLConnection*)connection didReceiveData:(NSData *)data
//{
//    // NSLog(@”==didReceiveData:data==%@==”,data);
//    [self.allData appendData:data];
//    // NSLog(@”==didReceiveData==self.allData==%@==”,self.allData);
//    // http://zasper.net/archives/4891
//    NSLog(@”connectDidReceiveData-endMarkerData-%@”,endMarkerData);
//    NSRange endRange=[self.allData rangeOfData:endMarkerData
//    options:0
//    range:NSMakeRange(0, self.allData.length)];
//    long endLocation=endRange.location + endRange.length;
//    if(self.allData.length >= endLocation){
//        NSRange imageRange=NSMakeRange(0, endLocation);
//        NSData* imageData=[self.allData subdataWithRange:imageRange];
//        UIImage* receivedImage=[UIImage imageWithData:imageData];
//        if(receivedImage){
//            self.imageView.image = receivedImage;
//            NSLog(@”解码图片”);
//        }
//    }
//}

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }


}
