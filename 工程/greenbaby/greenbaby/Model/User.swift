//
//  User.swift
//  greenbaby
//
//  Created by 刘向宏 on 16/3/20.
//  Copyright © 2016年 刘向宏. All rights reserved.
//

import Foundation
import CoreData


class User: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

    static func userByUid(uid : AnyObject) -> User{
        
        if let user = User.MR_findByAttribute("uid", withValue: uid)?.first as? User{
            return user;
        }
        else{
            let user = User.MR_createEntity()!
            user.uid = uid as? Int
            user.ip = ""
            return user
        }
    }
    
}
