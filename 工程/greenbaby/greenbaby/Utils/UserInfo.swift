//
//  UserInfo.swift
//  greenbaby
//
//  Created by 刘向宏 on 16/2/16.
//  Copyright © 2016年 刘向宏. All rights reserved.
//

import UIKit

class UserInfo: NSObject {

    static private var cuser : UserInfo!
    var userId : Int?{
        set{
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "userId")
        }
        get{
            return NSUserDefaults.standardUserDefaults().objectForKey("userId") as? Int
        }
    }
    
    var userName : String?{
        set{
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "userName")
        }
        get{
            if !(userId != nil){
                return nil
            }
            return NSUserDefaults.standardUserDefaults().objectForKey("userName") as? String
        }
    }
    
    var mobile : String?{
        set{
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "mobile")
        }
        get{
            if !(userId != nil){
                return nil
            }
            return NSUserDefaults.standardUserDefaults().objectForKey("mobile") as? String
        }
    }
    
    var province : String?{
        set{
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "province")
        }
        get{
            if !(userId != nil){
                return nil
            }
            return NSUserDefaults.standardUserDefaults().objectForKey("province") as? String
        }
    }
    
    var sex : Int?{
        set{
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "sex")
        }
        get{
            if !(userId != nil){
                return nil
            }
            return NSUserDefaults.standardUserDefaults().objectForKey("sex") as? Int
        }
    }
    
    var headImage : String?{
        set{
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "headImage")
        }
        get{
            if !(userId != nil){
                return nil
            }
            return NSUserDefaults.standardUserDefaults().objectForKey("headImage") as? String
        }
    }
    
    var gold : Int?{
        set{
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "gold")
        }
        get{
            if !(userId != nil){
                return nil
            }
            return NSUserDefaults.standardUserDefaults().objectForKey("gold") as? Int
        }
    }
    
    var eyeSight : String?{
        set{
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "eyeSight")
        }
        get{
            if !(userId != nil){
                return nil
            }
            return NSUserDefaults.standardUserDefaults().objectForKey("eyeSight") as? String
        }
    }
    
    var city : String?{
        set{
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "city")
        }
        get{
            if !(userId != nil){
                return nil
            }
            return NSUserDefaults.standardUserDefaults().objectForKey("city") as? String
        }
    }
    
    var averageTime : String?{
        set{
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "averageTime")
        }
        get{
            if !(userId != nil){
                return nil
            }
            return NSUserDefaults.standardUserDefaults().objectForKey("averageTime") as? String
        }
    }
    
    var age : String?{
        set{
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "age")
        }
        get{
            if !(userId != nil){
                return nil
            }
            return NSUserDefaults.standardUserDefaults().objectForKey("age") as? String
        }
    }
    
    static func CurrentUser() -> UserInfo!{
        if cuser == nil{
            cuser = UserInfo()
        }
        return cuser
    }
    
    static func setUser(dic : AnyObject){
        let user = UserInfo.CurrentUser()
        user!.userId = dic["userId"] as? Int
        user!.userName = dic["userName"] as? String
        user!.gold = dic["gold"] as? Int
        user!.headImage = dic["headImage"] as? String
        user!.city = dic["city"] as? String
        user!.province = dic["province"] as? String
        user!.averageTime = dic["averageTime"] as? String
        user!.eyeSight = dic["eyeSight"] as? String
        user!.sex = dic["sex"] as? Int
        user!.age = dic["age"] as? String
        user!.mobile = dic["mobile"] as? String
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}
