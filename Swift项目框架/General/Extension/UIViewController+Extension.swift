//
//  UIViewController_Extension.swift
//  点点汇
//
//  Created by wushiqi on 2017/9/16.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import UIKit

//MARK:- 获取当前显示在屏幕上的VC
extension UIViewController{
    
  static var topViewController : UIViewController?{
        
        var window = UIApplication.shared.keyWindow!
        if( window.windowLevel != UIWindowLevelNormal ){
            let windows = UIApplication.shared.windows
            for sub in windows{
                if( sub.windowLevel == UIWindowLevelNormal ){
                    window = sub
                    break
                }
            }
        }
        
        if let viewController = window.subviews.first?.next as? UIViewController{
            return viewController
        }else{
            return window.rootViewController
        }
    }
}

