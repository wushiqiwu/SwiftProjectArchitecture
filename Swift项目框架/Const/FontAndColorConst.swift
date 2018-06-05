//
//  FontAndColorConst.swift
//  Swift项目框架
//
//  Created by wushiqi on 2017/9/16.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import UIKit

extension APP {
    
    //常用颜色
    static let textMainColor    = UIColor.hexString(hexString: "#323232") //主文本颜色
    static let mainColor        = UIColor.hexString(hexString: "#3085FF") //APP主色调
    static let viewColor        = UIColor.hexString(hexString: "#f6f6f6") //View默认颜色
    static let lineColor        = UIColor.hexString(hexString: "#E5E5E5")
    static let backGroundColor  = UIColor.RGB(r: 245, g: 245, b: 245)     //背景色
    static let redText          = UIColor.red
    static let color727272      = UIColor.hexString(hexString: "#727272")
    static let color666666      = UIColor.hexString(hexString: "#666666")
    static let color999999      = UIColor.hexString(hexString: "#999999")
}


//字体
extension UIFont{
    
    static let size10 = UIFont.systemFont(ofSize: 10)
    static let size11 = UIFont.systemFont(ofSize: 11)
    static let size12 = UIFont.systemFont(ofSize: 12)
    static let size13 = UIFont.systemFont(ofSize: 13)
    static let size14 = UIFont.systemFont(ofSize: 14)
    static let size15 = UIFont.systemFont(ofSize: 15)
    static let size16 = UIFont.systemFont(ofSize: 16)
    static let size17 = UIFont.systemFont(ofSize: 17)
    static let size18 = UIFont.systemFont(ofSize: 18)
}

