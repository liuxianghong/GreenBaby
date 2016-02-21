//
//  WIFIUtils.swift
//  greenbaby
//
//  Created by 刘向宏 on 16/1/18.
//  Copyright © 2016年 刘向宏. All rights reserved.
//

import UIKit
import SystemConfiguration.CaptiveNetwork
import NetworkExtension

class WIFIUtils: NSObject {

    static func fetchSSIDInfo() -> String?{
        
        if #available(iOS 9.0, *) {
            let array = NEHotspotHelper.supportedNetworkInterfaces()
            for obj in array{
                if let hotspotNetwork = obj as? NEHotspotNetwork{
                    print(hotspotNetwork.SSID)
                    print(hotspotNetwork.BSSID)
                    print(hotspotNetwork.secure)
                    print(hotspotNetwork.autoJoined)
                    print(hotspotNetwork.signalStrength)
                    if !hotspotNetwork.SSID.isEmpty{
                        return hotspotNetwork.SSID;
                    }
                }
            }
        } else {
            // Fallback on earlier versions
            
        }
        
        let interfaces:CFArray! = CNCopySupportedInterfaces()
        if interfaces == nil{
            return nil
        }
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
