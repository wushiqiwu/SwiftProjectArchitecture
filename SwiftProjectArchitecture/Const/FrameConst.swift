//
//  FrameConst.swift
//  SwiftProjectArchitecture
//
//  Created by wushiqi on 2017/11/30.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import UIKit

extension APP{
    
    static var keyWindow : UIWindow { return UIApplication.shared.keyWindow! }
    
    static var screenWidth  : CGFloat { return  UIScreen.main.bounds.size.width }
    static var screenHeight : CGFloat { return  UIScreen.main.bounds.size.height }
    static var screenScale  : CGFloat { return  UIScreen.main.scale }
    
    static var statusBarHeight: CGFloat { return UIApplication.shared.statusBarFrame.height }
    static var navigationBarHeight : CGFloat { return 64.0; }
    static var tabBarHeight        : CGFloat { return 50.0; }
}


extension UIViewController{
    
    var navigationBarHeight : CGFloat? { return navigationController?.navigationBar.height}
    var tabBarHeight        : CGFloat? { return tabBarController?.tabBar.height}
    
}
