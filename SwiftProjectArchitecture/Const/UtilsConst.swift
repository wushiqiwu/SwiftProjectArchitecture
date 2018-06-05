//
//  UtilsConst.swift
//  SwiftProjectArchitecture
//
//  Created by wushiqi on 2017/11/29.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import UIKit

//自动适配
func FitValue(_ value : CGFloat) -> CGFloat {
    return value / 375.0 * APP.screenWidth
}

func FitValueHeight(_ value : CGFloat) -> CGFloat {
    return value / 667.0 * APP.screenHeight
}


let KSeparaterLineHeight = CGFloat(0.5) //分割线高度


//Log
func printLog<T>(_ message: T,
                 file: String = #file,
                 method: String = #function,
                 line: Int = #line)
{
    print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
}
