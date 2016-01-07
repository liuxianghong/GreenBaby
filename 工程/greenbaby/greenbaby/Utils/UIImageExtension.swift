//
//  UIImageExtension.swift
//  greenbaby
//
//  Created by 刘向宏 on 16/1/4.
//  Copyright © 2016年 刘向宏. All rights reserved.
//

import UIKit

extension UIImage {
    
    func scaleImage(scaleSize : CGFloat) -> UIImage?{
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.size.width * scaleSize, self.size.height * scaleSize), false, UIScreen.mainScreen().scale)
        self.drawInRect(CGRectMake(0, 0, self.size.width * scaleSize, self.size.height * scaleSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return scaledImage
    }
}
