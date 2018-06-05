//
//  UIColor_Extension.swift
//  点点汇
//
//  Created by wushiqi on 2017/9/16.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import UIKit
import SwifterSwift

//MARK:- 16进制创建Color
extension UIColor{
    
    class func hex(hexValue : UInt) -> UIColor{
        return UIColor(
            red: CGFloat((hexValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hexValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hexValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    class func hexString(hexString: String) -> UIColor {
        let color = UIColor.init(hexString: hexString)
        guard color != nil else { return UIColor.white }
        return color!
    }
}


//MARK:- RGB创建Color
extension UIColor{
    
    class func RGB(r:CGFloat,g:CGFloat,b:CGFloat) -> UIColor{
        return UIColor.init(red:r/255.0,green: g/255.0,blue: b/255.0,alpha: 1.0)
    }
    class func RGBA(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) -> UIColor{
            return UIColor.init(red:r/255.0,green: g/255.0,blue: b/255.0,alpha:a)
    }
}

