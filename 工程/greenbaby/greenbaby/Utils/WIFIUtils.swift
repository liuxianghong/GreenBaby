//
//  WIFIUtils.swift
//  greenbaby
//
//  Created by 刘向宏 on 16/1/18.
//  Copyright © 2016年 刘向宏. All rights reserved.
//

import UIKit
import SystemConfiguration.CaptiveNetwork

class WIFIUtils: NSObject {

    static func fetchSSIDInfo() -> String?{
        let interfaces:CFArray! = CNCopySupportedInterfaces()
        for i in 0..<CFArrayGetCount(interfaces){
            let interfaceName: UnsafePointer<Void>
            =  CFArrayGetValueAtIndex(interfaces, i)
            let rec = unsafeBitCast(interfaceName, AnyObject.self)
            let unsafeInterfaceData = CNCopyCurrentNetworkInfo("\(rec)")
            if unsafeInterfaceData != nil {
                let interfaceData = unsafeInterfaceData! as Dictionary!
                return interfaceData["SSID"] as? String
            }
        }
        return nil
    }
}
